//
//  CMDTextAttribute.swift
//  Pods
//
//  Created by Nikolay Karataev aka Babaka on 05.09.17.
//
//

open class CMDTextAttribute: NSObject {
    open var color: UIColor = UIColor.white
    open var spacing: Float = 1.0
    open var font: UIFont = UIFont.systemFont(ofSize: 17.0)
    
    convenience public init(withColor color: UIColor = UIColor.white, andFont font: UIFont = UIFont.systemFont(ofSize: 17.0), andSpacing spacing: Float = 1.0) {
        self.init()
        self.color = color
        self.font = font
        self.spacing = spacing
    }
}
