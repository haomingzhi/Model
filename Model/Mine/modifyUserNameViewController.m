//
//  modifyUserNameViewController.m
//  B2C
//
//  Created by ORANLLC_IOS1 on 15/7/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "modifyUserNameViewController.h"
#import "BUSystem.h"

@interface modifyUserNameViewController ()<MyTextFieldDelegate>

@end

@implementation modifyUserNameViewController
{
    MyTextField *textField;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户名";
    self.view.backgroundColor = kUIColorFromRGB(color_0xf5f5f5);
    [self setNavigateRightButton:@"完成" font:FontWithTitle(FONTS_H4) color:[UIColor whiteColor]];

}

-(void) viewWillAppear:(BOOL)animated
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 14, __SCREEN_SIZE.width  , 40)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
    textField = [[MyTextField alloc] initWithFrame:CGRectMake(14, 14, __SCREEN_SIZE.width -20 , 40)];
    textField.borderStyle = UITextBorderStyleNone;
    textField.placeholder = @"用户名";
    textField.kbMovingView = self.view;
    textField.text = busiSystem.agent.Name;
    textField.delegate =self;
    [self.view addSubview:textField];
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    return YES;
    UITextField *tf = (UITextField *)textField;
    NSInteger tfTag = tf.tag;
    if ([string isEqualToString:@"\n" ]|| [string isEqualToString:@""])
        return YES;
    switch (tfTag) {
        case 0:
        {
            BOOL bResult =[BSUtility contextDomainLimit:string ValidDomain:[NSString stringWithFormat:@"%@%@%@",NUMBERS,ALPHA,JGGZW]];
                    if (bResult&&range.location<30) {
                        return TRUE;
                    }else{
                        return FALSE;
                    }
        }
            break;
            //        case 1:
            //        {
            //            BOOL bResult =[BSUtility contextDomainLimit:string ValidDomain:NUMBERS];
            //            //限制只能输入数字
            //            if (bResult&&range.location<6) {
            //                return TRUE;
            //            }else{
            //                return FALSE;
            //            }
            //        }
            //            break;
            
        default:
            break;
    }
    return TRUE;
}

#pragma mark --handle
-(void) handleDidRightButton:(id)sender
{
    if([self.view emptyCheck ])
    {
//        if (textField.text.length>4&&textField.text.length<30) {
//            busiSystem.agent.Name = textField.text;
//            //         [self.navigationController popViewControllerAnimated:YES];
//            //        HUDSHOW(SubmitHintString);
//            [busiSystem.agent changeUserInfoType:1 observer:self callback:@selector(changeUserInfoNotification:)];
//        }
//        else{
//            TOASTSHOW(@"用户名长度不符");
//        }
        BOOL te =NO;
        for(int i=0; i< [textField.text length];i++){
            int a = [textField.text characterAtIndex:i];
            if( a > 0x4e00 && a < 0x9fff)
            {
                te=YES;
            }
        }
        if (te==YES) {
            if (textField.text.length <2||textField.text.length >15)
            {
                TOASTSHOWUNDERVIEW(@"字符长度不符！", textField, CGPointMake(0,10));
                return;
            }
        }
        else
        {
            if (textField.text.length <4||textField.text.length >30)
            {
                TOASTSHOWUNDERVIEW(@"字符长度不符！", textField, CGPointMake(0,10));
                return;
            }
        }
        busiSystem.agent.Name = textField.text;
        [busiSystem.agent changeUserInfoType:1 observer:self callback:@selector(changeUserInfoNotification:)];
//        [busiSystem.agent changeUserInfo:self callback:@selector(changeUserInfoNotification:)];
    }
}


-(void) changeUserInfoNotification:(BSNotification *) noti
{
    BASENOTIFICATION(noti);
    [self.navigationController popViewControllerAnimated:YES];
}
@end
