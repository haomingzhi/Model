//
//  UIView+Animation.h
//  MiniClient
//
//  Created by Apple on 14-12-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

//视图平移
-(void)translation:(CGPoint)point animationDuration:(NSTimeInterval)duration;
//淡入淡出，sx,sy 长宽缩放比例，duration 动画时长
-(void)curveEaseInOut:(CGFloat) sx  scaleSy:(CGFloat) sy animationDuration:(NSTimeInterval)duration;
//旋转,angle角度，M_PI * 2.0 表示旋转一圈 duration 旋转速度 count 动画重复次数
-(void)rotation:(CGFloat)angle animationDuration:(NSTimeInterval)duration repeatCount:(CGFloat)count;
@end
