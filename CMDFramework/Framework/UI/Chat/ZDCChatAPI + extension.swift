//
//  ZDCChatAPI + extension.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 07.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import Foundation
import ZDCChatAPI
import SDWebImage

extension ZDCChatEvent {
    var swiftTimestamp: Date {
        return Date.init(timeIntervalSince1970: self.timestamp.doubleValue / 1000.0)
    }
    
    var toEventType:EventType? {
        switch self.type {
        case .agentMessage:
            return EventType.agentMessage
        case .agentUpload:
            return EventType.agentImage
        case .memberJoin, .memberLeave:
            return EventType.systemMessage
        case .rating:
            return EventType.rating
        case .systemMessage:
            return EventType.systemMessage
        case .triggerMessage:
            return EventType.triggerMessage
        case .visitorMessage:
            return EventType.visitorMessage
        case .visitorUpload:
            return EventType.visitorImage
        default:
            return nil
        }
    }
}
