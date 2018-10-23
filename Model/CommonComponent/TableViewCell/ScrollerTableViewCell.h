//
//  ScrollerTableViewCell.h
//  deliciousfood
//
//  Created by air on 2017/2/16.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface ScrollerTableViewCell : JYAbstractTableViewCell
-(void)fitHeadModeA;
-(void)fitHeadModeB;
-(void)fitClassityMode;
-(void)fitHeadMode;
-(void)fitSearchMode;
-(void)fitOptimizationRecMode;
-(void)fitEvaluationMode:(BOOL)isAllShow;
-(void)fitSecondKillMode;
-(void)fitShopMode;
-(void)fitRecycleInfoMode;
-(void)fitRecycleInfoModeB;
@end
