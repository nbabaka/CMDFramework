//
//  Alert.swift
//
//  Created by Victor Shcherbakov on 2/12/16.
//  Copyright © 2016 Underlama. All rights reserved.
//

/// Shows UIAlertViewcontroller in convinence way!
///
/// - parameter title:          Alert or sheet title, "Warning" by default
/// - parameter message:        Message text
/// - parameter buttons:        String array with buttons, only "OK" button by defualt
/// - parameter viewController: Presenting view controller, rootViewController used by default
/// - parameter style:          UIAlertViewController style: .sheet or .alert
/// - parameter completion:     Block called after after UIAlertViewController is dismissed, button index is porvided

public func alert(title:String = "Warning".l, message:String, buttons:[String] = ["OK".l], fromViewController viewController:UIViewController? = nil, style:UIAlertControllerStyle = .alert, completion:((Int) -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    
    for (index, title) in buttons.enumerated() {
        alertController.addAction(UIAlertAction(title: title, style: .default, handler: { (action) -> Void in
            completion?(index)
        }))
    }
    
    guard let viewController = viewController else {
        // Use "default controller" if specific controller is not provided
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        return
    }
    
    viewController.present(alertController, animated: true, completion: nil)
}
