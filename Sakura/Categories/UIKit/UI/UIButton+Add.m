//
//  UIButton+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/16.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

#import "UIButton+Add.h"

@import ObjectiveC;

@implementation UIButton (Add)

-(UIButtonTextLayout)textLayout
{
    return [objc_getAssociatedObject(self, @selector(textLayout)) integerValue];
}

-(void)setTextLayout:(UIButtonTextLayout)textLayout
{
    objc_setAssociatedObject(self, @selector(textLayout), @(textLayout), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self _layoutText];
}

-(CGFloat)textLayoutSpacing
{
    return [objc_getAssociatedObject(self, @selector(textLayoutSpacing)) floatValue];
}

-(void)setTextLayoutSpacing:(CGFloat)textLayoutSpacing
{
    objc_setAssociatedObject(self, @selector(textLayout), @(textLayoutSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self _layoutText];
}

-(void)_layoutText
{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else
    {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和spacing得到imageEdgeInsets和labelEdgeInsets的值
    CGFloat spacing = self.textLayoutSpacing;
    switch (self.textLayout)
    {
            case UIButtonTextLayoutTop:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight - spacing / 2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight - spacing / 2.0, -imageWith, 0, 0);
            break;
            case UIButtonTextLayoutBottom:
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - spacing / 2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight - spacing / 2.0, 0);
            break;
            case UIButtonTextLayoutLeft:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing / 2.0, 0, -labelWidth - spacing / 2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith - spacing / 2.0, 0, imageWith + spacing / 2.0);
            break;
            case UIButtonTextLayoutRight:
            imageEdgeInsets = UIEdgeInsetsMake(0, -spacing / 2.0, 0, spacing / 2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, spacing / 2.0, 0, -spacing / 2.0);
            break;
    }
    
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end
