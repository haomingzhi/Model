//
//  MyActionViewController.m
//  compassionpark
//
//  Created by Steve on 2017/3/2.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "MyActionViewController.h"

@interface MyActionViewController ()

@end

@implementation MyActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self fitMode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)fitMode{
    self.view.backgroundColor = kUIColorFromRGB(color_9);
    self.view.width = __SCREEN_SIZE.width;
    
    _titleOneBtn.backgroundColor = kUIColorFromRGB(color_4);
    _titleTwoBtn.backgroundColor = kUIColorFromRGB(color_4);
    _cancelBtn.backgroundColor = kUIColorFromRGB(color_4);
    
    [_titleOneBtn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
    [_titleTwoBtn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
    
    UIImageView *lineImv =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, __SCREEN_SIZE.width, 0.5)];
    lineImv.backgroundColor =kUIColorFromRGB(color_3);
    [self.view addSubview:lineImv];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)titleOneAction:(UIButton *)sender {
    if (self.handleGoBack) {
        self.handleGoBack(@"1");
        [self.parentDialog dismiss];
    }
}

- (IBAction)titleTwoAction:(UIButton *)sender {
    if (self.handleGoBack) {
        self.handleGoBack(@"2");
        [self.parentDialog dismiss];
    }
}
- (IBAction)canCelAction:(UIButton *)sender {
    [self.parentDialog dismiss];
}

-(void)setData:(NSDictionary *)dic{
    [_titleOneBtn setTitle:dic[@"titleOne"] forState:UIControlStateNormal];
    [_titleTwoBtn setTitle:dic[@"titleTwo"] forState:UIControlStateNormal];
}

+(MyActionViewController *)createLimitVC
{
    
    
    MyActionViewController *dealvc = [MyActionViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];

    //    dealvc.view.width = 300;
    //    dealvc.view.y = __SCREEN_SIZE.height - 157;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    //    dealvc.view.layer.cornerRadius = 3;
    //    dealvc.view.layer.masksToBounds = YES;
    //    dealvc.userInfo = dic;
    //    dealvc.p = parentVC;
    //    dealvc.view.alpha = 1.0;
    [myDialog showAtPosition:CGPointMake(0,__SCREEN_SIZE.height -140) animated:YES];
    //    myDialog.dismissOnTouchOutside = YES;
    //    myDialog.isDownAnimate = YES;
    return dealvc;
}
@end
