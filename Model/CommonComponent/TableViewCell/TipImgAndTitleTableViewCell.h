//
//  TipImgAndTitleTableViewCell.h
//  yihui
//
//  Created by air on 15/8/31.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface TipImgAndTitleTableViewCell :JYAbstractTableViewCell
-(UILabel *)getTextLb;
-(void)fitHeadMode;
-(UILabel *)getCTextLb;
@end