//
//  CMDChatDataSource.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 21.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

class CMDChatDataSource: NSObject {
    var delegate: CMDChatDataSourceUIDelegate?
    private var chatLog: [ChatEvent]! {
        didSet {
            updateDelegate()
        }
    }
    
    override init() {
        super.init()
        self.chatLog = [ChatEvent]()
    }
    
    func append(with event: ChatEvent) {
        guard !chatLog.contains(where: { $0.id == event.id }) else {
            return
        }
        self.chatLog.append(event)
    }
    
    func value(at index: Int) -> ChatEvent {
        return chatLog[index]
    }
    
    func count() -> Int {
        return chatLog.count
    }
    
    func update(withId id: String, updateBlock: (inout ChatEvent) -> ()) {
        guard let (index, item) = chatLog.enumerated().filter({ $1.id == id }).first else {
            return
        }
        var retItem = item
        updateBlock(&retItem)
        chatLog[index] = retItem
    }
    
    func addAction(_ action: ChatActionEvent) {
        clearAction()
        self.append(with: action)
    }
    
    func addSystem(withText text: String) {
        let systemAction = ChatSystemEvent(confirmed: true, text: text)
        chatLog.append(systemAction)
    }
    
    func clearAction() {
        chatLog = chatLog.filter { $0.type != .action && $0.type != .rating }
    }
    
    func removeAll() {
        chatLog.removeAll()
    }
    
    func handleUpload(_ item: ChatUploadItem) {
        if let error = item.file?.errorType {
            switch error {
            case .errorSize:
                delegate?.showError(withText: "CHAT_ERROR_SIZE".podLocalization)
                return
            case .errorType:
                delegate?.showError(withText: "CHAT_ERROR_TYPE".podLocalization)
                return
            case .fileSendingDisabled:
                delegate?.showError(withText: "CHAT_ERROR_UPLOADDISABLED".podLocalization)
                return
            default:
                break
            }
        }
        
        chatLog.forEach {
            if let upload = $0 as? ChatUploadItemType {
                if let uploadItem = upload.uploadItem {
                    if uploadItem.file == item.file && item.error {
                        updateDelegate()
                    }
                }
            }
        }
    }
    
    private func updateDelegate() {
        self.delegate?.updateChat()
    }
}
