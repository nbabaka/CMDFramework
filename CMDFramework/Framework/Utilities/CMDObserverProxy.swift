//
//  CMDObserverProxy.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 24.08.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import UIKit

open class CMDObserverProxy: NSObject {
    
    open var closure: ((Notification) -> ())?
    open var name: Notification.Name!
    open var object: AnyObject?
    
    public convenience init(name: Notification.Name, closure: @escaping (Notification) -> ()) {
        self.init()
        self.closure = closure
        self.name = name
        self.start()
    }
    
    public convenience init(name: Notification.Name, object: AnyObject, closure: @escaping (Notification) -> ()) {
        self.init(name: name, closure: closure)
        self.object = object
    }
    
    deinit {
        stop()
    }
    
    public func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handler(_:)), name: name, object: object)
    }
    
    public func stop() {
        NotificationCenter.default.removeObserver(self);
    }
    
    @objc func handler(_ notification: Notification) {
        closure?(notification);
    }
}
