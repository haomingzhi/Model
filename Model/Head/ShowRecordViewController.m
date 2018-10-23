//
//  ShowRecordViewController.m
//  taihe
//
//  Created by air on 2016/11/29.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ShowRecordViewController.h"

@interface ShowRecordViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imgV;
@property (strong, nonatomic) IBOutlet UILabel *titleLb;

@end

@implementation ShowRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setData:(NSDictionary *)dic
{
    NSArray *a = dic[@"imgs"];
//    _imgV.image = [UIImage imageContentWithFileName:dic[@"img"]];
    _titleLb.text = dic[@"title"];
    _imgV.image = a[0];
    _imgV.animationImages = a;
    _imgV.animationDuration = 0.33;
//    _imgV.animationRepeatCount = 9999;
//    [_imgV startAnimating];
}

-(void)fitMode
{
    self.view.backgroundColor = kUIColorFromRGBWithAlpha(0x000000, 0.5);
    self.view.layer.cornerRadius = 5;
    self.view.layer.masksToBounds = YES;
    self.view.height = 100;
    self.view.width = 150;
    _titleLb.textColor = kUIColorFromRGB(color_2);
}
-(void)stopCustomView
{
  
    [_imgV stopAnimating];
}
-(void)beginCustomView
{
   
    [_imgV startAnimating];
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
