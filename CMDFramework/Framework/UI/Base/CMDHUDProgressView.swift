//
//  CMDHUDProgressView.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 11/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import PKHUD

public class CMDHUDProgressView: PKHUDSquareBaseView, PKHUDAnimating {
    public init(title: String? = nil, subtitle: String? = nil) {
        super.init(image: nil, title: title, subtitle: subtitle)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func startAnimation() {
        imageView.loadImages(withBundleName: "Resources", andWithZipName: "spinner__black", andImageType: "png", andReverse: false)
        imageView.animationDuration = TimeInterval(1)
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
    }
    
    public func stopAnimation() {
    }
}

