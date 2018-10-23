//
//  InputPassViewController.m
//  spokesman
//
//  Created by LinFeng on 2016/11/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "InputPassViewController.h"

@interface InputPassViewController (){
    NSInteger _requestCount;
}

@end

@implementation InputPassViewController

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
    self.view.height = 166;
    self.view.width = 300;
    self.view.layer.cornerRadius = 6.0;
    self.view.layer.masksToBounds = YES;
    self.view.backgroundColor = kUIColorFromRGB(color_4);
    
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 121, 300, 0.5)];
    [line setBackgroundColor:kUIColorFromRGB(color_3)];
    [self.view addSubview:line];
    
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(150, 121, 0.5, 45)];
    [line1 setBackgroundColor:kUIColorFromRGB(color_3)];
    [self.view addSubview:line1];
    
    
    _textFeild.isShowBorder = YES;
    _textFeild.borderColor = kUIColorFromRGB(color_5);
    _textFeild.borderWidth = 0.5;
    _textFeild.layer.cornerRadius = 6.0;
    _textFeild.layer.masksToBounds = YES;
    _textFeild.clearButtonMode = UITextFieldViewModeNever;
    _textFeild.delegate = self;
    _textFeild.tintColor = [UIColor clearColor];
    _textFeild.width = 40*6;
    _textFeild.height = 40;
    _textFeild.x = self.view.width/2.0 - _textFeild.width/2.0;
    [_textFeild setBackgroundColor:kUIColorFromRGB(color_4)];
    [_textFeild addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    [_textFeild becomeFirstResponder];
    
    
}

-(void)changeValue:(UITextField*)txtTf
{
    
    if (txtTf.text.length == 6) {
        [self.view endEditing:YES];
        [self.view becomeFirstResponder];
    }
    if (txtTf.text.length > 6) {
        txtTf.text = [txtTf.text substringToIndex:6];
//        TOASTSHOW(@"密码")
    }
}



+(InputPassViewController *)createLimitVC
{
    
    
    InputPassViewController *dealvc = [InputPassViewController new];
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
    [myDialog show];
    //    myDialog.dismissOnTouchOutside = YES;
    //    myDialog.isDownAnimate = YES;
    return dealvc;
}


- (IBAction)forgetPassAction:(UIButton *)sender {
    if (self.handleGoBack) {
        [self.parentDialog dismiss];
        self.handleGoBack(@{@"tag":@1});
    }
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self.parentDialog dismiss];
}

- (IBAction)checkPassAction:(UIButton *)sender {
    [self validatePwd];
    
}

-(void)validatePwd{
    if (_textFeild.text.length !=6) {
        //        TOASTSHOWUNDERVIEW(@"请输入6位数字", self.secondPwdTF, CGPointMake(0,10));
        TOASTSHOW(@"请输入6位数字");
        return;
    }
    
    if (self.handleGoBack) {
        [self.parentDialog dismiss];
        self.handleGoBack(@{@"tag":@2,@"pass":_textFeild.text});
    }
    
    /*
    HUDSHOW(@"提交中");
    _requestCount++;
    [busiSystem.passSetingManager validatePwd:_textFeild.text observer:self callback:@selector(validatePwdNotification:)];
     */
}
/*
-(void)validatePwdNotification:(BSNotification *)noti{
    _requestCount--;
    if (_requestCount == 0) {
        BASENOTIFICATION(noti);
    }
    else
    {
        BASENOTIFICATIONWITHCANMISS(noti, NO);
    }
    if (busiSystem.passSetingManager.flag == 2) {
        if (self.handleGoBack) {
            [self.parentDialog dismiss];
            self.handleGoBack(@{@"tag":@2});
        }
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提现密码错误,请重试" message:@"" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:@"忘记密码", nil];
        alert.tag = 2;
        [alert show];
    }
    
}
*/
 
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        _textFeild.text = @"";
    }
    
    if (buttonIndex == 1) {
        if (self.handleGoBack) {
            [self.parentDialog dismiss];
            self.handleGoBack(@{@"tag":@1});
        }
    }
}

@end
