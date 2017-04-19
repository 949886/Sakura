//
//  UIImage+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/15.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import "UIImage+Add.h"

#define BYTE_PER_PIXEL  4

@implementation UIImage (Add)

-(UIColor *)averageColor
{
    return [self averageColorInRect:CGRectMake(0, 0, self.size.width, self.size.height) samplingRate:0.5];
}

- (UIImage *)centerStretchableImage
{
    return [self stretchableImageWithLeftCapWidth:self.size.width * 0.5 topCapHeight:self.size.height * 0.5];
}

- (UIImage *)imageByResizeToSize:(CGSize)size {
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageByCropToRect:(CGRect)rect {
    rect.origin.x *= self.scale;
    rect.origin.y *= self.scale;
    rect.size.width *= self.scale;
    rect.size.height *= self.scale;
    if (rect.size.width <= 0 || rect.size.height <= 0) return nil;
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return image;
}

- (UIColor *)colorAtPixel:(CGPoint)point
{
    if (!CGRectContainsPoint(CGRectMake(0, 0, self.size.width, self.size.height), point)) return nil;
    
    unsigned char rgba[4] = {0, 0, 0, 0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, BYTE_PER_PIXEL * 1, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextTranslateCTM(context, -point.x, point.y - self.size.height);
    CGContextDrawImage(context, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    CGFloat red   = (CGFloat)rgba[0] / 255.0f;
    CGFloat green = (CGFloat)rgba[1] / 255.0f;
    CGFloat blue  = (CGFloat)rgba[2] / 255.0f;
    CGFloat alpha = (CGFloat)rgba[3] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (UIColor *)averageColorInRect:(CGRect)rect samplingRate:(float)rate
{
    if (rate > 1) rate = 1;
    if (rate < 0) rate = 0;
    
    UIImage * cropedImage = [self imageByCropToRect:rect];
    UIImage * image = [cropedImage imageByResizeToSize:CGSizeMake(rect.size.width * rate, rect.size.height * rate)];

    double width = image.size.width;
    double height = image.size.height;
    int pixelCount = width * height;
    
    unsigned char * rgba = (unsigned char*)calloc(pixelCount * 4, sizeof(unsigned char));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgba, width, height, 8, BYTE_PER_PIXEL * width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);

    double cumulativeRed = 0.0;
    double cumulativeGreen = 0.0;
    double cumulativeBlue = 0.0;
    double cumulativeAlpha = 0.0;
    
    for (int i = 0; i < pixelCount * 4; i += 4)
    {
        double red   = (rgba[i]     * 1.0) / 255.0;
        double green = (rgba[i + 1] * 1.0) / 255.0;
        double blue  = (rgba[i + 2] * 1.0) / 255.0;
        double alpha = (rgba[i + 3] * 1.0) / 255.0;
        
        cumulativeRed += alpha ? red : 1;
        cumulativeGreen += alpha ? green : 1;
        cumulativeBlue += alpha ? blue : 1;
        cumulativeAlpha += alpha;
    }

    free(rgba);
    
    double avgRed = (cumulativeRed / pixelCount);
    double avgGreen = (cumulativeGreen / pixelCount);
    double avgBlue = (cumulativeBlue / pixelCount);
    double avgAlpha = (cumulativeAlpha / pixelCount);
    
    return [UIColor colorWithRed:avgRed green:avgGreen blue:avgBlue alpha:avgAlpha];
}

- (UIColor *)averageColorAtPixel:(CGPoint)point radius:(CGFloat)radius
{
    return nil;
}

@end
