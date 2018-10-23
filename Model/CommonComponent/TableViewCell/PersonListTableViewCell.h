//
//  PersonListTableViewCell.h
//  yihui
//
//  Created by air on 15/8/28.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
typedef NS_ENUM(NSUInteger, SelectBtnMode) {
    SelectBtnModeNone,
    SelectBtnModeSingle
};
@interface PersonListTableViewCell : JYAbstractTableViewCell
-(void)selectBtn:(UIButton *)btn;
@end
