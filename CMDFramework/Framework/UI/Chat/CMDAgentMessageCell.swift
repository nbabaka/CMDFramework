//
//  CMDAgentMessageCell.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 10.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

class CMDAgentMessageCell: CMDMessageChatCell, CMDAgentCellType {
    @IBOutlet var agentImage: UIImageView!
    @IBOutlet var agentName: CMDSettableLabel!
    
    override var chatEvent: ChatEvent! {
        didSet {
            super.chatEvent = chatEvent
            if let agentEvent = chatEvent as? AgentEventType {
                setAgentAvatar(agentEvent.avatarURL)
                setAgentName(agentEvent.name)
            }
        }
    }
}

extension CMDAgentCellType {
    func setAgentAvatar(_ url: URL?) {
        self.agentImage.contentMode = .scaleAspectFit
        self.agentImage.backgroundColor = UIColor.background.chatAgent
//        if url != nil {
//            self.agentImage.sd_setImage(with: url)
//        } else {
        self.agentImage.image = #imageLiteral(resourceName: "user")
//        }
    }
    
    func setAgentName(_ name: String?) {
        agentName.t = name
    }
}

class CMDAgentImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}

class CMDAgentNameLabel: CMDSettableLabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.myFont = UIFont.chat.agentName
        self.myColor = UIColor.textColor.chatAgentName
        self.mySpacing = 1.2
    }
}
