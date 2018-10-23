//
//  UIButton+TitleStyle.h
//  MiniClient
//
//  Created by apple on 14-7-13.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 针对同时设置了Image和Title的场景时UIButton中的文字和按钮的关系
 */
typedef NS_ENUM(NSInteger, ButtonTitleStyle ) {
    ButtonTitleStyleDefault = 0,   //如果设置了背景则默认居中，如果是设置了前景图片默认居右。
    ButtonTitleStyleLeft  = 1,
    ButtonTitleStyleRight     = 2,
    ButtonTitleStyleTop  = 3,
    ButtonTitleStyleBottom    = 4,
    ButtonTitleStyleCenter = 5
};



@interface UIButton (TitleStyle)

/*
 调整按钮的文本和image的布局，前提是title和image同时存在才会调整。
 padding是调整布局时整个按钮和图文的边距。
 
 */
@property(nonatomic,weak) id userInfo;
@property(nonatomic,strong)UIImageView *customImgV;
@property(nonatomic,strong)UILabel *customDetailLb;
@property(nonatomic,strong)UILabel *customTitleLb;
-(void)setButtonTitleStyle:(ButtonTitleStyle)style padding:(CGFloat)padding;
-(void)fitImgAndTitleMode;
-(void)fitUpImgAndDownTitleMode;
-(void)fitDownImgAndUpTitleMode;
-(void)fitLeftImgAndRightTitleMode;
-(void)fitRightImgAndLeftTitleMode;
-(void)fitUpTitleAndDownTitleMode;
@end
