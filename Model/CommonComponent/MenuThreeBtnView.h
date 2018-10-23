//
//  MenuThreeBtnView.h
//  ulife
//
//  Created by air on 15/12/24.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuThreeBtnView : UIView
@property(nonatomic,strong) void (^handle)(UIButton *btn);
@property(nonatomic,strong)  UIButton *curBtn;
@property(nonatomic)  NSInteger curIndex;
@property(nonatomic) NSInteger curBtnIndex;
-(void)decoratorULifeView;
-(void)setMenuTitleTexts:(NSArray *)titleArr;
@end
