//
//  CMDRefreshControl.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 30/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import EasyPeasy

open class CMDRefreshControl: UIRefreshControl {

    var spinner = CMDSpinner()
    var refreshView: UIView!
    
    required override public init(frame: CGRect) {
        super.init()
        bounds.size.width = frame.size.width
        setupRefreshControl()
    }
    
    required override public init() {
        super.init()
        setupRefreshControl()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupRefreshControl() {
        tintColor = UIColor.clear
        refreshView = UIView(frame: self.frame)
        self.addSubview(refreshView)
        refreshView.clipsToBounds = true
        refreshView <- [Top(0), Right(0), Left(0), Bottom(0)]
        refreshView.addSubview(spinner)
        spinner.alpha = 1
        spinner <- [Size(25), Top(0), CenterX()]
        self.needsUpdateConstraints()
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.refreshView.frame = self.frame
    }
    
    override open func endRefreshing() {
        super.endRefreshing()
        main {
            self.spinner.alpha = 0
            self.spinner.imageView.stopAnimating()
        }
    }
    
    override open func beginRefreshing() {
        super.beginRefreshing()
        main {
            self.spinner.alpha = 1
            self.spinner.imageView.startAnimating()
        }
    }
}
