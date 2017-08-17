//
//  CMDButtonBase.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 05.04.17.
//  Copyright © 2017 Underlama. All rights reserved.
//

public typealias CMDButtonBlock = () -> Void
open class CMDButtonBase : UIButton {
    open var onPushButtonBlock : CMDButtonBlock?
    internal var spacing : Float = 4
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    public convenience init(withText text: String, action: @escaping CMDButtonBlock) {
        self.init()
        self.text = text
        self.onPushButtonBlock = action
    }
    
    public convenience init(withImage image: UIImage, andText text: String?, action: @escaping CMDButtonBlock) {
        self.init(withText: text ?? "", action: action)
        self.setImage(image, for: .normal)
        self.setImage(image, for: .highlighted)
    }
    
    public convenience init(withNormalImage image: UIImage, highlightImage highlight: UIImage, andText text: String?, action: @escaping CMDButtonBlock) {
        self.init(withImage: image, andText: text, action: action)
        self.setImage(highlight, for: .highlighted)
    }
    
    open var text : String? {
        get {
            return self.titleLabel?.text
        }
        set {
            self.setTitle(newValue, for: .normal)
            self.titleLabel?.text = newValue
            titleLabel?.addTextSpacing(spacing)
        }
    }
    
    internal func initButton() {
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.5
        self.addTarget(self, action: #selector(self.pushButton(_:)), for: UIControlEvents.touchUpInside)
    }
    
    @objc private func pushButton(_ sender: UIButton) {
        self.onPushButtonBlock?()
    }
}
