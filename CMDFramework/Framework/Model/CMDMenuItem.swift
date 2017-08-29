//
//  CMDMenuItem.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 12/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

public typealias CMDMenuItemActionBlock = (Void) -> Void

open class CMDMenuItem {
    public var title: String?
    public var action: CMDMenuItemAction?
    public var icon: CMDMenuItemIcon?
    public var hideMenu: Bool = true
    public var selectable: Bool = true
    public var visible: Bool = true
    public var needAuth: Bool = false
    
    public func makeAction() {
        self.action?.makeAction()
    }
}

open class CMDMenuItemAction: NSObject {
    public var action: CMDMenuItemActionBlock?
    public init(presentWithID id: String, target: UIViewController?, values: [String: Any]? = nil) {
        super.init()
        self.action = {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: id) 
            viewController.modalPresentationStyle = .overCurrentContext
            if let valuesDic = values {
                viewController.setValuesForKeys(valuesDic)
            }
            target?.present(viewController, animated: true, completion: nil)
        }
    }
    
    public init(withSelector selector: Selector, data: Any?) {
        super.init()
        self.action = {
            self.perform(selector, with: data)
        }
    }
    
    public init(withClosure: @escaping CMDMenuItemActionBlock) {
        super.init()
        self.action = withClosure
    }
    
    public convenience init(changeWithID id: String, target: UIViewController?, values: [String: Any]? = nil) {
        self.init(changeWithID: id, storyBoard: "Main", target: target, values: values)
    }
    
    public init(changeWithID id: String, storyBoard: String, target: UIViewController?, values: [String: Any]? = nil) {
        super.init()
        self.action = {
            let storyBoard = UIStoryboard(name: storyBoard, bundle: nil)
            let viewController = storyBoard.instantiateViewController(withIdentifier: id)
            if let navigationController = target?.sideMenuController?.rootViewController as? UINavigationController {
                navigationController.setViewControllers([viewController], animated: CMDConstants.menuAnimated)
            }
        }
    }
    
    public func makeAction() {
        self.action?()
    }
}


public struct CMDMenuItemIcon {
    private var image: [CMDMenuItemIconState: UIImage]
    
    mutating func setIconForState(_ state: CMDMenuItemIconState, image: UIImage) {
        self.image[state] = image
    }
    
    public init(normalImage: UIImage, highlightImage: UIImage) {
        self.image = [CMDMenuItemIconState: UIImage]()
        self.image[.normal] = normalImage
        self.image[.highlight] = highlightImage
    }
    
    public init(_ icon: UIImage) {
        self.image = [CMDMenuItemIconState: UIImage]()
        self.image[.normal] = icon
    }
    
    public func getIconForState(_ state: CMDMenuItemIconState) -> UIImage? {
        return self.image[state]
    }
}

public enum CMDMenuItemIconState {
    case normal
    case highlight
}
