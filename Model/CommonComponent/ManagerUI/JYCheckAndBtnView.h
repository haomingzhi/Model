//
//  JYCheckAndBtnView.h
//  yihui
//
//  Created by air on 15/9/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYCheckAndBtnView : UIView
@property(nonatomic,strong) void(^handleAction)(id obj);
@property(nonatomic,strong) NSString *btnTitle;
@property(nonatomic) BOOL isSelected;
@property(nonatomic) BOOL isAllSelected;
@property(nonatomic,strong) UIColor *btnBackgroundColor;
@property(nonatomic) CGFloat btnWidth;
-(void)hideAllSelectedView;
-(void)decoratorULifeView;
@end
