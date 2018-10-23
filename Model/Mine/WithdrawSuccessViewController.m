//
//  WithdrawSuccessViewController.m
//  compassionpark
//
//  Created by air on 2017/2/9.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "WithdrawSuccessViewController.h"

@interface WithdrawSuccessViewController ()
@property (strong, nonatomic) IBOutlet UILabel *detailLb;
@property (strong, nonatomic) IBOutlet UILabel *tipLb;
@property (strong, nonatomic) IBOutlet UIButton *sureBtn;
@end

@implementation WithdrawSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"提现申请成功";
    [self fitMode];
}

-(void)handleReturnBack:(id)sender
{
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}

-(void)fitMode
{
    [self setNavigateLeftView:nil view1:nil];
    _imgV.y = 115;
     _detailLb.font = [UIFont systemFontOfSize:16];
    _detailLb.text = [NSString stringWithFormat:@"你已申请提现%@元",_userInfo[@"money"]];
    [_detailLb sizeToFit];
    _detailLb.textColor = kUIColorFromRGB(color_mainTheme);
   
    _detailLb.x = __SCREEN_SIZE.width/2.0 - _detailLb.width/2.0;
    _detailLb.y = _imgV.y + _imgV.height + 15;
     _tipLb.font = [UIFont systemFontOfSize:13];
    [_tipLb sizeToFit];
    _tipLb.x = __SCREEN_SIZE.width/2.0 - _tipLb.width/2.0;
    _tipLb.y = _detailLb.y + _detailLb.height + 10;
    _sureBtn.x = 30;
    _sureBtn.y = _tipLb.y + _tipLb.height + 40;
    _sureBtn.width = __SCREEN_SIZE.width - 60;
    _sureBtn.height = 40;
    _sureBtn.backgroundColor = kUIColorFromRGB(color_mainTheme);
    [_sureBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    _sureBtn.layer.cornerRadius = 4;
    _sureBtn.layer.masksToBounds = YES;
    self.view.backgroundColor = kUIColorFromRGB(color_4);
}

- (IBAction)sureBtnHandle:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
