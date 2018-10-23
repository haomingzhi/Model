//
//  VIPTipViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/27.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "VIPTipViewController.h"

@interface VIPTipViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *containerView;
@property (strong, nonatomic) IBOutlet UIButton *aBtn;
@property (strong, nonatomic) IBOutlet UIButton *bBtn;
@property (strong, nonatomic) IBOutlet UIButton *cBtn;
@property (strong, nonatomic) IBOutlet UIButton *dBtn;
@property (strong, nonatomic) IBOutlet UIButton *eBtn;
@property (strong, nonatomic) IBOutlet UIButton *fBtn;
@property (strong, nonatomic) IBOutlet UIPageControl *pageCl;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;

@end

@implementation VIPTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
}

-(void)fitMode
{
     self.view.backgroundColor = [UIColor clearColor];
     [self.view addSubview:_pageCl];
     self.view.width = __SCREEN_SIZE.width;
     self.view.height = __SCREEN_SIZE.height;
     _containerView.layer.cornerRadius = 8;
     _containerView.layer.masksToBounds = YES;
     _containerView.width = 211;
     _containerView.height = 222;
     _containerView.y = 212;
     _containerView.x = __SCREEN_SIZE.width/2.0 - _containerView.width/2.0;
     _containerView.delegate = self;
     _pageCl.x = __SCREEN_SIZE.width/2.0 - _pageCl.width/2.0;
     _pageCl.y = _containerView.y + 186;
     _pageCl.pageIndicatorTintColor = kUIColorFromRGB(color_0xb0b0b0);
     _pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_3);
     _containerView.backgroundColor = kUIColorFromRGB(color_2);
     [self.view addSubview:_closeBtn];
     _closeBtn.width = 25;
     _closeBtn.height = 25;
     [_closeBtn setImage:[UIImage imageContentWithFileName:@"nav_close"] forState:UIControlStateNormal];
     _closeBtn.y = _containerView.y + 5;
     _closeBtn.x = _containerView.x + _containerView.width - _closeBtn.width - 5;
    [_closeBtn setTitle:@"" forState:UIControlStateNormal];
    
     [self setFitBtnMode:_aBtn withImg:@"tip_freeCarr" withTitle:@"满免运费" withDetail:@"会员购买商品对比金额达到标准 会员购买商品对比金额达到标准"];
     [self setFitBtnMode:_bBtn withImg:@"tip_sign" withTitle:@"签到奖励" withDetail:@"会员购买商品对比金额达到标准 会员购买商品对比金额达到标准"];

     [self setFitBtnMode:_cBtn withImg:@"tip_eva" withTitle:@"评价奖励" withDetail:@"会员购买商品对比金额达到标准 会员购买商品对比金额达到标准"];

     [self setFitBtnMode:_dBtn withImg:@"tip_act" withTitle:@"专享活动" withDetail:@"会员购买商品对比金额达到标准 会员购买商品对比金额达到标准"];

     [self setFitBtnMode:_eBtn withImg:@"tip_rightPrice" withTitle:@"会员特价" withDetail:@"会员购买商品对比金额达到标准 会员购买商品对比金额达到标准"];
 [self setFitBtnMode:_fBtn withImg:@"tip_birthday" withTitle:@"生日礼物" withDetail:@"会员购买商品对比金额达到标准 会员购买商品对比金额达到标准"];
     
     _bBtn.x = _aBtn.x + _aBtn.width;
         _cBtn.x = _bBtn.x + _bBtn.width;
         _dBtn.x = _cBtn.x + _cBtn.width;
         _eBtn.x = _dBtn.x + _dBtn.width;
         _fBtn.x = _eBtn.x + _eBtn.width;
     
     _containerView.contentSize = CGSizeMake(_containerView.width * 6, _containerView.height);
}

-(void)setFitBtnMode:(UIButton *)btn withImg:(NSString *)img withTitle:(NSString *)title withDetail:(NSString *)detail
{
     btn.width = _containerView.width;
     btn.height = _containerView.height;
     
     [btn fitImgAndTitleMode];
     
     btn.customImgV.width = 85;
     btn.customImgV.height = 85;
     btn.customImgV.y = 25;
     btn.customImgV.x = btn.width/2.0 - btn.customImgV.width/2.0;
     btn.customImgV.image = [UIImage imageContentWithFileName:img];
     
     btn.customTitleLb.width = btn.width;
     btn.customTitleLb.height = 15;
     btn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     btn.customTitleLb.font = [UIFont systemFontOfSize:15];
     btn.customTitleLb.y = 119;
     btn.customTitleLb.text = title;
     
     
     btn.customDetailLb.width = btn.width - 44;;
     btn.customDetailLb.height = 30;
     btn.customDetailLb.textColor = kUIColorFromRGB(color_5);
     btn.customDetailLb.font = [UIFont systemFontOfSize:12];
     btn.customDetailLb.y = btn.customTitleLb.y + btn.customTitleLb.height + 14;
     btn.customDetailLb.x = 22;
     btn.customDetailLb.text = detail;
     btn.customDetailLb.numberOfLines = 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


static VIPTipViewController *rrvc;
+(VIPTipViewController *)toVC:(UIViewController *)parentVC;
{
     VIPTipViewController *  rrvc = [[VIPTipViewController alloc] initWithNibName:@"VIPTipViewController" bundle:nil];
     rrvc.view.height = __SCREEN_SIZE.height;
     rrvc.view.width = __SCREEN_SIZE.width;

     MyDialog *myDialog = [[MyDialog alloc] initWithViewController:rrvc];

     
     [myDialog show];
     [rrvc fitMode];
     //    myDialog.dismissOnTouchOutside = YES;
     //    myDialog.isDownAnimate = YES;
     return rrvc;
     
}
- (IBAction)closeHandle:(id)sender {
    [self.parentDialog cancel];
}
-(void)selectIndex:(NSInteger)index
{
  _pageCl.currentPage = index;
     _containerView.contentOffset = CGPointMake(_containerView.width * index, 0);
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
   NSInteger index = scrollView.contentOffset.x/_containerView.width;
     _pageCl.currentPage = index;
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
