//
//  NSString+Add.h
//  Sakura
//
//  Created by YaeSakura on 2017/2/13.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Add)

/**
 Imitation of PHP function mb_strwidth(). 
 Caculate length of string including unicode characters.Algorithm:
 U+0000 - U+0019	0   0
 U+0020 - U+1FFF	1   1
 U+2000 - U+FF60	2   2
 U+FF61 - U+FF9F	1   1
 U+FFA0 - ???       2
 */
@property (nonatomic, readonly) NSUInteger unicodeLength;

/**
 Substring which unicode length not exceed specific length.
 @param length specific length.
 @return Truncated string.
 */
-(NSString *)substringWithinUnicodeLength:(NSUInteger)length;

/**
 Substring between start and end(excluding start & end).
 @param start Truncate string from start. If start is nil, substring will start from the head of string.
 @param end Truncate string to end. If end is nil, substring will end to the tail of string.
 @return Substring between start and end(excluding start & end). If the string not contains start or end, return nil.
 */
- (NSString *)substringWithStart:(NSString *)start End:(NSString *)end;

@end
