////
////  CMDChat.swift
////  CinemoodApp
////
////  Created by Karataev Nikolay aka Babaka on 07.07.17.
////  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
////
//
//import ZDCChatAPI
//
//protocol ChatEvent {
//    var id: String { get }
//    var confirmed: Bool { get set }
//    var type: EventType  { get }
//    var timeStamp: Date { get }
//}
//
//protocol AgentEventType {
//    var avatarURL: URL? { set get }
//    var name: String? { get }
//}
//
//protocol ChatMessageEventType: ChatEvent {
//    var text: String  { get }
//}
//
//protocol ChatActionEventType: ChatMessageEventType {
//    var buttonOrder: UILayoutConstraintAxis { get }
//    var buttons: [CMDButtonBase]? { get set }
//}
//
//protocol ChatUploadItemType: ChatEvent {
//    var uploadItem: ChatUploadItem? { get set }
//}
//
//enum EventType {
//    case agentMessage
//    case agentImage
//    case visitorMessage
//    case visitorImage
//    case triggerMessage
//    case systemMessage
//    case action
//    case rating
//}
//
//enum EventState {
//    case new(ChatEvent)
//    case update(ChatEvent)
//    case none
//}
//
//struct ChatActionEvent: ChatActionEventType {
//    var confirmed: Bool = true
//    var buttons: [CMDButtonBase]?
//    var buttonOrder: UILayoutConstraintAxis
//    let id: String
//    let type: EventType
//    let timeStamp: Date = Date()
//    let text: String
//}
//
//struct ChatSystemEvent: ChatMessageEventType {
//    let id: String = String.random()
//    var confirmed: Bool = true
//    let type: EventType = .systemMessage
//    let timeStamp: Date = Date()
//    let text: String
//}
//
//struct ChatVisitorMessageEvent: ChatMessageEventType {
//    let id: String
//    var confirmed: Bool
//    let type: EventType = .visitorMessage
//    let timeStamp: Date
//    let text: String
//}
//
//struct ChatAgentMessageEvent: ChatMessageEventType, AgentEventType {
//    var name: String?
//    let id: String
//    var confirmed: Bool
//    let type: EventType = .agentMessage
//    let timeStamp: Date
//    let text: String
//    var avatarURL: URL? = nil
//}
//
//struct ChatVisitorUploadEvent: ChatUploadItemType {
//    let id: String
//    var confirmed: Bool
//    let type: EventType = .visitorImage
//    let timeStamp: Date
//    var uploadItem: ChatUploadItem?
//}
//
//struct ChatAgentUploadEvent: ChatUploadItemType, AgentEventType {
//    var name: String?
//    let id: String
//    var confirmed: Bool
//    let type: EventType = .agentImage
//    let timeStamp: Date
//    var uploadItem: ChatUploadItem?
//    var avatarURL: URL? = nil
//}
//
