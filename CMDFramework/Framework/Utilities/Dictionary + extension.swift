//
//  Dictionary + extension.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 26/04/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import Foundation

public extension Dictionary {
    public mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
    
    public func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
}
