//
//  UIImage+SeparatorLine.h
//  MiniClient
//
//  Created by Apple on 14-10-29.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, UISeparatorLineType) {
    UISeparatorLineTypeLeft = 1,
    UISeparatorLineTypeRight = 1<<1,
    UISeparatorLineTypeTop = 1<<2,
    UISeparatorLineTypeBottom = 1<<3,
};

@interface UIImage (SeparatorLine)
+ (UIImage *) imageWithSeparatorLine:(UISeparatorLineType)lineType lineColor:(UIColor *) color withBounds:(CGRect)bounds;

+ (UIImage *) imageWithSeparatorLine:(UISeparatorLineType)lineType lineColor:(UIColor *) color withBounds:(CGRect)bounds lineWidth:(NSInteger) lineWidth;


+ (UIImage *) imageWithSeparatorLine:(UISeparatorLineType)lineType lineColor:(UIColor *) color withBounds:(CGRect)bounds offset:(UIEdgeInsets )edgeInsets lineWidth:(NSInteger) lineWidth;

+(UIImage *)ImageWithellipse:(CGRect)bounds lineColor:(UIColor*)color offset:(NSInteger)offset;

+(UIImage *)ImageWithellipse:(CGRect)bounds lineColor:(UIColor*)color fillColor:(UIColor *)fillColor offset:(NSInteger)offset;


+(UIImage *)ImageWithCircle:(CGRect)bounds lineColor:(UIColor*)color fillColor:(UIColor *)fillColor;

@end
