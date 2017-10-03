//
//  CMDChatEventManager.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 07.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import ZDCChatAPI

class CMDChatEventManager {
    internal var events: [String: ChatEvent]
    internal var agents: [ZDCChatAgent]
    internal var duplicateUpload: [String: String]
    internal var upload: [String: ChatUploadItem]
    
    init() {
        self.events = [String: ChatEvent]()
        self.duplicateUpload = [String: String]()
        self.agents = [ZDCChatAgent]()
        self.upload = [String: ChatUploadItem]()
    }
    
    func handleEvent(_ event: ZDCChatEvent) -> EventState {
        guard let filteredEvent = filterEvents(event) else {
            return .none
        }
        
        var chatItem = self.chatItem(forEvent: filteredEvent)
        if var agentItem = chatItem as? AgentEventType {
            if let url = getAgentAvatar(byName: agentItem.name ?? "") {
                agentItem.avatarURL = URL(string: url)
                chatItem = agentItem as! ChatEvent
            }
        }
        
        defer {
            self.events[chatItem.id] = chatItem
        }
        
        if events.keys.contains(chatItem.id) {
            return .update(chatItem)
        } else {
            return .new(chatItem)
        }
    }
    
    private func getAgentAvatar(byName name: String) -> String? {
        for agent in agents {
            if agent.displayName == name {
                return agent.avatarURL
            }
        }
        return nil
    }
    
    private func checkDupes(withEvent event: ZDCChatEvent) -> Bool {
        return events.contains(where: { (key, value) in
            guard let type = event.toEventType else {
                return false
            }
            if value.type != type {
                return false
            }
            
            guard let messageValue = value as? ChatMessageEventType else {
                return value.timeStamp == event.swiftTimestamp ? true : false
            }
            
            guard let eventMessage = event.message else {
                return false
            }
            return (messageValue.timeStamp == event.swiftTimestamp && messageValue.text == eventMessage ) ? true : false
        })
    }
    
    private func filterEvents(_ event: ZDCChatEvent) -> ZDCChatEvent? {
        if event.type == .unknown
            || event.type == .ratingComment {
            return nil
        }
        
        if checkDupes(withEvent: event) {
            return nil
        }
        
        if event.rating != .unrated {
            return nil
        }
        
        if event.type != .visitorUpload {
            return event
        }
        
        if event.fileUpload == nil {
            return event
        }
        
        if let uid = duplicateUpload[event.fileUpload.uploadURL] {
            event.eventId = uid
        }
        
        duplicateUpload[event.fileUpload.uploadURL] = event.eventId
        return event
    }
    
    func uploadItem(withFile file: ZDCChatUpload) -> ChatUploadItem? {
        let filter = upload.filter{$0.value.file == file}
        return filter.map {$0.value}.first
    }
    
    private func uploadItem(forEvent event: ZDCChatEvent) -> ChatUploadItem? {
        var item: ChatUploadItem? = nil
        if let file = event.fileUpload {
            if let url = file.uploadURL {
                if upload[url] != nil {
                    upload[url]?.file = file
                } else {
                    upload[url] = ChatUploadItem(withFile: file, andEvent: event)
                }
                
                item = upload[url]
            }
        }
        
        if let attach = event.attachment {
            if item == nil {
                item = ChatUploadItem()
            }
            item?.attachment(attach)
        }
        
        return item
    }
    
    private func chatItem(forEvent event: ZDCChatEvent) -> ChatEvent {
        let date = event.swiftTimestamp
        switch event.type {
        case .triggerMessage, .agentMessage:
            return ChatAgentMessageEvent(name: event.displayName, id: event.eventId, confirmed: event.verified, timeStamp: date, text: event.message, avatarURL: nil)
        case .visitorMessage:
            return ChatVisitorMessageEvent(id: event.eventId, confirmed: event.verified, timeStamp: date, text: event.message)
        case .visitorUpload:
            var confirmedState = false
            if let uploadState = event.fileUpload {
                confirmedState = uploadState.status == .complete
            } else {
                confirmedState = true
            }
            return ChatVisitorUploadEvent(id: event.eventId, confirmed: confirmedState, timeStamp: date, uploadItem: self.uploadItem(forEvent: event))
        case .agentUpload:
            return ChatAgentUploadEvent(name: event.displayName, id: event.eventId, confirmed: true, timeStamp: date, uploadItem: self.uploadItem(forEvent: event), avatarURL: nil)
        case .memberJoin:
            return ChatSystemEvent(confirmed: true, text: String(format: "CHAT_AGENT_JOIN".l, event.displayName))
        case .memberLeave:
            return ChatSystemEvent(confirmed: true, text: String(format: "CHAT_AGENT_LEAVE".l, event.displayName))
        case .rating:
            if event.rating == .unrated {
                let rateUp = CMDClassicButton(withImage: #imageLiteral(resourceName: "rateDown"), andText: "CHAT_RATING_BAD".l) {
                    NotificationCenter.default.post(name: Notification.Name.Chat.didChatRate, object: false)
                }
                let rateDown = CMDClassicButton(withImage: #imageLiteral(resourceName: "rateUp"), andText: "CHAT_RATING_GOOD".l) {
                    NotificationCenter.default.post(name: Notification.Name.Chat.didChatRate, object: true)
                }
                return ChatActionEvent(confirmed: true, buttons: [rateDown, rateUp], buttonOrder: .horizontal, id: event.eventId, type: .rating, text: "CHAT_RATING".l)
            } else {
                return ChatSystemEvent(confirmed: true, text: String(format: "CHAT_AGENT_JOIN".l, event.rating.rawValue))
            }
        default:
            return ChatSystemEvent(confirmed: true, text: "Type not supported")
        }
    }
}

