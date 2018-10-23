//
//  TwoTitleAndImgTableViewCell.h
//  deliciousfood
//
//  Created by Steve on 2017/2/23.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"

@interface ThreeTitleAndImgTableViewCell : JYAbstractTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgVA;
@property (weak, nonatomic) IBOutlet UILabel *titleA;
@property (weak, nonatomic) IBOutlet UIImageView *imgVB;
@property (weak, nonatomic) IBOutlet UILabel *titleB;
@property (weak, nonatomic) IBOutlet UIImageView *imgVC;
@property (weak, nonatomic) IBOutlet UILabel *titleC;

-(void)fitCellMode;
-(void)fitEvaMode;
-(void)fitTopicMode;
-(void)fitTopicHomeMode;
@end
