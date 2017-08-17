//
//  CMDCodeField.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 04/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import EasyPeasy

public typealias CMDCodeFieldBlock = (String) -> Void

open class CMDCodeField: BaseView, UITextFieldDelegate {
    let size = DeviceType.IS_IPHONE_5_OR_LESS == true ? CGSize(width: 60, height: 60) : CGSize(width: 65, height: 65)
    let spacing: CGFloat = DeviceType.IS_IPHONE_5_OR_LESS == true ? 15 : 20
    let inset = DeviceType.IS_IPHONE_5_OR_LESS == true ? CGRect(x: 5, y: 5, width: 5, height: 5) : CGRect(x: 5, y: 8, width: 5, height: 8)
    let countOfFields : Int = 4
    let limitCount = 1
    
    public var fieldsArray = [CMDTextInput]()
    public var validLabel = CMDSettableLabel()
    public var isValid = true
    
    public var code: String? {
        let textArray = fieldsArray.map {$0.text} as! [String]
        let text = textArray.joined()
        return text.characters.count == countOfFields ? text : nil
    }
    
    public var countOfSpacing: Int {
        return countOfFields - 1
    }
    
    private var completeBlock: CMDCodeFieldBlock?
    
    override open func initSubviews() {
        self.backgroundColor = UIColor.clear

        for _ in 1...countOfFields {
            createField()
        }
        fieldsArray.first?.becomeFirstResponder()
        setNeedsUpdateConstraints()
        
        validLabel.font =  UIFont.textFields.validationField
        validLabel.textColor = UIColor.textFields.validationLabel
        validLabel.mySpacing = 1
        self.addSubview(validLabel)
        validLabel <- Width(CGFloat(countOfFields) * size.width + CGFloat(countOfSpacing) * spacing)
        validLabel <- Height(13)
        validLabel <- CenterX()
        validLabel <- Top(8).to(fieldsArray.first!)
        validLabel.alpha = 0
    }
    
    public func onComplete(block: @escaping CMDCodeFieldBlock) {
        completeBlock = block
    }
    
    internal func createField() {
        let codeField = CMDTextInput(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        codeField.inset = inset
        codeField.font = codeField.font?.withSize(34)
        codeField.delegate = self
        codeField.keyboardType = .numberPad
        codeField.autocorrectionType = .no
        codeField.autocapitalizationType = .none
        codeField.spellCheckingType = .no
        codeField.textAlignment = .center
        codeField.textColor = UIColor.textFields.codeFieldText
        codeField.onBackwardPressed { control in
            self.backwardPressedFor(control)
        }
        
        codeField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.addSubview(codeField)

        codeField <- Top(0)
        codeField <- Width(size.width)
        codeField <- Height(size.height)

        if fieldsArray.count == 0 {
            codeField <- CenterX(-(CGFloat(countOfFields) * size.width + CGFloat(countOfSpacing) * spacing) / 2 + size.width / 2)
        } else {
            codeField <- Left(spacing).to(fieldsArray.last!)
        }
        fieldsArray.append(codeField)
    }
    
    public func setRed(_ isRed: Bool) {
        fieldsArray.forEach{
            $0.textColor = isRed == false ? UIColor.textFields.codeFieldText : UIColor.textFields.validationLabel
        }
    }
    
    public func setInvalidWithText(_ text: String) {
        setRed(true)
        validLabel.t = text
        UIView.animate(withDuration: 0.1) {
            self.validLabel.alpha = 1
        }
        isValid = false
    }
    
    public func setValid() {
        setRed(false)
        UIView.animate(withDuration: 0.1) {
            self.validLabel.alpha = 0
        }
        isValid = true
    }
    
    private func backwardPressedFor(_ textField: CMDTextInput) {
        guard let index = fieldsArray.index(of: textField) else {
            return
        }
        
        if index > 0 {
            fieldsArray[index - 1].becomeFirstResponder()
        }
    }
    
    @objc private func textFieldDidChange(_ textField: CMDTextInputWithValidation) {
        if isValid == false {
            setValid()
        }
        guard let index = fieldsArray.index(of: textField) else {
            return
        }
        if textField.text != "" && textField.text != nil {
            if index < countOfFields - 1 {
                fieldsArray[index + 1].becomeFirstResponder()
            }
        }
        
        if index == countOfFields - 1 {
            guard let code = self.code else {
                return
            }
            if code.characters.count == countOfFields {
                completeBlock?(code)
            }
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = NSString(string: textField.text!)
        let newText = nsString.replacingCharacters(in: range, with: string)
        let result = newText.characters.count <= limitCount
        if result == false {
            guard let index = fieldsArray.index(of: textField as! CMDTextInput) else {
                return result
            }
            if index < countOfFields - 1 {
                fieldsArray[index + 1].text = string
                fieldsArray[index + 1].becomeFirstResponder()
            }
        }
        return result
    }
}
