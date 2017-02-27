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
    
    // MARK: Cell Selection
    
    @objc optional func collectionTableView(
        _ tableView: CollectionTableView,
        shouldSelectItemAt indexPath: IndexPath)
        -> Bool
    
    @objc optional func collectionTableView(
        _ tableView: CollectionTableView,
        didSelectItemAt indexPath: IndexPath)
    
    @objc optional func collectionTableView(
        _ tableView: CollectionTableView,
        shouldDeselectItemAt indexPath: IndexPath)
        -> Bool
    
    @objc optional func collectionTableView(
        _ tableView: CollectionTableView,
        didDeselectItemAt indexPath: IndexPath)
    
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
