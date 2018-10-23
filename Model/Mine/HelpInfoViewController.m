//
//  HelpInfoViewController.m
//  compassionpark
//
//  Created by air on 2017/2/10.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "HelpInfoViewController.h"

@interface HelpInfoViewController ()

@end

@implementation HelpInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.title = @"账户问题";
}

-(id)init
{
    self = [super initWithNibName:@"UserAgreementViewController" bundle:nil];
    return self;
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
