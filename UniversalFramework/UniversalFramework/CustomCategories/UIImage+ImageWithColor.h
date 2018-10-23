//
//  UIImage+ImageWithColor.h
//  ；
//
//  Created by Ruichao Wang on 13-1-24.
//
//

#import <QuartzCore/QuartzCore.h>


@interface UIImage (ImageWithColor)

//将颜色绘制到一张图片上。
+ (UIImage *) imageWithColor: (UIColor *) color withBounds:(CGRect)bounds;

+(UIImage*)imageWithColor:(UIColor*)color withSize:(CGSize)size;

//  颜色转换为背景图片
+(UIImage *)imageWithColor:(UIColor *)color;

//将指定的颜色跟图片复合得到新的图片。
-(UIImage*)blendImageWithColor:(UIColor*)color;
+(UIImage*)createGrayCopy:(UIImage*)source;

@end
