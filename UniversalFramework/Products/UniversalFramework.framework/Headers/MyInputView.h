//
//  MyInputView.h
//  MiniClient
//
//  Created by longgong on 14-9-19.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef enum
//{
//    InputType_text, //文本，默认
//    InputType_date, //日期选择
//    InputType_time, //时间选择
//}InputType;

@interface MyInputView : MyTextField

-(void) initInputView;

-(void) initInputView:(UITextBorderStyle)borderStyle;
//左边图片
@property(nonatomic,strong) UIImageView *leftImgView;
//底部横线
//@property(nonatomic,strong) UIImageView *lineImg;
@property (nonatomic,assign) CGFloat leftImgWidth;//左边图片宽度
@property (nonatomic,assign) CGFloat leftImgHeight;
//@property (nonatomic,strong) NSString *leftImg;
//@property (nonatomic,assign) BOOL isLeftImg;
//最大可以输入的文字数量，如果为0则不限制
@property(nonatomic,assign) NSInteger maxTextLength;

@property(nonatomic,strong) UILabel *shownumLabel;

-(UIImage *)getSeparatorLineImage:(UIColor *)color;

- (void)setLeftImage:(UIImage *)leftImage forState:(UIControlState)state;

@end

