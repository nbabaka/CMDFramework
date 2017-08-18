//
//  CMDBlueButton.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 05.04.17.
//  Copyright © 2017 Cinemood. All rights reserved.
//

import UIKit

open class CMDBlueButton: CMDButtonBase {
    public var highlightBackgroundColor = UIColor.buttons.blueButtonBackgroundHighlight
    public var unHighlightBackgroundColor = UIColor.buttons.blueButtonBackground
    
    override open var isHighlighted: Bool {
        didSet {
            self.backgroundColor = self.isHighlighted ? highlightBackgroundColor : unHighlightBackgroundColor
            self.layer.shadowOpacity = self.isHighlighted ? 1 : 0
        }
    }
    
    var enabledBackgroundColor: UIColor?
    var disabledBackgroundColor: UIColor = UIColor.buttons.blueButtonBackgroundDisabled
    
    override open var isEnabled: Bool {
        didSet {
            if let enabledBackgroundColor = enabledBackgroundColor {
                self.backgroundColor = self.isEnabled ? enabledBackgroundColor : disabledBackgroundColor
            }
        }
    }
    
    override func initButton() {
        super.initButton()
        self.spacing = 4
        self.backgroundColor = unHighlightBackgroundColor
        self.enabledBackgroundColor = self.backgroundColor
        self.layer.cornerRadius = 18
        self.setTitleColor(UIColor.buttons.blueButtonTitle, for: .normal)
        self.setTitleColor(UIColor.buttons.blueButtonTitleHighlight, for: .highlighted)
        self.setTitleColor(UIColor.buttons.blueButtonTitleDisabled, for: .disabled)
        self.titleLabel?.font = UIFont.buttons.blueButton
        self.titleLabel?.addTextSpacing(self.spacing)
        self.layer.shadowRadius = 7
        self.layer.shadowColor = UIColor.buttons.blueButtonShadow.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0
    }
}
