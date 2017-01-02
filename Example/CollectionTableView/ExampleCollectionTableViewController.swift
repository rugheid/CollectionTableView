//
//  ExampleCollectionTableViewController.swift
//  CollectionTableView
//
//  Created by Rugen Heidbuchel on 02/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import CollectionTableView

class ExampleCollectionTableViewController: CollectionTableViewController {
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionTableView.registerNib(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    
    // MARK: Refresh Control
    
    func refresh(sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            sender.endRefreshing()
        }
    }
    
    
    // MARK: CollectionSectionedTableViewDelegate
    
    func collectionTableView(_ tableView: CollectionTableView, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170.0, height: 170.0)
    }
    
    func collectionTableView(_ tableView: CollectionTableView, backgroundColorForSectionAtIndex section: Int) -> UIColor? {
        return UIColor.groupTableViewBackground
    }
    
    func collectionTableView(_ tableView: CollectionTableView, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 12.0, bottom: 7.0, right: 12.0)
    }
    
    func collectionTableView(_ tableView: CollectionTableView, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 15
    }
    
    
    // MARK: CollectionSectionedTableViewDataSource
    
    func numberOfSectionsInCollectionSectionedTableView(_ tableView: CollectionTableView) -> Int {
        return 5
    }
    
    override func collectionTableView(_ tableView: CollectionTableView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    //    func sectionIndexTitlesForCollectionSectionedTableView(tableView: CollectionTableView) -> [String]? {
    //        return ["1", "2", "3", "4", "5"]
    //    }
    //
    //    func CollectionTableView(tableView: CollectionTableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
    //        return Int(title)! - 1
    //    }
    
    func collectionTableView(_ tableView: CollectionTableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    func collectionTableView(_ tableView: CollectionTableView, titleForFooterInSection section: Int) -> String? {
        switch section {
            
        case 1:
            return "This is an example for a footer."
            
        default:
            return nil
        }
    }
    
    override func collectionTableView(_ tableView: CollectionTableView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell? {
        guard let cell = tableView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? Cell else {
            return nil
        }
        
        cell.imageView.image = UIImage(named: "planckendael_main.jpg")
        cell.imageView.clipsToBounds = true
        cell.titleLabel.text = "Planckendael"
        cell.addressLabel.text = "Ergens in België, maar ik weet niet waar... :("
        
        let cornerRadius: CGFloat = 6
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.25
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cornerRadius).cgPath
        cell.layer.shadowRadius = 6
        cell.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.layer.masksToBounds = false
        cell.contentView.layer.cornerRadius = cornerRadius
        cell.contentView.layer.masksToBounds = true
        
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.white
        
        return cell
    }
}
