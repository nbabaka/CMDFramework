//
//  CMDTwoButtonsAlert.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 05.04.17.
//  Copyright © 2017 Cinemood. All rights reserved.
//

import EasyPeasy

open class CMDTwoButtonsAlert: CMDAlertViewBase {
    open var leftButtontext : String {
        get {
            return leftButton.text!
        }
        set {
            leftButton.text = newValue
        }
    }
    
    open var rightButtontext : String {
        get {
            return rightButton.text!
        }
        set {
            rightButton.text = newValue
        }
    }
    
    open var onPushLeftButtonBlock : CMDOneButtonAlertBlock? {
        didSet {
            leftButton.onPushButtonBlock = onPushLeftButtonBlock
        }
    }
    open var onPushRightButtonBlock : CMDOneButtonAlertBlock? {
        didSet {
            rightButton.onPushButtonBlock = onPushRightButtonBlock
        }
    }
    
    open var leftButton = CMDClassicButton()
    open var rightButton = CMDClassicButton()
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        setNeedsUpdateConstraints()
    }
    
    override open func initAdditionalViews() {
        rightButton.setTitleColor(UIColor.alerts.text, for: .normal)
        leftButton.contentHorizontalAlignment = .left
        rightButton.contentHorizontalAlignment = .right
        self.addSubview(leftButton)
        self.addSubview(rightButton)
        leftButton <- [Left(40), Bottom(68), Height(22), Width(self.frame.width/2 - 40)]
        rightButton <- [Size().like(leftButton), Bottom(68), Right(40)]
        self.onPushLeftButtonBlock = { self.close(.moveDown) }
    }
}
