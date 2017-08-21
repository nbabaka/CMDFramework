//
//  CMDVCKeyboardProtocols.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 15.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

public enum CMDKeyboardDependenceOption {
    case will
    case did
}

public protocol CMDKeyboardDependence {
    var keyboardShow: CMDKeyboardDependenceOption { get set }
    var keyboardHide: CMDKeyboardDependenceOption { get set }
    var willRegisterKeyboardHandle: Bool { get set }
    func registerKeyboardNotifications(isBeforeShow willShow: CMDKeyboardDependenceOption, isBeforeHide willHide: CMDKeyboardDependenceOption)
    func unregisterKeyboardNotifications()
    func keyboardShow(_ notification: Notification)
    func keyboardHide(_ notification: Notification)
}

public extension CMDKeyboardDependence where Self: UIViewController {
    public func registerKeyboardNotifications(isBeforeShow willShow: CMDKeyboardDependenceOption = .will, isBeforeHide willHide: CMDKeyboardDependenceOption = .will) {
        guard willRegisterKeyboardHandle else {
            return
        }
        
        NotificationCenter.default.addObserver(forName: keyboardShow == .will ? Notification.Name.UIKeyboardWillShow : Notification.Name.UIKeyboardDidShow, object: nil, queue: nil) { (notification) in
            self.keyboardShow(notification)
        }
        
        NotificationCenter.default.addObserver(forName: keyboardHide == .will ? Notification.Name.UIKeyboardWillHide : Notification.Name.UIKeyboardDidHide, object: nil, queue: nil) { (notification) in
            self.keyboardHide(notification)
        }
    }
    
    public func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardDidHide, object: nil)
    }
}
