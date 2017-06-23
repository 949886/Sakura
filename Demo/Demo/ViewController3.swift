//
//  ViewController3.swift
//  Demo
//
//  Created by YaeSakura on 2017/6/21.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import UIKit
import Sakura

class ViewController3: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: false, completion: {
            print("test")
        })
        
    }
    
}
