//
//  ThreeTitleTogetherTableViewCell.h
//  taihe
//
//  Created by LinFeng on 2016/11/25.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBStatusHelper.h"
#import "WBStatusLayout.h"
#import "WBStatusComposeTextParser.h"
#import "JYAbstractTableViewCell.h"

@interface ThreeTitleTogetherTableViewCell : JYAbstractTableViewCell
@property (nonatomic,strong) YYLabel *contentYYLb;
-(void)fitCellMode;
@end
