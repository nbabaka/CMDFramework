//
//  CMDMessageChatCell.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 10.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import ActiveLabel

class CMDMessageChatCell: CMDChatCell {
    @IBOutlet var messageLabel: ActiveLabel!
    var textContent: String? {
        set {
            self.messageLabel.text = newValue
        }
        get {
            return self.messageLabel.text
        }
    }
    
    override var chatEvent: ChatEvent! {
        didSet {
            super.chatEvent = chatEvent
            if let chatTextCell = chatEvent as? ChatMessageEventType {
                textContent = chatTextCell.text
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageLabel.font = UIFont.chat.text
        self.messageLabel.numberOfLines = 0
        self.messageLabel.enabledTypes = [.url]
        self.messageLabel.URLColor = UIColor.textColor.chatURL
        self.messageLabel.URLSelectedColor = UIColor.textColor.chatURL
        self.messageLabel.handleURLTap { url in
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
