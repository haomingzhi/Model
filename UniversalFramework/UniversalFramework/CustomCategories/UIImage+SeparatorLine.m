//
//  UIImage+SeparatorLine.m
//  MiniClient
//
//  Created by Apple on 14-10-29.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "UIImage+SeparatorLine.h"

@implementation UIImage (SeparatorLine)

+ (UIImage *) imageWithSeparatorLine:(UISeparatorLineType)lineType lineColor:(UIColor *) color withBounds:(CGRect)bounds
{
    return [UIImage imageWithSeparatorLine:lineType lineColor:color withBounds:bounds lineWidth:2];
}

+ (UIImage *) imageWithSeparatorLine:(UISeparatorLineType)lineType lineColor:(UIColor *) color withBounds:(CGRect)bounds lineWidth:(NSInteger) lineWidth
{
    return [UIImage imageWithSeparatorLine:lineType lineColor:color withBounds:bounds offset:UIEdgeInsetsMake(0,0,0,0) lineWidth:lineWidth];
}
+ (UIImage *) imageWithSeparatorLine:(UISeparatorLineType)lineType lineColor:(UIColor *) color withBounds:(CGRect)bounds offset:(UIEdgeInsets )edgeInsets lineWidth:(NSInteger) lineWidth;
{
    CGRect rect=bounds;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL)
    {
        UIGraphicsEndImageContext();
        return nil;
    }
    //CGFloat lineWidth = 2; //线宽
    CGFloat red,green,blue,alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red,green,blue, alpha);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    lineWidth = lineWidth < 1 ? 1 :lineWidth;
    float x =bounds.origin.x + edgeInsets.left;
    float y =bounds.origin.y + edgeInsets.top;
    float width =bounds.size.width + edgeInsets.right -edgeInsets.left;
    float height =bounds.size.height - edgeInsets.top +edgeInsets.bottom;
    if ((lineType & UISeparatorLineTypeLeft) == UISeparatorLineTypeLeft) {
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, y);  //起点坐标
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x, y+height);   //终点坐标
    }
    if ((lineType & UISeparatorLineTypeRight) == UISeparatorLineTypeRight) {
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x+width, y);  //起点坐标
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),  x+width,y+height);   //终点坐标
    }
    
    if ((lineType & UISeparatorLineTypeTop) == UISeparatorLineTypeTop) {
        if ((lineType & UISeparatorLineTypeLeft) == UISeparatorLineTypeLeft)
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x+lineWidth, y);  //起点坐标
        else
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, y);  //起点坐标
        if ((lineType & UISeparatorLineTypeRight) == UISeparatorLineTypeRight)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x+width - lineWidth,y);   //终点坐标
        else
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x+width,y);   //终点坐标
    }
    
    if ((lineType & UISeparatorLineTypeBottom) == UISeparatorLineTypeBottom) {
        if ((lineType & UISeparatorLineTypeLeft) == UISeparatorLineTypeLeft)
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x+lineWidth, y+height);  //起点坐标
        else
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x,y+height);  //起点坐标
        if ((lineType & UISeparatorLineTypeRight) == UISeparatorLineTypeRight)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x+width - lineWidth,y+height);   //终点坐标
        else
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),  x+width,y+height);   //终点坐标
    }
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIImage *)imageWithEllipse:(CGRect)leftCircle middleRect:(CGRect)middleRect rightCircle:(CGRect)rightCircle lineColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0, 0, leftCircle.size.width+middleRect.size.width+rightCircle.size.width +4, rightCircle.size.height +4);
    int xoffset =2;
    int yoffset =2;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL)
    {
        UIGraphicsEndImageContext();
        return nil;
    }
    CGFloat lineWidth = 2; //线宽
    CGFloat red,green,blue,alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red,green,blue, alpha);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    
    CGContextAddArc(context, xoffset+middleRect.size.height/2, yoffset+middleRect.size.height/2, middleRect.size.height/2, 90*M_PI/180, 270*M_PI/180, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    
    CGContextMoveToPoint(context, xoffset+middleRect.origin.x, yoffset+middleRect.origin.y);  //起点坐标
    CGContextAddLineToPoint(context,  xoffset+middleRect.origin.x+middleRect.size.width,yoffset+middleRect.origin.y);   //终点坐标
    
    
    
    CGContextAddArc(context, xoffset+middleRect.size.height/2+middleRect.size.width, yoffset+middleRect.size.height/2, middleRect.size.height/2, 270*M_PI/180, 90*M_PI/180, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    
    CGContextMoveToPoint(context, xoffset+middleRect.origin.x, yoffset+middleRect.origin.y + middleRect.size.height);  //起点坐标
    CGContextAddLineToPoint(context,  xoffset+middleRect.origin.x+middleRect.size.width,yoffset+middleRect.origin.y + middleRect.size.height);   //终点坐标
    
    CGContextStrokePath(context);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+(UIImage *)ImageWithellipse:(CGRect)bounds lineColor:(UIColor*)color offset:(NSInteger)offset;
{

    return [UIImage imageWithEllipse:CGRectMake(0, 0, bounds.size.height/2, bounds.size.height) middleRect:CGRectMake(bounds.size.height/2, 0, bounds.size.width-bounds.size.height, bounds.size.height) rightCircle:CGRectMake(bounds.size.width - bounds.size.height/2, 0, bounds.size.height/2, bounds.size.height) lineColor:color ];
}

+(UIImage *)imageWithEllipse:(CGRect)leftCircle middleRect:(CGRect)middleRect rightCircle:(CGRect)rightCircle lineColor:(UIColor*)color fillColor:(UIColor *)fillColor  offset:(NSInteger)offset;
{
    CGRect rect=CGRectMake(0, 0, leftCircle.size.width+middleRect.size.width+rightCircle.size.width+offset*2 , rightCircle.size.height+offset *2 );
    NSInteger xoffset =offset;
    NSInteger yoffset =offset;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL)
    {
        UIGraphicsEndImageContext();
        return nil;
    }
    CGFloat lineWidth = 2; //线宽
    CGFloat red,green,blue,alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red,green,blue, alpha);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    CGContextSetFillColorWithColor(context, fillColor.CGColor);//填充颜色
    CGContextSetStrokeColorWithColor(context, color.CGColor);//线框颜色
    
    CGContextAddArc(context, (xoffset ==0 ? 2 : xoffset)+middleRect.size.height/2, yoffset+middleRect.size.height/2, middleRect.size.height/2, 90*M_PI/180, 270*M_PI/180, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
    
    CGContextAddArc(context, (xoffset ==0 ? -2 : xoffset)+middleRect.size.height/2+middleRect.size.width, yoffset+middleRect.size.height/2, middleRect.size.height/2, 270*M_PI/180, 90*M_PI/180, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
    
    CGContextAddRect(context,CGRectMake(xoffset+middleRect.origin.x, yoffset+middleRect.origin.y, middleRect.size.width, middleRect.size.height));//画方框
    CGContextDrawPath(context, kCGPathFill);//绘画路径
    

    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), xoffset+middleRect.origin.x, yoffset+middleRect.origin.y);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), xoffset+middleRect.origin.x +middleRect.size.width, yoffset+middleRect.origin.y);   //终点坐标
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), xoffset+middleRect.origin.x, yoffset+middleRect.origin.y +middleRect.size.height);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), xoffset+middleRect.origin.x +middleRect.size.width, yoffset+middleRect.origin.y+middleRect.size.height);   //终点坐标
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIImage *)ImageWithellipse:(CGRect)bounds lineColor:(UIColor*)color fillColor:(UIColor *)fillColor offset:(NSInteger)offset;
{
    bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width - offset *2 , bounds.size.height - offset *2);
    return [UIImage imageWithEllipse:CGRectMake(0, 0, bounds.size.height/2, bounds.size.height) middleRect:CGRectMake(bounds.size.height/2, 0, bounds.size.width-bounds.size.height, bounds.size.height) rightCircle:CGRectMake(bounds.size.width - bounds.size.height/2, 0, bounds.size.height/2, bounds.size.height) lineColor:color fillColor:fillColor offset:offset];
}

//画一张圆图
+(UIImage *)ImageWithCircle:(CGRect)bounds lineColor:(UIColor*)color fillColor:(UIColor *)fillColor
{
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL)
    {
        UIGraphicsEndImageContext();
        return nil;
    }
    CGFloat lineWidth = 2; //线宽
    CGFloat red,green,blue,alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidth);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red,green,blue, alpha);  //颜色
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    CGContextSetFillColorWithColor(context, fillColor.CGColor);//填充颜色
    CGContextSetStrokeColorWithColor(context, color.CGColor);//线框颜色
    
    CGContextFillEllipseInRect(context, bounds);
    
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;

}
@end
