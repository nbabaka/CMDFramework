//
//  CMDChatSystemCell.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 13.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

class CMDChatSystemCell: UITableViewCell, CMDChatCellTypeBase {
    @IBOutlet weak var messageLabel: CMDSettableLabel!
    var state: CMDChatCellState = .hidden
    
    var chatEvent: ChatEvent! {
        didSet {
            if let chatTextCell = chatEvent as? ChatMessageEventType {
                messageLabel.t = chatTextCell.text
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageLabel.myFont = UIFont.chat.system
        messageLabel.myColor = UIColor.textColor.chatSystem
    }
}
