//
//  SignTableViewCell.h
//  rentingshop
//
//  Created by Steve on 2018/3/22.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"

@interface SignTableViewCell : JYAbstractTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *couponView;
@property (weak, nonatomic) IBOutlet UILabel *signDayLb;
@property (weak, nonatomic) IBOutlet UILabel *signWarnLb;
@property (weak, nonatomic) IBOutlet UIImageView *circleImgV;
@property (weak, nonatomic) IBOutlet UIImageView *circleAImgV;
-(void)setData:(NSDictionary *)dataDic;
@end
