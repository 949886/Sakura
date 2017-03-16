//
//  NSString+Chinese.h
//  Sakura
//
//  Created by YaeSakura on 2017/2/13.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Chinese)

/**
  E.G. 
 「氷菓」-> 「bing guo」
 「氷iscream菓」 -> 「bing iscream guo」
 「氷。菓」 -> 「bing。guo」
 */
@property (nonatomic, readonly) NSString * pinyin;

+(NSString *)integer2Chinese:(NSInteger)integer;
+(NSString *)integer2Chinese:(NSInteger)integer precision:(int)precision;

@end
