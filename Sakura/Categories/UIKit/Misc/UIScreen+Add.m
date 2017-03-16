//
//  UIScreen+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/15.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import "UIScreen+Add.h"

@implementation UIScreen (Add)

-(CGRect)fixedBounds
{
    CGSize screenSize = [self fixedScreenSize];
    return CGRectMake(0, 0, screenSize.width, screenSize.height);
}

-(CGSize)fixedScreenSize
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ([UIDevice currentDevice].systemVersion.doubleValue < 8 &&
        UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation))
        return CGSizeMake(screenSize.height, screenSize.width);
    return screenSize;
}

@end
