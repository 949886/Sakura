//
//  ArrayExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/6/24.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

//MARK: JSON

extension Array
{
    public init?(json: String) {
        if let data = json.data(using: .utf8){
            self.init(jsonData: data)
        } else { return nil }
    }
    
    public init?(jsonData: Data) {
        if  let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments),
            let array = jsonObject as? Array {
            self = array
        } else { return nil }
    }
    
    public init?(file: String) {
        if let array = NSArray(contentsOfFile: file) as? [Element] {
            self = array
        } else { return nil }
    }
}

//MARK: - Predicate

public typealias Predicate = NSPredicate

extension Array
{
    
}

//LINQ

extension Array
{
#if swift(>=4)
    func distinct(for keyPath: KeyPath<Element, Any>) -> Array? {
        return nil
    }
#endif
}
