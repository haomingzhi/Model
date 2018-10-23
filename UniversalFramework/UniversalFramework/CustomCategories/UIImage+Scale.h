//
//  UIImage+Scale.h
//  MiniClient
//
//  Created by Apple on 14-10-30.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)
- (UIImage *)scaleToSize:(CGFloat)scaling;                          //图片缩放
- (UIImage *)addTitle:(NSString *)title atPoint:(CGPoint)point;     //图片加字
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;               //图片最大显示尺寸
-(UIImage *) imageToSize:(CGSize)targetSize;
-(UIImage*)getSubImage:(CGRect)rect centerBool:(BOOL)centerBool;
- (UIImage *)cutMapView:(UIView *)theView;
+(UIImage *)imageContentWithFileName:(NSString *)fileName;
-(UIImage*)getSubImage:(CGRect)rect centerBool:(BOOL)centerBool canScale:(BOOL)b;
+ (UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect;
@end
