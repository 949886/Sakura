//
//  UIRatingBar.h
//  Sakura
//
//  Created by YaeSakura on 2017/2/28.
//  Copyright © 2017年 LunarEclipse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIRatingBar : UIControl

@property (nonatomic, assign) IBInspectable float rating;
@property (nonatomic, assign) IBInspectable float minimum;
@property (nonatomic, assign) IBInspectable float maximum;
@property (nonatomic, assign) IBInspectable float stepSize;     //Zero is no limit(default is 0.5).
@property (nonatomic, assign) IBInspectable float spacing;

@property (nonatomic, strong) IBInspectable UIImage * emptyImage;
@property (nonatomic, strong) IBInspectable UIImage * filledImage;

@property (nonatomic, copy) void(^onRatingChanged)(float rating);

@end
