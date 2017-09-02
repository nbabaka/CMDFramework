//
//  CMDGrayButton.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 05/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

open class CMDGrayButton: CMDBlueButton {
    override open func initButton() {
        super.initButton()
        self.backgroundColor = UIColor.buttons.grayButtonBackground
        self.unHighlightBackgroundColor = UIColor.buttons.grayButtonBackground
        self.highlightBackgroundColor = UIColor.buttons.grayButtonBackgroundHighlight
        self.layer.shadowColor = UIColor.buttons.grayButtonShadow.withAlphaComponent(0.8).cgColor
        self.setTitleColor(UIColor.buttons.grayButtonTitle, for: .normal)
        self.setTitleColor(UIColor.buttons.grayButtonTitleHighlight, for: .highlighted)
        self.spacing = 4
        self.text = "NEXT".podLocalization
    }
}
