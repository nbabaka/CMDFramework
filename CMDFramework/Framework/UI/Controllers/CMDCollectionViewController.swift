//
//  CMDCollectionViewController.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 30/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import EasyPeasy

open class CMDCollectionViewController: CMDInitialViewController {
    open var refreshControl = CMDRefreshControl()
    override open func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(self.refreshOptions(_:)), for: .valueChanged)
    }
    
    open func refreshOptions(_ sender: UIRefreshControl) {
        // Override
    }
}
