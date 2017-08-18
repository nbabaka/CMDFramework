//
//  CMDBlurEffectView.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 08.05.17.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

open class CMDBlurEffectView: UIVisualEffectView {
    let classNameArray: [String] = ["_","U","I","C","u","s","t","o","m","B","l","u","r","E","f","f","e","c","t"]
    
    open var scale: CGFloat {
        get {
            return getValue(forKey: "scale") as! CGFloat
        }
        set {
            setNewValue(newValue, forKey: "scale")
        }
    }
    
    open var colorTint: UIColor? {
        get {
            return getValue(forKey: "colorTint") as? UIColor
        }
        set {
            setNewValue(newValue, forKey: "colorTint")
        }
    }

    open var colorTintAlpha: CGFloat {
        get {
            return getValue(forKey: "colorTintAlpha") as! CGFloat
        }
        set {
            setNewValue(newValue, forKey: "colorTintAlpha")
        }
    }
    
    open var blurRadius: CGFloat {
        get {
            return getValue(forKey: "blurRadius") as! CGFloat
        }
        set {
            setNewValue(newValue, forKey: "blurRadius")
        }
    }
    
    public var blurEffect: UIBlurEffect!
    
    public override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        commonInit()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        blurEffect = (NSClassFromString(classNameArray.joined()) as! UIBlurEffect.Type).init()
        self.scale = 1
    }

    private func getValue(forKey key: String) -> Any? {
        return blurEffect.value(forKeyPath: key)
    }
    
    private func setNewValue(_ value: Any?, forKey key: String) {
        blurEffect.setValue(value, forKeyPath: key)
        self.effect = blurEffect
    }
}

