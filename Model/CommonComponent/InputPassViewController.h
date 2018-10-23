//
//  InputPassViewController.h
//  spokesman
//
//  Created by LinFeng on 2016/11/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface InputPassViewController : JYBaseViewController<UIAlertViewDelegate,UITextFieldDelegate>
- (IBAction)forgetPassAction:(UIButton *)sender;
- (IBAction)cancelAction:(UIButton *)sender;
- (IBAction)checkPassAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@property (weak, nonatomic) IBOutlet MyPwdTextField *textFeild;

+(InputPassViewController *)createLimitVC;
@end
