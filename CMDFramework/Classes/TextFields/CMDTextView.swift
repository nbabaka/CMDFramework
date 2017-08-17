//
//  CMDTextView.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 14.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

open class CMDTextView: UITextView, CMDText {
    open var inset: CGRect = Dimensions.textFields.textInset
    open var placeholderFont: UIFont? = UIFont.textFields.placeholder
    open var placeholderSpacing: CGFloat = 1.2
    open var placeholderColor: UIColor = UIColor.textFields.nonActivePlaceholder
    public var onChangeBlock : CMDTextInputOnChangeBlock?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    internal func handleTextViewTextDidChangeNotification(_ notification: Notification) {
        guard let object = notification.object as? CMDTextView, object === self else {
            return
        }
        self.attributedText = redrawText(text ?? "")
        onChangeBlock?(text)
        setNeedsDisplay()
    }
    
    internal func setupView() {
        self.backgroundColor = UIColor.textFields.nonActiveBackground
        self.layer.cornerRadius = Dimensions.textFields.cornerRadius
        self.layer.masksToBounds = true
        let insets = Dimensions.textFields.textInset
        self.textContainerInset = UIEdgeInsets(top: insets.minY, left: insets.minX, bottom: insets.height, right: insets.width)
        self.textColor = UIColor.textFields.nonActiveText
        self.font = UIFont.textFields.text
        self.returnKeyType = .default
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextViewTextDidChangeNotification(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: self)
        setNeedsDisplay()
    }
}
