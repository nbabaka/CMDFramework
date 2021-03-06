//
//  CMDTitleLabel.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 03.04.17.
//  Copyright © 2017 Cinemood. All rights reserved.
//

import UIKit

open class CMDLabelBase: UILabel {
    override open var text: String? {
        didSet {
            super.text = text
            setLabel()
        }
    }
    
    open var t: String? {
        set {
            self.text = newValue
            setLabel()
        }
        get {
            return self.text
        }
    }
    
    convenience init(text: String) {
        self.init()
        self.text = text
        baseInit()
        setLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseInit()
        setLabel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseInit()
        setLabel()
    }
    
    private func baseInit() {
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
    }
    
    func setLabel() {
        fatalError("Must override")
    }
}
