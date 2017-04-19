//
//  UIApplication+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/22.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

#import "UIApplication+Add.h"

@implementation UIApplication (Add)

- (UIImage *)launchImageWithOrientation:(LaunchImageOrientation)orientation
{
    //Get launch image from assets.
    NSArray * launchImages = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    NSString * viewOrientation = nil;
    switch (orientation) {
        case LaunchImageOrientationPortrait: viewOrientation = @"Portrait"; break;
        case LaunchImageOrientationLandscape: viewOrientation = @"Landscape"; break;
    }
    for (NSDictionary* dict in launchImages)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if([viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            if([dict[@"UILaunchImageOrientation"] isEqualToString:@"Landscape"])
                imageSize = CGSizeMake(imageSize.height, imageSize.width);
            if(CGSizeEqualToSize(imageSize, [UIScreen mainScreen].bounds.size))
                return [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    
    //Get launch image from LaunchScreen.stroyboard.
    if (launchImages == nil || launchImages.count == 0) {
        NSString * launchsbname = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchStoryboardName"];
        UIStoryboard * stroryboard = [UIStoryboard storyboardWithName:launchsbname bundle:nil];
        UIViewController * controller = [stroryboard instantiateInitialViewController];
        
        UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, NO, [UIScreen mainScreen].scale);
        controller.view.frame = [UIScreen mainScreen].bounds;
        [controller.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        return UIGraphicsGetImageFromCurrentImageContext();
    }
    
    return nil;
}

@end
