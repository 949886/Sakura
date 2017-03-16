//
//  NSFileManager+Add.h
//  Sakura
//
//  Created by YaeSakura on 2017/2/15.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Add)

+(long long)fileSizeWithPath:(NSString *)path;
+(long long)folderSizeWithPath:(NSString *)path;

@end
