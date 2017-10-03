//
//  CMDChatActionCell.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 13.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import EasyPeasy

class CMDChatActionCell: CMDChatSystemCell {
    @IBOutlet weak var buttonsView: UIStackView!
    
    var buttons = [CMDButtonBase]()
    var buttonOrder: UILayoutConstraintAxis! = .vertical
    
    override var chatEvent: ChatEvent! {
        didSet {
            super.chatEvent = chatEvent
            if let action = chatEvent as? ChatActionEventType {
                clearButtons()
                if let buttons = action.buttons {
                    self.buttons = buttons
                    self.buttonOrder = action.buttonOrder
                    initButtons()
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageLabel.myFont = UIFont.chat.text
    }
    
    private func initButtons() {
        buttonsView.axis = buttonOrder
        if buttonOrder == .vertical {
            buttonsView.layoutMargins = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)
            buttonsView.isLayoutMarginsRelativeArrangement = true
            buttonsView.distribution = .equalSpacing
        } else {
            buttonsView.distribution = .fillEqually
        }
        
        buttons.forEach {
            if $0 is CMDBlueButton {
                $0 <- Height(60)
            } else {
                if let image = $0.currentImage {
                    $0 <- Height(image.size.height)
                } else {
                    $0 <- Height(30)
                }
            }
            buttonsView.addArrangedSubview($0)
            if DeviceType.IS_IPAD_ANY {
                $0 <- Width(320)
            }
        }
    }
    
    private func clearButtons() {
        buttons.forEach { $0.removeFromSuperview() }
    }
}
