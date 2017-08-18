//
//  CMDDropList.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 25/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import EasyPeasy

open class CMDDropList: UIButton {
    // Constants
    let dropImage: UIImage = #imageLiteral(resourceName: "dropdown")
    let itemsDrop: Int = Dimensions.dropList.itemsDrop
    
    // Styles
    
    public var animationTime = 0.4
    public var inactiveBackgroundColor = UIColor.dropList.nonActiveBackground
    public var activeBackgroundColor = UIColor.dropList.activeBackground
    public var separatorColor = UIColor.dropList.separator
    public var tableviewBottomMargin: CGFloat = Dimensions.dropList.tableviewBottomMargin
    
    // Views
    open var dropImageView: UIImageView?
    open var mainView: CMDDropListItem?
    open var itemsView: [CMDDropListItem]?
    
    open var isOpen: Bool = false {
        didSet {
            setHighlight(isOpen)
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            if isButton, isEnabled {
                setHighlight(isHighlighted)
            }
        }
    }
    
    open var isButton: Bool = false {
        didSet {
            dropImageView?.isHidden = isButton
        }
    }
    
    var animateOffset: CGFloat?
    var dismissView: UIView?
    var tableView: UITableView?
    var tableBaseView: UIView?
    var tableBaseHeightConstraint: NSLayoutConstraint?

    // MARK: Initial stuff
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override open func draw(_ rect: CGRect) {
        if tableBaseView == nil {
            initTableBaseView()
        }
    }
    
    private func initSubviews() {
        self.backgroundColor = inactiveBackgroundColor
        self.layer.cornerRadius = Dimensions.dropList.cornerRadius
        self.clipsToBounds = true
        dropImageView = UIImageView(image: dropImage)
        self.addSubview(dropImageView!)
        dropImageView! <- [CenterY(), Width(dropImage.size.width), Height(dropImage.size.width), Right(25)]
        dropImageView?.contentMode = .scaleAspectFit
        dropImageView?.isHidden = true
        setNeedsUpdateConstraints()
    }
    
    private func initTableBaseView() {
        tableBaseView = UIView(frame: self.frame)
        tableBaseView?.layer.cornerRadius =  Dimensions.dropList.cornerRadius
        tableBaseView?.clipsToBounds = true
        tableBaseView?.backgroundColor = inactiveBackgroundColor
        self.superview?.insertSubview(tableBaseView!, belowSubview: self)
        tableBaseView?.translatesAutoresizingMaskIntoConstraints = false
        tableBaseView! <- [Top().to(self, .top), Left(0).to(self, .left), Width().like(self)]
        tableBaseHeightConstraint = NSLayoutConstraint(item: tableBaseView!, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: 0)
        self.superview?.addConstraint(tableBaseHeightConstraint!)
        tableView = UITableView()
        tableView?.register(CMDDropListCell.self, forCellReuseIdentifier: "CMDDropListCell")
        tableView?.separatorStyle = .none
        tableView?.bounces = false
        tableView?.separatorColor = self.separatorColor
        tableBaseView?.addSubview(tableView!)
        tableView?.backgroundColor = UIColor.clear
        tableView?.delegate = self
        tableView?.dataSource = self
        guard let offset = animateOffset else {
            return
        }
        updateTableBase(offset - tableviewBottomMargin)
    }
    
    private func initDismissView() {
        dismissView?.removeFromSuperview()
        dismissView = UIView(frame: (UIWindow.visibleWindow()?.frame)!)
        self.superview?.insertSubview(dismissView!, belowSubview: tableBaseView!)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissableViewTapped(_:)))
        dismissView?.addGestureRecognizer(gestureRecognizer)
    }
    
    private func updateTableBase(_ height: CGFloat) {
        guard let tableView = tableView else {
            return
        }
        tableView.easy_clear()
        tableView <- [Left(10), Right(10), Top(self.frame.height + 5), Height(height)]
    }
    
    // MARK: Setters
    
    public func getActiveID() -> String? {
        return self.mainView?.identifier
    }
    
    public func getActiveView() -> CMDDropListItem? {
        return mainView
    }
    
    internal func setHighlight(_ status: Bool) {
        UIView.animate(withDuration: 0.1) { [unowned self] in
            self.backgroundColor = status ? self.activeBackgroundColor : self.inactiveBackgroundColor
            self.tableBaseView?.backgroundColor = status ? self.activeBackgroundColor : self.inactiveBackgroundColor
            self.mainView?.setActive(status)
        }
    }

    internal func setMainFormWithItem( _ item: CMDDropListItem) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .beginFromCurrentState, animations: {
            self.mainView?.alpha = 0
        }, completion: nil)
        mainView?.removeFromSuperview()
        mainView = item.copyObject()
        mainView?.setActive(false)
        mainView?.alpha = 0
        mainView?.setupConstraints()
        self.addSubview(mainView!)
        mainView! <- [CenterY(), Left(15), Right(10).to(dropImageView!)]
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .beginFromCurrentState, animations: {
            self.mainView?.alpha = 1
        }, completion: nil)
    }

    //MARK: Actions
    
    public func reload() {
        guard let tableView = self.tableView else {
            return
        }
        guard let items = itemsView else {
            return
        }
        guard items.count > 0 else {
            return
        }
        tableView.reloadSections(IndexSet(integersIn: 0...0), with: UITableViewRowAnimation.fade)
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: false)
        self.setMainFormWithItem(items[0])
    }
    
    public func loadItems(_ array: [CMDDropListItem]) {
        guard array.count > 0 else {
            return
        }
        self.removeTarget(self, action: #selector(self.pushButton(_:)), for: UIControlEvents.touchDown)
        self.removeTarget(self, action: #selector(self.pushButton(_:)), for: UIControlEvents.touchUpInside)
        
        itemsView = array
        setMainFormWithItem(itemsView!.first!)
        
        if mainView?.action != .closure {
            dropImageView?.isHidden = false
        }
        
        if array.count > 1 {
            self.addTarget(self, action: #selector(self.pushButton(_:)), for: UIControlEvents.touchDown)
            self.isButton = false
        } else {
            self.addTarget(self, action: #selector(self.pushButton(_:)), for: UIControlEvents.touchUpInside)
            self.isButton = true
            if array[0].action == .select {
                self.isEnabled = false
            }
        }
        let height = self.frame.height * CGFloat(array.count < itemsDrop ? array.count : itemsDrop)
        animateOffset =  height + tableviewBottomMargin
        updateTableBase(height)
    }
    
    @objc private func pushButton(_ sender: UIButton) {
        guard let items = itemsView else {
            return
        }
        guard items.count > 1 else {
            processClosure(atIndex: 0)
            return
        }
        
        if !isOpen {
            isOpen = true
            animateDrop(offset: animateOffset!, isDown: true)
        } else {
            cancel()
        }
    }
    
    internal func cancel() {
        if !isOpen {
            return
        }
        if let gestureRecognizer = dismissView?.gestureRecognizers?.first {
            dismissView?.removeGestureRecognizer(gestureRecognizer)
        }
        dismissView?.removeFromSuperview()
        animateDrop(offset: 0, isDown: false)
    }
    
    private func animateDrop(offset: CGFloat, isDown: Bool) {
        self.rotateDropImage(isDown: isDown)
        superview?.bringSubview(toFront: tableBaseView!)
        superview?.bringSubview(toFront: self)
        
        self.tableView?.isUserInteractionEnabled = isDown

        UIView.animate(withDuration: TimeInterval(animationTime), delay: 0, options: .allowUserInteraction, animations: { [unowned self] in
            if isDown {
                self.tableBaseHeightConstraint?.constant = offset
            } else {
                self.tableBaseHeightConstraint?.constant = 0
            }
            self.superview?.layoutIfNeeded()
            }, completion: { [unowned self] isSuccess in
                if isDown {
                    self.initDismissView()
                    DispatchQueue.main.async { [unowned self] in
                        self.tableView?.flashScrollIndicators()
                    }
                } else {
                    self.isOpen = false
                    self.tableView?.reloadData()
                }
        })
    }
    
    internal func dismissableViewTapped(_ gesture: UIGestureRecognizer) {
        cancel()
    }
    
    internal func processClosure(atIndex index: Int) {
        guard let items = itemsView else {
            return
        }
        
        guard items[index].action == .closure else {
            return
        }
        items[index].closure?()
    }
    
    // MARK: Helpers
    /*
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if  view == dismissView {
            cancel()
            return nil
        } else {
            return view
        }
    }*/
    
    private func rotateDropImage(isDown: Bool) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.toValue = isDown ? CGFloat.pi : 0
        rotationAnimation.duration = TimeInterval(animationTime)
        rotationAnimation.fillMode = kCAFillModeForwards
        rotationAnimation.isRemovedOnCompletion = false
        self.dropImageView?.layer.add(rotationAnimation, forKey: nil)
    }
}

extension CMDDropList: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = itemsView else {
            return 0
        }
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CMDDropListCell", for: indexPath) as! CMDDropListCell
        let item = itemsView![indexPath.row]
        cell.addView(item.copyObject())
        cell.itemView?.setActive(true)
        cell.selectedImageView.isHidden = !isSetCurrent(inIndex: indexPath.row)
        return cell
    }
    
    internal func isSetCurrent(inIndex index: Int) -> Bool {
        let item = itemsView![index]
        guard let mainId = mainView!.identifier else {
            return false
        }
        guard let cellId = item.identifier else {
            return false
        }
        return mainId == cellId
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.frame.height
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let items = itemsView else {
            return
        }
        if items[indexPath.row].action == .select {
            setMainFormWithItem(items[indexPath.row])
            cancel()
        } else if items[indexPath.row].action == .closure {
            processClosure(atIndex: indexPath.row)
            cancel()
        }
    }
}

internal extension UIWindow {
    static func visibleWindow() -> UIWindow? {
        var currentWindow = UIApplication.shared.keyWindow
        
        if currentWindow == nil {
            let frontToBackWindows = Array(UIApplication.shared.windows.reversed())
            
            for window in frontToBackWindows {
                if window.windowLevel == UIWindowLevelNormal {
                    currentWindow = window
                    break
                }
            }
        }
        return currentWindow
    }
}

