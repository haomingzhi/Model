//
//  JYNewPersonViewController.m
//  ulife
//
//  Created by air on 16/1/19.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "JYNewPersonViewController.h"

@interface JYNewPersonViewController ()

@end

@implementation JYNewPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigateLeftButton:@"nav_back"];
//    self.navigationController.navigationBar
}
-(void) setNavigateLeftButton:(NSString *)imgName
{
    //建立一个自己的返回视图。。
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 29, 29);
    
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(handleReturnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

-(void)handleReturnBack
{
    [self.navigationController popViewControllerAnimated:YES];
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
