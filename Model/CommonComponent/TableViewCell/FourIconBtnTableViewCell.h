//
//  FourIconBtnTableViewCell.h
//  yihui
//
//  Created by air on 15/9/1.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface FourIconBtnTableViewCell : JYAbstractTableViewCell
//@property(nonatomic,strong) void (^handleAction)(UIButton * btn);
-(void)fitMode;
-(void)fitMineMode;
-(void)fitTraceOrderMode;
-(void)fitLuckMode:(CGFloat )y withHeight:(CGFloat)height;
-(void)fitVipHelpMode;
@end
