//
//  Double + extension.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 06/06/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import Foundation

public extension Double {
    public func getDateStringFromUnixTime(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}
