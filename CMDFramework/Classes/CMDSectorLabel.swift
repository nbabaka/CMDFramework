//
//  CMDSectorLabel.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 22/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import UIKit

open class CMDSectorLabel: CMDSettableLabel {
    override func setLabel() {
        super.setLabel()
        self.mySpacing = 2
        self.myFont = UIFont.labels.sectorLabel
        self.myColor = UIColor.labels.sectorLabelTextColor
    }
}
