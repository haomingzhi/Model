//
//  ReceiverAddressViewController.m
//  JiXie
//  收件地址维护
//  Created by ORANLLC_IOS1 on 15/5/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ReceiverAddressViewController.h"
#import "BUSystem.h"
//#import "AreaPickerView.h"

@interface ReceiverAddressViewController ()<UITextFieldDelegate>

@end

@implementation ReceiverAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址";
    [self setNavigateRightButton:@"完成" font: FontWithBody(FONTS_H4) color:[UIColor whiteColor]];
//    [self showDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [BSUtility loopView:self.view condition:^BOOL(UIView *v) {
        return [v isKindOfClass:[MyInputView class]];
    } finded:^BOOL(UIView *findedView) {
        MyInputView *inputView = (MyInputView *)findedView;
        inputView.font = FontWithBody(FONTS_H4);
        //输入框变大
        CGRect rect = inputView.frame;
        rect.size.height = 36;
        inputView.frame = rect;
        //设置图标
        NSInteger inputTag = inputView.tag;
        [inputView initInputView:UITextBorderStyleRoundedRect];
        inputView.delegate = self;
        return NO;
    }];
}


-(void) handleDidRightButton:(id)sender
{
    if (![self.view emptyCheck]) {
        return;
    }
    if (self.inputViewdorder_mobile.text.length != 11) {
        TOASTSHOWUNDERVIEW(@"车辆接收人手机号必须为11位", self.inputViewdorder_mobile, CGPointMake(0,10));
        return ;
    }
    HUDSHOW(@"正在提交数据，请稍等...");
//    [busiSystem.agent updateReceive:self.inputVieworder_receiver.text phone:self.inputViewdorder_mobile.text address:self.inputVieworder_address.text addressDetail:self.inputVieworder_detailaddress.text observer:self callback:@selector(updateReceiveNotification:)];
}


- (IBAction)handleTextFieldReturn:(id)sender {
    UIView *v = (UIView *)sender;
    NSInteger tag = v.tag;
    UIView *nextView = [v.superview viewWithTag:tag +1];
    if (nextView != NULL) {
        [nextView becomeFirstResponder];
    }
    else [v resignFirstResponder];
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BASEVERIFY;
    if (textField == self.inputViewdorder_mobile) {
        MOBILEVERFY;
    }
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    if (textField != self.inputVieworder_address) {
        return YES;
    }
    [self.inputVieworder_receiver resignFirstResponder];
    [self.inputViewdorder_mobile resignFirstResponder];
    [self.inputVieworder_detailaddress resignFirstResponder];
    
//    AreaPickerView *vc = [[AreaPickerView alloc]initWithStyle:AreaPickerWithProvince|AreaPickerWithCity|AreaPickerWithCounty];
//    MyDialog *dlg = [[MyDialog alloc] initWithViewController:vc];
//    dlg.dismissOnTouchOutside = YES;
//    dlg.mydelegate = self;  //处理对话框取消后的问题。。
//    [dlg show];
    return NO;
}



-(void) dismissBy:(MyDialog*)dialog withViewController:(UIViewController*)vc isCanceled:(BOOL)isCanceled
{
    [self.inputVieworder_receiver resignFirstResponder];
    [self.inputVieworder_address resignFirstResponder];
    [self.inputViewdorder_mobile resignFirstResponder];
    [self.inputVieworder_detailaddress resignFirstResponder];
    if (isCanceled) {
        return;
    }
//    AreaPickerView *pvc = (AreaPickerView *)vc;
//    self.inputVieworder_address.text = pvc.labelSelected.text;
}

-(void) updateReceiveNotification:(BSNotification *) noti
{
//    BASENOTIFICATION(noti);
//    BUAgent *agent = busiSystem.agent;
//    agent.order_receiver = self.inputVieworder_receiver.text;
//    agent.order_mobile = self.inputViewdorder_mobile.text;
//    agent.order_address = self.inputVieworder_address.text;
//    agent.order_detailaddress = self.inputVieworder_detailaddress.text;
//    if (_doneCallBack) {
//        _doneCallBack();
//    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) showDetail
{
    BUAgent *agent = busiSystem.agent;
    [self.view autoFill:agent];
}
@end
