//
//  CMDImageChatCell.swift
//  CinemoodApp
//
//  Created by Karataev Nikolay aka Babaka on 10.07.17.
//  Copyright © 2017 CINEMOOD Trendsetters Co. All rights reserved.
//

import SDWebImage
import EasyPeasy

class CMDUploadChatCell: CMDChatCell, CMDUploadCell {
    @IBOutlet var loadingProgress: CMDLoadProgress?
    @IBOutlet var imageContentView: UIImageView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    var uploadContentLabel: CMDInsetsLabel?
    var resendButton: CMDClassicButton?
    
    var uploadItem: ChatUploadItem! {
        didSet {
            self.setDelegate()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override var chatEvent: ChatEvent! {
        didSet {
            super.chatEvent = chatEvent
            guard let chatUploadCell = chatEvent as? ChatUploadItemType else {
                return
            }
            
            guard let uploadItem = chatUploadCell.uploadItem else {
                return
            }
            self.uploadItem = uploadItem
            
            guard !isUploadError() else {
                return
            }
            processUploaded()
        }
    }
    
    func processUploaded() {
        guard uploadItem.isLoaded else {
            return
        }

        if uploadItem.getType().isImage {
            if let image = self.uploadItem.image {
                imageContentView.image = image
                setImageViewSize()
                setImage()
            } else {
                setImageURL(uploadItem.url)
            }
        } else {
            setContentLabel(forType: uploadItem.getType())
        }
    }
    
    private func isUploadError() -> Bool {
        if self.uploadItem.error {
            state = .error
            resendButton = CMDClassicButton(withText: "CHAT_RESEND".l, action: {
                self.state = .notConfirmed
                self.resendButton?.removeFromSuperview()
                self.setDelegate()
                self.uploadItem.file?.resend()
            })
            
            view.addSubview(resendButton!)
            resendButton! <- [CenterX(), CenterY(), Width().like(view)]
            deleteDelegate()
            return true
        }
        return false
    }
    
    private func setDelegate() {
        if let file = self.uploadItem.file {
            if file.status == .pending || file.status == .transfering {
                uploadItem.delegate = self
            } else {
                deleteDelegate()
            }
        }
    }
    
    private func deleteDelegate() {
        loadingProgress?.hide()
        uploadItem.delegate = nil
    }

    func setImageURL(_ url: URL?) {
        self.imageContentView.sd_setImage(with: url)
        self.imageContentView.contentMode = .center
        setImageViewSize()
        self.imageContentView.image = UIImage(named: "placeholder")
        self.imageContentView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "placeholder")) { [unowned self] (image, _, _, _ ) in
            if image != nil {
                self.setImage()
            }
        }
    }
    
    func setContentLabel(forType type: ChatUploadItem.FileType) {
        uploadContentLabel = CMDInsetsLabel(withUpperText: type.rawValue)
        view.addSubview(uploadContentLabel!)
        uploadContentLabel! <- [CenterX(), CenterY()]
        self.heightConstraint.constant = 50
        self.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        self.setupViews()
    }
    
    private func setImage() {
        self.imageContentView.contentMode = .scaleAspectFill
        self.imageContentView.clipsToBounds = true
    }
    
    private func setupViews() {
        self.deleteDelegate()
        self.imageContentView.sd_cancelCurrentImageLoad()
        self.heightConstraint.constant = 40
        self.imageContentView.image = nil
        self.imageContentView.gestureRecognizers?.removeAll()
        self.resendButton?.removeFromSuperview()
        self.resendButton = nil
        self.uploadContentLabel?.removeFromSuperview()
        self.uploadContentLabel = nil
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func setImageViewSize() {
        guard let viewWidth = imageContentView.superview?.frame.width else {
            return
        }
        self.heightConstraint.constant = viewWidth
        self.layoutIfNeeded()
    }
}
