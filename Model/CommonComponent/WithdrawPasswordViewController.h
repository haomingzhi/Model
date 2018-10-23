//
//  WithdrawPasswordViewController.h
//  compassionpark
//
//  Created by air on 2017/4/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "DealPasswordViewController.h"

@interface WithdrawPasswordViewController : DealPasswordViewController
@property(nonatomic,copy)void (^cancelCallBack)(id);
+(WithdrawPasswordViewController *)toWithdrawVC:(UIViewController *)parentVC;
@end
