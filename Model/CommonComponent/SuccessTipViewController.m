//
//  SuccessTipViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/9.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SuccessTipViewController.h"

@interface SuccessTipViewController ()
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) IBOutlet UILabel *titleLb;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;
@property (strong, nonatomic) IBOutlet UIImageView *imgV;
@property (strong, nonatomic) IBOutlet UILabel *detailLb;
@property (strong, nonatomic) IBOutlet UILabel *contentLb;

@end

@implementation SuccessTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)fitMode
{
     self.view.width =__SCREEN_SIZE.width;
     self.view.height = __SCREEN_SIZE.height - 64;
     self.view.backgroundColor = [UIColor clearColor];
     _containerView.width = 211;
     _containerView.height = 252;
     _containerView.y = 220;
     _containerView.x = __SCREEN_SIZE.width/2.0 - _containerView.width/2.0;
     _titleView.backgroundColor = kUIColorFromRGB(color_3);
     _titleView.height = 60;
     _titleView.width = 211;
     _titleLb.text = @"领取成功";
     _titleLb.height = 15;
     _titleLb.width = 211;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.x = 0;
     _titleLb.y = 23;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_2);
     
     _closeBtn.width = 34;
     _closeBtn.height = 34;
     _closeBtn.x = _containerView.width - _closeBtn.width;
     _closeBtn.y = 0;
     [_closeBtn setImage:[UIImage imageContentWithFileName:@"tip_close"] forState:UIControlStateNormal];
     
     _imgV.width = 50;
     _imgV.height = 50;
     _imgV.y = _titleView.y + _titleView.height + 29;
     _imgV.x = _containerView.width/2.0 - _imgV.width/2.0;
     _imgV.image = [UIImage imageContentWithFileName:@"tip_check"];
     
     _detailLb.width = 200;
     _detailLb.height = 15;
     _detailLb.font = [UIFont systemFontOfSize:15];
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.x = _containerView.width/2.0 - _detailLb.width/2.0;
     _detailLb.textAlignment = NSTextAlignmentCenter;
     _detailLb.y = _imgV.y + _imgV.height + 25;
     _detailLb.text = @"新手奖励领取成功";
     
     _contentLb.width = 200;
     _contentLb.height = 13;
     _contentLb.font = [UIFont systemFontOfSize:13];
     _contentLb.textColor = kUIColorFromRGB(color_3);
     _contentLb.textAlignment = NSTextAlignmentCenter;
     _contentLb.x = _containerView.width/2.0 - _contentLb.width/2.0;
     _contentLb.y = _detailLb.y + _detailLb.height + 14;
     _contentLb.text = @"过得充值+10 获得优币+5";
     _contentLb.attributedText = [_contentLb richText:@"过得充值" color:kUIColorFromRGB(color_5)];
     [_contentLb richMText:@"获得优币" color:kUIColorFromRGB(color_5) withFont:_contentLb.font];
    // _contentLb.attributedText = [_contentLb richText:@"获得优币" color:kUIColorFromRGB(color_5)];
     
     _containerView.layer.cornerRadius = 6;
     _containerView.layer.masksToBounds = YES;
}

-(void)fitSignMode:(NSDictionary *)dic
{
     
     NSInteger count = [dic[@"toIndex"] integerValue];
     _titleLb.text = @"签到成功";
     
         _detailLb.y = _titleView.y + _titleView.height + 15;
         _detailLb.text = [NSString stringWithFormat:@"已连续签到 %ld 天",count];
     _detailLb.font = [UIFont systemFontOfSize:18];
     _detailLb.textColor = kUIColorFromRGB(color_3);
     [_detailLb richMText:@"已连续签到" color:kUIColorFromRGB(color_5) withFont:[UIFont systemFontOfSize:14]];
        [_detailLb richMText:@"天" color:kUIColorFromRGB(color_5) withFont:[UIFont systemFontOfSize:14]];
     
     _imgV.width = 53;
     _imgV.height = 50;
     _imgV.y = _detailLb.y + _detailLb.height + 25;
     _imgV.x = _containerView.width/2.0 - _imgV.width/2.0;
     _imgV.image = [UIImage imageContentWithFileName:@"tipSign"];
     
          _contentLb.y = _imgV.y + _imgV.height + 26;
       _contentLb.text = @"获得成长值 +10 获得优币 +10";
     _contentLb.attributedText = [_contentLb richText:@"获得成长值" color:kUIColorFromRGB(color_0xb0b0b0)];
     [_contentLb richMText:@"获得优币" color:kUIColorFromRGB(color_0xb0b0b0) withFont:_contentLb.font];

     UILabel *lb = [_containerView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 200;
          lb.height = 13;
          lb.tag = 12113;
     }
     lb.textAlignment = NSTextAlignmentCenter;
     lb.text = [NSString stringWithFormat:@"再签到%ld天可获得额外奖励哦!",8 - count];
     lb.textColor = kUIColorFromRGB(color_3);
     lb.font =  [UIFont systemFontOfSize:13];
     lb.x = _containerView.width/2.0 - lb.width/2.0;
     lb.y = 4 + _contentLb.y + _contentLb.height;
     [_containerView addSubview:lb];
     [lb richMText:@"再签到" color:kUIColorFromRGB(color_5) withFont:[UIFont systemFontOfSize:13]];
[lb richMText:@"天可获得额外奖励哦!" color:kUIColorFromRGB(color_5) withFont:[UIFont systemFontOfSize:13]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeHandle:(id)sender {
    [self.parentDialog cancel];
}
static SuccessTipViewController *rrvc;
+(SuccessTipViewController *)toVC:(UIViewController *)parentVC
{
     SuccessTipViewController *  rrvc = [[SuccessTipViewController alloc] initWithNibName:@"SuccessTipViewController" bundle:nil];
     rrvc.view.height = __SCREEN_SIZE.height;
     rrvc.view.width = __SCREEN_SIZE.width;
     
     MyDialog *myDialog = [[MyDialog alloc] initWithViewController:rrvc];
     
     
     [myDialog show];
     [rrvc fitMode];
     //    myDialog.dismissOnTouchOutside = YES;
     //    myDialog.isDownAnimate = YES;
     return rrvc;
     
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
