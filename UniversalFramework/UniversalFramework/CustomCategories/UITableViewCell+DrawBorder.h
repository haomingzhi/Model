//
//  UITableViewCell+DrawBorder.h
//  JiXie
//
//  Created by air on 15/5/27.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    BorderModeNone,
    BorderModeTop,
    BorderModeBottom,
    BorderModeCenter,
    BorderModeAll,
} BorderMode;
typedef enum : NSUInteger {
    DrawTypeLayerDraw,
    DrawTypeBezierPathDraw
} DrawType;
@interface UITableViewCell (DrawBorder)
-(NSArray *)drawBottomLine:(CGFloat)padding;
-(NSArray *)drawBorder:(BorderMode)borderMode;
-(NSArray *)drawBorder:(BorderMode)borderMode withLRPadding:(CGFloat)padding;
-(NSArray *)drawBorder:(BorderMode)borderMode withIsNeedBottomLine:(BOOL)isNeed withPadding:(CGFloat)padding;
-(NSArray *)drawLostBottomBorder;
-(void)drawBezierPathLostBottomBorder:(CGFloat)padding withRadius:(CGFloat)radius;
-(NSArray *)drawLostTopBorder;
-(void)drawBezierPathLostTopBorder:(CGFloat)padding withRadius:(CGFloat)radius;
-(NSArray *)drawLostTopAndBottomBorder;
-(void)drawBezierPathLostTopAndBottomBorder:(CGFloat)padding;
-(NSArray *)drawAllBorder;
-(void)drawBezierPathAllBorder:(CGFloat)padding withRadius:(CGFloat)radius;
-(NSArray *)drawBottomLine;
-(void)drawBezierPathBottomLineY:(CGFloat)y  withLeftPadding:(CGFloat) paddingLeft withRightPading:(CGFloat)paddingRight;
@end
