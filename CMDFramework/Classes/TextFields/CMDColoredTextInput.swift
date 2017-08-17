//
//  CMDColoredTextInput.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 22/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

open class CMDColoredTextInput: CMDTextInput, UITextFieldDelegate {
    private var activeStatus: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.2, delay: 0, options: .beginFromCurrentState, animations: {
                self.backgroundColor = self.activeStatus ? UIColor.textFields.activeBackground : UIColor.textFields.nonActiveBackground
                self.textColor = self.activeStatus ? UIColor.textFields.activeText : UIColor.textFields.nonActiveText
                self.placeholderColor = self.activeStatus ? UIColor.textFields.activePlaceholder : UIColor.textFields.nonActivePlaceholder
            }, completion: nil )
        }
    }
    
    override func setupView() {
        super.setupView()
        self.activeStatus = false
    }

    public func setActiveStatus(_ status: Bool) {
        activeStatus = status
    }
}

public extension UITextField {
    public func checkAndSetActiveStatus(_ status: Bool) {
        guard let colored = self as? CMDColoredTextInput else {
            return
        }
        return colored.setActiveStatus(status)
    }
}
