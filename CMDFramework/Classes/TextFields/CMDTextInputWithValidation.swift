//
//  CMDTextInputWithValidation.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 04/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import EasyPeasy

open class CMDTextInputWithValidation: CMDColoredTextInput {
    
    open var validLabel = CMDSettableLabel(text: "", andFont: UIFont.textFields.validationField, andColor: UIColor.textFields.validationLabel, andSpacing: 1)
    open var isClearValidWithChanges = true
    
    private var isValid = true
    private var previousColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initValidationLabel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initValidationLabel()
    }
    
    public func initValidationLabel() {
        setNeedsUpdateConstraints()
        self.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        validLabel.removeFromSuperview()
        self.superview?.addSubview(validLabel)
        validLabel <- Width().like(self)
        validLabel <- Height(15)
        validLabel <- CenterX()
        validLabel <- Top(8).to(self)
    }
    
    public func setInvalidWithText(_ text: String) {
        previousColor = self.textColor
        self.textColor = UIColor.textFields.validationLabel
        validLabel.t = text
        UIView.animate(withDuration: 0.1) {
            self.validLabel.alpha = 1
        }
        isValid = false
    }
    
    public func setValid() {
        if let color = previousColor {
            self.textColor = color
        }
        UIView.animate(withDuration: 0.1) {
            self.validLabel.alpha = 0
        }
        isValid = true
    }
    
    internal func textFieldDidChange(_ textField: CMDTextInputWithValidation) {
        if !isValid && isClearValidWithChanges {
            setValid()
        }
    }
    
    
}
