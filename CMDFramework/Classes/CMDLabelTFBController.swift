//
//  CMDLabelTFBController.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 08.05.17.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import UIKit

open class CMDLabelTFBController: CMDSettableLabel {
    override func setLabel() {
        super.setLabel()
        self.mySpacing = 2
        self.myColor = UIColor.labels.TBFLabelTextColor
        self.font = UIFont.labels.TBFLabel
        self.sizeToFit()
    }
}
