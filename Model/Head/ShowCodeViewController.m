//
//  ShowCodeViewController.m
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/15.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ShowCodeViewController.h"

@interface ShowCodeViewController ()
{
     
     NSTimer *_timer;
}
@end

@implementation ShowCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fitCellMode{
     _weekLb.text = _dataDic[@"week"];
     _dateLb.text = _dataDic[@"date"];
     if ([_dataDic[@"hasSign"] boolValue]) {
          [_signBtn setTitle:@"已签到" forState:UIControlStateNormal];
          [_signBtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
     }else{
          [_signBtn setTitle:@"签到" forState:UIControlStateNormal];
          [_signBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     }
     _signBtn.layer.cornerRadius = _signBtn.height/2.0;
     _signBtn.layer.masksToBounds = YES;
     _bgBtn.layer.cornerRadius = 6.0;
     _bgBtn.layer.masksToBounds = YES;
     _bgBtn.userInteractionEnabled = NO;
     
     _img = _dataDic[@"img"];
     if ([_img isKindOfClass:[BUImageRes class]]) {
          BUImageRes *img = _img;
          [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
     }
     else if([_img isKindOfClass:[NSString class]]){
          if ([(NSString *)_img length] == 0) {
               return;
          }
          [_bgBtn setBackgroundImage:[UIImage imageNamed:_img] forState:UIControlStateNormal];
     }
     else if([_img isKindOfClass:[UIImage class]]){
          [_bgBtn setBackgroundImage:_img forState:UIControlStateNormal];
     }
     
//     [self numberCount];
}

-(void)getImgNotification:(BSNotification *)noti
{
     if(noti.error.code ==0)
     {
          BUImageRes *res =(BUImageRes *) noti.target;
          if (res.isCached) {
               [_bgBtn setBackgroundImage:[UIImage imageWithContentsOfFile:res.cacheFile] forState:UIControlStateNormal];
     
               //             self.height = [self heightOfCellWithImg:_imgV.image];
          }
     }
}


static ShowCodeViewController *dealvc;
+(ShowCodeViewController *)toCreateVC:(NSDictionary *)dic
{
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          dealvc = [[ShowCodeViewController alloc] init];
//          dealvc.view.width = __SCREEN_SIZE.width-30;
          dealvc.view.x = __SCREEN_SIZE.width/2.0- dealvc.view.width/2.0;
//          dealvc.view.layer.cornerRadius = 8.0;
//          dealvc.view.layer.masksToBounds = YES;
     });
//
     MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];
     dealvc.view.x = __SCREEN_SIZE.width/2.0 - dealvc.view.width/2.0;
     dealvc.dataDic = dic;
     [dealvc fitCellMode];

     myDialog.mydelegate = dealvc;
     myDialog.bgColor = kUIColorFromRGBWithAlpha(color_12, 0.5);
     myDialog.isDownAnimate = NO;
     [myDialog show];
     //     [myDialog showAtPosition:CGPointMake(15,__SCREEN_SIZE.height/2.0 - dealvc.view.height/2.0) animated:NO];
     myDialog.dismissOnTouchOutside = NO;
//
     
     return dealvc;
     
}

- (IBAction)btnAction:(UIButton *)sender {
     NSLog(@"action");
     [self.parentDialog dismiss];
     if (self.handleGoBack) {
//          [_timer invalidate];
          self.handleGoBack(@{@"index":@"1"});
     }
}
- (IBAction)bgBtnAction:(UIButton *)sender {
     [self.parentDialog dismiss];
     if (self.handleGoBack) {
          //          [_timer invalidate];
          self.handleGoBack(@{@"index":@"3"});
     }
}
- (IBAction)signAction:(UIButton *)sender {
     [self.parentDialog dismiss];
     if (self.handleGoBack) {
          //          [_timer invalidate];
          self.handleGoBack(@{@"index":@"2"});
     }
}
@end
