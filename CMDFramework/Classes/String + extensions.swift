//
//  String + Extensions.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 16/08/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import Foundation

public extension String {
    var l:String {
        get {
            return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: self, comment: self)
        }
    }
}
