//
//  UIScreen+Add.h
//  Sakura
//
//  Created by YaeSakura on 2017/2/15.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (Add)

/* iOS7及以前版本[UIScreen mainScreen].bounds属性不会随着屏幕的旋转而改变 */
-(CGRect)fixedBounds;
-(CGSize)fixedScreenSize;

@end
