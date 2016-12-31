//
//  CollectionTableViewDelegate.swift
//  CollectionTableView
//
//  Created by Rugen Heidbuchel on 21/08/2016.
//  Copyright © 2016 Rugen Heidbuchel. All rights reserved.
//

import UIKit

@objc
public protocol CollectionTableViewDelegate {
    
    // MARK: Item Configuration
    
    @objc optional func collectionTableView(
        _ tableView: CollectionTableView,
        sizeForItemAtIndexPath indexPath: IndexPath)
        -> CGSize
    
    
    // MARK: Section Configuration
    
    @objc optional func collectionTableView(
        _ tableView: CollectionTableView,
        backgroundColorForSectionAtIndex section: Int)
        -> UIColor?
    
    @objc optional func collectionTableView(
        _ tableView: CollectionTableView,
        insetForSectionAtIndex section: Int)
        -> UIEdgeInsets
    
    @objc optional func collectionTableView(
        _ tableView: CollectionTableView,
        minimumLineSpacingForSectionAtIndex section: Int)
        -> CGFloat
    
}
