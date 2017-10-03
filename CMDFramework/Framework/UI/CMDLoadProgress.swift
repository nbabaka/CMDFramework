//
//  CMDLoadProgress.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 20.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import EasyPeasy

open class CMDLoadProgress: BaseView {
    public var spinner = CMDSpinner()
    public var label = CMDSettableLabel(text: "", andFont: UIFont.widgets.loadingLabel, andColor: UIColor.textColor.loadingLabel, andSpacing: 1.4)
    public var value: Float = 0 {
        didSet {
            if oldValue == 100, value == 1 {
                self.hide()
                return
            }
            
            let stringValue = String(format: "%.0f%%", value)
            self.label.t = String(format: "LOADING".podLocalization, stringValue)

            if value == 100 {
                self.hide()
            } else {
                self.show()
            }
        }
    }

    override open func initSubviews() {
        self.addSubview(spinner)
        spinner <- [Width(20), Height(20), CenterX(), CenterY(-15)]
        self.addSubview(label)
        label <- [Top(5).to(spinner), CenterX()]
        self.needsUpdateConstraints()
        self.isHidden = true
    }
    
    open func hide() {
        self.spinner.stop()
        delay(0.5) {
            self.setVisible(false)
        }
    }
    
    open func show() {
        self.spinner.start()
        setVisible(true)
    }
    
    open func set(value: Float) {
        self.value = value
    }
    
    private func setVisible(_ status: Bool) {
        if status {
            self.isHidden = false
        }
        UIView.animate(withDuration: 0.1, delay: 0, options: .beginFromCurrentState, animations: {
            let visible: CGFloat = status ? 1 : 0
            self.spinner.alpha = visible
            self.label.alpha = visible
        }, completion: { _ in
            if !status {
                self.isHidden = true
            }
        })
    }
}
