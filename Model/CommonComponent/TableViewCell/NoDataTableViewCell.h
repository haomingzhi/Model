//
//  NoDataTableViewCell.h
//  taihe
//
//  Created by LinFeng on 2016/12/9.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"

@interface NoDataTableViewCell : JYAbstractTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *noDataImageView;
@property (weak, nonatomic) IBOutlet UILabel *warnLb;
-(void)fitCellMode;
-(void)fitCellModeA;
-(void)fitClassifyMode;
@end
