//
//  CMDTextFieldButtonController.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 08.05.17.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import EasyPeasy

open class CMDTextFieldButtonController: CMDInitialViewController {

    public var label: UILabel?
    public var field: UIControl?
    public var fieldView: UIView?
    public var button: UIButton?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let currentField = field else {
            return
        }
        
        if !animated {
            currentField.resignFirstResponder()
        }
        
        delay(0.2){
            currentField.becomeFirstResponder()
        }
    }
    
    override open var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    open func setOldIPhoneConstraints() {
        if DeviceType.IS_IPHONE_5_OR_LESS {
            self.view.easy_clear()
            let tempField = fieldView != nil ? fieldView : field
            if let currentField = tempField {
                currentField.easy_clear()
                currentField <- Height(55)
                currentField <- CenterY(-100)
                currentField <- [Left(15), Right(15)]
            
                if let currentText = self.label {
                    currentText.easy_clear()
                    currentText <- [Left(8), Right(8), Bottom(18).to(currentField)]
                }
            }
            self.view.layoutIfNeeded()
        }
    }
}
