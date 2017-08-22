//
//  Animation.swift
//  CinemoodApp
//
//  Created by Victor Shcherbakov on 10/4/16.
//  Copyright © 2016 Underlama. All rights reserved.
//

public func prepareAnimation(views:[UIView], withAlpha alpha:CGFloat, andScale scale:CGFloat) {
    for view in views {
        prepareAnimationFloatIn(forView: view, withAlpha: alpha, andScale: scale)
    }
}

public func prepareAnimationFloatIn(forView view:UIView, withAlpha alpha:CGFloat, andScale scale:CGFloat) {
    view.isHidden = true
    view.alpha = alpha
    view.transform = CGAffineTransform(scaleX: scale, y: scale)
}

public func multipleAnimationFloatIn(forViews views:[UIView], withDelayBetween delayBetween:Double) {
    var startDelay:Double = 0.0
    
    for view in views {
        delay(startDelay, closure: {
            animateFloatIn(forView: view)
        })
        
        startDelay += delayBetween
    }
}

public func animateFloatIn(forView view:UIView) {
    view.isHidden = false
    UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
        view.transform = CGAffineTransform.identity
        view.alpha = 1.0
        }, completion: nil)
}

