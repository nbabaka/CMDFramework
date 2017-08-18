//
//  CMDSettableLabel.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 04.04.17.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import UIKit
@IBDesignable
open class CMDSettableLabel: CMDLabelBase {
    open var myFont : UIFont? {
        set {
            self.font = newValue
        }
        get {
            return self.font
        }
    }
    
    open var myColor : UIColor? {
        set {
            self.textColor = newValue
        }
        get {
            return self.textColor
        }
    }

    @IBInspectable open var mySpacing : Float {
        get {
            return spacing
        }
        set {
            spacing = newValue
            self.addTextSpacing(spacing)
        }
    }
    
    private var spacing : Float = 0
    
    public convenience init(text: String, andFont font: UIFont, andColor color: UIColor, andSpacing spacing: Float) {
        self.init()
        self.myColor = color
        self.myFont = font
        self.mySpacing = spacing
        self.numberOfLines = 0
        self.t = text
    }
    
    override func setLabel() {
        self.font = myFont
        self.textColor = myColor
        self.addTextSpacing(mySpacing)
    }
}

public extension UILabel {
    public func addTextSpacing(_ spacing : Float) {
        attributedText = getAttributedStringWithSpacing(spacing)
    }
    
    public func adjustFontSizeToFit(spacing: Float, minimumFontSize : CGFloat, maximumFontSize : CGFloat? = nil) {
        let maxFontSize = maximumFontSize ?? font.pointSize
        for size in stride(from: maxFontSize, to: minimumFontSize, by: -CGFloat(0.1)) {
            let proposedFont = font.withSize(size)
            let constraintSize = CGSize(width: bounds.size.width, height: CGFloat(MAXFLOAT))
            let attributedString = getAttributedStringWithSpacing(spacing)
            let range = NSRange(location: 0, length: (text ?? "").characters.count)
            attributedString.addAttribute(NSFontAttributeName, value: proposedFont, range: range)
            let labelSize = attributedString.boundingRect(with: constraintSize, options: .usesFontLeading, context: nil)
            if labelSize.width <= bounds.size.width {
                font = proposedFont
                setNeedsLayout()
                break;
            }
        }
    }
    
    private func getAttributedStringWithSpacing(_ spacing : Float) -> NSMutableAttributedString {
        let spacing = calculateSpacingWithDevice(fromValue: spacing)
        let textString = text ?? ""
        let attributedString = NSMutableAttributedString(string: textString)
        if attributedString.length > 0 {
            attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: attributedString.length - 1))
        }
        return attributedString
    }
}

