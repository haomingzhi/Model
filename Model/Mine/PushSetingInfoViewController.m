//
//  PushSetingInfoViewController.m
//  taihe
//
//  Created by air on 2016/11/24.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "PushSetingInfoViewController.h"
#import "TitleDetailTableViewCell.h"
@interface PushSetingInfoViewController ()

@end

@implementation PushSetingInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title =  @"推送消息设置";
    self.view.backgroundColor = kUIColorFromRGB(color_9);
    TitleDetailTableViewCell *tCell = [TitleDetailTableViewCell createTableViewCell];
   
    [tCell setCellData:@{@"title":@"消息推送",@"detail":@"如果你项开启或关闭消息推送，请在iPhone的\"设置-通知中心\"里，找到“孝笑陶坊商城”进行修改。"}];
    [tCell fitPushSetingMode];
//    [tCell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.view addSubview:tCell];
     tCell.width = __SCREEN_SIZE.width;
//    tCell.backgroundColor = kUIColorFromRGB(color_4);
    
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
