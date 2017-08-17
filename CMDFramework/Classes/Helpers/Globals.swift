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

