//
//  IconTitleAndImgTableViewCell.h
//  lovecommunity
//
//  Created by air on 16/6/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface IconTitleAndImgTableViewCell : JYAbstractTableViewCell
-(void)iconTitleMode:(CGFloat )height withImgHeight:(CGFloat)iHeihgt withColor:(UIColor *)color;
-(void)iconTitleMode:(CGFloat )height withImgHeight:(CGFloat)iHeihgt withColor:(UIColor *)color withNeedDot:(BOOL)b;
-(void)fitconfirmOrderMode:(BOOL)isSelected;
-(void)fitBuyStyleMode;
-(void)fitMineMode;
-(void)fitSettingMode;
@end
