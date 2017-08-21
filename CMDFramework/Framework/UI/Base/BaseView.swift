//
//  BaseView.swift
//  CinemoodApp
//
//  Created by Victor Shcherbakov on 12/5/16.
//  Copyright © 2016 Underlama. All rights reserved.
//

open class BaseView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSubviews()
    }
    
    open func initSubviews() {
        
    }
}

public extension UIView {
    public func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
