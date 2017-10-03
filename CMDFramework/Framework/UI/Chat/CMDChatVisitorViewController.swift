//
//  CMDChatVisitorViewController.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 09.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//


class CMDChatVisitorViewController: CMDInitialViewController {
    @IBOutlet weak var usernameTitle: CMDSectorLabel!
    @IBOutlet weak var emailTitle: CMDSectorLabel!
    @IBOutlet weak var usernameText: CMDTextInputWithValidation!
    @IBOutlet weak var emailText: CMDTextInputWithValidation!
    @IBOutlet weak var nextButton: CMDBlueButton!
    @IBOutlet weak var cancelButton: CMDClassicButton!
    
    let nameFlag = "chatNameFlag"
    let emailFlag = "chatEmailFlag"
    
    @IBAction func cancelAction(_ sender: Any) {
//        self.usernameText.text = "Anonymous Visitor"
//        self.emailText.text = ""
//        self.performSegue(withIdentifier: "returnToChatSegue", sender: self)
//        UIApplication.pushControllers(sender: self, controllers: ["remoteViewController"], andSetActiveMenuIndex: 0)
    }
    
    @IBAction func nextAction(_ sender: Any) {
        guard usernameText.text != "" else {
            usernameText.setInvalidWithText("CHAT_VISITOR_USERNAME_ERROR".l)
            return
        }
        
        guard let text = emailText?.text else {
            emailText.setInvalidWithText("SIGNINEMAIL_ERROR".l)
            return
        }
        
        guard text.isValidEmail() else {
            emailText.setInvalidWithText("SIGNINEMAIL_ERROR".l)
            return
        }
        self.saveNameToDefaults()
        self.performSegue(withIdentifier: "returnToChatSegue", sender: self)
    }
    
    private func changeInfoWithAuth() {
        //self.usernameText.text = CMDManager.shared.getUsername()
        //self.emailText.text = CMDManager.shared.getEmail()
        self.usernameText.setValid()
        self.emailText.setValid()
    }
    
    override internal func initSubviews() {
        self.setNavigationTitle("CHAT_VISITOR_TITLE".l)
        self.navigationItem.hidesBackButton = true
        usernameTitle.t = "CHAT_VISITOR_NAME".l
        emailTitle.t = "CHAT_VISITOR_EMAIL".l
        usernameText.placeholder = "CHAT_VISITOR_NAME_PH".l
        emailText.placeholder = "CHAT_VISITOR_EMAIL_PH".l
        usernameText.autocapitalizationType = .words
        usernameText.delegate = self
        emailText.delegate = self
        nextButton.text = "NEXT".l
        cancelButton.text = "CANCEL".l
        self.hideKeyboardWhenTappedAround()
        self.getNameFromDefaults()
    }
    
    private func getNameFromDefaults() {
        usernameText.text = UserDefaults.standard.string(forKey: nameFlag)
        emailText.text = UserDefaults.standard.string(forKey: emailFlag)
    }
    
    private func saveNameToDefaults() {
        UserDefaults.standard.set(usernameText.text, forKey: nameFlag)
        UserDefaults.standard.set(emailText.text, forKey: emailFlag)
        UserDefaults.standard.synchronize()
    }
}

extension CMDChatVisitorViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    internal func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.checkAndSetActiveStatus(true)
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        textField.checkAndSetActiveStatus(false)
    }
}
