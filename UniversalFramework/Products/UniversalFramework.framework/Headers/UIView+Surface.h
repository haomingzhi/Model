//
//  UIView+Surface.h
//  MiniClient
//
//  Created by Apple on 15-1-5.
//  Copyright (c) 2015年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Surface)
-(void)corner:(UIColor *)color;

-(void)corner:(UIColor *)color radius:(NSInteger) radius;

-(void)corner:(UIColor *)color radius:(NSInteger) radius borderWidth:(CGFloat) borderWidth;
@end
