//
//  MyDialog.h
//  MiniClient
//
//  Created by apple on 14-7-10.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyDialog;

@protocol MyDialogDelegate<NSObject>

@optional

//在对话框销毁前会调用此方法,也就是手动调用dismiss,或者点击对话框外的区域时会调用。注意这个方法内部不能再调用对话框的dismiss
//isCanceled表明是用户点击对话框外被销毁的还是调用dismiss，如果是点击对话框外则为YES, 否则为NO
-(void) dismissBy:(MyDialog*)dialog withViewController:(UIViewController*)vc isCanceled:(BOOL)isCanceled;

@end


@interface UIViewController(MyDialog)

@property(nonatomic, readonly) MyDialog *parentDialog;

@end


@interface MyDialog : NSObject
@property (nonatomic) NSInteger tag;
//指定是否在对话框外点击时dismiss对话框，默认是NO
@property(nonatomic,assign, getter = isDismissOnTouchOutSide) BOOL dismissOnTouchOutside;
@property(nonatomic,strong)void (^outsideHitCallBack)(id o);
@property(nonatomic,weak) id<MyDialogDelegate> mydelegate;
@property(nonatomic,strong) UIColor *bgColor;
@property(nonatomic) BOOL isDownAnimate;
@property(nonatomic) BOOL hasKeyboard;
@property(nonatomic) CGRect kbRect;//hasKeyboard等于YES时才有效，用来防止低版本系统键盘被点击时自动收缩无法输入字符，所以这是键盘区域
-(id)initWithViewController:(UIViewController*)vc;

-(void)show;

//在某个位置显示这里的pt是基于Window坐标，x是toast左右居中的位置，y是toast顶部显示的。
-(void)showAtPosition:(CGPoint)pt;  //在某个位置下显示对话框，这里的pt是屏幕坐标。
-(void)showAtPosition:(CGPoint)pt animated:(BOOL)animated;

//在某个视图下显示对话框，yOffset是视图的垂直偏移。
-(void)showUnderView:(UIView*)underView offset:(CGPoint)offset;

-(void)hide;

-(BOOL)isShowing;

-(void)dismiss;  //dismiss后不能再使用了。MyDialogDelegate的dismissBy中的isCanceled。是NO。
-(void)cancel;   //终止，在MyDialogDelegate的dismissBy中的isCanceled。是YES


@end
