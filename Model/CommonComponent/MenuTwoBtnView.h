//
//  MenuTwoBtnView.h
//  ChaoLiu
//
//  Created by air on 15/8/5.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYTwoBtnMenuComponent.h"
@interface MenuTwoBtnView : UIView<JYTwoBtnMenuComponent>
@property(nonatomic,strong) void (^handle)(UIButton *btn);
@property(nonatomic,strong)  UIButton *curBtn;
@property(nonatomic)  NSInteger curIndex;
@property(nonatomic) NSInteger curBtnIndex;
-(void)setMenuTitleImgs:(NSArray *)imgArr;
-(void)decoratorView;
-(void)setMyCollecteTopView;
-(void)setMenuBackgroundImgs:(NSArray *)imgArr;
-(void)setMenuSelectedBackgroundImgs:(NSArray *)imgArr;
-(void)decoratorULifeViewNormal;
-(void)decoratorULifeViewEdit;
@end
