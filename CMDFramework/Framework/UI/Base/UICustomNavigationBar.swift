//
//  UICustomNavigationBar.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev on 16/03/2017.
//  Copyright © 2017 Underlama. All rights reserved.
//

@IBDesignable open class UICustomNavigationBar: UINavigationBar {
    @IBInspectable public var imageTitle: UIImage? = nil {
        didSet {
            guard let imageTitle = imageTitle else {
                topItem?.titleView = nil
                return
            }
            let imageView = UIImageView(image: imageTitle)
            imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
            imageView.contentMode = .scaleAspectFit
            topItem?.titleView = imageView
        }
    }
}
