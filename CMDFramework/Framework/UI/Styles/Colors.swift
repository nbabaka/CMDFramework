//
//  Colors.swift
//  CINEMOOD Apps Framework
//
//  Created by Nikolay Karataev on 15.08.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import UIKit

public extension UIColor {
    public struct background {
        public static var greenForSwipeCell: UIColor {
            return UIColor(red: 35/255.0, green: 184/255.0, blue: 64/255.0, alpha: 1.0)
        }
        
        public static var redForSwipeCell: UIColor {
            return UIColor(red: 230/255.0, green: 13/255.0, blue: 67/255.0, alpha: 1.0)
        }
        
        public static var devicesCell: UIColor {
            return UIColor(red: 45/255.0, green: 45/255.0, blue: 53/255.0, alpha: 1.0)
        }
        
        public static var activeDevicesCell: UIColor {
            return UIColor(red: 85/255.0, green: 85/255.0, blue: 93/255.0, alpha: 1.0)
        }
        
        public static var blueButton: UIColor {
            return UIColor(red:40/255.0, green:146/255.0, blue:211/255.0,  alpha:1)
        }
        
        public static var switchBack: UIColor {
            return UIColor(red: 55/255.0, green: 55/255.0, blue: 66/255.0, alpha: 1.0)
        }
        
        public static var chatAgent: UIColor {
            return UIColor(red: 97/255.0, green: 97/255.0, blue: 97/255.0, alpha: 1.0)
        }
        
        public static var chatVisitor: UIColor {
            return UIColor(red: 40/255.0, green: 146/255.0, blue: 211/255.0, alpha: 1.0)
        }
    }
    
    public struct textColor {
        public static var tableViewHeader: UIColor {
            return UIColor(red: 114/255.0, green: 114/255.0, blue: 127/255.0, alpha: 1.0)
        }
        
        public static var chatAgent: UIColor {
            return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        }
        
        public static var chatAgentName: UIColor {
            return UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
        }
        
        public static var chatAgentTimestamp: UIColor {
            return UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
        }
        
        public static var chatVisitor: UIColor {
            return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        }
        
        public static var chatVisitorTimestamp: UIColor {
            return UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
        }
        
        public static var chatSystem: UIColor {
            return UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0)
        }
        
        public static var loadingLabel: UIColor {
            return UIColor(red: 220/255.0, green: 220/255.0, blue: 230/255.0, alpha: 1.0)
        }
        
        public static var chatURL: UIColor {
            return UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
        }
    }

    public struct controllers {
        public static var title: UIColor {
            return UIColor(red: 207/255.0, green: 210/255.0, blue: 225/255.0, alpha: 1.0)
        }
    }
    
    public struct alerts {
        public static var title: UIColor {
            return UIColor(red: 195.0 / 255.0, green: 199.0 / 255.0, blue: 217.0 / 255.0, alpha: 1.0)
        }
        
        public static var text: UIColor {
            return UIColor(red: 160.0 / 255.0, green: 163.0 / 255.0, blue: 179.0 / 255.0, alpha: 1.0)
        }
    }
    
    public struct labels {
        public static var TBFLabelTextColor: UIColor {
            return UIColor(red: 160/255.0, green: 163/255.0, blue: 179/255.0, alpha: 1.0)
        }
        
        public static var cellStatusLabelOther: UIColor {
            return UIColor(red: 160/255.0, green: 163/255.0, blue: 179/255.0, alpha: 1.0)
        }
        
        public static var sectorLabelTextColor: UIColor {
            return UIColor(red: 70/255.0, green: 70/255.0, blue: 80/255.0, alpha: 1.0)
        }
        
        public static var insetLabelBorder: UIColor {
            return UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
        }
        
        public static var insetLabelBackground: UIColor {
            return UIColor(red: 45/255.0, green: 45/255.0, blue: 53/255.0, alpha: 1.0)
        }
    }
    
    public struct buttons {
        public static var blueButtonBackground: UIColor {
            return UIColor(red: 40.0 / 255.0, green: 146.0 / 255.0, blue: 211.0 / 255.0, alpha: 1.0)
        }
        
        public static var blueButtonBackgroundHighlight: UIColor {
            return UIColor(red: 0.0, green: 153.0 / 255.0, blue: 212.0 / 255.0, alpha: 1.0)
        }
        
        public static var blueButtonBackgroundDisabled: UIColor {
            return UIColor(red: 55.0 / 255.0, green: 55.0 / 255.0, blue: 66.0 / 255.0, alpha: 1.0)
        }
        
        public static var blueButtonTitle: UIColor {
            return UIColor(red: 212.0 / 255.0, green: 233.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
        }
        
        public static var blueButtonTitleHighlight: UIColor {
            return UIColor.white
        }
        
        public static var blueButtonTitleDisabled: UIColor {
            return UIColor(red: 64/255.0, green: 64/255.0, blue: 67/255.0, alpha: 1.0)
        }
        
        public static var blueButtonShadow: UIColor {
            return UIColor(red: 17.0 / 255.0, green: 134.0 / 255.0, blue: 207.0 / 255.0, alpha: 0.5)
        }
        
        public static var classicButtonTitle: UIColor {
            return UIColor(red: 91.0 / 255.0, green: 93.0 / 255.0, blue: 110.0 / 255.0, alpha: 1.0)
        }
        
        public static var classicButtonTitleHightlight: UIColor {
            return UIColor(red: 195.0 / 255.0, green: 199.0 / 255.0, blue: 217.0 / 255.0, alpha: 1.0)
        }
        
        public static var backButtonTitle: UIColor {
            return UIColor(red: 195.0 / 255.0, green: 199.0 / 255.0, blue: 217.0 / 255.0, alpha: 1.0)
        }
        
        public static var grayButtonBackground: UIColor {
            return UIColor(red: 55.0 / 255.0, green: 55.0 / 255.0, blue: 66.0 / 255.0, alpha: 1.0)
        }
        
        public static var grayButtonBackgroundHighlight: UIColor {
            return UIColor(red: 55.0 / 255.0, green: 55.0 / 255.0, blue: 66.0 / 255.0, alpha: 1.0)
        }
        
        public static var grayButtonShadow: UIColor {
            return UIColor(red: 55.0 / 255.0, green: 55.0 / 255.0, blue: 66.0 / 255.0, alpha: 1.0)
        }
        
        public static var grayButtonTitle: UIColor {
            return UIColor(red: 167.0 / 255.0, green: 170.0 / 255.0, blue: 187.0 / 255.0, alpha: 1.0)
        }
        
        public static var grayButtonTitleHighlight: UIColor {
            return UIColor.white
        }
        
        public static var rightImageTitle: UIColor {
            return UIColor(white: 111.0 / 255.0, alpha: 1.0)
        }
        
        public static var rightImageTint: UIColor {
            return UIColor(white: 111.0 / 255.0, alpha: 1.0)
        }
        
        public static var colorButtonBackground: UIColor {
            return UIColor(red: 45/255.0, green: 45/255.0, blue: 53/255.0, alpha: 1.0)
        }
        
        public static var colorButtonBackgroundHighlight: UIColor {
            return UIColor(red: 174/255.0, green: 174/255.0, blue: 186/255.0, alpha: 1.0)
        }
        
        public static var colorButtonTint: UIColor {
            return UIColor(red: 20/255.0, green: 20/255.0, blue: 24/255.0, alpha: 1.0)
        }
        
        public static var colorButtonTitleHighlight: UIColor {
            return UIColor(red: 20/255.0, green: 20/255.0, blue: 24/255.0, alpha: 1.0)
        }
        
        public static var colorButtonTitle: UIColor {
            return UIColor(red: 114/255.0, green: 114/255.0, blue: 127/255.0, alpha: 1.0)
        }
        
        public static var redButtonBackground: UIColor {
            return UIColor(red: 230/255.0, green: 13/255.0, blue: 67/255.0, alpha: 1.0)
        }
        
        public static var redButtonTitle: UIColor {
            return UIColor(red: 230/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1.0)
        }
        
        public static var facebook: UIColor {
            return UIColor(red: 60.0 / 255.0, green: 90.0 / 255.0, blue: 153.0 / 255.0, alpha: 1.0)
        }
    }
    
    
    public struct textFields {
        public static var activeText: UIColor {
            return UIColor(red: 20/255.0, green: 20/255.0, blue: 24/255.0, alpha: 1.0)
        }
        
        public static var nonActiveText: UIColor {
            return UIColor(red: 114/255.0, green: 114/255.0, blue: 127/255.0, alpha: 1.0)
        }
        
        public static var activeBackground: UIColor {
            return UIColor(red: 174/255.0, green: 174/255.0, blue: 186/255.0, alpha: 1.0)
        }
        
        public static var nonActiveBackground: UIColor {
            return UIColor(red: 45/255.0, green: 45/255.0, blue: 53/255.0, alpha: 1.0)
        }
        
        public static var activePlaceholder: UIColor {
            return UIColor(red: 82/255.0, green: 85/255.0, blue: 98/255.0, alpha: 1.0)
        }
        
        public static var nonActivePlaceholder: UIColor {
            return UIColor(red: 82/255.0, green: 85/255.0, blue: 98/255.0, alpha: 1.0)
        }
        
        public static var validationLabel: UIColor {
            return UIColor(red: 230.0 / 255.0, green: 13.0 / 255.0, blue: 67.0 / 255.0, alpha: 1.0)
        }
        
        public static var phoneFieldBorder: UIColor {
            return UIColor(red: 82.0 / 255.0, green: 85.0 / 255.0, blue: 98.0 / 255.0, alpha: 1.0)
        }
        
        public static var codeFieldText: UIColor {
             return UIColor(red: 20.0 / 255.0, green: 20.0 / 255.0, blue: 24.0 / 255.0, alpha: 1.0)
        }
    }
    
    
    public struct dropList {
        public static var activeText: UIColor {
            return UIColor(red: 20/255.0, green: 20/255.0, blue: 24/255.0, alpha: 1.0)
        }
        
        public static var nonActiveText: UIColor {
            return UIColor(red: 114/255.0, green: 114/255.0, blue: 127/255.0, alpha: 1.0)
        }
        
        public static var activeBackground: UIColor {
            return UIColor(red: 174/255.0, green: 174/255.0, blue: 186/255.0, alpha: 1.0)
        }
        
        public static var nonActiveBackground: UIColor {
            return UIColor(red: 45/255.0, green: 45/255.0, blue: 53/255.0, alpha: 1.0)
        }
        
        public static var separator: UIColor {
            return UIColor(red: 82/255.0, green: 85/255.0, blue: 98/255.0, alpha: 1.0)
        }
        
        public static var nonActiveTextItem: UIColor {
            return UIColor(red: 156/255.0, green: 159/255.0, blue: 174/255.0, alpha: 1.0)
        }
        
        public static var activeTextItem: UIColor {
            return UIColor(red: 82/255.0, green: 85/255.0, blue: 98/255.0, alpha: 1.0)
        }
    }
    
    public struct padColors {
        public static var roundedRect: UIColor {
            return UIColor(red:34/255.0, green:35/255.0, blue:39/255.0,  alpha:1)
        }
    }
}
