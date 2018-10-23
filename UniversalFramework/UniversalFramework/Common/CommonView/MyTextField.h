//
//  MyTextField.h
//  MiniClient
//
//  Created by apple on 14-7-9.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTextField;

@protocol MyTextFieldDelegate<UITextFieldDelegate>

@optional

//如果是显示浮动视图的话告诉浮动视图要显示的文字内容,如果不实现或者返回nil则是文本框中的内容。
-(NSString*)floatTextForMyTextField:(MyTextField*)textField;

@end


@interface MyTextField : UITextField

//设置这个视图为跟随键盘移动视图，一般为TextFiled的某级父视图。
//当TextField获得焦点后这个kbMovingView会往上移动。以便显示这个TextField。
@property(nonatomic, weak) UIView *kbMovingView;

@property(nonatomic) BOOL showFloatingView;  //是否显示浮动的视图。用户在编辑时会自动漂浮在上面并显示输入的值。

@end
