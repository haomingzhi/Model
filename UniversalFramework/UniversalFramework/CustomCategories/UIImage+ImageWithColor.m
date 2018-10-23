//
//  UIImage+ImageWithColor.m
//  YinXinBao
//
//  Created by Ruichao Wang on 13-1-24.
//
//

#import "UIImage+ImageWithColor.h"

@implementation UIImage (ImageWithColor)

+ (UIImage *) imageWithColor: (UIColor *) color withBounds:(CGRect)bounds
{
    CGRect rect=bounds;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL)
    {
        UIGraphicsEndImageContext();
        return nil;
    }
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


+(UIImage*)imageWithColor:(UIColor*)color withSize:(CGSize)size
{
  /*  CIColor *cicolor =  [CIColor colorWithCGColor:color.CGColor];
    
    CIImage *imge = [CIImage imageWithColor:cicolor];
    
    CIContext *cont = [CIContext contextWithOptions:nil];
    
    CGImageRef imgRef =[cont createCGImage:imge fromRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *uiimg = [UIImage imageWithCGImage:imgRef];
    return uiimg;*/
    
    return nil;
}

+(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


-(UIImage*)blendImageWithColor:(UIColor*)color
{
    if (self == nil)
        return nil;
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL)
    {
        UIGraphicsEndImageContext();
        return nil;
    }
    
    [self drawInRect:rect];
    
    CGContextSetBlendMode(context, kCGBlendModeSourceAtop);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


+(UIImage*)createGrayCopy:(UIImage*)source
{
    int width = source.size.width;
    int height = source.size.height;
    CGColorSpaceRef colorSpace =CGColorSpaceCreateDeviceGray();
    CGContextRef context =CGBitmapContextCreate(nil,
                                               width,
                                               height,
                                               8,// bits per component
                                               0,
                                               colorSpace,
                                               kCGBitmapByteOrderDefault);
    CGColorSpaceRelease(colorSpace);
    if(context ==NULL) {
        return nil;
    }
    CGContextDrawImage(context,
                       CGRectMake(0,0, width, height), source.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}
@end
