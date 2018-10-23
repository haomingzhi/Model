//
//  UIView+AutoLayOut.h
//  UniversalFramework
//
//  Created by air on 15/8/27.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSInteger {
    JYLayoutRelationEqual = 0,
    JYLayoutRelationLessThanOrEqual  = -1,
    JYLayoutRelationGreaterThanOrEqual = 1
} JYLayoutRelation;
typedef enum : NSInteger {
    JYLayoutSizeWidth = 7,
    JYLayoutSizeHeight = 8
} JYLayoutSize;
typedef enum : NSInteger {
    JYLayoutPositionTop = 3,
    JYLayoutPositionRight = 2,
    JYLayoutPositionBottom = 4,
    JYLayoutPositionLeft = 1
} JYLayoutPosition;

typedef enum : NSInteger {
    JYLayoutToOnTop = 3,
    JYLayoutToOnRight = 2,
    JYLayoutToOnBottom = 4,
    JYLayoutToOnLeft = 1
} JYLayoutToOn;

@interface UIView (AutoLayOut)
-(void)alignViewCenterWithLeftView:(UIView *)v1 right:(UIView*)v2;//两个视图一起向父视图居中 基于左视图对齐
-(void)alignViewCenterWithLeftView:(UIView *)v1 right:(UIView*)v2 innerViewLeft:(CGFloat)iLeft;//两个视图一起向父视图居中 基于左视图对齐 ileft内部间距
-(void)alignViewLeftWithLeftView:(UIView *)v1 right:(UIView*)v2 toParentViewLeft:(CGFloat)theLeft innerViewLeft:(CGFloat)iLeft;//两个视图一起向父视图左边靠拢 基于左视图对齐  theleft距离父视图多少，iLeft两视图间距 (垂直居中)

-(void)alignViewRightWithLeftView:(UIView *)v1 right:(UIView*)v2 toParentViewRight:(CGFloat)theRight innerViewRight:(CGFloat)iRight;//两个视图一起向父视图右边靠拢 基于右视图对齐 theRight距离父视图多少，iRight两视图间距 (垂直居中)

-(void)alignViewCenter;//水平垂直居中

-(void)alignViewHCenter:(CGFloat)theTop;//水平居中theTop距离头顶高度

-(void)alignViewVCenter:(CGFloat)theLeft;//垂直居中theLeft距离左边宽度

-(void)addWidthConstraint:(JYLayoutRelation) related width:(CGFloat)theWidth;//宽度大小约束

-(void)baseSizeConstrain:(UIView *)v layoutSize:(JYLayoutSize)hOrw related:(JYLayoutRelation)theRelated size:(CGFloat)theSize;//设置v的宽度或高度的大小约束

-(void)addHeightConstraint:(JYLayoutRelation)related width:(CGFloat)theHeight;//高度大小约束

-(void)addLeftConstraint:(CGFloat)theLeft;//theLeft距父视图左边距离

-(void)addTopConstraint:(CGFloat)theTop;//theTop距离父视图头顶高度

-(void)addRightConstraint:(CGFloat)theRight;//theRight距父视图右边距离

-(void)addBottomConstraint:(CGFloat)theBottom;//theBottom距父视图底部距离

-(void)addHorizontalConstraint;//水平居中

-(void)addVerticalConstraint;//垂直居中

-(void)toLeftOnConstraint:(UIView *)v withEx:(CGFloat)y;//向左边v视图靠拢距离y

-(void)toRightOnConstraint:(UIView *)v withEx:(CGFloat)y;//向右边v视图靠拢距离y

-(void)toTopOnConstraint:(UIView *)v withEx:(CGFloat)x;//向上边v视图靠拢距离x

-(void)toBottomOnConstraint:(UIView *)v withEx:(CGFloat)x;//向下边v视图靠拢距离x

-(void)addVerticalConstraint:(CGFloat) y;//垂直约束，y=0时垂直居中，其他则以中心偏移

-(void)addHorizontalConstraint:(CGFloat)x;//水平约束，x=0时水平居中，其他则以中心偏移

@end
