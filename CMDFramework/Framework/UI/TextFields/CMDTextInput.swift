//
//  CMDTextInput.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 11.04.17.
//  Copyright © 2017 Cinemood. All rights reserved.
//

import EasyPeasy

public typealias CMDTextInputOnChangeBlock = (String?) -> Void
public typealias CMDTextInputBackward = (CMDTextInput) -> Void

open class CMDTextInput: UITextField, CMDText {
    open var placeholderFont: UIFont? = UIFont.textFields.placeholder
    open var placeholderSpacing: CGFloat = 2
    open var placeholderColor: UIColor = UIColor.textFields.nonActivePlaceholder {
        didSet {
            setPlaceholder()
        }
    }
    public var inset = Dimensions.textFields.textInset
    public var onChangeBlock : CMDTextInputOnChangeBlock?
    private var backwardBlock: CMDTextInputBackward?
    
    override open var placeholder: String? {
        didSet {
            setPlaceholder()
        }
    }
    
    override open var text: String? {
        didSet {
            self.attributedText = redrawText(text ?? "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        setPlaceholder()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return getRect(forBounds: bounds)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override open func deleteBackward() {
        super.deleteBackward()
        self.backwardBlock?(self)
    }
    
    public func onBackwardPressed(block: @escaping CMDTextInputBackward) {
        backwardBlock = block
    }
    
    internal func setPlaceholder() {
        self.attributedPlaceholder = getAttributedStringFor(text: self.placeholder ?? "")
    }
    
    internal func handleTextViewTextDidChangeNotification(_ notification: Notification) {
        guard let object = notification.object as? CMDTextInput, object === self else {
            return
        }
        self.attributedText = redrawText(text ?? "")
        onChangeBlock?(text)
        setNeedsDisplay()
    }
    
    open func setupView() {
        self.backgroundColor = UIColor.textFields.nonActiveBackground
        self.layer.cornerRadius = Dimensions.textFields.cornerRadius
        self.layer.masksToBounds = true
        self.textColor = UIColor.textFields.nonActiveText
        self.font = UIFont.textFields.text
        self.returnKeyType = .done
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextViewTextDidChangeNotification(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: self)
        setNeedsDisplay()
    }
}
