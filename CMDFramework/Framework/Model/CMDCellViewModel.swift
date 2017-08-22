//
//  CMDCellViewModel.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 31/05/2017.
//  Copyright © 2017 CINEMOOD. All rights reserved.
//

public protocol CMDCellViewAnyModel {
    static var CellAnyType: UIView.Type { get }
    func setupAny(cell: UIView, sender: UIViewController?)
}

public protocol CMDCellViewModel: CMDCellViewAnyModel {
    associatedtype CellType: UIView
    func setup(cell: CellType, sender: UIViewController?)
}

public extension CMDCellViewModel {
    public static var CellAnyType: UIView.Type {
        return CellType.self
    }
    public func setupAny(cell: UIView, sender: UIViewController?) {
        if let cell = cell as? CellType {
            setup(cell: cell, sender: sender)
        } else {
            assertionFailure("CELL TYPE ERROR!")
        }
    }
}

public extension UITableView {
    public func dequeueReusableCell (withModel model: CMDCellViewAnyModel, for indexPath: IndexPath, sender: UIViewController? = nil) -> UITableViewCell {
        let id = String(describing: type(of: model).CellAnyType)
        let cell = self.dequeueReusableCell(withIdentifier: id, for: indexPath)
        model.setupAny(cell: cell, sender: sender)
        return cell
    }
    
    public func register(nibModels: [CMDCellViewAnyModel.Type]) {
        for model in nibModels {
            let id = String(describing: model.CellAnyType)
            self.register(nibName: id)
        }
    }
    
    public func register(nibNames: [String]) {
        for nib in nibNames {
            self.register(nibName: nib)
        }
    }
    
    public func register(nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: nibName)
    }
}

public extension UICollectionView {
    public func dequeueReusableCell (withModel model: CMDCellViewAnyModel, for indexPath: IndexPath, sender: UIViewController? = nil) -> UICollectionViewCell {
        let id = String(describing: type(of: model).CellAnyType)
        let cell = self.dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
        model.setupAny(cell: cell, sender: sender)
        return cell
    }
    
    public func register(nibModels: [CMDCellViewAnyModel.Type]) {
        for model in nibModels {
            let id = String(describing: model.CellAnyType)
            let nib = UINib(nibName: id, bundle: nil)
            self.register(nib, forCellWithReuseIdentifier: id)
        }
    }
}
