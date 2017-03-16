//
//  UIViewPager.h
//  Sakura
//
//  Created by YaeSakura on 2017/2/10.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITabs.h"

@interface UIViewPager : UIView

@property (nonatomic, strong, readonly) UIScrollView * scrollView;

@property (nonatomic, strong) UITabs * tabs;

@end
