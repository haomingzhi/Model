//
//  PaySuccessViewController.h
//  oranllcshoping
//
//  Created by Steve on 2017/7/27.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface PaySuccessViewController : JYBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *payStyleLb;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLb;
@property (weak, nonatomic) IBOutlet UIButton *showOrderBtn;
- (IBAction)showOrderAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *goHomeBtn;
- (IBAction)goHomeAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *warnLb;
@property (weak, nonatomic) IBOutlet UIImageView *payMoneyImgV;

@property (weak, nonatomic) IBOutlet UIImageView *payStyleImgV;
@property (nonatomic,assign) CGFloat money;
@property (nonatomic,strong) NSString *payStyle;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@property (nonatomic,assign) NSInteger payType;
@property (nonatomic,assign) CGFloat price;
@property (nonatomic,assign)NSInteger mode;

@property (nonatomic,strong) NSString *orderType; // 1-正常订单支付(第一次支付) 2-续租申请，3-买断支付 4-续租 ,

-(void)fitVIPCenterMode;
@end
