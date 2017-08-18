//
//  CMDDropListItemImageLabel.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 26/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import EasyPeasy

open class CMDDropListItemImageLabel: CMDDropListItem {

    open var title: CMDSettableLabel?
    open var imageView: UIImageView?
    
    override open func setActive(_ status: Bool) {
        self.title?.textColor = status ? activeTextColor : inactiveTextColor
    }
    
    override open func initSubviews() {
        super.initSubviews()
        if title == nil {
            title = CMDSettableLabel(text: "", andFont: UIFont(name: "GothamPro-Bold", size: 18)!, andColor: self.inactiveTextColor, andSpacing: 2)
            self.addSubview(title!)
            imageView = UIImageView()
            imageView?.contentMode = .scaleAspectFit
            imageView?.backgroundColor = UIColor.clear
            self.addSubview(imageView!)
            self.setupConstraints()
        }
    }
    
    override open func setupConstraints() {
        title?.easy_clear()
        imageView?.easy_clear()
        imageView! <- [CenterY(), Left(5), Width(30), Height(22)]
        title! <- [CenterY(), Left(15).to(imageView!)]
        self.layoutIfNeeded()
        self.updateConstraintsIfNeeded()
    }
    
    override open func copyObject() -> CMDDropListItemImageLabel {
        let item = CMDDropListItemImageLabel(withText: self.title?.text, image: self.imageView?.image)
        item.identifier = self.identifier
        return item
    }
    
    public convenience init(withText text: String?, image: UIImage?) {
        self.init()
        self.title?.t = text
        self.imageView?.image = image
    }

}
