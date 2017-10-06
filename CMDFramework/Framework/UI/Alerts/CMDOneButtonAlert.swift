//
//  CMDOneButtonAlert.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 05.04.17.
//  Copyright © 2017 Cinemood. All rights reserved.
//

import EasyPeasy

public typealias CMDOneButtonAlertBlock = () -> Void
open class CMDOneButtonAlert: CMDAlertViewBase {
    open var text : String {
        get {
            return button.text!
        }
        set {
            button.text = newValue
        }
    }
    
    private var button = CMDBlueButton()
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        button <- CenterX()
        button <- Bottom(69)
        button <- Left(50)
        button <- Right(50)
        button <- Height(66)
    }
    
    open func onPushButton(_ block: @escaping CMDOneButtonAlertBlock) {
        self.button.onPushButtonBlock = block
    }
    
    override open func initAdditionalViews() {
        self.addSubview(button)
        onPushButton { self.close(.moveDown) }
    }
}
