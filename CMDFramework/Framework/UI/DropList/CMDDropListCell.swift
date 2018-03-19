//
//  CMDDropListCell.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 26/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import EasyPeasy

open class CMDDropListCell: UITableViewCell {
    open var itemView: CMDDropListItem?
    open var selectedImageView: UIImageView = UIImageView(image: getImageFromBundle(name: "default", withClass: UITableViewCell.self))
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initCell()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCell()
    }
    
    open func initCell() {
        self.backgroundColor = UIColor.clear
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        bgColorView.layer.cornerRadius = 5
        bgColorView.clipsToBounds = true
        self.selectedBackgroundView = bgColorView
        self.addSubview(selectedImageView)
        selectedImageView.easy.layout(CenterY(),
                                      Right(15))
        selectedImageView.isHidden = true
    }
    
    open func addView(_ view: CMDDropListItem) {
        self.itemView?.removeFromSuperview()
        self.addSubview(view)
        itemView = view
        view.easy.layout(Left(5),
                         Right(35),
                         Top(0),
                         Bottom(0))
    }
}
