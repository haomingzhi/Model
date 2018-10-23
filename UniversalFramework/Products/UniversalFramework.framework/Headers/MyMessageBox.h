//
//  MyMessageBox.h
//  MyTest13
//
//  Created by oybq on 11-4-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
  
 UIAlertView 和UIActionSheet的简易使用封装！ 主要可以解决掉UIAlertView和UIActionSheet的委托的设置的麻烦处理的问题
 直接采用block的方式，简单易用，易处理。。UIAlertView  用show， UIActionSheet用showFromXXX 函数。
 
 */
 
@interface MyMessageBox : NSObject{
	
}

+msgBox;


//显示某个对话框指定多少秒后自动销毁。
-(void)show:(NSString *)title message:(NSString *)message until:(NSTimeInterval)sec;


//显示对话框，采用block而不是采用委托index是从上到下从0开始的按钮点击的顺序。
-(void)show:(NSString*)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles completion:(void (^)(NSInteger index))completion;


//增加一个带自定义绘制对话框面板的调用方法custom的方法参数为： -(void)custom:(AlertView*)view;
-(void)show:(NSString*)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles withCustom:(NSInvocation*)custom completion:(void (^)(NSInteger index))completion;


//主要针对UIActionSheet的封装，采用block而不是采用委托
- (void)showFromToolbar:(UIToolbar *)view withStyle:(UIActionSheetStyle)style title:(NSString*)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle buttons:(NSArray*)buttons completion:(void (^)(NSInteger index))completion;

- (void)showFromTabBar:(UITabBar *)view withStyle:(UIActionSheetStyle)style title:(NSString*)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle buttons:(NSArray*)buttons completion:(void (^)(NSInteger index))completion;

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated withStyle:(UIActionSheetStyle)style title:(NSString*)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle buttons:(NSArray*)buttons completion:(void (^)(NSInteger index))completion;

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated withStyle:(UIActionSheetStyle)style title:(NSString*)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle buttons:(NSArray*)buttons completion:(void (^)(NSInteger index))completion;


@end


