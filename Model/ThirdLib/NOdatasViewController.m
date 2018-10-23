//
//  NOdatasViewController.m
//  ulife
//
//  Created by sunmax on 16/1/27.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "NOdatasViewController.h"

@interface NOdatasViewController ()

@end

@implementation NOdatasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view =[self getUnfoundView];
    [self.view addSubview:view];
    // Do any additional setup after loading the view from its nib.
}

//创建无数据时的界面
-(UIView *) getUnfoundView
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"OrderUnfound" owner:nil options:nil];
    UIView *headView = [nib objectAtIndex:0];
    headView.backgroundColor = kUIColorFromRGB(color_white);
    headView.frame =CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height);
    UILabel *labelUnfound = (UILabel *)[headView viewWithTag:2];
    UIImageView *imgV =(UIImageView *)[headView viewWithTag:1];
    imgV.image =[UIImage imageNamed:@"NOdata"];
    labelUnfound.textColor = kUIColorFromRGB(color_0x999999);
    labelUnfound.text=@"抱歉，该城市暂未开通服务";
    UILabel *goShopping = (UILabel *)[headView viewWithTag:4];
    [goShopping setText:@"" ];
    CGRect frame = headView.frame;
    frame.size.height = self.view.frame.size.height;
    headView.frame = frame;
    return headView;
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
