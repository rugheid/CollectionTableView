//
//  CollectionTableViewDataSource.swift
//  CollectionTableView
//
//  Created by Rugen Heidbuchel on 17/07/2016.
//  Copyright © 2016 Rugen Heidbuchel. All rights reserved.
//

import UIKit

@objc
public protocol CollectionTableViewDataSource {
    
    // MARK: Items
    
    func collectionTableView(
        _ tableView: CollectionTableView,
        numberOfItemsInSection section: Int)
        -> Int
    
    func collectionTableView(
        _ tableView: CollectionTableView,
        cellForItemAtIndexPath indexPath: IndexPath)
        -> UICollectionViewCell?
    
    // MARK: Configuration
    
    @objc optional func numberOfSectionsInCollectionSectionedTableView(
        _ tableView: CollectionTableView)
        -> Int
    
    @objc optional func sectionIndexTitlesForCollectionSectionedTableView(
        _ tableView: CollectionTableView)
        -> [String]?
    
    @objc optional func collectionTableView(
        _ tableView: CollectionTableView,
        sectionForSectionIndexTitle title: String,
        atIndex index: Int)
        -> Int
    
    @objc optional func collectionTableView(
        _ tableView: CollectionTableView,
        titleForHeaderInSection section: Int)
        -> String?
    
    @objc optional func collectionTableView(
        _ tableView: CollectionTableView,
        titleForFooterInSection section: Int)
        -> String?
    
}
