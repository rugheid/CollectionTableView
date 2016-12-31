//
//  ViewController.swift
//  CollectionTableView
//
//  Created by Rugen Heidbuchel on 12/31/2016.
//  Copyright (c) 2016 Rugen Heidbuchel. All rights reserved.
//

import UIKit
import CollectionTableView

class ViewController: UIViewController, CollectionTableViewDelegate, CollectionTableViewDataSource {
    
    var tableView: CollectionTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the table view
        self.tableView = CollectionTableView(frame: self.view.bounds, style: .grouped)
        self.view.addSubview(self.tableView)
        
        // Setup the table view
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerNib(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        // Setup the constraints
        let views: [String: UIView] = ["tableView": tableView]
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[tableView]|",
            options: [],
            metrics: nil,
            views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[tableView]|",
            options: [],
            metrics: nil,
            views: views))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func collectionTableView(_ tableView: CollectionTableView, numberOfItemsInSection section: Int) -> Int {
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
    
    func collectionTableView(_ tableView: CollectionTableView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell? {
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
