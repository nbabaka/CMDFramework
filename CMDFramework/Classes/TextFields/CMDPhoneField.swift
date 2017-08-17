//
//  CMDPhoneField.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 03/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import libPhoneNumber_iOS
import Darwin
import EasyPeasy

open class CMDPhoneField: CMDTextInputWithValidation {
    open var isValidated = false
    open var phoneNumber: String?
    open var phoneNumberFormatted: String?
    open var phoneRegion: String?
    
    private let googleLab = NBPhoneNumberUtil()
    private let leftMargin: CGFloat = 50
    private var flagImageView: UIImageView!
    private var isLoadingFlag = false
    
    override func setupView() {
        super.setupView()
        self.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.keyboardType = .phonePad
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.spellCheckingType = .no
        checkPrefix()
        flagImageView = UIImageView(frame: CGRect(x: 15, y: 22, width: 41, height: 28))
        flagImageView.backgroundColor = UIColor.clear
        flagImageView.alpha = 0
        flagImageView.layer.borderWidth = 1
        flagImageView.layer.borderColor = UIColor.textFields.phoneFieldBorder.cgColor
        flagImageView.layer.cornerRadius = 3
        flagImageView.clipsToBounds = true
        self.addSubview(flagImageView)
        flagImageView <- CenterY()
        flagImageView <- Left(15)
        flagImageView <- [Width(41), Height(28)]
        self.setActiveStatus(false)
        setNeedsUpdateConstraints()
        setNeedsDisplay()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + leftMargin + inset.width, y: bounds.origin.y + inset.height, width: bounds.width - inset.width * 2 - leftMargin, height: bounds.height - inset.height * 2)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override open func deleteBackward() {
        if let lastChar = text?.characters.last {
            if lastChar.isMatchWithCharacters(" -()") {
                if let indexNumberWithWhiteSpace = text?.characters.index((text?.endIndex)!, offsetBy: -1) {
                    text = text?.substring(to: indexNumberWithWhiteSpace)
                }
                return
            }
        }
        super.deleteBackward()
    }
    
    internal override func textFieldDidChange(_ textField: UITextField) {
        super.textFieldDidChange(textField as! CMDTextInputWithValidation)
        checkPrefix()
        if let text = textField.text {
            let delCharsText = text.withReplacedCharacters(" -()", by: "")
            let parsedNumber = try? googleLab.parse(delCharsText, defaultRegion: nil)
            let f = NBAsYouTypeFormatter(regionCodeForTest: googleLab.getRegionCode(for: parsedNumber))
            self.text = f?.inputString(delCharsText)
            tryToChangeFlag(withParsedNumber: parsedNumber)
            isValidated = googleLab.isValidNumber(parsedNumber)
            phoneNumber =  isValidated == false ? nil : try? googleLab.format(parsedNumber, numberFormat: .E164)
            phoneRegion =  isValidated == false ? nil : googleLab.getRegionCode(for: parsedNumber)
            phoneNumberFormatted =  isValidated == false ? nil : try? googleLab.format(parsedNumber, numberFormat: .INTERNATIONAL)
        }
        self.redrawText(textField.text ?? "")
        setNeedsDisplay()
    }
    
    public func tryToChangeFlag(withParsedNumber number: NBPhoneNumber?) {
        guard number != nil else {
            return
        }
        
        if let regionCode = googleLab.getRegionCode(for: number) {
            changeFlag(countryCode: regionCode)
        } else {
            setHiddenFlag(true)
        }
    }
    
    internal func changeFlag(countryCode: String) {
        isLoadingFlag = true
        getImageFromUrl("https://flagpedia.net/data/flags/normal/\(countryCode.lowercased()).png") { [unowned self] image in
            if let image = image {
                self.flagImageView.image = image
                self.setHiddenFlag(false)
            } else {
                self.setHiddenFlag(true)
            }
        }
    }
    
    internal func setHiddenFlag(_ isHidden: Bool) {
        if !isHidden {
            isLoadingFlag = false
        }
        UIView.animate(withDuration: 0.1){
            self.flagImageView.alpha = (isHidden == true) ? 0 : 1
        }
    }
    
    internal func checkPrefix() {
        if self.text == "" {
            self.text = "+"
        } else {
            if let text = self.text {
                if text[text.startIndex] != "+" {
                    self.text = "+" + text
                }
            }
        }
    }
}
