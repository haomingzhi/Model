//
//  UIView+ReLayout.h
//  MiniClient
//
//  Created by apple on 14-7-24.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ReLayout)

//高度，宽度转换，参数：1.标记的高度、宽度，2.标记参照高度、宽阔
+(CGFloat)convertHeight:(NSInteger) markedHeight referenceHeight:(NSInteger) refrenceHeight;
+(CGFloat)convertwidth:(NSInteger) markedWidth referenceWidth:(NSInteger) refrenceWidth;


//垂直或者水平收缩子视图，函数会把subView后面的兄弟视图往上移动或者往左移动,
-(CGFloat)vertShrinkSubview:(UIView*)subview resizeSelf:(BOOL)resizeSelf;
-(CGFloat)horizShrinkSubview:(UIView*)subview resizeSelf:(BOOL)resizeSelf;




//扩充或者压缩视图，会把subview的位置偏移指定的值，同时会把subview后面的兄弟视图也做偏移。返回实际缩放的大小
-(CGFloat)vertInflateSubview:(UIView*)subview offsetY:(CGFloat)offsetY resizeSelf:(BOOL)resizeSelf;
-(CGFloat)vertInflateSubview:(UIView*)subview subViews:(NSArray *) subViews  offsetY:(CGFloat)offsetY resizeSelf:(BOOL)resizeSelf;


-(CGFloat)horizInflateSubview:(UIView*)subview offsetX:(CGFloat)offsetX resizeSelf:(BOOL)resizeSelf;




@end
