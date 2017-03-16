//
//  CALayer+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/24.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

#import "CALayer+Add.h"

@implementation CALayer (Add)

-(void)pauseAnimation
{
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

-(void)resumeAnimation
{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}

@end
