//
//  CMDCellStatusLabel.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 21.05.17.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import UIKit

public enum CMDCellStatusLabelStatus  {
    case good
    case bad
    case other
}

open class CMDCellStatusLabel: CMDSettableLabel {
    public var topInset: CGFloat = 3.0
    public var bottomInset: CGFloat = 1.0
    public var leftInset: CGFloat = 10.0
    public var rightInset: CGFloat = 10.0
    
    private var colors = [CMDCellStatusLabelStatus: UIColor]()
    private var status: CMDCellStatusLabelStatus = .other
    private var negative: Bool = false
    
    override open var textColor: UIColor! {
        didSet {
            self.layer.borderColor = negative ? self.backgroundColor?.cgColor : textColor.cgColor
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
    
    override open func setLabel() {
        super.setLabel()
        self.mySpacing = 1
        self.myColor = UIColor.green
        self.font = UIFont.labels.cellStatusLabel
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 3
        self.setStatus(.other)
        self.clipsToBounds = true
    }
    
    override open func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    open func setStatus(_ status: CMDCellStatusLabelStatus) {
        self.status = status
        switch status {
        case .good:
            self.textColor = colors[.good] ?? UIColor.green
        case .bad:
            self.textColor = colors[.bad] ?? UIColor.red
        default:
            self.textColor = colors[.other] ?? UIColor.labels.cellStatusLabelOther
        }
        
        self.backgroundColor = self.negative ? self.textColor : UIColor.clear
        if self.negative {
            self.textColor = UIColor.black
        }
    }
    
    open func setNegative(_ status: Bool) {
        self.negative = status
        self.setStatus(self.status)
    }
    
    open func setColor(_ color: UIColor, forStatus status: CMDCellStatusLabelStatus) {
        colors[status] = color
    }
}
