//
//  JYTwoBtnMenuComponent.h
//  yihui
//
//  Created by air on 15/8/28.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JYTwoBtnMenuComponent <NSObject>
@optional
-(void)setMenuTitleTexts:(NSArray *)titleArr;
-(void)setMenuTitleColors:(NSArray *)titleArr;
- (void)handleAction:(UIButton *)btn;
@end
