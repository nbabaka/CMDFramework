//
//  CMDChatOfflineViewController.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 14.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

class CMDChatOfflineViewController: CMDInitialViewController {
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nextButton: CMDBlueButton!
    @IBOutlet weak var messageTitle: CMDSectorLabel!
    @IBOutlet weak var cancelButton: CMDClassicButton!
    @IBOutlet weak var message: CMDTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.willRegisterKeyboardHandle = true
    }

    @IBAction func nextAction(_ sender: Any) {
        if (message.text ?? "").isEmpty {
            self.showError("CHAT_OFFLINE_ERROR".l)
            return
        }
        self.performSegue(withIdentifier: "unwindFromOfflineSegue", sender: self)
    }
    
    override func keyboardShow(_ notification: Notification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.bottomConstraint.constant = keyboardFrame.size.height
        self.view.layoutIfNeeded()
    }
    
    override func keyboardHide(_ notification: Notification) {
        self.bottomConstraint.constant = 0
    }
    
    override internal func initSubviews() {
        messageTitle.text = "CHAT_OFFLINE_MESSAGE".l
        self.setNavigationTitle("CHAT_OFFLINE_TITLE".l)
        self.navigationItem.hidesBackButton = true
        nextButton.text = "NEXT".l
        cancelButton.text = "CANCEL".l
        self.hideKeyboardWhenTappedAround()
    }
}
