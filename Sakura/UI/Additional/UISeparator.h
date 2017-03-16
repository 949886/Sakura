//
//  UISeparator.h
//  Sakura
//
//  Created by YaeSakura on 2017/3/2.
//  Copyright © 2017年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE @interface UISeparator : UIView

@property (nonatomic, strong) IBInspectable UIColor * color;
@property (nonatomic, strong) IBInspectable NSArray * pattern;          //虚线间隔样式(e.g. @[@4, @4] 表示虚线每节长4，间隔为4如此循环)，nil则为实线
@property (nonatomic, strong) IBInspectable NSString * patternString;   //虚线间隔样式(e.g. @"4,4" @"4 4", 优先级高于pattern，xib、Stroyboard使用该属性设置pattern)
@property (nonatomic, assign) IBInspectable CGFloat parse;                //段前距离

@end
