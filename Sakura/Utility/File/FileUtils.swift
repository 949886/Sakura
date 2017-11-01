//
//  FileUtils.swift
//  Sakura
//
//  Created by YaeSakura on 2017/6/9.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation
import Darwin

open class FileUtils
{
    
    static func open(_ url: String, _ mode: File.Mode = .readwrite) -> File? {
        if  let path = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL(string: path) {
            return self.open(url, mode)
        }
        return nil
    }
    
    public static func open(_ url: URL, _ mode: File.Mode = .readwrite) -> File? {
        
        var file: File?
        
        return file
    }
    
    public static func copy(_ file: File, to url: URL) -> Bool {
        return false
    }
    
    public static func clip(_ file: File, to url: URL) -> Bool {
        return false
    }
    
    public static func delete(_ file: File, byForce: Bool = false) -> Bool {
        return false
    }
    
    public static func rename(_ file: File, newName: String) {
        
    }
    
    public static func fileExists(atPath: String) -> Bool {
        return false
    }
    
    public static func traverse(_ path: String, recursively: Bool = true) {
        
    }
}
