//
//  CollectionTableViewController.swift
//  Pods
//
//  Created by Rugen Heidbuchel on 02/01/2017.
//
//

import UIKit

open class CollectionTableViewController: UIViewController, CollectionTableViewDelegate, CollectionTableViewDataSource {
    
    // MARK: Properties
    
    private let tableViewController: UITableViewController = UITableViewController()
    
    private var _collectionTableView: CollectionTableView? = nil
    
    /// The collection table view of the controller.
    open var collectionTableView: CollectionTableView! {
        get {
            if _collectionTableView == nil {
                _collectionTableView = CollectionTableView()
                self.tableViewController.tableView = _collectionTableView!.tableView
                _collectionTableView!.delegate = self
                _collectionTableView!.dataSource = self
            }
            return _collectionTableView
        }
        set {
            _collectionTableView = newValue
            self.tableViewController.tableView = _collectionTableView!.tableView
        }
    }
    
    /// The refresh control used to update the collection table contents.
    open var refreshControl: UIRefreshControl? {
        get {
            return self.tableViewController.refreshControl
        }
        set {
            self.tableViewController.refreshControl = newValue
        }
    }
    
    
    // MARK: View Lifecycle
    
    open override func viewDidLoad() {
        let _ = self.collectionTableView
        self.addChildViewController(self.tableViewController)
        self.view.addSubview(self.tableViewController.view)
        
        let views: [String: UIView] = ["tableViewController": self.tableViewController.view]
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[tableViewController]|",
            options: [],
            metrics: nil,
            views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[tableViewController]|",
            options: [],
            metrics: nil,
            views: views))
    }
    
    
    // MARK: CollectionTableViewDataSource
    
    open func collectionTableView(_ tableView: CollectionTableView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    open func collectionTableView(_ tableView: CollectionTableView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell? {
        return nil
    }
}
