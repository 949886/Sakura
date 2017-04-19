//
//  UIApplication+Add.h
//  Sakura
//
//  Created by YaeSakura on 2017/2/22.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LaunchImageOrientation) {
    LaunchImageOrientationPortrait,
    LaunchImageOrientationLandscape
};

@interface UIApplication (Add)

/**
 <#Description#>
 
 @param orientation <#orientation description#>
 @return <#return value description#>
 */
- (UIImage *)launchImageWithOrientation:(LaunchImageOrientation)orientation;

@end
