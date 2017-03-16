//
//  UIView+Add.h
//  Sakura
//
//  Created by YaeSakura on 2017/1/15.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Add)

@property (nonatomic, readonly) UIViewController * viewController;
@property (nonatomic, readonly) UINavigationController * navigationController;
@property (nonatomic, readonly) UITabBarController * tabBarController;

- (void)printViewHierarchy;
- (void)traverseSubviews:(void (^)(UIView * view))block;

/**
 Capture a image from whole current view.
 @return A image from current view.
 */
- (UIImage *)captureImage;

/**
 Capture a image from whole current view, then save it to album.
 */
- (void)captureImageToAlbum;

@end
