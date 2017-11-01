//
//  ViewController.swift
//  Demo
//
//  Created by LunarEclipse on 2016/11/25.
//  Copyright © 2016 Sakura. All rights reserved.
//

import UIKit
import Sakura

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.tableView.frame = self.view.bounds
        self.tableView.backgroundColor = UIColor.white
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -44, 0)
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.view.addSubview(tableView)
        
        let form = UIFormSubclass()
        
        if UIScreen.main.type == .p2436x1125 {
            print("iPhone X")
        } else {
            print("iPhone")
        }
        print("\(UIScreen.main.topbarHeight)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    class Content
    {
        static let items = ["Animated Transiting",
                            "Downloader"]
        
    }
}
