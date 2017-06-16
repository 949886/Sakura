//
//  PointerExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/5/24.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

public typealias Byte = Int8

prefix operator %   //Equal to '&' (address-of operator) in C.
prefix operator *   //Equal to '*' (value of pointer) in C.

prefix func % <T>(object: T) -> UnsafeMutablePointer<T> {
    var object = object
    var pointer: UnsafeMutablePointer<T>!
    withUnsafeMutablePointer(to: &object) {
        pointer = $0
    }
    return pointer
}

public prefix func * <T>(pointer: UnsafePointer<T>) -> T {
    return pointer.pointee
}
public prefix func * <T>(pointer: UnsafeMutablePointer<T>) -> T {
    return pointer.pointee
}
