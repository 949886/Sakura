//
//  CoreGraphicExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/14.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

extension CGRect
{
    var area: CGFloat {
        return self.width * self.height
    }
}

extension CGContext
{
    public static func `init`(data: UnsafeMutableRawPointer?,
                              width: Int,
                              height: Int,
                              colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB(),
                              bitmapInfo: CGBitmapInfo = [.byteOrder32Big],
                              alphaInfo: CGImageAlphaInfo = .premultipliedLast) -> CGContext? {
        return CGContext(data: data, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 4 * width, space: colorSpace, bitmapInfo: bitmapInfo.rawValue | alphaInfo.rawValue)
    }
}

