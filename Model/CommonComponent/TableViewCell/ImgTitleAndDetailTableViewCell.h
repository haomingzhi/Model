//
//  ImgTitleAndDetailTableViewCell.h
//  yihui
//
//  Created by air on 15/9/2.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface ImgTitleAndDetailTableViewCell : JYAbstractTableViewCell
-(void)fitCellMode;
-(void)fitActivityInfoMode:(BOOL)hasCer;
-(void)fitInvGetGiftMode;
@end
