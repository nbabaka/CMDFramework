//
//  CMDDropListItemSimple.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 26/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import EasyPeasy

open class CMDSimpleDropItem: CMDDropListItem {
    open var title: CMDSettableLabel?
    
    override open func setActive(_ status: Bool) {
        self.title?.textColor = status ? activeTextColor : inactiveTextColor
    }
    
    override open func initSubviews() {
        super.initSubviews()
        if title == nil {
            title = CMDSettableLabel(text: "", andFont: UIFont(name: "GothamPro-Bold", size: 16)!, andColor: self.inactiveTextColor, andSpacing: 2)
            self.addSubview(title!)
            self.setupConstraints()
        }
    }
    
    override open func setupConstraints() {
        title?.easy_clear()
        title! <- [CenterY(), Left(0), Right(0)]
        self.layoutIfNeeded()
        self.updateConstraintsIfNeeded()
    }
    
    override open func copyObject() -> CMDSimpleDropItem {
        let item = CMDSimpleDropItem(withText: (self.title?.text)!)
        item.identifier = self.identifier
        return item
    }
    
    public convenience init(withText text: String) {
        self.init()
        title?.t = text
    }
}

