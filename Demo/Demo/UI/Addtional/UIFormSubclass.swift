//
//  UIFormSubclass.swift
//  Demo
//
//  Created by YaeSakura on 2017/4/12.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation
import Sakura

class Cell: UIView {
    
}

class UIFormSubclass: UIForm {
    
    var items = [String]()
    
    override func onCreate(form: inout UIForm) {
        
        form --
            Section()
            --
            Header()
            -- 8 --
            Row.defaultRow(text: "test")
            -- 40 --
            Row.defaultRow(text: "string")
                .register(class: Cell.self, id: "cell")
                .register(class: Cell.self, id: "")
            -- 8 --
            Row() ~ items.count
            -- 8 --
            Footer()
            --
            Section()
        
    }
}
