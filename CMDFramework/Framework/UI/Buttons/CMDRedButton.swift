//
//  CMDRedButton.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 05/06/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

open class CMDRedButton: CMDGrayButton {
    override open func initButton() {
        super.initButton()
        self.backgroundColor = UIColor.buttons.redButtonBackground
        self.setTitleColor(UIColor.buttons.redButtonTitle, for: .normal)
        self.unHighlightBackgroundColor = UIColor.buttons.redButtonBackground
        self.highlightBackgroundColor = UIColor.buttons.redButtonBackground
    }
}
