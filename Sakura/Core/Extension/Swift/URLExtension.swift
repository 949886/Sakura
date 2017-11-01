//
//  URLExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/7/21.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension URL
{
    /// Initialize from string, which allow percent encoding.
    init?(_ string: String) {
        if let percentEncoding = string.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            self.init(string: percentEncoding)
        }
        return nil
    }
}
