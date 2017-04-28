//
//  DataExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/4/19.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation
import zlib

//MARK: Data

extension Data
{
    
    func zip() -> Data?
    {
        return nil
    }
    
    func unzip() -> Data?
    {
        return nil
    }
    
    func gzip() -> Data?
    {
        if self.count == 0 { return Data() }
        
        var stream = z_stream()
        stream.next_in = malloc(1).assumingMemoryBound(to: Bytef.self)
        stream.avail_in = uint(self.count)
        
        
        return nil
    }
    
    func ungzip() -> Data? {
        
        var stream = z_stream()
        stream.next_in = malloc(1).assumingMemoryBound(to: Bytef.self)
        stream.avail_in = uint(self.count)
        
        return nil
    }
    
}
