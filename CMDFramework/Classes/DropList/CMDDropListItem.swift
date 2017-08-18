//
//  CMDDropListItem.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 26/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import EasyPeasy

public enum CMDDropListItemAction {
    case select
    case closure
}

public typealias CMDDropListItemBlock = () -> Void

open class CMDDropListItem: BaseView {
    let inactiveTextColor: UIColor = UIColor(red: 156/255.0, green: 159/255.0, blue: 174/255.0, alpha: 1.0)
    let activeTextColor: UIColor = UIColor(red: 82/255.0, green: 85/255.0, blue: 98/255.0, alpha: 1.0)
    var action: CMDDropListItemAction = .select
    var isSelect: Bool = false
    var identifier: String?
    var closure: CMDDropListItemBlock?
    
    override open func initSubviews() {
        super.initSubviews()
        self.backgroundColor = UIColor.clear
    }
    
    open func setActive(_ status: Bool) {
        // Override
    }
    
    open func setupConstraints() {
        // Override
    }
    
    open func copyObject () -> CMDDropListItem {
        return self
    }
}

