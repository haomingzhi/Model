//
//  PinpaiView.h
//  oranllcshoping
//
//  Created by air on 2017/7/19.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinpaiView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *imgV;
@property (strong, nonatomic) IBOutlet UILabel *titleLb;
@property (strong, nonatomic) IBOutlet UILabel *detailLb;
@property (strong, nonatomic) IBOutlet UILabel *markLb;
@property (strong, nonatomic) IBOutlet UIImageView *markImgV;
@property(nonatomic,strong) void (^handleAction)(id sender);
-(void)fitPinpaiMode;
@end
