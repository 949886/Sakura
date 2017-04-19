//
//  UIColor+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/4/13.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

#import "UIColor+Add.h"

@implementation UIColor (Add)

- (CGFloat)red {
    CGFloat red = 0;
    [self getRed:&red green:nil blue:nil alpha:nil];
    return red;
}

- (CGFloat)green {
    CGFloat green = 0;
    [self getRed:nil green:&green blue:nil alpha:nil];
    return green;
}

- (CGFloat)blue {
    CGFloat blue;
    [self getRed:nil green:nil blue:&blue alpha:nil];
    return blue;
}

- (CGFloat)hue {
    CGFloat hue = 0;
    [self getHue:&hue saturation:nil brightness:nil alpha:nil];
    return hue;
}

- (CGFloat)saturation {
    CGFloat saturation = 0;
    [self getHue:nil saturation:&saturation brightness:nil alpha:nil];
    return saturation;
}

- (CGFloat)brightness {
    CGFloat brightness = 0;
    [self getHue:nil saturation:nil brightness:&brightness alpha:nil];
    return brightness;
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

-(CGFloat)grayScale
{
    CGFloat red, green, blue, alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return red * 0.299 + green * 0.587 + blue * 0.114;
}

@end
