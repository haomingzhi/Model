//
//  MenuFourBtnViewController.h
//  yihui
//
//  Created by wujiayuan on 15/9/21.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuFourBtnViewController : UIViewController
@property(nonatomic,strong) void (^handle)(UIButton *btn);
@property(nonatomic,strong)  UIButton *curBtn;
@property(nonatomic)  NSInteger curIndex;
@property(nonatomic) NSInteger curBtnIndex;
-(void)setMenuTitleImgs:(NSArray *)imgArr;
-(void)decoratorView;
-(void)setMenuBackgroundImgs:(NSArray *)imgArr;
-(void)setMenuSelectedBackgroundImgs:(NSArray *)imgArr;
-(void)setMenuTitleTexts:(NSArray *)titleArr;
-(void)setMenuTitleColors:(NSArray *)titleArr;
- (void)handleAction:(UIButton *)btn;
@end
