//
//  CMDTextFieldButtonController.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 08.05.17.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import EasyPeasy

open class CMDTextFieldButtonController: CMDInitialViewController {

    @IBOutlet public var label: UILabel?
    @IBOutlet public var field: UIControl?
    @IBOutlet public var fieldView: UIView?
    @IBOutlet public var button: UIButton?
    
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
            self.view.easy.clear()
            let tempField = fieldView != nil ? fieldView : field
            if let currentField = tempField {
                currentField.easy.layout (Height(55),
                                          CenterY(-100),
                                          Left(15),
                                          Right(15))
            
                if let currentText = self.label {
                    currentText.easy.clear()
                    currentText.easy.layout(Left(8),
                                            Right(8),
                                            Bottom(18).to(currentField))
                }
            }
            self.view.layoutIfNeeded()
        }
    }
}
