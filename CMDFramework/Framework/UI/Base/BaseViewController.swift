//
//  BaseViewController.swift
//  CinemoodApp
//
//  Created by Victor Shcherbakov on 10/3/16.
//  Copyright © 2016 Underlama. All rights reserved.
//

open class BaseViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.initSubviews()
    }
    
    open func initSubviews() {
        // Override it
    }
}
