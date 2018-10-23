//
//  UIImage+Scale.m
//  MiniClient
//
//  Created by Apple on 14-10-30.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

/**
 *  图片缩放
 *
 *  @param scaling 缩放比例1.0代表原图
 *
 *  @return 缩放后图片
 */
- (UIImage *)scaleToSize:(CGFloat)scaling{
    
    CGSize size = CGSizeMake(self.size.width * scaling, self.size.height *scaling);    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

#pragma mark - 截取图片

- (UIImage *)cutMapView:(UIView *)theView
{
    
    //************** 得到图片 *******************
    
    CGRect rect = theView.frame;  //截取图片大小
    
    //开始取图，参数：截图图片大小
    
    UIGraphicsBeginImageContext(rect.size);
    
    //截图层放入上下文中
    
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //从上下文中获得图片
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束截图
    
    UIGraphicsEndImageContext();
    return image;
}
-(UIImage*)getSubImage:(CGRect)rect centerBool:(BOOL)centerBool
{
    return [self getSubImage:rect centerBool:centerBool canScale:YES];
}
/*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
-(UIImage*)getSubImage:(CGRect)rect centerBool:(BOOL)centerBool canScale:(BOOL)b
{
    
    float imgwidth = self.size.width;
    float imgheight = self.size.height;
    float viewwidth = rect.size.width * [UIScreen mainScreen].scale;
    float viewheight = rect.size.height * [UIScreen mainScreen].scale;
    if(centerBool)
    {
        if(imgwidth < viewwidth && imgheight < viewheight)
        {
            
            CGFloat h = imgwidth * rect.size.height/(rect.size.width * 1.0);
            if (h > imgheight) {
                CGFloat w = imgheight * rect.size.width/(rect.size.height *1.0);
                rect = CGRectMake((imgwidth - w)/2.0, 0, w, imgheight);
            }
            else
            rect = CGRectMake(0, (imgheight - h)/2.0, imgwidth, h);
        }
        else
            if (imgwidth < viewwidth) {
                rect = CGRectMake(0, (imgheight-viewheight)/2, imgwidth, imgwidth*viewheight/(viewwidth*1.0));
            }else
        if (imgheight < viewheight)
        {
            rect = CGRectMake((imgwidth-viewwidth)/2, 0, viewwidth, imgheight);
        }
        
        else
        {
            if (b) {
 rect = CGRectMake(0, (imgheight-viewheight)/2, imgwidth, imgwidth*viewheight/(viewwidth*1.0));
            }
            else
          rect = CGRectMake((imgwidth-viewwidth)/2, (imgheight-viewheight)/2, viewwidth, viewheight);
        }
    }
    else
    {
        if(imgwidth < viewwidth && imgheight < viewheight)
        {

            CGFloat h = imgwidth * rect.size.height/(rect.size.width * 1.0);
            if (h > imgheight) {
                CGFloat w = imgheight * rect.size.width/(rect.size.height *1.0);
                rect = CGRectMake(rect.origin.x, rect.origin.y, w, imgheight);
            }
            else
                rect = CGRectMake(rect.origin.x, rect.origin.y, imgwidth, h);
        }
        else
            if (imgwidth < viewwidth) {
                rect = CGRectMake(rect.origin.x,rect.origin.y, imgwidth, imgwidth*viewheight/(viewwidth*1.0));
            }else
                if (imgheight < viewheight)
                {
                    rect = CGRectMake(rect.origin.x, rect.origin.y, viewwidth, imgheight);
                }

                else
                {
                    if (b) {
                        rect = CGRectMake(rect.origin.x, rect.origin.y, imgwidth, imgwidth*viewheight/(viewwidth*1.0));
                    }
                    else
                        rect = CGRectMake(rect.origin.x,rect.origin.y, viewwidth, viewheight);
                }
    }
    
    //对图片进行截取
    UIImage *im = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([self CGImage], rect) scale:[UIScreen mainScreen].scale  orientation:self.imageOrientation];
    return im;
}
+ (UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect{

    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x= rect.origin.x*scale,y=rect.origin.y*scale,w=rect.size.width*scale,h=rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y,w, h);

    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:image.imageOrientation];
    return newImage;
}
- (UIImage *)addTitle:(NSString *)title atPoint:(CGPoint)point
{
    //    UIGraphicsBeginImageContext(self.size);
    //    // 绘制改变大小的图片
    //    [self drawInRect:CGRectMake(0,0, self.size.width, self.size.height)];
    //    // 从当前context中创建一个改变大小后的图片
    //    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    //    [title drawAtPoint:point withFont:[UIFont systemFontOfSize:15]];
    //
    //    // 使当前的context出堆栈
    //    UIGraphicsEndImageContext();
    //    //返回新的改变大小后的图片
    //    return scaledImage;
    ////    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    ////    [title drawAtPoint:point withFont:[UIFont systemFontOfSize:15]];
    return self;
}

- (UIImage *)imageByScalingToSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width ;//* self.scale;
    CGFloat targetHeight = targetSize.height;// * self.scale;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) ==NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        //        if (widthFactor < heightFactor) {
        //            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        //        } else if (widthFactor > heightFactor) {
        //            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        //        }
    }
    // this is actually the interesting part:
    //UIGraphicsBeginImageContext(targetSize);
    //UIGraphicsBeginImageContext(CGSizeMake(scaledWidth, scaledHeight));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(scaledWidth, scaledHeight),NO,self.scale ==1 ? 2 : self.scale);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(newImage == nil)
    {
        NSLog(@"could not scale image");
        return sourceImage;
    }
    return newImage ;
    
}

-(UIImage *) imageToSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointMake(0.0,0.0);
    thumbnailRect.size = targetSize;
    [self drawInRect:thumbnailRect];
    newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(newImage == nil)
    {
        NSLog(@"could not scale image");
        return self;
    }
    return newImage ;
}

+(CGSize) getMaxSize:(BURes *)imgRes defaultImg:(NSString *) defaultImgName frameSize:(CGSize) size
{
    UIImage *img = imgRes.isCached ? [UIImage imageWithContentsOfFile:imgRes.cacheFile] : [UIImage imageNamed:defaultImgName];
    return  CGSizeMake(size.width ,size.width  * (  img.size.height /img.size.width)) ;
}


+(UIImage *)imageContentWithFileName:(NSString *)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
    if(!filePath)
    {
        filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%.0fx",fileName,[UIScreen mainScreen].scale] ofType:@"png"];
    }
    NSData *dd = [NSData dataWithContentsOfFile:filePath];

  return [UIImage imageWithData:dd scale:[UIScreen mainScreen].scale];
}

@end
