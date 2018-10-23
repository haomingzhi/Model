//
//  ZJMenuView.h
//  spokesman
//
//  Created by Steve on 2017/1/11.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJMenuView : UIView
@property(nonatomic,strong) void (^handle)(UIButton *btn);
-(void)setData:(NSArray *)arr;
-(void)setCurrenItem:(NSInteger)index;
-(void)setCurrenItem:(NSInteger)index animated:(BOOL)animated;
@end
