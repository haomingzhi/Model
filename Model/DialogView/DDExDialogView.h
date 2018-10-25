//
//  DDExDialogView.h
//  NIM
//
//  Created by apple on 2018/7/25.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDExDialogView : UIView
-(id)initWithView:(UIView *)view;
@property(nonatomic,readonly)UIView *view;
@property(nonatomic,strong)void (^closeCallBack)(NSDictionary *dic);
@property(nonatomic,assign)BOOL isOutSideClickClose;//是否点击对话框外面关闭对话框
-(void)addToWindow;
-(void)removeFromWindow;
@end
