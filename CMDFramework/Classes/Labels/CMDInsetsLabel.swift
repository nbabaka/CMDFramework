//
//  CMDInsetsLabel.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 28.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import UIKit

@IBDesignable open class CMDInsetsLabel: CMDSettableLabel {
    @IBInspectable open var topInset: CGFloat = 7.0
    @IBInspectable open var leftInset: CGFloat = 15.0
    @IBInspectable open var bottomInset: CGFloat = 5.0
    @IBInspectable open var rightInset: CGFloat = 15.0
    @IBInspectable open var radius: CGFloat = 3.0
    @IBInspectable open var border: CGFloat = 1.0
    @IBInspectable open var borderColor: UIColor = UIColor.labels.insetLabelBorder

    open var insets: UIEdgeInsets {
        get {
            return UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset)
        }
        set {
            topInset = newValue.top
            leftInset = newValue.left
            bottomInset = newValue.bottom
            rightInset = newValue.right
        }
    }
    
    public convenience init(withUpperText text: String) {
        self.init(text: text.uppercased(), andFont: UIFont.labels.insetLabel, andColor: UIColor.labels.insetLabelBorder, andSpacing: 1.5)
    }
    
    override open var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += leftInset + rightInset
        contentSize.height += topInset + bottomInset
        return contentSize
    }
    
    override func setLabel() {
        super.setLabel()
        self.backgroundColor = UIColor.labels.insetLabelBackground
        self.myColor = UIColor.labels.insetLabelBorder
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = border
    }
    
    override open func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var adjSize = super.sizeThatFits(size)
        adjSize.width += leftInset + rightInset
        adjSize.height += topInset + bottomInset
        return adjSize
    }
}
