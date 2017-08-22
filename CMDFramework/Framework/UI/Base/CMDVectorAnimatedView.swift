//
//  CMDVectorAnimatedView.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 20/04/2017.
//  Copyright © 2017 Cinemood. All rights reserved.
//

open class CMDVectorAnimatedView: BaseView {
    public var path: UIBezierPath!
    public var color: UIColor!
    public var duration = 1.2
    
    override open func initSubviews() {
        self.backgroundColor = UIColor.clear
    }
    
    open func copyWithZone(zone: NSZone) -> AnyObject {
        return self
    }
    
    open func animate(withPath path: UIBezierPath, andColor color: UIColor) {
        self.animate(withPath: path, andColor: color, withDelay: 0, andDuration: TimeInterval(self.duration))
    }
    
    open func animate(withPath path: UIBezierPath, andColor color: UIColor, withDelay delay: TimeInterval) {
        self.animate(withPath: path, andColor: color, withDelay: delay, andDuration: TimeInterval(self.duration))
    }
    
    open func animate(withPath path: UIBezierPath, andColor color: UIColor, withDelay delay: TimeInterval, andDuration duration: TimeInterval) {
        self.setNeedsUpdateConstraints()
        self.path = path
        self.color = color
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.strokeColor = self.color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.strokeEnd = 0
        shapeLayer.path = path.fit(into: self.bounds).moveCenter(to: CGPoint(x: self.bounds.midX, y: self.bounds.midY)).cgPath
        self.layer.addSublayer(shapeLayer)
        
        let shapeLayerBack = CAShapeLayer(layer: shapeLayer)
        shapeLayerBack.fillColor = self.color.cgColor
        shapeLayerBack.path = shapeLayer.path
        shapeLayerBack.opacity = 0
        self.layer.addSublayer(shapeLayerBack)
        
        UIView.animate(withDuration: duration, delay: delay, options: .curveLinear, animations: {
            shapeLayer.strokeEnd = 1
        }, completion: nil)
        UIView.animate(withDuration: duration / 2, delay: delay + duration, options: .curveLinear, animations: {
            shapeLayerBack.opacity = 1
        }, completion: nil)
    }
}
