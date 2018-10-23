//
//  WaveProgressView.h
//  WaveViewDemo
//
//  Created by Darwin on 2017/4/6.
//  Copyright © 2017年 Darwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveProgressView : UIView

/*
 * 前波浪的颜色
 */
@property (nonatomic, strong) UIColor *firstWaveColor;

/*
 * 后波浪的颜色
 */
@property (nonatomic, strong) UIColor *secondWaveColor;

/*
 * 设置进度 0 - 1 之间
 */
@property (nonatomic, assign) CGFloat percent;

/*
 * 是否显示百分比进度
 */
@property (nonatomic, assign) BOOL showPercent;

/*
 * 设置百分比文字的颜色
 */
@property (nonatomic, strong) UIColor *percentColor;

/*
 * 是否显示冒泡的动画效果 ⚠️
 */
@property (nonatomic, assign) BOOL showAnimation;

/*
 * 进度是否使用双层波浪，默认为是
 */
@property (nonatomic, assign) BOOL isDouble;

/*
 * 圆形样式
 */
@property (nonatomic, assign) BOOL isCircle;

@end
