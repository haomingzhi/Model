//
//  FiveBtnTableViewCell.h
//  oranllcshoping
//
//  Created by air on 2017/7/21.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface FiveBtnTableViewCell : JYAbstractTableViewCell
-(void)fitMineModeA;
-(void)fitMineModeB;
-(void)fitVIPCenterMode;
-(void)fitRecordInfoMode;
-(void)fitVipHelpModeA;
-(void)fitVipHelpModeB;
-(void)fitVipHelpModeC:(CGFloat)height;
-(void)fitGoodsInfoMode;
@end
