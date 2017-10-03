//
//  CMDChatCellView.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 10.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import EasyPeasy
import DateToolsSwift

enum CMDChatCellState {
    case hidden
    case notConfirmed
    case confirmed
    case error
    var image: UIImage {
        switch self {
        case .hidden:
            return UIImage()
        case .notConfirmed:
            return UIImage(named: "refreshMark")!
        case .confirmed:
            return UIImage(named: "checkMark")!
        case .error:
            return UIImage(named: "errorMark")!
        }
    }
}

enum CMDChatCellType: String {
    case Agent          = "agent"
    case Visitor        = "visitor"
    
    var cellBackgroundColor: UIColor {
        let isAgent = self == .Agent
        return isAgent ? UIColor.background.chatAgent : UIColor.background.chatVisitor
    }
    
    var messageTextColor: UIColor {
        let isAgent = self == .Agent
        return isAgent ? UIColor.textColor.chatAgent : UIColor.textColor.chatVisitor
    }
    
    var timestampTextColor: UIColor {
        let isAgent = self == .Agent
        return isAgent ? UIColor.textColor.chatAgentTimestamp : UIColor.textColor.chatVisitorTimestamp
    }
}

@IBDesignable class CMDChatCellView: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBInspectable var typeString: String? {
        didSet {
            updateType()
        }
    }
    
    var type: CMDChatCellType = .Agent {
        didSet {
            let isAgent = type == .Agent
            verifiedImage?.isHidden = isAgent
            backgroundColor = type.cellBackgroundColor
            timeStampLabel?.textColor = type.timestampTextColor
            additionalViewUpdate()
        }
    }
    
    var timestamp: Date = Date.init(timeIntervalSinceNow: -1000) {
        didSet {
            updateTimestampLabel()
        }
    }
    
    var state: CMDChatCellState = .confirmed {
        didSet {
            verifiedImage.image = state.image
        }
    }
    
    private var timeStampLabel: UILabel!
    private var verifiedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 4
        initSubviews()
        updateType()
    }
    
    func initSubviews() {
        timeStampLabel = CMDSettableLabel(text: "Time", andFont: UIFont.chat.timestamp, andColor: UIColor.white, andSpacing: 1.2)
        timeStampLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(timeStampLabel)
        
        verifiedImage = UIImageView(image: UIImage.init(named: "checkMark"))
        verifiedImage.contentMode = .scaleAspectFit
        verifiedImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(verifiedImage)
        setupConstraints()
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) {_ in
            self.updateTimestampLabel()
        }
    }
    
    private func updateTimestampLabel() {
        timeStampLabel.text = timestamp.timeAgoSinceNow
    }
    
    private func additionalViewUpdate() {
        if let label = contentView as? UILabel {
            label.textColor = type.messageTextColor
        }
    }
    
    private func setupConstraints() {
        timeStampLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8).isActive = true
        timeStampLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        timeStampLabel.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
        timeStampLabel.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        
        verifiedImage.widthAnchor.constraint(equalToConstant: 10).isActive = true
        verifiedImage.heightAnchor.constraint(equalToConstant: 10).isActive = true
        verifiedImage.centerYAnchor.constraint(equalTo: timeStampLabel.centerYAnchor, constant: 0).isActive = true
        verifiedImage.leadingAnchor.constraint(equalTo: timeStampLabel.trailingAnchor, constant: 4).isActive = true
        
        if type == .Agent {
            timeStampLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            trailingAnchor.constraint(greaterThanOrEqualTo: verifiedImage.trailingAnchor, constant: 10).isActive = true
        } else {
            timeStampLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 10).isActive = true
            trailingAnchor.constraint(equalTo: verifiedImage.trailingAnchor, constant: 8).isActive = true
        }
    }
    
    private func updateType() {
        if let typeString = typeString, let newType = CMDChatCellType(rawValue: typeString) {
            type = newType
        }
    }
}
