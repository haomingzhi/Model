//
//  TextFieldTableViewCell.h
//  ulife
//
//  Created by air on 15/12/23.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface TextFieldTableViewCell : JYAbstractTableViewCell
@property (strong, nonatomic) IBOutlet MyTextField *textTf;
-(UIButton *)getCodeBtn;
-(void)fitMode;
-(void)fitModeB;
-(void)fitModeC:(NSString *)leftTitle;
-(void)fitModeD:(NSString *)leftTitle;
-(void)fitModeE:(id)obj withSel:(SEL)sel;
//-(void)fitPublishMode;
-(void)fitRegMode;
-(void)fitRegNextMode;
-(void)fitForgetPwdNextMode;
-(void)fitForgetPwdNextModeB;
-(void)fitForgetPwdNextMode:(NSString *)img;
-(void)fitRegMode:(NSString*)img;
-(void)fitMeetingMode;
-(void)fitRentHouseMode;
-(void)fitCerMode;
-(void)fitPublishActMode;
-(void)fitEidtNickNameMode;
-(void)fitForgetPwdNextModeB:(NSString*)imgName;
-(void)fitModeF:(id)obj withSel:(SEL)sel;
-(void)fitModiPwdMode:(NSString*)text;
-(void)fitFeedbackMode;
-(void)fitForgetPwdNextModeB:(id)obj withSel:(SEL)sel;
-(void)fitApplyReturnMode;
-(void)fitApplyReturnModeB:(NSString *)leftTitle;
-(void)fitForgetPwdNextModeA:(UIImage *)img;
-(void)fitRegModeWithTagName:(NSString*)str;
-(void)fitPublishSecHandMode;
-(void)fitPublishSecHandModeB;
-(void)fitPublishSecHandModeC;
-(void)fitZhiMaAuthMode;
@end
