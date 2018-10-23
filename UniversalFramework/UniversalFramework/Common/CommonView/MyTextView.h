//
//  CustomTextView.h
//  UMPControl
//
//  Created by kong fugen on 13-2-22.
//  Copyright (c) 2013年 kong fugen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTextView;

/*自定义多行编辑框*/
@interface MyTextView : UITextView

@property(nonatomic,strong) UIImage *background;  //背景图片。
@property(nonatomic,strong) UIColor *borderColor; //边框颜色
@property(nonatomic, assign) CGFloat  borderWidth; //边框宽度
@property(nonatomic, assign) CGFloat  borderRadius; //边框圆角半径

//最大可以输入的文字数量，如果为0则不限制
@property(nonatomic, assign) NSInteger maxTextLength;     //总共可以显示的文字数量。

@property(nonatomic,strong) UILabel *shownumLabel;      //显示数量的标题文本
@property(nonatomic,strong) UIButton *clearButton;       //清除按钮
@property(nonatomic,strong) UILabel *placeholder;

@property (nonatomic) BOOL isLeftImg;
@property(nonatomic,strong) UIImageView *leftImgView;
@property(strong,nonatomic) NSString *leftImg;
 
@property(nonatomic, assign) id<UITextViewDelegate> textDelegate; //输入委托。


//当MyTextView获得焦点后这个kbMovingView会往上移动。以便显示这个MyTextView。
@property(nonatomic, weak) UIView *kbMovingView;
@property(nonatomic) NSInteger extraHeight;//额外移动高度


//- (void)setShownumTextColor:(UIColor *)numco withfont:(UIFont *)numfont;
//- (void)setTextplaceholder:(NSString *)str withfont:(UIFont *)showfont withcolor:(UIColor* )textco withtype:(UIReturnKeyType)type;

@end
