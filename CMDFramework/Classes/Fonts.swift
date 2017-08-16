//
//  Fonts.swift
//  CINEMOOD Apps Framework
//
//  Created by Nikolay Karataev aka Babaka on 15.08.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import UIKit

public extension UIFont {
    public struct labels {
        public static var TBFLabel: UIFont {
            return UIFont(name: "GothamPro-Medium", size: 18.0)!
        }
        
        public static var cellStatusLabel: UIFont {
            return UIFont(name: "GothamPro", size: 10.0)!
        }
        
        public static var sectorLabel: UIFont {
            return UIFont(name: "GothamPro-Bold", size: 14)!
        }
        
        public static var insetLabel: UIFont {
            return UIFont(name: "GothamPro-Bold", size: 18.0)!
        }
    }
    
    public struct chat {
        public static var timestamp: UIFont {
            return UIFont(name: "GothamPro-Light", size: 11.0)!
        }
        
        public static var agentName: UIFont {
            return UIFont(name: "GothamPro-Light", size: 10.0)!
        }
        
        public static var text: UIFont {
            return UIFont(name: "GothamPro", size: 17.0)!
        }
        
        public static var system: UIFont {
            return UIFont(name: "GothamPro-Light", size: 13.0)!
        }
    }
    
    public struct textWidgets {
        public static var placeholder: UIFont {
            return UIFont(name: "GothamPro-Bold", size: 18.0)!
        }
        
        public static var text: UIFont {
            return UIFont(name: "GothamPro-Bold", size: 18.0)!
        }
    }
    
    public struct widgets {
        public static var loadingLabel: UIFont {
            return UIFont(name: "GothamPro-Light", size: 12.0)!
        }
    }
}
