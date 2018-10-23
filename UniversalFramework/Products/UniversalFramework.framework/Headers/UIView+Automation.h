//
//  UIView+Automation.h
//  JiXie
//  自动化扩展如：自动判空，自动填充、自动清空
//  Created by ORANLLC_IOS1 on 15/6/30.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Automation)
-(BOOL) emptyCheck; //默认检测 textField,InputView,UITextView
-(BOOL) emptyCheck :(NSArray *) classList;
/**
 *  清空TextField输入框内容
 */
-(void) clearTextField;

//启动填充到View
-(void) autoFill:(id)object;
//自动设置kbMoving
-(void) autokbMovingView;


@end
