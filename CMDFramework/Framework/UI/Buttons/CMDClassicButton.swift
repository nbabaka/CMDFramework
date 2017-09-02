//
//  CMDClassicButton.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 05.04.17.
//  Copyright © 2017 Cinemood. All rights reserved.
//

open class CMDClassicButton: CMDButtonBase {
    open var f : UIFont {
        get {
            return (self.titleLabel?.font)!
        }
        set {
            self.titleLabel?.font = newValue
            self.titleLabel?.addTextSpacing(self.spacing)
        }
    }
    
    override open func initButton() {
        super.initButton()
        self.spacing = 4
        self.setTitleColor(UIColor.buttons.classicButtonTitle, for: .normal)
        self.setTitleColor(UIColor.buttons.classicButtonTitleHightlight, for: .highlighted)
        self.titleLabel?.font = UIFont.buttons.classicButton
        self.titleLabel?.addTextSpacing(self.spacing)
    }
}
