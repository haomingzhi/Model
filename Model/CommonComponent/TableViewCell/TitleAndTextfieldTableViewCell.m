//
//  TitleAndTextfieldTableViewCell.m
//  spokesman
//
//  Created by LinFeng on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleAndTextfieldTableViewCell.h"
#import "JYCommonTool.h"

@implementation TitleAndTextfieldTableViewCell{
    NSDictionary *_dataDic;
     UITapGestureRecognizer *_tap;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)hiddenTextField{
    _textField.hidden = YES;
    _contentLbl.hidden = YES;
}

-(void)fitCellMode{
    self.height = 40;
    _titleLbl.x = 15;
    _titleLbl.y = 0;
    _titleLbl.textColor = kUIColorFromRGB(color_1);
//    _titleLbl.width = 300;
    _titleLbl.font = [UIFont systemFontOfSize:15];
    [_titleLbl sizeToFit];
    _titleLbl.height = self.height;
    
//    _contentLbl.x = 135;
//    _contentLbl.y = 0;
//    _contentLbl.width = __SCREEN_SIZE.width - 145;
//    _contentLbl.textColor = kUIColorFromRGB(color_6);
    _contentLbl.hidden = YES;
    _textField.x = _titleLbl.x + _titleLbl.width +15;
    _textField.y = 0;
    _textField.width = __SCREEN_SIZE.width - _titleLbl.x - _titleLbl.width -30;
    [_textField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _textField.textColor = kUIColorFromRGB(color_1);
    _textField.delegate = self;
    _textField.height = self.height;
//    _textField.keyboardType = UIKeyboardTypeNumberPad;
//    _textField.clearButtonMode = UITextFieldViewModeNever;
}


-(void)fitFillOrderMode{
     self.height = 45;
     _titleLbl.x = 15;
     _titleLbl.y = 0;
     _titleLbl.textColor = kUIColorFromRGB(color_5);
     _titleLbl.font = [UIFont systemFontOfSize:15];
     [_titleLbl sizeToFit];
     _titleLbl.height = self.height;
     
     //    _contentLbl.x = 135;
     //    _contentLbl.y = 0;
     //    _contentLbl.width = __SCREEN_SIZE.width - 145;
     //    _contentLbl.textColor = kUIColorFromRGB(color_6);
     _contentLbl.hidden = YES;
     _textField.x = _titleLbl.x + _titleLbl.width +15;
     _textField.y = 0;
     _textField.width = __SCREEN_SIZE.width - _titleLbl.x - _titleLbl.width -30;
     [_textField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
     _textField.textColor = kUIColorFromRGB(color_1);
     [_textField setValue:kUIColorFromRGB(color_0xb0b0b0) forKeyPath:@"_placeholderLabel.textColor"];
     _textField.delegate = self;
     _textField.height = self.height;
     _textField.textAlignment = NSTextAlignmentLeft;
     //    _textField.keyboardType = UIKeyboardTypeNumberPad;
     //    _textField.clearButtonMode = UITextFieldViewModeNever;
}


-(void)fitInvoiceMode{
     self.height = 40;
     _titleLbl.x = 15;
     _titleLbl.y = 0;
     _titleLbl.textColor = kUIColorFromRGB(color_1);
     _titleLbl.font = [UIFont systemFontOfSize:14];
     _titleLbl.height = self.height;
     _titleLbl.width = 200;
     
     _contentLbl.hidden = YES;
     
     _textField.x = 117;
     _textField.y = 0;
     _textField.width = __SCREEN_SIZE.width  - _textField.x -15;
     [_textField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
     _textField.textColor = kUIColorFromRGB(color_7);
     [_textField setValue:kUIColorFromRGB(color_7) forKeyPath:@"_placeholderLabel.textColor"];
     _textField.height = self.height;
     _textField.textAlignment = NSTextAlignmentLeft;
}


-(void)fitConfirmOrderMode{
    self.height = 40;
    _titleLbl.x = 15;
    _titleLbl.y = 0;
    _titleLbl.textColor = kUIColorFromRGB(color_1);
    //    _titleLbl.width = 300;
    [_titleLbl sizeToFit];
    _titleLbl.height = self.height;
    
    _contentLbl.text = @"（商品到达自提点会电话联系您）";
    _contentLbl.x = _titleLbl.x + _titleLbl.width;
    _contentLbl.y =0 ;
    _contentLbl.font = [UIFont systemFontOfSize:12];
    _contentLbl.textColor = kUIColorFromRGB(color_8);
    [_contentLbl sizeToFit];
    _contentLbl.height = self.height;
    
    
    _textField.x = _titleLbl.x + _titleLbl.width +15;
    _textField.y = 0;
    _textField.width = __SCREEN_SIZE.width - _titleLbl.x - _titleLbl.width -30;
    [_textField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _textField.textColor = kUIColorFromRGB(color_1);
    _textField.delegate = self;
    _textField.height = self.height;
}

-(void)fitUpPersonInfoMode{
    _titleLbl.x = 15;
    _titleLbl.y = 0;
    _titleLbl.textColor = kUIColorFromRGB(color_1);
    _titleLbl.width = 200;
    //    _contentLbl.x = 135;
    //    _contentLbl.y = 0;
    //    _contentLbl.width = __SCREEN_SIZE.width - 145;
    //    _contentLbl.textColor = kUIColorFromRGB(color_6);
    _contentLbl.hidden = YES;
    _textField.x = 135;
    _textField.y = 7.50;
    _textField.width = __SCREEN_SIZE.width - 150;
    [_textField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _textField.textColor = kUIColorFromRGB(color_7);
    _textField.delegate = self;
    //_textField.keyboardType = UIKeyboardTypeNumberPad;
    //    _textField.clearButtonMode = UITextFieldViewModeNever;
}

-(void)fitUpPersonInfoModeB{
    self.height = 56;
    _titleLbl.x = 15;
    
    _titleLbl.textColor = kUIColorFromRGB(color_1);
    _titleLbl.width = 200;
    _titleLbl.height = 16;
    _titleLbl.y = 10;
    //    _contentLbl.x = 135;
    //    _contentLbl.y = 0;
    //    _contentLbl.width = __SCREEN_SIZE.width - 145;
    //    _contentLbl.textColor = kUIColorFromRGB(color_6);
    _contentLbl.hidden = YES;
    _textField.x = 135;
    _textField.y = self.height/2.0 - _textField.height/2.0;
    _textField.width = __SCREEN_SIZE.width - 170;
    [_textField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _textField.textColor = kUIColorFromRGB(color_7);
    _textField.delegate = self;
    //_textField.keyboardType = UIKeyboardTypeNumberPad;
    //    _textField.clearButtonMode = UITextFieldViewModeNever;
    
    UIImageView *imgv = [self.contentView viewWithTag:973];
    if (!imgv) {
        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 17)];
        imgv.tag = 973;
        
        imgv.y = 19;
        
        
    }
    imgv.x = __SCREEN_SIZE.width - 15 - 9;
 
    imgv.image = [UIImage imageContentWithFileName:@"icon_arrow_right"];
 
    imgv.y = self.height/2.0 - imgv.height/2.0;
    [self.contentView addSubview:imgv];
    
    
    UILabel *lb = [self.contentView viewWithTag:6663];
    if (!lb) {
        lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, __SCREEN_SIZE.width - 130, 16)];
        lb.tag = 6663;
    }
    lb.text = @"选项仅为已开通服务的城市";
    lb.font = [UIFont systemFontOfSize:13];
    lb.textColor = kUIColorFromRGB(color_8);
    [self.contentView addSubview:lb];
    
}


-(void)fitWithdrawMode{
    self.height = 45;
    _titleLbl.x = 15;
    _titleLbl.y = self.height/2.0 - _titleLbl.height/2.0;
    _titleLbl.textColor = kUIColorFromRGB(color_1);
       _titleLbl.font = [UIFont systemFontOfSize:14];
    _titleLbl.width = 140;
    //    _contentLbl.x = 135;
    //    _contentLbl.y = 0;
    //    _contentLbl.width = __SCREEN_SIZE.width - 145;
    //    _contentLbl.textColor = kUIColorFromRGB(color_6);
    _contentLbl.hidden = YES;
    _textField.x = 145;
    _textField.y = self.height/2.0 - _textField.height/2.0;
    _textField.width = __SCREEN_SIZE.width - 160;
    [_textField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_textField setValue:kUIColorFromRGB(color_8) forKeyPath:@"_placeholderLabel.textColor"];
    _textField.textColor = kUIColorFromRGB(color_1);
    _textField.font = [UIFont systemFontOfSize:14];
    _textField.delegate = self;
    _textField.textAlignment = NSTextAlignmentLeft;
    //_textField.keyboardType = UIKeyboardTypeNumberPad;
    //    _textField.clearButtonMode = UITextFieldViewModeNever;
      self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}



-(void)setCellData:(NSDictionary *)dataDic{
    _content = dataDic[@"content"];
    _state = [dataDic[@"state"] intValue];
    _titleLbl.text = dataDic[@"title"];
    NSString *placeholder = dataDic[@"placeholder"];
    _textField.placeholder = placeholder;
    _textField.text = dataDic[@"textField"];
    
//    //0:正常 1:账户名 2:支付宝账号
//    NSString *contentStr;
//    if (_state == 1) {
//        if (_content.length <= 3) {
//            contentStr = [_content substringFromIndex:1];
//        }else{
//            contentStr = [_content substringFromIndex:2];
//        }
//        contentStr = [NSString stringWithFormat:@"*%@",contentStr];
//        _textField.text = contentStr;
//    }else if (_state == 2){
//        if ([JYCommonTool isMobileNum:_content]) {
//            NSString *str1 = [_content substringToIndex:3];
//            NSString *str2 = [_content substringFromIndex:7];
//            contentStr = [NSString stringWithFormat:@"%@***%@",str1,str2];
//        }else{
//            NSString *str1 = [_content substringToIndex:2];
//            NSString *str2 = [_content substringFromIndex:(_content.length -7)];
//            contentStr = [NSString stringWithFormat:@"%@***%@",str1,str2];
//        }
//        _textField.text = contentStr;
//    }
    
   
}

-(void)fitUserCardRechargeMode
{
    self.height = 40;
    _titleLbl.x = 15;
    _titleLbl.y = self.height/2.0 - _titleLbl.height/2.0;
    _titleLbl.textColor = kUIColorFromRGB(color_1);
    _titleLbl.font = [UIFont systemFontOfSize:15];
    _titleLbl.width = 80;
    //    _contentLbl.x = 135;
    //    _contentLbl.y = 0;
    //    _contentLbl.width = __SCREEN_SIZE.width - 145;
    //    _contentLbl.textColor = kUIColorFromRGB(color_6);
    _contentLbl.hidden = YES;
    _textField.x = 145;
    _textField.y = self.height/2.0 - _textField.height/2.0;
    _textField.width = __SCREEN_SIZE.width - 160;
    [_textField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [_textField setValue:kUIColorFromRGB(color_8) forKeyPath:@"_placeholderLabel.textColor"];
    _textField.textColor = kUIColorFromRGB(color_1);
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.delegate = self;
   
    _textField.textAlignment = NSTextAlignmentRight;
   
    //    _textField.clearButtonMode = UITextFieldViewModeNever;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    _content = _textField.text;
}

-(void)tapHandle:(UITapGestureRecognizer *)tap
{
    [tap.view removeGestureRecognizer:tap];
    [self endEditing:YES];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    }
    [self.window addGestureRecognizer:_tap];
    return YES;
}



-(void)fitPersonInfoMode{
     self.height = 44;
     _titleLbl.x = 15;
     _titleLbl.y = self.height/2.0 - _titleLbl.height/2.0;
     _titleLbl.textColor = kUIColorFromRGB(color_5);
     _titleLbl.font = [UIFont systemFontOfSize:15];
     _titleLbl.width = 140;
     //    _contentLbl.x = 135;
     //    _contentLbl.y = 0;
     //    _contentLbl.width = __SCREEN_SIZE.width - 145;
     //    _contentLbl.textColor = kUIColorFromRGB(color_6);
     _contentLbl.hidden = YES;
     _textField.x = 131;
     _textField.y = self.height/2.0 - _textField.height/2.0;
     _textField.width = __SCREEN_SIZE.width - 160;
     [_textField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
     [_textField setValue:kUIColorFromRGB(color_0x757575) forKeyPath:@"_placeholderLabel.textColor"];
     _textField.textColor = kUIColorFromRGB(color_1);
     _textField.font = [UIFont systemFontOfSize:15];
     _textField.delegate = self;
     _textField.textAlignment = NSTextAlignmentLeft;
     //_textField.keyboardType = UIKeyboardTypeNumberPad;
     //    _textField.clearButtonMode = UITextFieldViewModeNever;
//     self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}


-(void)dealloc
{
    [_tap.view removeGestureRecognizer:_tap];
    _tap = nil;
}

@end
