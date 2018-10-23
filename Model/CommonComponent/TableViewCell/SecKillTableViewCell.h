//
//  SecKillTableViewCell.h
//  oranllcshoping
//
//  Created by air on 2017/7/20.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
#import "SeckillView.h"
@interface SecKillTableViewCell : JYAbstractTableViewCell
@property(nonatomic,strong)SeckillView *aView;
@property(nonatomic,strong)SeckillView *bView;
@property(nonatomic,strong)NSDictionary *dataDic;
-(void)fitSecKillMode;
-(void)fitYouLikeMode;
-(void)fitPopularityRecModeA;
-(void)fitPopularityRecModeB;
-(void)fitHeadMode;
@end
