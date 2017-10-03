//
//  CMDAgentImageCell.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 11.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

class CMDAgentImageCell: CMDUploadChatCell, CMDAgentCellType {
    @IBOutlet var agentImage: UIImageView!
    @IBOutlet var agentName: CMDSettableLabel!
    
    override var chatEvent: ChatEvent! {
        didSet{
            super.chatEvent = chatEvent
            if let agentEvent = chatEvent as? AgentEventType {
                setAgentAvatar(agentEvent.avatarURL)
                setAgentName(agentEvent.name)
            }
        }
    }
}
