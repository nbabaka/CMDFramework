//
//  Globals.swift
//  CINEMOOD Apps Framework
//
//  Created by Nikolay Karataev aka Babaka on 15.08.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import UIKit

public struct ScreenSize
{
    public static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    public static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    public static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    public static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

public struct DeviceType
{
    public static let IS_IPHONE_5_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH <= 568.0
    public static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    public static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    public static let IS_IPHONE_7          = IS_IPHONE_6
    public static let IS_IPHONE_7P         = IS_IPHONE_6P
    public static let IS_IPAD_ANY          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH >= 1024.0
    public static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    public static let IS_IPAD_PRO_9_7      = IS_IPAD
    public static let IS_IPAD_PRO_12_9     = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}

public func calculateSpacingWithDevice(fromValue spacing: Float) -> Float {
    if DeviceType.IS_IPHONE_5_OR_LESS {
        return min(spacing / 2, 1)
    }
    if DeviceType.IS_IPAD {
        return spacing * 1.5
    }
    return spacing
}

public func getImageFromUrl(_ url: String, onComplete: @escaping (UIImage?) -> Void) {
    DispatchQueue.global(qos: .background).async {
        guard let url = URL(string: url) else {
            onComplete(nil)
            return
        }
        let data = try? Data(contentsOf: url)
        DispatchQueue.main.async {
            onComplete((data != nil) ? UIImage(data: data!) : nil)
        }
    }
}

public func getBundleFilePath(bundle: String) -> String? {
    let path = Bundle(for: BaseView.self).path(forResource: bundle, ofType: "bundle")
    return path
}

public func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
    var i = 0
    return AnyIterator {
        let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
        if next.hashValue != i { return nil }
        i += 1
        return next
    }
}

public func associatedObject<ValueType: AnyObject>(base: AnyObject, key: UnsafePointer<String>, initialiser: () -> ValueType) -> ValueType {
    if let associated = objc_getAssociatedObject(base, key) as? ValueType {
        return associated
    }
    let associated = initialiser()
    objc_setAssociatedObject(base, key, associated, .OBJC_ASSOCIATION_RETAIN)
    return associated
}

public func associateObject<ValueType: AnyObject>(base: AnyObject, key: UnsafePointer<String>, value: ValueType) {
    objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_RETAIN)
}

public func getImageFromBundle(name: String, withClass: AnyClass) -> UIImage {
    let podBundle = Bundle(for: withClass.self)
    if let url = podBundle.url(forResource: "Assets", withExtension: "bundle") {
        let bundle = Bundle(url: url)
        return UIImage(named: name, in: bundle, compatibleWith: nil)!
    }
    return UIImage()
}
