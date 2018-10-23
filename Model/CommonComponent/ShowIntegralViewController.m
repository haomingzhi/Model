//
//  ShowIntegralViewController.m
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/18.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ShowIntegralViewController.h"

@interface ShowIntegralViewController ()

@end

@implementation ShowIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static ShowIntegralViewController *dealvc;
+(ShowIntegralViewController *)toShowIntrgral:(NSString *)title withIntegral:(NSString *)integral
{
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          dealvc = [[ShowIntegralViewController alloc] init];
          //          dealvc.view.width = __SCREEN_SIZE.width-30;
          dealvc.view.x = __SCREEN_SIZE.width/2.0- dealvc.view.width/2.0;
          //          dealvc.view.layer.cornerRadius = 8.0;
          //          dealvc.view.layer.masksToBounds = YES;
     });
     //
     MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];
     dealvc.view.x = __SCREEN_SIZE.width/2.0 - dealvc.view.width/2.0;
     myDialog.mydelegate = dealvc;
     dealvc.titleLb.text = title;
     dealvc.integralLb.text = integral;

     myDialog.bgColor = kUIColorFromRGBWithAlpha(color_12, 0.5);
     myDialog.isDownAnimate = NO;
     [myDialog show];
     //     [myDialog showAtPosition:CGPointMake(15,__SCREEN_SIZE.height/2.0 - dealvc.view.height/2.0) animated:NO];
     myDialog.dismissOnTouchOutside = NO;
     //
     
     return dealvc;
     
}

- (IBAction)btnAction:(UIButton *)sender {
     [self.parentDialog dismiss];
}
@end
