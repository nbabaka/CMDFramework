//
//  CMDRightImageButton.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev on 17/05/2017.
//  Copyright © 2017 Underlama. All rights reserved.
//

open class CMDRightImageButton: CMDClassicButton {
    override func initButton() {
        super.initButton()
        self.spacing = 2
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 10.0)
        self.contentHorizontalAlignment = .right
        self.setTitleColor(UIColor.buttons.rightImageTitle, for: .normal)
        self.tintColor = UIColor.buttons.rightImageTint
        if #available(iOS 9.0, *) {
            self.semanticContentAttribute = .forceRightToLeft
        } 
    }
}
