//
//  CMDChatImageViewController.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 27.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

class CMDChatImageViewController: CMDInitialViewController {

    var image: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = image
    }
}
