//
//  PromoteTableViewCell.h
//  yinglingzhe
//
//  Created by LinFeng on 2016/10/20.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"

@interface PromoteTableViewCell : JYAbstractTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *contetLbl;
@property (assign ,nonatomic) float cellHeight;
@property (strong,nonatomic) CWStarRateView *starView;
- (void)fitCellMode;

@end
