//
//  Reusable.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 09/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable { }
extension UITableViewHeaderFooterView: Reusable { }
extension UICollectionReusableView: Reusable { }


public extension UITableView {
    
    @discardableResult
    public func registerReusables(withClasses cellClasses: [Reusable.Type]) -> UITableView {
        for reusable in cellClasses {
            register(reusable, forCellReuseIdentifier: reusable.reuseIdentifier)
        }
        return self
    }
    
    @discardableResult
    public func registerReusableClass(withClass cellClass: Reusable.Type) -> UITableView {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
        
        return self
    }
    
    @discardableResult
    public func registerReusableNibs(withClasses cellClasses: [Reusable.Type]) -> UITableView {
        for reusable in cellClasses {
            let nib = UINib(nibName: reusable.reuseIdentifier, bundle: nil)
            register(nib, forCellReuseIdentifier: reusable.reuseIdentifier)
        }
        return self
    }
    
    @discardableResult
    public func registerReusableNib(withClass cellClass: Reusable.Type) -> UITableView {
        let nib = UINib(nibName: cellClass.reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: cellClass.reuseIdentifier)
        
        return self
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(withClass cellClass: T.Type,
                                                        for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
}

// MARK: - UITableViewHeaderFooterView

public extension UITableView {
    
    @discardableResult
    public func registerReusableHeaderFooterView(withClass headerFooterViewClass: Reusable.Type,
                                                 fromNib: Bool = false) -> UITableView {
        if fromNib {
            let nib = UINib(nibName: headerFooterViewClass.reuseIdentifier, bundle: nil)
            register(nib, forHeaderFooterViewReuseIdentifier: headerFooterViewClass.reuseIdentifier)
        } else {
            register(headerFooterViewClass, forHeaderFooterViewReuseIdentifier: headerFooterViewClass.reuseIdentifier)
        }
        
        return self
    }
    
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass
        headerFooterViewClass: T.Type = T.self) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T
    }
    
}

extension UICollectionView {
    @discardableResult
    public func registerReusables(withClasses cellClasses: [Reusable.Type],
                                  fromNib: Bool = true) -> UICollectionView {
        for reusable in cellClasses {
            registerReusable(withClass: reusable, fromNib: fromNib)
        }
        return self
    }
    
    @discardableResult
    public func registerReusables(withNibs nibs: [String]) -> UICollectionView {
        for reusable in nibs {
            register(UINib(nibName: reusable, bundle: nil), forCellWithReuseIdentifier: reusable)
        }
        return self
    }
    
    @discardableResult
    public func registerReusable(withClass cellClass: Reusable.Type, fromNib: Bool = false) -> UICollectionView {
        if fromNib {
            let nib = UINib(nibName: cellClass.reuseIdentifier, bundle: nil)
            register(nib, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        } else {
            register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
        }
        
        return self
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(withClass cellClass: T.Type,
                                                             for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

// MARK: - UICollectionReusableView

public extension UICollectionView {
    @discardableResult
    public func registerReusableViewOfKind(_  kind: String,
                                           withClass viewClass: Reusable.Type) -> UICollectionView {
        let nib = UINib(nibName: viewClass.reuseIdentifier, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: viewClass.reuseIdentifier)
        return self
    }
    
    public func dequeueReusableViewOfKind<T: UICollectionReusableView>
        (_ kind: String, withClass viewClass: T.Type, for indexPath: IndexPath) -> T {
        
        return dequeueReusableSupplementaryView(ofKind: kind,
                                                withReuseIdentifier: T.reuseIdentifier,
                                                for: indexPath)  as! T
    }
}



