//
//  CMDChatCell.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 10.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

class CMDChatCell: UITableViewCell, CMDChatCellTypeBase {
    @IBOutlet var view: CMDChatCellView!
    var chatEvent: ChatEvent! {
        didSet {
            state = chatEvent.confirmed ? .confirmed : .notConfirmed
            view.timestamp = chatEvent.timeStamp
        }
    }
    var state: CMDChatCellState {
        get {
            return view.state
        }
        set {
            view.state = newValue
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCell()
    }
    
    private func initCell() {
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
