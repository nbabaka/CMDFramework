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
    open var inactiveTextColor = UIColor.dropList.nonActiveTextItem
    open var activeTextColor = UIColor.dropList.activeTextItem
    open var action: CMDDropListItemAction = .select
    open var isSelect: Bool = false
    open var identifier: String?
    open var closure: CMDDropListItemBlock?
    
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

