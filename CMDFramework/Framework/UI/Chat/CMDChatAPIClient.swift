//
//  CMDChatAPIClient.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 07.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import Foundation
import ZDCChatAPI
import AVFoundation

typealias eventReceivedBlock = (ChatEvent) -> Void
typealias eventUpdatedBlock = (ChatEvent) -> Void
typealias chatConnectionUpdatedBlock = (Bool) -> Void
typealias chatConnectionTimeoutBlock = () -> Void
typealias chatTimeoutReachedBlock = () -> Void
typealias chatAccountUpdatedBlock = (Bool) -> Void
typealias uploadReceivedBlock = (ChatUploadItem?) -> Void

class CMDChatAPIClient {
    let chat: ZDCChatAPI
    let eventManager = CMDChatEventManager()
    
    public static var shared = CMDChatAPIClient()

    var isConnected: Bool {
        return chat.connectionStatus == .connected
    }
    
    var isOnline: Bool {
        return chat.isAccountOnline
    }
    
    var chatStatus: ZDCChatSessionStatus {
        return chat.chatStatus
    }
    
    var connectionStatus: ZDCConnectionStatus {
        return chat.connectionStatus
    }
    
    var eventReceived: eventReceivedBlock?
    var eventUpdated: eventUpdatedBlock?
    var chatConnectionUpdated: chatConnectionUpdatedBlock?
    var chatConnectionTimeout: chatConnectionTimeoutBlock?
    var chatTimeoutReached: chatTimeoutReachedBlock?
    var chatAccountUpdated: chatAccountUpdatedBlock?
    var uploadReceived: uploadReceivedBlock?
    var timeoutConnection: Timer?
    
    init() {
        chat = ZDCChatAPI.instance()
        ZDCLog.enable(true)
        if UIApplication.isDebugMode() {
            ZDCLog.setLogLevel(ZDCLogLevel.debug)
        }
        chat.addObserver(self, forChatLogEvents: #selector(chatLogEvent(_:)))
        chat.addObserver(self, forConnectionEvents: #selector(chatConnectionStateUpdate(_:)))
        chat.addObserver(self, forAgentEvents: #selector(chatAgentEvent(_:)))
        chat.addObserver(self, forAccountEvents: #selector(chatAccountEvent(_:)))
        chat.addObserver(self, forTimeoutEvents: #selector(chatTimeoutEvent(_:)))
        chat.addObserver(self, forUploadEvents: #selector(chatUploadEvent(_:)))
    }
    
    deinit {
        chat.removeObserver(forChatLogEvents: self)
        chat.removeObserver(forConnectionEvents: self)
        chat.removeObserver(forAgentEvents: self)
        chat.removeObserver(forTimeoutEvents: self)
        chat.removeObserver(forTimeoutEvents: self)
        chat.removeObserver(forUploadEvents: self)
    }
    
    func startChat(withKey key: String) {
        let config = ZDCAPIConfig()
        chat.startChat(withAccountKey: key, config: config)
        setTimeoutTimer()
    }
    
    func onChatConnectionStateUpdate(_ block: @escaping chatConnectionUpdatedBlock) {
        chatConnectionUpdated = block
    }
    
    func onEventReceived(_ block: @escaping eventReceivedBlock) {
        eventReceived = block
    }
    
    func onEventUpdated(_ block: @escaping eventUpdatedBlock) {
        eventUpdated = block
    }
    
    func onChatConnectionTimeout(_ block: @escaping chatConnectionTimeoutBlock) {
        chatConnectionTimeout = block
    }
    
    func onChatTimeoutReached(_ block: @escaping chatTimeoutReachedBlock) {
        chatTimeoutReached = block
    }
    
    func onChatAccountUpdated(_ block: @escaping chatAccountUpdatedBlock) {
        chatAccountUpdated = block
    }
    
    func onUploadReceived(_ block: @escaping uploadReceivedBlock) {
        uploadReceived = block
    }
    
    func endChat() {
        chat.endChat()
    }
    
    func sendOffline(message: String) {
        chat.sendOfflineMessage(message)
    }
    
    func sendRating(isGood: Bool = true) {
        chat.send(isGood ? ZDCChatRating.good : ZDCChatRating.bad)
    }
    
    func updateProfile(withName name: String?, email: String?, note: String? = nil) {
        chat.visitorInfo.name = name ?? ""
        chat.visitorInfo.email = email ?? ""
        if note != nil {
            chat.visitorInfo.addNote(note!)
        }
        chat.visitorInfo.shouldPersist = true
    }
    
    func resumeChatIfNeeded() {
        for event in chat.livechatLog {
            if event.type == .rating && event != chat.livechatLog.last {
                continue
            }
            handleChatEvent(event)
        }
    }
    
    @objc func chatLogEvent(_ note: Notification) {
        let events = chat.livechatLog
        if let lastEvent = events?.last {
            handleChatEvent(lastEvent)
        }
    }
    
    @objc func chatUploadEvent(_ note: Notification) {
        guard let attachment = note.object as? ZDCChatUpload else {
            return
        }
        handleUpload(attachment)
    }
    
    @objc func chatConnectionStateUpdate(_ note: Notification) {
        print("Chat connection updated \(isConnected)")
        if isConnected {
            clearTimeoutTimer()
        }
        chatConnectionUpdated?(isConnected)
    }
    
    @objc func chatAgentEvent(_ note: Notification) {
        self.eventManager.agents = chat.agents.map { $0.1 }
    }
    
    @objc func chatAccountEvent(_ note: Notification) {
        chatAccountUpdated?(isOnline)
    }
    
    @objc func chatTimeoutEvent(_ note: Notification) {
        chatTimeoutReached?()
    }
    
    func send(message: String) {
        guard checkConnection() else {
            return
        }
        chat.sendChatMessage(message)
    }
    
    func uploadImage(_ image: UIImage) {
        guard checkConnection() else {
            return
        }
        
        guard let image = self.compress(image: image) else {
            return
        }
        
        chat.uploadImage(image, name: "attachment.jpg")
    }
    
    func uploadVideo(_ video: AVAsset?, onComplete block: @escaping (Bool) -> Void) {
        guard checkConnection() else {
            return
        }
        guard let video = video as? AVURLAsset else {
            return
        }
        self.compressAndUpload(inputURL: video.url, onComplete: block)
    }
    
    func checkConnection() -> Bool {
        guard self.isConnected else {
            print("Cannot send anything to disconnected chat")
            return false
        }
        return true
    }
    
    private func setTimeoutTimer() {
        self.clearTimeoutTimer()
        self.timeoutConnection = Timer.scheduledTimer(withTimeInterval: 30, repeats: false) { timer in
            self.clearTimeoutTimer()
            if !self.isConnected {
                self.chatConnectionTimeout?()
            }
        }
    }
    
    private func clearTimeoutTimer() {
        self.timeoutConnection?.invalidate()
        self.timeoutConnection = nil
    }
    
    private func compress(image: UIImage, toSizeInMb expectedSize: Float = 0.8) -> UIImage? {
        let sizeInBytes = Int(expectedSize * 1024 * 1024)
        var imgData: Data?
        var compressingValue: CGFloat = 1.0
        
        while compressingValue > 0.0 {
            if let data: Data = UIImageJPEGRepresentation(image, compressingValue) {
                if data.count < sizeInBytes {
                    imgData = data
                    break
                } else {
                    compressingValue -= 0.05
                }
            }
        }
        
        if let data = imgData {
            if (data.count < sizeInBytes) {
                return UIImage(data: data)
            }
        }
        
        return nil
    }
    
    private func compressAndUpload(inputURL : URL, onComplete: @escaping (Bool) -> Void ) {
        let videoAsset = AVAsset(url: inputURL) as AVAsset
        let clipVideoTrack = videoAsset.tracks(withMediaType: AVMediaType.video).first! as AVAssetTrack
        
        let composition = AVMutableComposition()
        composition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: CMPersistentTrackID())
        
        let videoComposition = AVMutableVideoComposition()
        let size = clipVideoTrack.naturalSize
        let cof: CGFloat = 1
        videoComposition.renderSize = CGSize(width: size.width * cof, height: size.height * cof)
        videoComposition.frameDuration = CMTimeMake(1, 24)
        
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRangeMake(kCMTimeZero, CMTimeMakeWithSeconds(180, 24))
        
        let transformer : AVMutableVideoCompositionLayerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: clipVideoTrack)
        let t1 = CGAffineTransform(scaleX: cof, y: cof)
        transformer.setTransform(t1, at: kCMTimeZero)
        
        instruction.layerInstructions = [transformer]
        videoComposition.instructions = [instruction]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "_HHmmss"
        let date = Date()
        let filename = inputURL.deletingPathExtension().lastPathComponent
        let tempDir = NSTemporaryDirectory() + filename + formatter.string(from: date) + ".mov"
        let outputURL = URL.init(fileURLWithPath: tempDir)
        
        let exporter = AVAssetExportSession(asset: videoAsset, presetName: AVAssetExportPresetMediumQuality)
        exporter!.videoComposition = videoComposition
        exporter!.outputURL = outputURL
        exporter!.outputFileType = AVFileType.mp4 //  AVFileTypeQuickTimeMovie
        exporter?.exportAsynchronously(completionHandler: { () -> Void in
            main {
                guard let video = try? Data(contentsOf: outputURL) else {
                    return
                }
                let status = exporter!.status == AVAssetExportSessionStatus.completed
                onComplete(status)
                if status {
                    self.chat.uploadFile(with: video, name: outputURL.lastPathComponent)
                }
            }
        })
    }
    
    private func handleChatEvent(_ event: ZDCChatEvent) {
        print("Received event \(event.eventId), type \(event.type.rawValue), message \(event.message)")
        if (event.timestamp == nil) {
            return
        }
        newEventReceived(event)
    }
    
    private func newEventReceived(_ event: ZDCChatEvent) {
        switch eventManager.handleEvent(event) {
        case let .new(event):
            eventReceived?(event)
            break
        case let .update(event):
            eventUpdated?(event)
            break
        case .none:
            break
        }
    }
    
    private func handleUpload(_ file: ZDCChatUpload) {
        print("Upload information received about \(file.fileName) with Error \(file.errorType.rawValue)")
        uploadReceived?(eventManager.uploadItem(withFile: file))
    }
}
