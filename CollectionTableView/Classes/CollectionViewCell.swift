//
//  CollectionViewCell.swift
//  CollectionTableView
//
//  Created by Rugen Heidbuchel on 19/08/2016.
//  Copyright © 2016 Rugen Heidbuchel. All rights reserved.
//

import UIKit

open class CollectionViewCell: UITableViewCell {

    // MARK: Properties
    
    open var collectionView = { () -> UICollectionView in
        
        // Setup the flow layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        // Create the collection view
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    
    // MARK: Initialisation
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set the frame of the collection view
        self.collectionView.frame = self.bounds
        
        // Add it as a subview
        self.addSubview(collectionView)
        
        // Add constraints to fill the cell
        let views: [String: UIView] = ["collectionView": collectionView]
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[collectionView]|",
            options: [],
            metrics: nil,
            views: views))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[collectionView]|",
            options: [],
            metrics: nil,
            views: views))
        
        // Disable autoresizing mask constraints
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    // MARK: Nib and Class Registration
    
    /**
     Registers the given nibs and classes with the collection view for the given identifiers.
     
     - parameter nibsAndClasses: The nibs and classes.
     - parameter identifiers:    The respective identifiers. The identifier is for the element with the same index.
     */
    func registerNibsAndClassesForIdentifiers(_ nibsAndClasses: [Any], identifiers: [String]) {
        
        for (index, identifier) in identifiers.enumerated() {
            switch nibsAndClasses[index] {
            case let cls as AnyClass:
                self.collectionView.register(cls, forCellWithReuseIdentifier: identifier)
            case let nib as UINib:
                self.collectionView.register(nib, forCellWithReuseIdentifier: identifier)
            default:
                fatalError("Only classes and nibs are supported!")
            }
        }
    }
}
