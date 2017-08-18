//
//  BaseControl.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 25/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

open class BaseControl: UIControl {
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

