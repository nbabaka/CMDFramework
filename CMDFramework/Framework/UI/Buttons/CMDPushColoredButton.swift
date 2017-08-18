//
//  CMDPushColoredButton.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 22/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

open class CMDPushColoredButton: CMDButtonBase {
    override open var isHighlighted: Bool {
        didSet {
            self.backgroundColor = self.isHighlighted ? UIColor.buttons.colorButtonBackgroundHighlight : UIColor.buttons.colorButtonBackground
        }
    }
    
    override func initButton() {
        super.initButton()
        self.spacing = 2
        self.setImage(#imageLiteral(resourceName: "select"), for: .normal)
        self.setImage(#imageLiteral(resourceName: "select"), for: .highlighted)
        self.tintColor = UIColor.buttons.colorButtonTint
        self.contentHorizontalAlignment = .left
        self.setTitleColor(UIColor.buttons.colorButtonTitle, for: .normal)
        self.setTitleColor(UIColor.buttons.colorButtonTitleHighlight, for: .highlighted)
        self.titleLabel?.font = UIFont.buttons.colorButton
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.buttons.colorButtonBackground
        self.titleLabel?.adjustsFontSizeToFitWidth = false
        self.titleLabel?.frame = self.bounds
        self.titleLabel?.minimumScaleFactor = 0.0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 9.0, *) {
            self.imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0).isActive = true
        }
        if #available(iOS 9.0, *) {
            self.imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
        } 
        self.contentHorizontalAlignment = .left
    }
}
