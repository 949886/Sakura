//
//  UITouch+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/15.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import "UITouch+Add.h"

@implementation UITouch (Add)

-(CGPoint)touchPoint
{
    return [self locationInView:self.view];
}

-(CGPoint)globalTouchPoint
{
    return [self locationInView:[UIApplication sharedApplication].keyWindow];
}

@end
