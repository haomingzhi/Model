//
//  SignCouponView.h
//  rentingshop
//
//  Created by Steve on 2018/3/22.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignCouponView : UIView

@property (weak, nonatomic) IBOutlet UILabel *detailLb;
@property (weak, nonatomic) IBOutlet UILabel *stateLb;
@property (weak, nonatomic) IBOutlet UIImageView *lineImgV;
@property (weak, nonatomic) IBOutlet UIImageView *stateImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
-(void)setCellData:(NSDictionary *)dataDic;
@end
