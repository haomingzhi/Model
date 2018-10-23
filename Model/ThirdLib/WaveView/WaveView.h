//
//  WaveView.h
//  WaveViewDemo
//
//  Created by Darwin on 2017/4/6.
//  Copyright © 2017年 Darwin. All rights reserved.
//

/*
 * 由于本代码的定时器使用的是CADisplayLink，建议直接在真机上测试，电脑频率和手机不同，会显示不同的速度。
 */


#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WaveViewTypeDefault = 0,
    WaveViewTypeBottom,
    WaveViewTypeLeft,
    WaveViewTypeRight
} WaveViewType;

@interface WaveView : UIView

/*
 * 波浪类型
 */
@property (nonatomic, assign) WaveViewType waveViewType;

/*
 * 图层颜色, 推荐颜色：
 */
@property (nonatomic, strong) UIColor *firsetWaveColor;
@property (nonatomic, strong) UIColor *secondWaveColor;

/*
 * 是否显示第二个波浪,默认为 NO
 */
@property (nonatomic, assign) BOOL isDouble;

/*
 * 波动速度, 当波动速度为负时，向右(上)波动，当波动速度为正时，向右(下)波动，波动速度指每秒钟波浪偏移多少像素，默认为 1，推荐值 1或 -1;
 */
@property (nonatomic, assign) CGFloat waveSpeed;

/*
 * 波动振幅,不设置或者设置为-1的时候，为默认值，默认为上下波动16px。如果设置了该值，则波峰可变属性会被忽略。该值代表波峰到谷底的距离
 */
@property (nonatomic, assign) CGFloat waveAmplitude;

/*
 * 波峰是否可变, 默认为不可变，默认值为16像素，波低至波顶的高度。如果手动设置了波动振幅，则该属性自动设置为不可变。单层layer建议使用可变，双层使用可变效果不好。
 */
@property (nonatomic, assign) BOOL isMutable;

/*
 * 波动周期，默认值为1.29 * M_PI ／ self.bounds.size.width，谨慎修改，不然太丑。
 */
@property (nonatomic, assign) CGFloat waveCycle;


/*
 * 开始波动代码，默认自动开启。
 */
- (void)startWave;

/*
 * 停止波动代码 ---- 这个很重要，要解决循环引用
 */
- (void)stopWave;

@end
