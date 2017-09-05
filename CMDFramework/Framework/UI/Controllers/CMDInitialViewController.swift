//
//  CMDInitialViewController.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev on 21/08/2017.
//  Copyright © 2017 Cinemood Trendsetters Co. All rights reserved.
//

import PKHUD
import EasyPeasy

open class CMDInitialViewController : CMDKeyboardHandledViewController {
    
    @IBOutlet open var scrollView: UIScrollView?
    open var titleLogo: UIImage?
    open var titleAttribute: CMDTextAttribute?
    public var activeField: UIView?
    public var backgroundImage: UIImageView?
    public var moveToRoot: Bool = false
    public var parentVC: UIViewController?
    public let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    internal var backButtonAction: ((Void) -> Void)?
    internal var hideDelay = 4
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(broadcastNotificationsReceived(_:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(broadcastNotificationsReceived(_:)), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(broadcastNotificationsReceived(_:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    override open func keyboardShow(_ notification: Notification) {
        super.keyboardShow(notification)
        guard let scrollView = self.scrollView else {
            return
        }
        scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        if let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size {
            let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            
            var aRect: CGRect = self.view.frame
            aRect.size.height -= keyboardSize.height
            if let activeField = self.activeField {
                if !aRect.contains(activeField.frame.origin) {
                    scrollView.scrollRectToVisible(activeField.frame, animated: true)
                }
            }
        }
    }
    
    override open func keyboardHide(_ notification: Notification) {
        super.keyboardHide(notification)
        guard let scrollView = self.scrollView else {
            return
        }
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        view.endEditing(true)
        scrollView.isScrollEnabled = true
    }
    
    public func addBackButton(withBlock block: @escaping (Void) -> Void) {
        let button = CMDBackButton()
        self.backButtonAction = block
        button.addTarget(self, action: #selector(self.handleBackButton(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        button <- [Top(30), Left(15), Right(15)]
        self.view.needsUpdateConstraints()
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
        let titleLabel = CMDSettableLabel(text: text, andFont: titleAttribute?.font ?? UIFont.controllers.title, andColor: titleAttribute?.color ?? UIColor.controllers.title, andSpacing: titleAttribute?.spacing ?? 4)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
    
    public func setNavigationTitle(withText text: String, andAttribute attr: CMDTextAttribute) {
        self.titleAttribute = attr
        self.setNavigationTitle(text)
    }
    
    open func setMenuBarButton(withImage image: UIImage?) {
        let menuButton = UIBarButtonItem.init(image: image, landscapeImagePhone: image, style: .plain, target: self, action: #selector(self.menuButtonPressed(_:)))
        self.navigationItem.leftBarButtonItem = menuButton
    }
    
    open func menuButtonPressed(_ sender: UIBarButtonItem) {
        // Override
    }
    
    public func setBackground(withImage image: UIImage?) {
        guard let image = image else {
            return
        }
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        image.drawAsPattern(in: self.view.bounds)
        let compiledImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: compiledImage)
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
    
    public func showAlert(withTitle title: String, andText text: String, andIcon icon: UIImage, andButton button: String) {
        let alert = CMDOneButtonAlert(withIcon: icon, andTitle: title, andMainText: text)
        alert.text = button
        alert.onPushButtonBlock = {
            alert.close(.moveDown)
        }
        alert.show(.moveUp)
    }
    
    @objc private func handleBackButton(_ button: UIButton) {
        self.backButtonAction?()
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
