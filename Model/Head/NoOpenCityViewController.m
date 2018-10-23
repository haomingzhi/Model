//
//  NoOpenCityViewController.m
//  compassionpark
//
//  Created by Steve on 2017/3/31.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "NoOpenCityViewController.h"
#import "JYNoDataManager.h"

@interface NoOpenCityViewController ()

@end

@implementation NoOpenCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kUIColorFromRGB(color_4);
    [[JYNoDataManager manager] addNodataView:self.view withTip:@"抱歉，该城市暂未开通服务" withImg:@"icon_noData@2x" withCount:0 withTag:[NSString stringWithFormat:@"myac%d",0]];
    [[JYNoDataManager manager] fitModeY:55];
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
