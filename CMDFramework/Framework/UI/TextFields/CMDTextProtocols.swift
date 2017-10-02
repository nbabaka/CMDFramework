//
//  CMDTextProtocols.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay on 14.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

public protocol CMDText {
    var inset: CGRect { get set }
    var placeholderFont: UIFont? { get set }
    var placeholderSpacing: CGFloat { get set }
    var placeholderColor: UIColor { get set }
    var font: UIFont? { get set }
    var textColor: UIColor? { get set }
    var onChangeBlock : CMDTextInputOnChangeBlock? { get set }
    func getAttributedStringFor(text: String) -> NSAttributedString
    func addSpacing(_ spacing: Float, toString: NSMutableAttributedString)
    func redrawText(_ text: String) -> NSAttributedString
    func getRect(forBounds bounds: CGRect) -> CGRect
}

public extension CMDText {
    mutating func onChange(block: @escaping CMDTextInputOnChangeBlock) {
        onChangeBlock = block
    }
    
    func getRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + inset.origin.x, y: bounds.origin.y + inset.origin.y, width: bounds.width - inset.origin.x - inset.width, height: bounds.height - inset.origin.y - inset.height)
    }
    
    func getAttributedStringFor(text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        
        if attributedString.length > 0 {
            let range = NSRange(location: 0, length: attributedString.length)
            addSpacing(Float(self.placeholderSpacing), toString: attributedString)
            attributedString.addAttribute(NSAttributedStringKey.font, value: self.placeholderFont ?? self.font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize), range: range)
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: self.placeholderColor, range: range)
        }
        return attributedString
    }
    
    func addSpacing(_ spacing: Float, toString: NSMutableAttributedString) {
        if toString.length > 0 {
            let range = NSRange(location: 0, length: toString.length-1)
            toString.addAttribute(NSAttributedStringKey.kern, value: calculateSpacingWithDevice(fromValue: spacing), range: range)
        }
    }
    
    @discardableResult func redrawText(_ text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let range = NSRange(location: 0, length: attributedString.length)
        addSpacing(Float(self.placeholderSpacing), toString: attributedString)
        attributedString.addAttribute(NSAttributedStringKey.font, value: self.font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize), range: range)
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: self.textColor ?? self.placeholderColor, range: range)
        return attributedString
    }
}
