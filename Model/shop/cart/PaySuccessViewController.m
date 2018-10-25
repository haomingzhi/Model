//
//  PaySuccessViewController.m
//  oranllcshoping
//
//  Created by Steve on 2017/7/27.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "PaySuccessViewController.h"
#import "MyOrderViewController.h"
//#import "BuyOutServerViewController.h"
//#import "ReletServerViewController.h"

@interface PaySuccessViewController ()

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"支付成功";
//     [self setNavigateLeftButton:@"" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_3)];
     [self setNavigateLeftView:nil view1:nil];
     [self fitMode];
}

-(void)viewWillAppear:(BOOL)animated
{
     self.panGesture.enabled = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
     self.panGesture.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleReturnBack:(id)sender{
     
}

-(void)fitMode{
     self.view.width = __SCREEN_SIZE.width;
     self.view.backgroundColor = kUIColorFromRGB(color_common_bg);
     _imgV.x = __SCREEN_SIZE.width/2.0 - _imgV.width/2.0;
     
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width -30;
     
     _showOrderBtn.x = (__SCREEN_SIZE.width -210)/2.0;
     _goHomeBtn.x= _showOrderBtn.x + _showOrderBtn.width +40;
     
     _showOrderBtn.layer.cornerRadius = 6.0;
     _showOrderBtn.layer.masksToBounds = YES;
     _goHomeBtn.layer.cornerRadius = 6.0;
     _goHomeBtn.layer.masksToBounds = YES;
     
     _showOrderBtn.backgroundColor = kUIColorFromRGB(color_2);
     _showOrderBtn.layer.borderColor = kUIColorFromRGB(color_0xf82D45).CGColor;
     _showOrderBtn.layer.borderWidth = 0.5;
     [_showOrderBtn setTitleColor:kUIColorFromRGB(color_0xf82D45) forState:UIControlStateNormal];
     
     _goHomeBtn.backgroundColor = kUIColorFromRGB(color_0xf82D45) ;
     
     _payStyleImgV.x= _showOrderBtn.x +25;
     _payStyleLb.x = _payStyleImgV.x + _payStyleImgV.width +15;
     
     _payMoneyImgV.x = _payStyleImgV.x;
     _payMoneyLb.x = _payStyleLb.x;
     
     if (_payType == 1) {
          _payStyleLb.text = @"支付方式 支付宝支付";
     }else if (_payType == 2){
          _payStyleLb.text = @"支付方式 微信支付";
     }else if (_payType == 3){
          _payStyleLb.text = @"支付方式 积分支付";
     }
     _payStyleLb.textColor  = kUIColorFromRGB(color_0xf82D45);
//     NSMutableAttributedString *str =  [[NSMutableAttributedString alloc] initWithString:_payStyleLb.text];
//     NSRange range = [_payStyleLb.text rangeOfString:@"支付方式"];
//     //设置文字颜色
//     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_1) range:range];
//     _payStyleLb.attributedText = str;
     _payStyleLb.attributedText = [_payStyleLb richText:@"支付方式" color:kUIColorFromRGB(color_0xb0b0b0)];
     
     
     _payMoneyLb.text = [NSString stringWithFormat:@"支付金额 ¥%.2f",_price];
     
     _payMoneyLb.textColor  = kUIColorFromRGB(color_0xf82D45);
     _payMoneyLb.attributedText = [_payMoneyLb richText:@"支付金额" color:kUIColorFromRGB(color_0xb0b0b0)];
//     NSMutableAttributedString *str1 =  [[NSMutableAttributedString alloc] initWithString:_payMoneyLb.text];
//     NSRange range1 = [_payMoneyLb.text rangeOfString:@"支付金额"];
//     //设置文字颜色
//     [str1 addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_1) range:range1];
//     _payMoneyLb.attributedText = str1;
     
     
//     _warnLb.text = @"温馨提示：\n平台不会以订单异常、系统升级为由要求您点击任何网 址链接进行退款操作。";
//     _warnLb.width = __SCREEN_SIZE.width - 30;
//     [_warnLb sizeToFit];
     _warnLb.hidden = YES;
     
     if (_mode == 1) {
          [self fitVIPCenterMode];
     }
}
-(void)fitVIPCenterMode
{
     _payStyleLb.width = 130;
     _goHomeBtn.width = 116;
     _goHomeBtn.x = __SCREEN_SIZE.width/2.0 - _goHomeBtn.width/2.0;
     _showOrderBtn.hidden = YES;
     _warnLb.text = @"";
     [self setNavigateLeftButton:nil];
}


-(IBAction)showOrderAction:(UIButton *)sender{
//     [self.navigationController popToRootViewControllerAnimated:YES];
//     self.tabBarController.tabBarController.selectedIndex = 4;
     if ([_orderType isEqualToString:@"2"]) {//续租
//          ReletServerViewController *vc = [ReletServerViewController new];
//          vc.hidesBottomBarWhenPushed = YES;
//          [self.navigationController pushViewController:vc animated:YES];
     }
     else if ([_orderType isEqualToString:@"3"]){//买断
//          BuyOutServerViewController *vc = [BuyOutServerViewController new];
//          vc.hidesBottomBarWhenPushed = YES;
//          [self.navigationController pushViewController:vc animated:YES];
     }else{
          MyOrderViewController *vc = [MyOrderViewController new];
          vc.hidesBottomBarWhenPushed = YES;
          [self.navigationController pushViewController:vc animated:YES];
     }
     
     
}

- (IBAction)goHomeAction:(UIButton *)sender {
     self.tabBarController.selectedIndex = 0;
     [self.navigationController popToRootViewControllerAnimated:YES];
     
}
@end
