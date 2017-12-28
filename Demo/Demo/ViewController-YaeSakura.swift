//
//  ViewController.swift
//  Demo
//
//  Created by LunarEclipse on 2016/11/25.
//  Copyright © 2016 Sakura. All rights reserved.
//

import UIKit
import CoreData
import Sakura

class Image: UIImage {
    deinit {
        print("Image deinit.")
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
//        self.tableView.frame = self.view.bounds
//        self.tableView.backgroundColor = UIColor.white
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
//        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -44, 0)
//        self.tableView.estimatedRowHeight = 200
//        self.tableView.rowHeight = UITableViewAutomaticDimension
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
//        self.view.addSubview(tableView)
        
        let form = UIFormSubclass()
        
        if UIScreen.main.type == .p2436x1125 {
            print("iPhone X")
        } else {
            print("iPhone")
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .lightGray
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        layout.columnCount = 3
        layout.rowCount = 2
        
        let image = UIImage(named:"go")!
        let color = image.averageColor()
//
//        let context = UIManagedDocument.default.managedObjectContext
//        let info = NSEntityDescription.insertNewObject(forEntityName: "LocalHistoryInfo", into: context) as! LocalHistoryInfo
//        info.id = 1
//        info.aid = 2
//        info.cover = "test"
//        info.time = Float(Date().timeIntervalSinceNow)
//        try! context.save()
//
//        let request = NSFetchRequest<LocalHistoryInfo>(entityName: "LocalHistoryInfo")
//        if let results = try? context.fetch(request) {
//            for result in results {
//                print(result.cover)
//            }
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    // MARK: Delegate
    
    /* UITableViewDataSource */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Content.items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = Content.items[indexPath.row]
        cell.selectedBackgroundView = UIView()
        return cell
    }
    
    
    /* UITableViewDelegate */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        }
        if indexPath.row == 1 {
            
        }
    }
    
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .orange
        return cell
    }
    
    
    @available(iOS 6.0, *)
    
    
    class Content
    {
        static let items = ["Animated Transiting",
                            "Downloader"]
        
    }
}

