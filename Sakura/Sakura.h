//
//  Sakura.h
//  Sakura
//
//  Created by YaeSakura on 2017/1/14.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double SakuraVersionNumber;
FOUNDATION_EXPORT const unsigned char SakuraVersionString[];

#define ONE_PIXEL (1.0 / [UIScreen mainScreen].scale)
#define PIXEL(_VALUE_) (_VALUE_ / [UIScreen mainScreen].scale)
#define TRUNCATE(_value_, _restriction_) \
((_restriction_) > 0) ? (((_value_) >= 0) ? (_value_) % (_restriction_) : (_restriction_) + ((_value_) % (_restriction_))) : 0

#import "UIFont+Add.h"
#import "UIView+Add.h"
#import "UIImage+Add.h"
#import "UIColor+Add.h"
#import "NSString+Chinese.h"

#import "UIBanner.h"
#import "UITabs.h"
#import "UIViewPager.h"
#import "UIRatingBar.h"
