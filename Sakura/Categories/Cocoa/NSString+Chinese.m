//
//  NSString+Chinese.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/13.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import "NSString+Chinese.h"

@implementation NSString (Chinese)

#pragma mark Getter

-(NSString *)pinyin
{
    NSMutableString * mString = self.mutableCopy;
    CFStringTransform((__bridge CFMutableStringRef)mString, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)mString, NULL, kCFStringTransformStripCombiningMarks, NO);
    return mString;
}

#pragma mark Methods

+(NSString *)integer2Chinese:(NSInteger)integer
{
    return [self integer2Chinese:integer precision:1];
}

+(NSString *)integer2Chinese:(NSInteger)integer precision:(int)precision
{
    float number = integer;
    
    while(number >= 10)
        number /= 10;
    
    if (integer >= 10000)
        return [NSString stringWithFormat:@"%.*f万", precision, number];
    if (integer >= 100000000)
        return [NSString stringWithFormat:@"%.*f亿", precision, number];
    
    return [NSString stringWithFormat:@"%ld", (long)integer];
}

@end
