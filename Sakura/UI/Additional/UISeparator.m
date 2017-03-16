//
//  UISeparator.m
//  Sakura
//
//  Created by YaeSakura on 2017/3/2.
//  Copyright © 2017年 LunarEclipse. All rights reserved.
//

#import "UISeparator.h"

@implementation UISeparator

#pragma mark Functions

void setLineDash(CGContextRef context, NSArray<NSNumber *> * pattern, CGFloat phase)
{
    NSInteger count = [pattern count];
    CGFloat lengths[count];
    for (int i = 0; i < count; ++i)
        lengths[i] = [pattern[i] floatValue];
    CGContextSetLineDash(context, phase, lengths, count);
}

#pragma mark Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        [self initialize];
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
        [self initialize];
    return self;
}

- (void)initialize
{
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark Override

-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.color set];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    BOOL isHorizontal = width >= height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, isHorizontal ? 0 : width * 0.5 , isHorizontal ? height * 0.5 : 0);
    CGContextAddLineToPoint(context, isHorizontal ? width : width * 0.5, isHorizontal ? height * 0.5 : height);
    if (_pattern) setLineDash(context, _pattern, _parse);
    CGContextSetLineWidth(context, isHorizontal ? height : width);
    CGContextStrokePath(context);
}

#pragma mark Getter & Setter

-(void)setPatternString:(NSString *)patternString
{
    _patternString = patternString;
    
    NSMutableArray * pattern = [NSMutableArray new];
    
    NSArray * components = [patternString componentsSeparatedByString:@" "];
    if(!components || components.count == 0) components = [patternString componentsSeparatedByString:@","];
    
    for (NSString * component in components)
        [pattern addObject:@([component floatValue])];
    self.pattern = pattern;
    
    [self setNeedsDisplay];
}

-(void)setColor:(UIColor *)color
{
    _color = color;
    [self setNeedsDisplay];
}

-(void)setParse:(CGFloat)parse
{
    _parse = parse;
    [self setNeedsDisplay];
}

@end
