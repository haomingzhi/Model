//
//  UIView+JYExFrame.m
//  JiXie
//
//  Created by air on 15/6/3.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "UIView+JYExFrame.h"
@implementation UIView (JYExFrame)
-(void)setHeight:(CGFloat)height
{
  CGRect rect = self.frame;
    rect.size.height = height;
    [self willChangeValueForKey:@"height"];
    self.frame = rect;
     [self didChangeValueForKey:@"height"];
}

-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    [self willChangeValueForKey:@"width"];
    self.frame = rect;
    [self didChangeValueForKey:@"width"];
}

-(CGFloat)width
{
    return self.frame.size.width;
}

-(void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
     [self willChangeValueForKey:@"x"];
    self.frame = rect;
    [self didChangeValueForKey:@"x"];
}

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    [self willChangeValueForKey:@"x"];
    self.frame = rect;
    [self didChangeValueForKey:@"x"];
}
-(CGFloat)y
{
    return self.frame.origin.y;
}

-(CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

-(void)setBorderWidth:(CGFloat)width
{
    [self willChangeValueForKey:@"layer.borderWidth"];
    self.layer.borderWidth = width;
    [self didChangeValueForKey:@"layer.borderWidth"];
}

-(UIColor*)borderColor
{
    UIColor *color = [UIColor colorWithCGColor:self.layer.borderColor];
    return color;
}

-(void)setBorderColor:(UIColor *)color
{
    [self willChangeValueForKey:@"layer.borderColor"];
    self.layer.borderColor = color.CGColor;
    [self didChangeValueForKey:@"layer.borderColor"];
}

-(CGSize) middle:(CGSize ) s
{
    return CGSizeMake((self.frame.size.width -s.width )/2, (self.frame.size.height - s.height)/2) ;
}

@end
