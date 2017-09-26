//
//  CMDChatViewController.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 07.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import PKHUD
import ZDCChatAPI
import DKImagePickerController

class CMDChatViewController: CMDViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageText: CMDColoredTextInput!
    @IBOutlet weak var connectionLabel: CMDSettableLabel!

    let client = CMDChatAPIClient()
    let source = CMDChatDataSource()
    
    private var name: String?
    private var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.willRegisterKeyboardHandle = true
        self.keyboardHide = .will
        initHandlers()
        initChat()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        processConnectionStateChanges()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func unwindAndProcessOfflineMessage(_ segue: UIStoryboardSegue) {
        guard let sourceVC = segue.source as? CMDChatOfflineViewController else {
            return
        }
        let message = sourceVC.message.text ?? ""
        guard !message.isEmpty else {
            return
        }
        client.sendOffline(message: message)
        source.clearAction()
        source.addSystem(withText: "CHAT_OFFLINE_SENT".l)
    }
    
    @IBAction func unwindAndProcessVisitorInfo(_ segue: UIStoryboardSegue) {
        guard let sourceVC = segue.source as? CMDChatVisitorViewController else {
            return
        }
        name = sourceVC.usernameText.text
        email = sourceVC.emailText.text
        self.startChat()
    }
    
    @IBAction func pickImageAction(_ sender: Any) {
        let pickerController = DKImagePickerController()
        
        pickerController.singleSelect = true
        pickerController.allowMultipleTypes = true
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            guard assets.count > 0 else {
                return
            }
            assets.forEach {
                if !$0.isVideo {
                    $0.fetchOriginalImage(false) { [weak self] (image, info) in
                        self?.client.uploadImage(image!)
                    }
                } else {
                    $0.fetchAVAsset(.none, completeBlock: { [weak self] video, info in
                        self?.showProgress(message: "CHAT_CONVERT".l)
                        self?.client.uploadVideo(video) {_ in
                            self?.hideMessage()
                        }
                    })
                }
            }
        }
        self.present(pickerController, animated: true) {}
    }
    
    
    @IBAction func sendMessage(_ sender: Any) {
        sendMessage()
    }
    
    override internal func initSubviews() {
        self.setBackground()
        self.setMenuBarButton(withImage: #imageLiteral(resourceName: "burger"))
        self.setNavigationTitle("CHAT".l)
        self.updateSendButtonState()
        messageText.inset = CGRect(x: 12, y: 12, width: 12, height: 12)
        messageText.autocapitalizationType = .sentences
        messageText.placeholderSpacing = 1.0
        messageText.font = UIFont.chat.text
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func initChat() {
        if !CMDManager.shared.isAuth() {
            self.performSegue(withIdentifier: "showChatVisitorInfoSegue", sender: self)
        } else {
            name = CMDManager.shared.getUsername()
            email = CMDManager.shared.getEmail()
            self.startChat()
        }
    }
    
    private func initHandlers() {
        self.source.delegate = self
        
        client.onChatConnectionStateUpdate { [unowned self] (state) in
            if state {
                CMDLoggingService.newEvent(withName: .chatConnected, andAttributes: ["isOnline": self.client.isOnline, "username": self.name ?? "", "email": self.email ?? ""])
                if !self.client.isOnline {
                    self.actionOfflineEvent()
                }
            }
            self.processConnectionStateChanges()
        }
        
        client.onEventReceived { [unowned self] event in
            self.source.append(with: event)
        }
        
        client.onEventUpdated {
            [unowned self] event in
            self.source.update(withId: event.id, updateBlock: { (updatedEvent: inout ChatEvent) in
                updatedEvent = event
            })
        }
        
        client.onChatConnectionTimeout {
            self.hideMessage()
            self.client.endChat()
            self.actionConnectionError()
        }
        
        client.onChatTimeoutReached {
            self.client.endChat()
            self.actionTimeoutEvent()
        }
        
        client.onChatAccountUpdated { state in
            guard self.client.isConnected else {
                return
            }
            if state == false {
                self.actionOfflineEvent()
            } else {
                self.source.clearAction()
            }
        }
        
        client.onUploadReceived { file in
            if let file = file {
                self.source.handleUpload(file)
            }
        }
        
        CMDChatCellFactory.registerCells(withTable: tableView, nibs: ["CMDAgentMessageCell", "CMDVisitorMessageCell", "CMDAgentImageCell", "CMDVisitorImageCell", "CMDChatSystemCell", "CMDChatActionCell"])
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(CMDConstants.notifications.chatRate.rawValue), object: nil, queue: nil) { notification in
            let ratingIsGood = notification.object as? Bool
            self.client.sendRating(isGood: ratingIsGood ?? true)
            self.source.clearAction()
        }
    }
    
    fileprivate func startChat(withClear clear: Bool = false) {
        source.clearAction()
        if clear {
            source.removeAll()
        }
        client.startChat()
        client.updateProfile(withName: name, email: email)
        client.resumeChatIfNeeded()
    }
    
    fileprivate func scrollToLast() {
        let last = tableView.numberOfRows(inSection: 0) - 1
        guard last >= 0 else {
            return
        }
        tableView.scrollToRow(at: IndexPath(row: last, section: 0), at: .middle, animated: true)
    }
    
    private func processConnectionStateChanges() {
        switch client.connectionStatus {
        case .connected:
            self.connectionLabel.t = "CHAT_CONNECTED".l
            self.hideMessage()
        case .connecting:
            self.connectionLabel.t = "CHAT_CONNECTING_CAPS".l
            self.showProgress(message: "CHAT_CONNECTING".l)
        default:
            self.connectionLabel.t = "CHAT_DISCONNECTED".l
            print("Cannot process Status = \(client.connectionStatus.rawValue)")
            break
        }
    }
    
    fileprivate func updateSendButtonState() {
        sendButton.isEnabled = !(messageText.text ?? "").isEmpty
    }
    
    fileprivate func sendMessage() {
        if (messageText.text ?? "").isEmpty {
            return
        }
        
        client.send(message: messageText.text!)
        messageText.text = ""
        updateSendButtonState()
    }
    
    override func keyboardShow(_ notification: Notification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.bottomConstraint.constant = keyboardFrame.size.height
        self.view.layoutIfNeeded()
        self.scrollToLast()
    }
    
    override func keyboardHide(_ notification: Notification) {
        self.bottomConstraint.constant = 0
    }
}

extension CMDChatViewController {
    fileprivate func actionTimeoutEvent() {
        source.addAction(ChatActionEvent(confirmed: true, buttons: [getReconnectionButton()], buttonOrder: .vertical, id: String.random(), type: .action, text: "CHAT_TIMEOUT_REACHED".l))
    }
    
    fileprivate func actionOfflineEvent() {
        let cancelButton = CMDClassicButton(withText: "CHAT_CLOSE_ALERT".l) {
            self.source.clearAction()
        }
        source.addAction(ChatActionEvent(confirmed: true, buttons: [getOfflineButton(), cancelButton], buttonOrder: .vertical, id: String.random(), type: .action, text: "CHAT_OFFLINE_TEXT".l))
    }
    
    fileprivate func actionConnectionError() {
        source.addAction(ChatActionEvent(confirmed: true, buttons: [getOfflineButton(), getReconnectionButton()], buttonOrder: .vertical, id: String.random(), type: .action, text: "CHAT_CONNECTION_ERROR".l))
    }
    
    private func getOfflineButton() -> CMDButtonBase {
        let offlineButton = CMDBlueButton(withText: "CHAT_OFFLINE_BUTTON".l) {
            self.performSegue(withIdentifier: "showChatOfflineMessage", sender: self)
        }
        return offlineButton
    }
    
    private func getReconnectionButton() -> CMDButtonBase {
        let button = CMDGrayButton(withText: "CHAT_TIMEOUT_REACHED_BUTTON".l) {
            self.startChat(withClear: true)
        }
        return button
    }
}

extension CMDChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
    
    @IBAction func textChanged(_ sender: Any) {
        updateSendButtonState()
    }
}

extension CMDChatViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CMDChatCellFactory.construct(withTable: tableView, indexPath: indexPath, event: source.value(at: indexPath.row), target: self)
    }
}

extension CMDChatViewController: CMDChatTapCellDelegate {
    func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view as? UIImageView else {
            return
        }
        
        guard let image = view.image else {
            return
        }
        
        if image != #imageLiteral(resourceName: "placeholder") {
            let vc = UIStoryboard(name: "Chat", bundle: nil).instantiateViewController(withIdentifier: "chatImage") as! CMDChatImageViewController
            vc.image = image
            self.setBackButton()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CMDChatViewController: CMDChatDataSourceUIDelegate {
    func updateChat() {
        tableView.reloadData()
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        self.scrollToLast()
    }
    
    func showError(withText text: String) {
        self.showError(text)
    }
}

