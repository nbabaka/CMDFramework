//
//  CMDBackButton.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 05/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

open class CMDBackButton: CMDClassicButton {
    override func initButton() {
        super.initButton()
        self.contentHorizontalAlignment = .left
        self.spacing = 2
        self.text = !DeviceType.IS_IPHONE_5_OR_LESS ? "CANCEL".podLocalization : ""
        self.setTitleColor(UIColor.buttons.backButtonTitle, for: .normal)
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 0.0)
        self.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        self.setImage(#imageLiteral(resourceName: "back"), for: .highlighted)
    }
}
