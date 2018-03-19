//
//  CMDSpinner.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 14.04.17.
//  Copyright © 2017 Cinemood. All rights reserved.
//

import EasyPeasy

public struct spinner {
    static var image: UIImageView?
}

open class CMDSpinner: BaseView {
    private let animationDuration = 1
    public var imageView: UIImageView!
    
    override open func initSubviews() {
        self.backgroundColor = UIColor.clear
        if spinner.image == nil {
            spinner.image = UIImageView()
            spinner.image?.loadImages(withBundleName: "Resources", andWithZipName: "spinner_white", andImageType: "png", andReverse: false)
        }
        imageView = UIImageView(frame: self.bounds)
        imageView.animationImages = spinner.image?.animationImages
        self.addSubview(imageView)
        imageView.easy.layout(Top(0),
                              Leading(0),
                              Trailing(0),
                              Bottom(0))
        imageView.animationDuration = TimeInterval(animationDuration)
        imageView.animationRepeatCount = 0
        self.alpha = 0
        imageView.stopAnimating()
        setNeedsUpdateConstraints()
    }
    
    public func start() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }, completion: { _ in
            self.imageView.startAnimating()
        })
    }

    public func stop() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }, completion: { _ in
            main {
                self.imageView.stopAnimating()
            }
        })
    }
}
