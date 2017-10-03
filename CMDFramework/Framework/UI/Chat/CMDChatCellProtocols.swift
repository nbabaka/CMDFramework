//
//  CMDChatCellProtocols.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 10.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

protocol CMDChatCellTypeBase {
    var state: CMDChatCellState { get set }
    var chatEvent: ChatEvent! { get set }
}

protocol CMDTextCellType: CMDChatCellTypeBase {
    var textContent: String? { get set }
}

protocol CMDUploadCell: CMDChatCellTypeBase, CMDChatUploadItemDelegate {
    var uploadItem: ChatUploadItem! { get set }
    func processUploaded()
}

protocol CMDAgentCellType: CMDChatCellTypeBase {
    var agentImage: UIImageView! { get }
    var agentName: CMDSettableLabel! {get}
    func setAgentAvatar(_ url: URL?)
    func setAgentName(_ name: String?)
}

@objc protocol CMDChatTapCellDelegate {
    func handleTap(_ gesture: UITapGestureRecognizer)
}

protocol CMDChatDataSourceUIDelegate {
    func updateChat()
    func showError(withText text: String)
}
