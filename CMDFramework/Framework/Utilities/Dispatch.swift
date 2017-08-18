//
//  Dispatch.swift
//  CinemoodApp
//
//  Created by Victor Shcherbakov on 10/4/16.
//  Copyright © 2016 Underlama. All rights reserved.
//

import Foundation

public func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

public func main(_ closure:@escaping ()->()) {
    DispatchQueue.main.async {
        closure()
    }
}

public func async(_ closure:@escaping ()->()) {
    let queue = OperationQueue()
    queue.addOperation { 
        closure()
    }
}
