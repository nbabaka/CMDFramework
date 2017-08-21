//
//  AlertView.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 03.04.17.
//  Copyright © 2017 Cinemood. All rights reserved.
//

import EasyPeasy
import EasyAnimation

public typealias CMDAlertBlock = ()->Void
public weak var currentFirstResponder: UIResponder?

open class CMDAlertViewBase: BaseView {
    public let animationTime = 0.6
    public let defaultBlurRadius: CGFloat = 15
    public static let alphaTint: CGFloat = 0.35

    public var firstResponder: UIResponder?
    public var isOnscreen = false
    
    public enum alertTransaction {
        case dissolve
        case blink
        case moveUp
        case moveDown
    }
    
    public var iconImage : UIImageView?
    public var titleLabel : UILabel!
    public var textLabel : UILabel!
    public var flashView : UIView!
    public var bluredBackground: CMDBlurEffectView!
    public var blurRadius: CGFloat!
    
    public convenience init(withRadius radius: CGFloat, withTintedBackgroundColor color: UIColor = UIColor.black, withAlpha aplha: CGFloat = CMDAlertViewBase.alphaTint) {
        self.init()
        bluredBackground = CMDBlurEffectView()
        bluredBackground.blurRadius = radius
        self.blurRadius = radius
        setup()
        initAdditionalViews()
        self.flashView = UIView(frame: self.frame)
        self.flashView.backgroundColor = UIColor.white
        self.addSubview(flashView)
        self.bringSubview(toFront: flashView)
        self.flashView.layer.opacity = 0
    }

    public convenience init(withBlur blur: Bool) {
        self.init()
        if blur {
            blurSetup()
        }
        setup()
        initAdditionalViews()
    }
    
    public convenience init(withIcon icon: UIImage?, andTitle title: String, andMainText mainText: String) {
        self.init()
        blurSetup()
        setup()
        if let icon = icon {
            iconImage = UIImageView(image: icon)
            self.addSubview(iconImage!)
        }
        titleLabel = CMDSettableLabel(text: title, andFont: UIFont.alerts.title, andColor: UIColor.alerts.title, andSpacing: 4)
        addSubview(titleLabel)
        textLabel = CMDSettableLabel(text: mainText, andFont: UIFont.alerts.text, andColor: UIColor.alerts.text, andSpacing: 1.8)
        addSubview(textLabel)
        initConstraints()
        initAdditionalViews()
    }
    
    open func blurSetup() {
        bluredBackground = CMDBlurEffectView()
        bluredBackground.colorTint = .black
        bluredBackground.colorTintAlpha = CMDAlertViewBase.alphaTint
        bluredBackground.blurRadius = defaultBlurRadius
        self.blurRadius = defaultBlurRadius
    }
    
    open func setup() {
        self.frame = UIScreen.main.bounds
        self.backgroundColor = UIColor.clear
        self.layer.opacity = 0
        self.clipsToBounds = true
        bluredBackground.frame = self.frame
        self.addSubview(bluredBackground)
        self.sendSubview(toBack: bluredBackground)
    }
    
    open func initConstraints() {
        if let iconImageView = self.iconImage {
            iconImageView <- [Size((iconImageView.image?.size)!), Left(40), CenterY(-140)]
            titleLabel <- [Top(18).to(iconImageView)]
        } else {
            titleLabel <- CenterY(-120)
        }
        titleLabel <- Left(40)
        titleLabel <- Right(8)
        textLabel <- [Left(40), Top(19).to(titleLabel)]
        textLabel <- Right(8)
        setNeedsUpdateConstraints()
    }
    
    open func initAdditionalViews() {
        // Override it
    }
 
    override open func draw(_ rect: CGRect) {
        self.setNeedsUpdateConstraints()
    }
    
    public func closeAndHideSomeViews(_ viewArray: [UIView], withTransaction transaction: alertTransaction) {
        closeAndHideSomeViews(viewArray, withTransaction: transaction, withDelay: 0){}
    }
    
    public func closeAndHideSomeViews(_ viewArray: [UIView], withTransaction transaction: alertTransaction, withDelay: Double, closure: @escaping CMDAlertBlock) {
        showViews(false, viewArray: viewArray)
        self.close(transaction)
        close(transaction, withDelay: 0.3) {
            self.showViews(true, viewArray: viewArray)
            delay(withDelay) {
                closure()
            }
        }
    }
    
    public func close(_ transaction: alertTransaction, withDelay: Double, closure: @escaping CMDAlertBlock){
        self.isUserInteractionEnabled = true
        switch transaction {
        case .dissolve, .blink:
            UIView.animate(withDuration: animationTime, delay: 0.0, options: [.curveEaseInOut, .beginFromCurrentState], animations: {
                self.layer.opacity = 0
                self.bluredBackground.blurRadius = 0
            }, completion: {(Finished) in
                self.removeFromSuperview()
                delay(withDelay) {
                    closure()
                    self.showKeyboard()
                }
            })
        case .moveDown:
            UIView.animate(withDuration: animationTime, delay: 0.0, options: [.curveEaseInOut, .beginFromCurrentState] , animations: {
                self.frame = self.frame.offsetBy(dx: 0.0, dy: self.frame.height)
            }, completion: {(Finished) in
                self.layer.opacity = 0
                delay(withDelay) {
                    closure()
                    self.showKeyboard()
                }
            })
        case .moveUp:
            UIView.animate(withDuration: animationTime, delay: 0.0, options: [.curveEaseInOut, .beginFromCurrentState] , animations: {
                self.frame = self.frame.offsetBy(dx: 0.0, dy: -self.frame.height)
            }, completion: {(Finished) in
                self.layer.opacity = 0
                delay(withDelay) {
                    closure()
                    self.showKeyboard()
                }
            })
        }
        isOnscreen = false
    }
    
    public func close(_ transaction: alertTransaction) {
        self.close(transaction, withDelay: 0) {}
    }
    
    public func show(_ transaction: alertTransaction) {
        self.show(transaction, withDelay: 0) {}
    }
    
    public func show(_ transaction: alertTransaction, withDelay delay: Double, closure: @escaping CMDAlertBlock) {
        hideKeyboard()
        let window = UIApplication.shared.keyWindow
        window?.isUserInteractionEnabled = false
        window?.addSubview(self)
        switch transaction {
        case .dissolve:
            self.bluredBackground.blurRadius = 0
            UIView.animate(withDuration: animationTime, delay: 0.0, options: [.curveEaseInOut, .beginFromCurrentState] , animations: {
                self.layer.opacity = 1
                self.bluredBackground.blurRadius = self.blurRadius
            }, completion: {(Finished) in
                self.processShowCompletion(withDelay: delay, andBlock: closure)
            })
        case .moveUp:
            self.layer.opacity = 1
            self.frame.origin.y = self.frame.height
            UIView.animate(withDuration: animationTime, delay: 0.0, options: [.curveEaseInOut, .beginFromCurrentState] , animations: {
                self.frame = self.frame.offsetBy(dx: 0.0, dy: -self.frame.height)
            }, completion: {(Finished) in
                self.processShowCompletion(withDelay: delay, andBlock: closure)
            })
        case .moveDown:
            self.layer.opacity = 1
            self.frame.origin.y = -self.frame.height
            UIView.animate(withDuration: animationTime, delay: 0.0, options: [.curveEaseInOut, .beginFromCurrentState] , animations: {
                self.frame = self.frame.offsetBy(dx: 0.0, dy: self.frame.height)
            }, completion: {(Finished) in
                self.processShowCompletion(withDelay: delay, andBlock: closure)
            })
        case .blink:
            self.alpha = 1
            UIView.animateAndChain(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.flashView.layer.opacity = 1
            }, completion: nil).animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn, .beginFromCurrentState] , animations: {
                self.flashView.layer.opacity = 0
            }, completion: {(Finished) in
                self.processShowCompletion(withDelay: delay, andBlock: closure)
            })
        }
        isOnscreen = true
    }
    private func processShowCompletion(withDelay: Double, andBlock closure: @escaping CMDAlertBlock) {
        window?.isUserInteractionEnabled = true
        delay(withDelay) {
            closure()
        }
    }

    private func showViews(_ show: Bool, viewArray: [UIView]){
        viewArray.forEach {
            $0.isHidden = !show
        }
    }
    
    private func hideKeyboard() {
        firstResponder = UIResponder.firstResponder()
        firstResponder?.resignFirstResponder()
        if let viewResponser = firstResponder as? UIView {
            viewResponser.endEditing(true)
        }
    }
    
    private func showKeyboard() {
        firstResponder?.becomeFirstResponder()
    }
}

extension UIResponder {
    static func firstResponder() -> UIResponder? {
        currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(self.findFirstResponder(sender:)), to: nil, from: nil, for: nil)
        return currentFirstResponder
    }
    func findFirstResponder(sender: AnyObject) {
        currentFirstResponder = self
    }
}
