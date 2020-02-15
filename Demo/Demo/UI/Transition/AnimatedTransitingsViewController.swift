//
//  AnimatedTransitingsViewController.swift
//  Demo
//
//  Created by YaeSakura on 2017/8/9.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

import UIKit
import Sakura

class AnimatedTransitingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
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
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -44, right: 0)
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.view.addSubview(tableView)
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
            let controller = AnimatedTransitingsViewController()
            controller.view.backgroundColor = UIColor(hex: (UInt(arc4random() % 0xFFFFFF) | 0xFF00000))
            self.navigationController?.push(controller, animation: .fade(duration: 0.5), completion: {
                print("Push fade")
            })
        }
        if indexPath.row == 1 {
            if let controller = UIStoryboard(name: "BukaExhibitionTicketPurchase", bundle: nil).instantiateInitialViewController() {
                //                self.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    
    class Content
    {
        static let items = ["Fade",
                            "Dim"]
    }
}

