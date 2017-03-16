//
//  NSString+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/13.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import "NSString+Add.h"

@implementation NSString (Add)

#pragma mark Getter

-(NSUInteger)unicodeLength
{
    NSUInteger length = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        length += [self unicodeCharacterLength:uc];
    }
    return length;
}

#pragma mark Methods

-(NSString *)substringWithinUnicodeLength:(NSUInteger)length
{
    NSUInteger unicodeLength = 0;
    NSInteger index = 0;
    while (true) {
        unichar uc = [self characterAtIndex: index];
        unicodeLength += [self unicodeCharacterLength:uc];
        if (unicodeLength > length) break;
        ++index;
    }
    return [self substringToIndex:index];
}

- (NSString *)substringWithStart:(NSString *)start End:(NSString *)end
{
    if(start && ![self containsString:start]) return nil;
    if(end && ![self containsString:end]) return nil;
    
    NSString * result;
    NSScanner * scanner = [NSScanner scannerWithString:self];
    if(nil != start) {
        [scanner scanUpToString:start intoString:&result];
        [scanner scanString:start intoString:&result];
    }
    if(nil == end) end = @"\0";
    [scanner scanUpToString:end intoString:&result];
    
    return result;
}

#pragma mark Encapsulation

-(NSUInteger)unicodeCharacterLength:(unichar)uc
{
    NSUInteger length = 0;
    
    if (uc >= 0x0000 && uc <= 0x0019)
        length += 0;
    else if (uc >= 0x0020 && uc <= 0x1FFF)
        length += 1;
    else if (uc >= 0x2000 && uc <= 0xFF60)
        length += 2;
    else if (uc >= 0xFF61 && uc <= 0xFF9F)
        length += 1;
    else length += 2;
    
    return length;
}

@end
