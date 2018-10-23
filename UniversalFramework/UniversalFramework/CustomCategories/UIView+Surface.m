//
//  UIView+Surface.m
//  MiniClient
//
//  Created by Apple on 15-1-5.
//  Copyright (c) 2015年 SunnadaSoft. All rights reserved.
//

#import "UIView+Surface.h"

@implementation UIView (Surface)

-(void)corner:(UIColor *)color
{
    [self corner:color radius:8];
}

-(void)corner:(UIColor *)color radius:(NSInteger) radius
{
    [self corner:color radius:radius borderWidth:1.0f];
}

-(void)corner:(UIColor *)color radius:(NSInteger) radius borderWidth:(CGFloat) borderWidth
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius =  radius;
}

@end
