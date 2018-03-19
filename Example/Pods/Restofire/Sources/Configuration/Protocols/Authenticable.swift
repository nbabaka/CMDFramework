//
//  Authenticable.swift
//  Restofire
//
//  Created by Rahul Katariya on 23/04/16.
//  Copyright © 2016 AarKay. All rights reserved.
//

import Foundation

/// Represents an `Authenticable` that is associated with `Requestable`.
public protocol Authenticable {
    
    /// The `authentication`.
    var authentication: Authentication { get }
    
}

extension Authenticable where Self: AConfigurable {
    
    /// `Authentication.default`
    public var authentication: Authentication {
        return Authentication.default
    }
    
}
