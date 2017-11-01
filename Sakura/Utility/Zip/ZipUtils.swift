//
//  ZipUtils.swift
//  Sakura
//
//  Created by YaeSakura on 2017/7/5.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

class ZipUtils
{
    
    var data: Data?
    
    func unzip(_ data: Data) -> Data? {
        return nil
    }
    
    func unzip(_ file: File) -> Data? {
        return nil
    }
    
    func ungzip(_ data: Data) -> Data? {
        return nil
    }
    
    func ungzip(_ file: File) -> Data? {
        return nil
    }
    
    
    func analyze() {
        if let data = self.data {
            let istream = InputStream(data: data)
            let buffer = calloc(4, sizeof(Byte.self)).assumingMemoryBound(to: Byte.self)
            istream.read(buffer, maxLength: 4)
            free(buffer)
        }
    }
    
}

extension ZipUtils
{
    private static let FILE_SIGNATURE: UInt32 = 0x02014b50  // Zip file start with a four bytes signature 0x02014b50.
}
