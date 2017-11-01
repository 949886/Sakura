//
//  File.swift
//  Sakura
//
//  Created by YaeSakura on 2017/6/9.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

open class File: Equatable
{
    var path: URL?
    var mode: Mode = .readonly
    
    private var data: Data?
    private var file: PFILE?
    
    init(path: String, mode: Mode = .readonly) {
        if  let path = path.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            let url = URL(string: path) {
            self.path = url
            self.mode = mode
        }
    }
    
    init(path: URL, mode: Mode = .readonly) {
        self.path = path
        self.mode = mode
    }
    
    deinit {
        close()
    }
    
    //MARK: Computed properties
    
    var isReadable: Bool {
        return false
    }
    
    var isWritable: Bool {
        return false
    }
    
    var isExecutable: Bool {
        return false
    }
    
    var isDirectory: Bool {
        return false
    }
    
    var exists: Bool {
        
        return false
    }
    
    //MARK: Methods
    
    func open() throws {
        if let filePath = path?.absoluteString.cString(using: .utf8) {
            file = fopen(filePath, "r")
            var fstate = stat()
            if(stat(filePath, &fstate) != 0) { throw Exception.unknown }
            let fileSize = Int(fstate.st_size)
            if let buffer = malloc(fileSize * sizeof(CChar.self)) {
                fread(buffer, sizeof(CChar.self), fileSize, file)
                data = Data(bytes: buffer, count: fileSize)
                free(buffer)
            }
        }
    }
    
    func close() {
        if file != nil {
            fclose(file)
        }
    }
    
    func readLine() -> Data? {
        return nil
    }
    
    func stream() -> Stream {
        return Stream()
    }
    
    //MARK: Encapsulation
    
    func throwException(_ code: Int32) throws {
        switch code {
        case ENOENT: throw Exception.notExists
        case EACCES: throw Exception.permissionDenied
        case ENOMEM: throw Exception.noFreeSpace
        default: throw Exception.unknown
        }
    }
    
    //MARK: Operator
    
    public static func ==(lhs: File, rhs: File) -> Bool {
        return false
    }
    
    //MARK: Nested
    
    public enum Exception: Error {
        case unknown
        case notExists
        case permissionDenied
        case noFreeSpace
        
//        init(code) {
//            
//        }
    }
    
    public enum Mode: Int {
        /* Common */
        case readonly       // 'r'
        case readwrite      // 'r+'
        
        /* Caution */
        case overwrite      // 'w'
        case truncate       // 'w+' 
    }
    
    
    typealias PFILE = UnsafeMutablePointer<FILE>
}
