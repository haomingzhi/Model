//
//  MyToast.h
//  MiniClient
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

//类似于android的toast的功能
@interface MyToast : NSObject<UIAppearance>

+(MyToast*)toast;


//设置显示文字的字体，字号，颜色，边框，椭圆角
@property(nonatomic, strong) CATextLayer *labelLayer; //UI_APPEARANCE_SELECTOR
@property(nonatomic,assign) NSTimeInterval timeInterval; //UI_APPEARANCE_SELECTOR

//显示特定的文本
-(void)show:(NSString*)text;
-(void)show:(NSString*)text withTextColor:(UIColor *)color;
//在某个位置显示这里的pt是基于Window坐标，x是toast左右居中的位置，y是toast顶部显示的。
-(void)show:(NSString *)text atPosition:(CGPoint)pt;

//在某个视图的正下面，yOffset就是正下方的偏移值
-(void)show:(NSString *)text underView:(UIView*)underView offsetPosition:(CGPoint)offsetPosition;

@end
#define TOASTSHOWWITHTEXTCOLOR(text,textColor) [[MyToast toast]show:text withTextColor:textColor];
#define TOASTSHOW(text) [[MyToast toast]show:text]
#define TOASTSHOWATPOSITION(text,pt) [[MyToast toast]show:text atPosition:pt]
#define TOASTSHOWUNDERVIEW(text,view,offset) [[MyToast toast]show:text underView:view offsetPosition:offset]

