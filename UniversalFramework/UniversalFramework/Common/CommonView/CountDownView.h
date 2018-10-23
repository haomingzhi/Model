//
//  CountDownView.h
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/10/29.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownView : UIView


+(id) shareInstance;
/**
 *  初始化一个倒计时试图
 *
 *  @param frame        试图大小，提示字符串自动居中
 *  @param hintFormat   提示字符串[yy][mm][dd][hh][mi][ss]来表示倒计时字符串 请在[hh]小时[mi]分[ss]秒内付款，超时订单将被取消
 *  @param num          倒计时时常（秒）
 *  @param color        字体颜色
 *  @param markerColor  标记颜色
 *  @return 试图本身
 */
-(id) setFrame:(CGRect)frame andFormat:(NSString *) hintFormat countDownNum:(CGFloat)num font:(UIFont *)font color:(UIColor *) color markerColor :(UIColor *) markerColor;

-(void) startCountDown;
-(void) endCountDown;
@end
