//
//  PwdTableViewCell.m
//  compassionpark
//
//  Created by air on 2017/2/3.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "PwdTableViewCell.h"

@implementation PwdTableViewCell
{

    IBOutlet MyPwdTextField *_pwdTf;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _pwdTf.isShowBorder = YES;
    _pwdTf.borderColor = kUIColorFromRGB(color_5);
    _pwdTf.borderWidth = 0.5;
    _pwdTf.layer.cornerRadius = 4;
    _pwdTf.clearButtonMode = UITextFieldViewModeNever;
       //    _pwdTf.delegate = self;
//    _pwdTf.font = [UIFont systemFontOfSize:40];
    _pwdTf.tintColor = [UIColor clearColor];
}
-(MyPwdTextField *)passwordTf
{
    return _pwdTf;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fitMode
{
    _pwdTf.x = __SCREEN_SIZE.width/2.0 - _pwdTf.width/2.0;
    _pwdTf.keyboardType = UIKeyboardTypeNumberPad;
    _pwdTf.clearButtonMode = UITextFieldViewModeNever;
    self.height = 52;
    _pwdTf.y = 4;
    self.backgroundColor = kUIColorFromRGB(color_9);
     self.contentView.backgroundColor = kUIColorFromRGB(color_9);
    _pwdTf.backgroundColor = kUIColorFromRGB(color_4                                                                                                                                                                                                                                                        );
}
@end
