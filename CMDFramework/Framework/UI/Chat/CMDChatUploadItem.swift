//
//  CMDChatUploadItem.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 20.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import ZDCChatAPI

protocol CMDChatUploadItemDelegate {
    var loadingProgress: CMDLoadProgress? { get set }
}

class ChatUploadItem: NSObject {
    enum FileType: String {
        case mov            = "mov"
        case jpg            = "jpg"
        case png            = "png"
        case gif            = "gif"
        case pdf            = "pdf"
        case txt            = "txt"
        case unknown        = "unknown"
        case nofile         = ""
        var isImage: Bool {
            switch self {
            case .gif, .jpg, .png:
                return true
            default:
                return false
            }
        }
    }
    
    var urlString: String? {
        didSet {
            guard let urlString = urlString else {
                return
            }
            url = URL(string: urlString)
        }
    }
    
    var file: ZDCChatUpload? {
        didSet {
            self.urlString = file?.uploadURL
        }
    }
    
    var url: URL?
    var error: Bool {
        guard let status = file?.status else {
            return false
        }
        return status == .error
    }
    
    var attachment: Bool = false
    
    var isLoaded: Bool {
        guard let file = self.file else {
            return attachment
        }
        return file.status == .complete
    }
    
    var image: UIImage?
    var delegate: CMDChatUploadItemDelegate?
    
    convenience init(withFile file: ZDCChatUpload, andEvent event: ZDCChatEvent?) {
        self.init()
        self.initWithFile(file, andEvent: event)
    }
    
    func attachment(_ attach: ZDCChatAttachment) {
        self.urlString = attach.url
        self.attachment = true
    }
    
    func getType() -> FileType {
        guard let url = self.url else {
            return .nofile
        }
        
        if self.image != nil {
            return .jpg
        }
        
        let urlExtension = url.pathExtension.lowercased()
        return FileType(rawValue: urlExtension) ?? .unknown
    }
    
    private func initWithFile(_ file: ZDCChatUpload, andEvent event: ZDCChatEvent?) {
        self.file = file
        
        guard let event = event else {
            return
        }
        
        switch file.status {
        case .complete:
            self.urlString = event.attachment.url
            self.attachment = true
        case .transfering:
            file.progressListener = self
        default:
            break
        }
        
        guard let image = file.image else {
            return
        }
        
        self.image = image
    }
}

extension ChatUploadItem: ZDCUploadDelegate {
    func progressUpdate(_ progress: Float) {
        self.delegate?.loadingProgress?.set(value: progress)
    }
}
