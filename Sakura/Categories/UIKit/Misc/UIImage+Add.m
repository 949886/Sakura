//
//  UIImage+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/15.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import "UIImage+Add.h"

@implementation UIImage (Add)

- (UIImage *)centerStretchableImage
{
    return [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.height * 0.5];
}

@end
