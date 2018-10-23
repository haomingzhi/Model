//
//  PointRuleViewController.m
//  compassionpark
//
//  Created by air on 2017/2/9.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "PointRuleViewController.h"
#import "BUSystem.h"
@interface PointRuleViewController ()

@end

@implementation PointRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"积分规则";
    self.view.backgroundColor = kUIColorFromRGB(color_4);
     self.textFView.text =  busiSystem.agent.integralConfig.integralExplain?:@"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getData
{

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
