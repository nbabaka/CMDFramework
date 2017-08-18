//
//  UIImageView + extensions.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 15.04.17.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

import SSZipArchive

public extension UIImageView {
    public func loadImages(withBundleName bundle: String, andFilename filename: String, andType type: String, andReverse reverse: Bool) {
        guard let filePath = getBundleFilePath(bundle: bundle) else {
            return
        }
        addImagesForAnimation(atPath: filePath, andFilename: filename, andType: type, andReverse: reverse)

    }
    
    public func loadImages(withBundleName bundle: String, andWithZipName zipname: String, andImageType type: String, andReverse reverse: Bool) {
        guard let filePath = getBundleFilePath(bundle: bundle) else {
            return
        }
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let basePath = (paths.count > 0) ? paths.first : nil
        guard let documentPath = basePath else {
            return
        }
        SSZipArchive.unzipFile(atPath: filePath + "/" + zipname + ".zip", toDestination: documentPath)
        addImagesForAnimation(atPath: documentPath, andFilename: zipname, andType: type, andReverse: reverse)
    }
    
    private func addImagesForAnimation(atPath path: String, andFilename filename: String, andType type: String, andReverse reverse: Bool) {
        var imageArray = [UIImage]()
        let fileManager = FileManager.default
        let enumerator:FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: path)!
        
        while let element = enumerator.nextObject() as? String {
            if element.isMatch(regex: "^" + filename + "[_]*[0-9]*." + type + "$", options: .caseInsensitive) {
                if let img = returnImage(UIImage(contentsOfFile: path + "/" + element), withReverse: reverse) {
                    imageArray.append(img)
                }
            }
        }
        
        if imageArray.count > 0 {
            self.animationImages = imageArray
        }
    }
    
    private func returnImage(_ image: UIImage?, withReverse: Bool) -> UIImage? {
        guard let trueImage = image else {
            return nil
        }
        
        if withReverse {
            return trueImage.inverseImage(cgResult: true)
        }
        return trueImage
    }
    
    public func clearFolder(path: String) {
        let fileManager = FileManager.default
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: path)
            for filePath in filePaths {
                try fileManager.removeItem(atPath: path + filePath)
            }
        } catch let error as NSError {
            print("Could not clear temp folder: \(error.debugDescription)")
        }
    }
}
