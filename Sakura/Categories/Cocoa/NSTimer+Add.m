//
//  NSTimer+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/27.
//  Copyright © 2017年 LunarEclipse. All rights reserved.
//

#import "NSTimer+Add.h"


@implementation NSTimer (Add)

-(void)pause
{
    self.fireDate = [NSDate distantFuture];
}

-(void)resume
{
    self.fireDate = [NSDate date];
}

@end
