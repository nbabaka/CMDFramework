//
//  CMDMenuLoader.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 12/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

public class CMDMenuItemsManager: NSObject {
    public static var shared = CMDMenuItemsManager()
    
    private var target: UIViewController?
    private var menuItems = [CMDMenuItem]()
    private var isAuth: Bool = false
    
    public func getTarget() -> UIViewController? {
        return target
    }
    
    public func initMenuItems(withTarget target: UIViewController, menuItems items: [CMDMenuItem], andAuth auth: Bool) {
        self.target = target
        self.isAuth = auth
        self.menuItems.removeAll()
        self.menuItems = items
    }
    
    public func getVisible() -> [CMDMenuItem] {
        return menuItems.filter { $0.isVisible(withAuth: self.isAuth) }
    }
    
    public func getVisibleCount() -> Int {
        return getVisible().count
    }
}

public extension CMDMenuItem {
    public func isVisible(withAuth auth: Bool)  -> Bool {
        guard self.visible else {
            return false
        }
        if needAuth && !auth {
            return false
        }
        return true
    }
}
