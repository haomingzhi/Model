//
//  YHMenuBtnView.h
//  yihui
//
//  Created by air on 15/8/26.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "JYTwoBtnMenuComponent.h"

@interface YHMenuBtnView : UIView<JYTwoBtnMenuComponent>
-(void)setMenuTitleImgs:(NSArray *)titleArr;
+ (UILabel *)createLableWithBtn:(UIButton *)btn1;
-(id)initWithComponent:(id<JYTwoBtnMenuComponent>)comp;
@end
