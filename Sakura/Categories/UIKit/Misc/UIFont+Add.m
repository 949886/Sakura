//
//  UIFont+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/10.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import "UIFont+Add.h"

@implementation UIFont (Add)

+ (UIFont *)lightSystemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
}

+ (UIFont *)ultraLightSystemFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:fontSize];
}

@end
