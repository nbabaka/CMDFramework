//
//  CMDInitialViewController.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev on 21/08/2017.
//  Copyright © 2017 Cinemood Trendsetters Co. All rights reserved.
//

import PKHUD

open class CMDInitialViewController : CMDKeyboardHandledViewController {
    
    open var titleLogo: UIImage?
    public var backgroundImage: UIImageView?
    public var moveToRoot: Bool = false
    public var parentVC: UIViewController?
    public let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    internal var hideDelay = 4
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(broadcastNotificationsReceived(_:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(broadcastNotificationsReceived(_:)), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(broadcastNotificationsReceived(_:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    public func deleteController(atIndex index: Int = 1) {
        guard let array = navigationController?.viewControllers else {
            return
        }
        guard let i = navigationController?.viewControllers.index(of: self) else {
            return
        }
        
        guard (i-index) > 0 else {
            return
        }
        
        let previousViewController = navigationController?.viewControllers[i - index]
        
        if let index = array.index(of: previousViewController!) {
            navigationController?.viewControllers.remove(at: index)
        }
    }
    
    public func setNavigationTitle(_ text: String) {
        let titleLabel = CMDSettableLabel(text: text, andFont: UIFont.controllers.title, andColor: UIColor.controllers.title, andSpacing: 4)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
    
    public func setNavigationTitleLogo() {
        let imageView = UIImageView(image: self.titleLogo)
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    public func addBackgroundBlur(withRadius radius: CGFloat = 10.0, andColor color: UIColor = UIColor.black, andColorAplha alpha: CGFloat = 0.3) {
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        let ve = CMDBlurEffectView()
        ve.colorTint = color
        ve.colorTintAlpha = alpha
        ve.blurRadius = radius
        ve.frame = self.view.bounds
        self.view.addSubview(ve)
        self.view.sendSubview(toBack: ve)
    }
    
    public func showError(_ message: String) {
        if message.isEmpty {
            HUD.hide(animated: true)
            return
        }
        main {
            HUD.flash(.label(message), delay: TimeInterval(self.hideDelay))
        }
    }
    
    public func showSuccess() {
        self.hideMessage()
    }
    
    public func showProgress(message: String? = nil) {
        main {
            PKHUD.sharedHUD.contentView = CMDHUDProgressView(title: nil, subtitle: message)
            PKHUD.sharedHUD.show()
        }
    }
    
    public func hideMessage() {
        main {
            HUD.hide(animated: true)
        }
    }
    
    public func getSnapshotAndPutBelow(_ view: UIView?) {
        if backgroundImage == nil {
            view?.isHidden = true
            backgroundImage = UIImageView(image: self.view.asImage().applyCustomBlur())
            backgroundImage?.layer.opacity = 0
            if view != nil {
                self.view.insertSubview(backgroundImage!, belowSubview: view!)
            } else {
                self.view.addSubview(backgroundImage!)
            }
            view?.isHidden = false
        }
    }
    
    public func blurBackground(_ blur: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState] , animations: {
            self.backgroundImage?.layer.opacity = (blur == true) ? 1 : 0
        }, completion: nil)
    }
    
    open func setActiveAgain() {
        // Must override
    }
    
    open func setResignActive() {
        // Must override
    }

    open func setBackground() {
        // Must override
    }
    
    public func dismissModal() {
        if let presentVC = findFirstPresentController(for: self, findController: self.parentVC) {
            let image = UIApplication.shared.screenShot
            let screenView = UIImageView(image: image)
            screenView.frame = UIScreen.main.bounds
            presentVC.view.addSubview(screenView)
            if self == presentVC {
                rootDismissFrom(presentVC)
            } else {
                presentVC.dismiss(animated: false) {
                    self.rootDismissFrom(presentVC)
                }
            }
        } else {
            rootDismissFrom(self, withAnimating: false)
        }
    }
    
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    public func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func modalPresent(_ vc: UIViewController) {
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    public func userOn() {
        userActivity(isOn: true)
    }
    
    public func userOff() {
        userActivity(isOn: false)
    }

    private func userActivity(isOn: Bool) {
        self.view.isUserInteractionEnabled = isOn
    }
    
    private func rootDismissFrom(_ controller: UIViewController, withAnimating animation: Bool = true) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    private func findFirstPresentController(for controller: UIViewController, findController: UIViewController? = nil) -> UIViewController? {
        if controller.presentingViewController == (findController == nil ? self.view.window?.rootViewController : findController) {
            return controller
        } else {
            if let presentVC = controller.presentingViewController {
                return findFirstPresentController(for: presentVC, findController: findController)
            }
        }
        return nil
    }
    
    @objc private func broadcastNotificationsReceived(_ notification: NSNotification) {
        switch notification.name {
        case NSNotification.Name.UIApplicationDidBecomeActive:
            setActiveAgain()
        case NSNotification.Name.UIApplicationWillResignActive:
            setResignActive()
        case NSNotification.Name.UIApplicationDidEnterBackground:
            setBackground()
        default:
            break
        }
    }
}
