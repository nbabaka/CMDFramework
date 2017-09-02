//
//  CMDFacebookButton.swift
//  Pods
//
//  Created by Nikolay Karataev aka Babaka on 02.09.17.
//
//

import UIKit

class CMDFacebookButton: CMDBlueButton {
    override open func initButton() {
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.white, for: .highlighted)
        self.backgroundColor = UIColor.buttons.facebook
        self.unHighlightBackgroundColor = UIColor.buttons.facebook
        self.highlightBackgroundColor = UIColor.buttons.facebook
        self.titleLabel?.font = UIFont.buttons.blueButton
        self.spacing = 4
        self.text = "FACEBOOK"
    }
}
