//
//  UIView+JYExFrame.h
//  JiXie
//
//  Created by air on 15/6/3.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JYExFrame)
@property(nonatomic) CGFloat height;
@property(nonatomic)CGFloat width;
@property(nonatomic)CGFloat x;
@property(nonatomic)CGFloat y;
@property(nonatomic)CGFloat left;
@property(nonatomic)CGFloat top;
@property(nonatomic) UIColor * borderColor;
@property(nonatomic) CGFloat borderWidth;

-(CGSize) middle:(CGSize ) s;
@end
