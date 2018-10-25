//
//  DDTextFieldTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDTextFieldTableViewCell.h"
#import "UIView+NTES.h"

@interface DDTextFieldTableViewCell()
@property(nonatomic,strong)UITextField *textTf;
@property(nonatomic,strong)UILabel *lineLb;
@end

@implementation DDTextFieldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.textTf];
        [self.contentView addSubview:self.lineLb];
        [self.textTf addTarget:self action:@selector(onTextChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

    
    -(void)onTextChanged:(UITextField *)tf
    {
        if(_limitCount != 0)
        {
            tf.text = [tf.text substringToIndex:MIN(_limitCount, tf.text.length)];
        }
        if(_textChangeCallBack)
        {
            _textChangeCallBack(@{@"title":tf.text});
        }
    }
-(NSString *)text
{
    return _textTf.text;
}

-(UITextField *)textTf
{
    if (!_textTf) {
        _textTf = [UITextField new];
        _textTf.height = 35;
        _textTf.left = 18;
        _textTf.width = UIScreenWidth - 36;
        _textTf.textColor = UIColorFromRGB(0x3A424D);
        _textTf.font = [UIFont systemFontOfSize:26];
    }
    return _textTf;
}


-(UILabel *)lineLb
{
    if (!_lineLb) {
        _lineLb = [UILabel new];
        _lineLb.width = UIScreenWidth - 36;
        _lineLb.height = 0.5;
        _lineLb.backgroundColor = UIColorFromRGB(0xE5E5E5);
        _lineLb.top = 35.5;
        _lineLb.left = 18;
    }
    return _lineLb;
}

-(void)refresh:(NSDictionary *)dic
{
    _textTf.text = dic[@"title"];
    if(dic[@"limit"])
    {
        _limitCount = [dic[@"limit"] integerValue];
    }
    if(dic[@"phoneNum"])
    {
        _textTf.keyboardType = UIKeyboardTypePhonePad;
    }
    [self setNeedsLayout];
}

@end
