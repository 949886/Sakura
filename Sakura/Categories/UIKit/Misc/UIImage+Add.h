//
//  UIImage+Add.h
//  Sakura
//
//  Created by YaeSakura on 2017/2/15.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Add)

@property (nonatomic, readonly) UIColor * averageColor;
@property (nonatomic, readonly) UIImage * centerStretchableImage;

/**
 Get color of a specific pixel inside the image.

 @param point A point inside of image.
 @return Color at specific pixel, if point outside the image it will return nil.
 */
- (UIColor *)colorAtPixel:(CGPoint)point;

/**
 Caculate the average color of a certain image according to
 Time-consuming(approximately):
 size: 1 x 1       rate: 1.0  ≈  0.001s.
 size: 512 x 512   rate: 1.0  ≈  0.024s.
 size: 1024 x 1024 rate: 1.0  ≈  0.064s.
 (Mac mini, i7 3GHz)
 
 @param rect If you want to get average color from a part of this image, set this parameter.
 @param rate image scaling.
 @return Average color of a image.
 */
- (UIColor *)averageColorInRect:(CGRect)rect samplingRate:(float)rate;

@end
