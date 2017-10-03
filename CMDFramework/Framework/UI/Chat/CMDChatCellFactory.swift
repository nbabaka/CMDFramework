//
//  CMDChatCellFactory.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 10.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

class CMDChatCellFactory: NSObject {
    class func registerCells(withTable tableView: UITableView, nibs: [String]) {
        tableView.register(nibNames: nibs)
    }
    
    class func construct(withTable tableView: UITableView, indexPath: IndexPath, event: ChatEvent, target: CMDChatTapCellDelegate) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: event.type.identifier, for: indexPath)

        if let upload = cell as? CMDUploadChatCell {
            let tap = UITapGestureRecognizer.init(target: target, action: #selector(target.handleTap(_:)))
            upload.imageContentView.addGestureRecognizer(tap)
            upload.imageContentView.isUserInteractionEnabled = true
        }
        
        if var th = cell as? CMDChatCellTypeBase {
            th.chatEvent = event
        }
        
        return cell
    }
}

extension EventType {
    var identifier: String {
        switch self {
        case .agentMessage:
            return "CMDAgentMessageCell"
        case .visitorMessage:
            return "CMDVisitorMessageCell"
        case .visitorImage:
            return "CMDVisitorImageCell"
        case .agentImage:
            return "CMDAgentImageCell"
        case .triggerMessage:
            return "CMDAgentMessageCell"
        case .systemMessage:
            return "CMDChatSystemCell"
        case .rating, .action:
            return "CMDChatActionCell"
        }
    }
}
