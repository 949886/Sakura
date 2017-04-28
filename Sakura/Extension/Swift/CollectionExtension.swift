//
//  CollectionExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/4/26.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension Array
{
    public init?(json: String) {
        if let data = json.data(using: .utf8){
            self.init(jsonData: data)
        } else { return nil }
    }
    
    public init?(jsonData: Data) {
        if  let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments),
            let dict = jsonObject as? Array {
            self = dict
        } else { return nil }
    }
}

extension Dictionary
{
    public init?(json: String) {
        if let data = json.data(using: .utf8) {
            self.init(jsonData: data)
        } else { return nil }
    }
    
    public init?(jsonData: Data) {
        if  let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments),
            let dict = jsonObject as? Dictionary {
            self = dict
        } else { return nil }
    }
}

