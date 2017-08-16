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
        
        public static var redButton: UIColor {
            return UIColor(red: 230/255.0, green: 13/255.0, blue: 67/255.0, alpha: 1.0)
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
    
    public struct labels {
        public static var TBFLabelTextColor: UIColor {
            return UIColor(red: 160/255.0, green: 163/255.0, blue: 179/255.0, alpha: 1.0)
        }
        
        public static var cellStatusLabelOther: UIColor {
            return UIColor(red: 160/255.0, green: 163/255.0, blue: 179/255.0, alpha: 1.0)
        }
        
        static var sectorLabelTextColor: UIColor {
            return UIColor(red: 70/255.0, green: 70/255.0, blue: 80/255.0, alpha: 1.0)
        }
        
        static var insetLabelBorder: UIColor {
            return UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
        }
        
        static var insetLabelBackground: UIColor {
            return UIColor(red: 45/255.0, green: 45/255.0, blue: 53/255.0, alpha: 1.0)
        }
    }
    
    public struct textWidgets {
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
    }
    
    public struct padColors {
        public static var roundedRect: UIColor {
            return UIColor(red:34/255.0, green:35/255.0, blue:39/255.0,  alpha:1)
        }
    }
}
