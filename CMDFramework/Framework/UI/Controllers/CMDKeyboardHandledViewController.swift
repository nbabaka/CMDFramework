//
//  CMDKeyboardHandledViewController.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 15.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

open class CMDKeyboardHandledViewController: BaseViewController, CMDKeyboardDependence {
    public var keyboardShow: CMDKeyboardDependenceOption = .will
    public var keyboardHide: CMDKeyboardDependenceOption = .did
    public var willRegisterKeyboardHandle: Bool = false

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.registerKeyboardNotifications(isBeforeShow: keyboardShow, isBeforeHide: keyboardHide)
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.unregisterKeyboardNotifications()
    }
    
    open func keyboardShow(_ notification: Notification) {
        // Override it
    }
    
    open func keyboardHide(_ notification: Notification) {
        // Override it
    }
}
