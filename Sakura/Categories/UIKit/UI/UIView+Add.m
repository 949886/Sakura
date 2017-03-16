//
//  UIView+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/1/15.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import "UIView+Add.h"

@implementation UIView (Add)

-(UIViewController *)viewController
{
    for (UIView *view = self; view; view = view.superview)
        if ([[view nextResponder] isKindOfClass:[UIViewController class]])
            return (UIViewController *)[view nextResponder];
    return nil;
}

-(UINavigationController *)navigationController
{
    for (UIView *view = self; view; view = view.superview)
    {
        UIResponder * nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            UIViewController * viewController = (UIViewController *)nextResponder;
            if (viewController.navigationController != nil)
            return viewController.navigationController;
        }
    }
    return nil;
}

-(UITabBarController *)tabBarController
{
    UITabBarController * tabBarController = nil;
    
    //Scan rootViewController.
    UIViewController * rootViewContrller = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootViewContrller isKindOfClass:[UINavigationController class]])
    {
        UINavigationController * controller = (UINavigationController *)rootViewContrller;
        if ([controller.topViewController isKindOfClass:[UITabBarController class]])
            tabBarController = (UITabBarController *)controller.topViewController;
    }
    
    //Traverse all response to find tab bar controller.
    if (tabBarController == nil)
        for (UIView *view = self; view; view = view.superview)
            if ([[view nextResponder] isKindOfClass:[UITabBarController class]])
                tabBarController = (UITabBarController *)[view nextResponder];
    
    return tabBarController;
}

- (void)printViewHierarchy
{
    static uint level = 0;
    for(uint i = 0; i < level; i++) printf("\t");
    
    const char *className = NSStringFromClass([self class]).UTF8String;
    const char *frame = NSStringFromCGRect(self.frame).UTF8String;
    printf("%s:%s\n", className, frame);
    
    ++level;
    for(UIView * subview in self.subviews)
        [subview printViewHierarchy];
    --level;
}

- (void)traverseSubviews:(void (^)(UIView * view))block
{
    if(block) block(self);
    
    for(UIView * subview in self.subviews)
        [subview traverseSubviews:block];
}

- (void)traverseSubviews:(void (^)(UIView * view))block level:(NSInteger)level
{
    for(UIView * subview in self.subviews)
        [subview traverseSubviews:block];
}

- (UIImage *)captureImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (void)captureImageToAlbum
{
    UIImage * image = [self captureImage];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

-(void)image: (UIImage *)image didFinishSavingWithError: (NSError *)error contextInfo: (void *)contextInfo
{
    NSString *msg = nil ;
    if(error != NULL) msg = @"保存失败，请确认相册权限已打开";
    else msg = @"保存成功";
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
#pragma clang diagnostic pop
}

@end
