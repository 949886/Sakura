//
//  NSFileManager+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/15.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

#import "NSFileManager+Add.h"

@implementation NSFileManager (Add)

+(long long)fileSizeWithPath:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) return 0;
    return [[manager attributesOfItemAtPath:path error:nil] fileSize];
}

+(long long)folderSizeWithPath:(NSString *)path
{
    long long size = 0;
    NSFileManager * manager = [NSFileManager defaultManager];
    if(![manager fileExistsAtPath:path]) return 0;
    
    NSArray<NSString *> * subpaths = [manager subpathsAtPath:path];
    for (NSString * subpath in subpaths) {
        NSString * fullpath = [path stringByAppendingPathComponent:subpath];
        size += [self fileSizeWithPath:fullpath];
    }
    return size;
}

@end
