//
//  PinpaiTableViewCell.h
//  oranllcshoping
//
//  Created by air on 2017/7/20.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
#import "PinpaiView.h"
@interface PinpaiTableViewCell : JYAbstractTableViewCell
@property(nonatomic,strong)PinpaiView *aView;
@property(nonatomic,strong)PinpaiView *bView;
@property(nonatomic,strong)NSDictionary *dataDic;
-(void)fitPinpaiMode;
@end
