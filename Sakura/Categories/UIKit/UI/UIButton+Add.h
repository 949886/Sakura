//
//  UIButton+Add.h
//  Sakura
//
//  Created by YaeSakura on 2017/2/16.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, UIButtonTextLayout){
    UIButtonTextLayoutBottom = 0,
    UIButtonTextLayoutTop,
    UIButtonTextLayoutLeft,
    UIButtonTextLayoutRight
};

@interface UIButton (Add)

@property (nonatomic, assign) UIButtonTextLayout textLayout;
@property (nonatomic, assign) CGFloat textLayoutSpacing;

@end
