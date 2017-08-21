//
//  UIDevice+extension.swift
//  volumeControl
//
//  Created by Karataev Nikolay on 28.02.17.
//  Copyright © 2017 Karataev Nikolay. All rights reserved.
//

public extension UIDevice {
    public static var isSimulator: Bool {
        return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
    }
    
    public static func simulatorAssert() {
        if !UIApplication.isDebugMode() {
            assert(!UIDevice.isSimulator, "Not possible to run this application on SIMULATOR")
        }
    }
}
