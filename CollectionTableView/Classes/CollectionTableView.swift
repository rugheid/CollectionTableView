//
//  CollectionTableView.swift
//  CollectionTableView
//
//  Created by Rugen Heidbuchel on 17/07/2016.
//  Copyright © 2016 Rugen Heidbuchel. All rights reserved.
//

import UIKit

/**
 A table view where every section is a `UICollectionView` with horizontal scrolling.
 This means the rows of the table view are actually collection view cells.
 */
@objc
@IBDesignable open class CollectionTableView: UIView {
    
    // MARK: Properties
    
    /// The internal table view.
    internal var tableView: UITableView!
    
    /// The delegate of the sectioned table view.
    open var delegate: CollectionTableViewDelegate?
    
    /// The data source of the sectioned table view.
    open var dataSource: CollectionTableViewDataSource?
    
    /// Two arrays to keep track of the registered nibs and classes.
    fileprivate var registeredIdentifiers: [String] = []
    fileprivate var registeredNibsAndClasses: [Any] = []
    
    
    // MARK: Initialisers
    
    public init() {
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        super.init(frame: CGRect.zero)
        initTableView()
    }
    
    public init(frame: CGRect, style: UITableViewStyle = .grouped) {
        self.tableView = UITableView(frame: frame, style: style)
        super.init(frame: frame)
        initTableView()
    }
    
    public override init(frame: CGRect) {
        self.tableView = UITableView(frame: frame, style: .grouped)
        super.init(frame: frame)
        initTableView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.tableView = UITableView(frame: self.frame, style: .grouped)
        initTableView()
    }
    
    fileprivate func initTableView() {
        self.addSubview(tableView)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: UIView] = ["tableView": tableView]
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "|[tableView]|",
            options: [],
            metrics: nil,
            views: views))
        self.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[tableView]|",
            options: [],
            metrics: nil,
            views: views))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CollectionViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.tableView.frame = self.frame
    }
    
    
    // MARK: Configuration
    
    open var style: UITableViewStyle {
        return self.tableView.style
    }
    
    open func numberOfItemsInSection(_ section: Int) -> Int {
        return self.collectionViewForSection(section)?.numberOfItems(inSection: 0) ?? 0
    }
    
    open var numberOfSections: Int {
        return self.tableView.numberOfSections
    }
    
    @IBInspectable
    open var sectionHeight: CGFloat {
        get {
            return self.tableView.rowHeight
        }
        set {
            self.tableView.rowHeight = newValue
        }
    }
    
    open var separatorStyle: UITableViewCellSeparatorStyle {
        get {
            return self.tableView.separatorStyle
        }
        set {
            self.tableView.separatorStyle = newValue
        }
    }
    
    @IBInspectable
    open var separatorColor: UIColor? {
        get {
            return self.tableView.separatorColor
        }
        set {
            self.tableView.separatorColor = newValue
        }
    }
    
    open var separatorEffect: UIVisualEffect? {
        get {
            return self.tableView.separatorEffect
        }
        set {
            self.tableView.separatorEffect = newValue
        }
    }
    
    open var backgroundView: UIView? {
        get {
            return self.tableView.backgroundView
        }
        set {
            self.tableView.backgroundView = newValue
        }
    }
    
    open var separatorInset: UIEdgeInsets {
        get {
            return self.tableView.separatorInset
        }
        set {
            self.tableView.separatorInset = newValue
        }
    }
    
    open var itemSize: CGSize = CGSize(width: 50, height: 50)
    
    @IBInspectable
    open var sectionBackgroundColor: UIColor? = nil
    
    open var sectionInset: UIEdgeInsets = UIEdgeInsets()
    
    @IBInspectable
    open var minimumLineSpacing: CGFloat = 10
    
    
    // MARK: Creating cells
    
    public func registerClass(
        _ cellClass: AnyClass?,
        forCellWithReuseIdentifier identifier: String) {
        
        registerNibOrClassForIdentifier(cellClass, identifier: identifier)
    }
    
    public func registerNib(
        _ nib: UINib?,
        forCellWithReuseIdentifier identifier: String) {
        
        registerNibOrClassForIdentifier(nib, identifier: identifier)
    }
    
    public func dequeueReusableCellWithReuseIdentifier(
        _ identifier: String,
        forIndexPath indexPath: IndexPath)
        -> UICollectionViewCell? {
            
            let collectionView = collectionViewForSection(indexPath.section)
            let collectionViewIndexPath = IndexPath(item: indexPath.row, section: 0)
            return collectionView?.dequeueReusableCell(
                withReuseIdentifier: identifier,
                for: collectionViewIndexPath)
    }
    
    
    // MARK: Reloading Data
    
    public func reloadData() {
        self.tableView.reloadData()
    }
    
    public func reloadSections(_ sections: IndexSet, with animation: UITableViewRowAnimation) {
        self.tableView.reloadSections(sections, with: animation)
    }
    
    public func reloadSectionIndexTitles() {
        self.tableView.reloadSectionIndexTitles()
    }
    
    
    // MARK: - Private Helpers
    
    /**
     Returns the collection view for the given section.
     
     - parameter section: The section index.
     */
    fileprivate func collectionViewForSection(_ section: Int) -> UICollectionView? {
        let tableIndexPath = IndexPath(row: 0, section: section)
        let collectionViewCell = self.tableView.cellForRow(at: tableIndexPath) as? CollectionViewCell
        return collectionViewCell?.collectionView
    }
    
    /**
     Returns the index path for the user for a given collection view. The tag of the collection view
     is the section index, where the item index of the given index path is the actual item index.
     
     - parameter indexPath:      The index path from the collection view.
     - parameter collectionView: The collection view.
     */
    fileprivate func realIndexPathForCollectionView(
        _ indexPath: IndexPath,
        collectionView: UICollectionView)
        -> IndexPath {
            return IndexPath(item: indexPath.row, section: collectionView.tag)
    }
    
    /**
     Registers a nib or class for the given identifier.
     
     - parameter nibOrClass: The nib or class. Nil means the identifier should be deregistered.
     - parameter identifier: The identifier.
     */
    fileprivate func registerNibOrClassForIdentifier(_ nibOrClass: Any?, identifier: String) {
        
        if let index = registeredIdentifiers.index(of: identifier) {
            
            if let obj = nibOrClass {
                registeredNibsAndClasses[index] = obj
            } else {
                registeredIdentifiers.remove(at: index)
                registeredNibsAndClasses.remove(at: index)
            }
            
        } else if let obj = nibOrClass {
            
            registeredIdentifiers.append(identifier)
            registeredNibsAndClasses.append(obj)
        }
    }
    
}


// MARK: - UITableViewDelegate

extension CollectionTableView: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let section = (indexPath as NSIndexPath).row
        
        var maxItemHeight = self.itemSize.height
        if let sizeClosure = self.delegate?.collectionTableView(_:sizeForItemAtIndexPath:) {

            let numberOfItems = self.dataSource!.collectionTableView(
                self,
                numberOfItemsInSection: section)
            
            for index in 0 ..< numberOfItems {
                let realIndexPath = IndexPath(item: index, section: section)
                let size = sizeClosure(self, realIndexPath)
                maxItemHeight = max(maxItemHeight, size.height)
            }
            
        } else {
            
            return self.itemSize.height
        }
        
        let sectionInset = self.delegate?.collectionTableView?(self, insetForSectionAtIndex: section)
            ?? self.sectionInset
        
        return maxItemHeight + sectionInset.top + sectionInset.bottom
    }
}


// MARK: UITableViewDataSource

extension CollectionTableView: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource?.numberOfSectionsInCollectionSectionedTableView?(self) ?? 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.dataSource?.sectionIndexTitlesForCollectionSectionedTableView?(self)
    }
    
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        // TODO: Return better default value here -> interpolation
        return self.dataSource?.collectionTableView?(self, sectionForSectionIndexTitle: title, atIndex: index)
            ?? 0
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dataSource?.collectionTableView?(self, titleForHeaderInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.dataSource?.collectionTableView?(self, titleForFooterInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.registerNibsAndClassesForIdentifiers(
            self.registeredNibsAndClasses,
            identifiers: self.registeredIdentifiers)
        
        (cell.collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = self.itemSize
        cell.collectionView.backgroundColor = self.delegate?.collectionTableView?(
            self,
            backgroundColorForSectionAtIndex: section)
            ?? self.sectionBackgroundColor
        
        cell.collectionView.tag = section
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionTableView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
               sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let realIndexPath = realIndexPathForCollectionView(indexPath, collectionView: collectionView)
        return self.delegate?.collectionTableView?(
            self,
            sizeForItemAtIndexPath: realIndexPath)
            ?? (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let section = collectionView.tag
        return self.delegate?.collectionTableView?(self, insetForSectionAtIndex: section) ?? self.sectionInset
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        let section = collectionView.tag
        return self.delegate?.collectionTableView?(self, minimumLineSpacingForSectionAtIndex: section)
            ?? self.minimumLineSpacing
    }
}


// MARK: UICollectionViewDataSource

extension CollectionTableView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = collectionView.tag
        return self.dataSource?.collectionTableView(self, numberOfItemsInSection: section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let realIndexPath = realIndexPathForCollectionView(indexPath, collectionView: collectionView)
        if let cell = self.dataSource?.collectionTableView(self, cellForItemAtIndexPath: realIndexPath) {
            return cell
        } else {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: self.registeredIdentifiers.first!,
                for: indexPath)
        }
    }
}
