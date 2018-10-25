//
//  DDPasswordTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDPasswordTableViewCell.h"
#import "UIView+NTES.h"

@interface DDPasswordTableViewCell()
@property(nonatomic,strong)UITextField *textTf;
@property(nonatomic,strong)UILabel *lineLb;
@property(nonatomic,strong)UIButton *viewBtn;
 @property(nonatomic,assign)NSInteger limitCount;
@end

@implementation DDPasswordTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.textTf];
        [self.contentView addSubview:self.lineLb];
        [self.contentView addSubview:self.viewBtn];
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
}
-(UIButton *)viewBtn
{
    if (!_viewBtn) {
        _viewBtn = [UIButton new];
        _viewBtn.width = 30;
        _viewBtn.height = 30;
        _viewBtn.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8 );
        [_viewBtn setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateNormal];
        [_viewBtn setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateSelected];
        [_viewBtn addTarget:self action:@selector(viewHandle:) forControlEvents:UIControlEventTouchUpInside];
        _viewBtn.centerY = self.height/2.0;
        _viewBtn.left = UIScreenWidth - 18 - _viewBtn.width;
    }
    return _viewBtn;
}

-(void)viewHandle:(UIButton *)btn
{
    btn.selected = !btn.selected;
     _textTf.secureTextEntry = !btn.selected;
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
        _textTf.width = UIScreenWidth - 36 - 78;
        _textTf.textColor = UIColorFromRGB(0x3A424D);
        _textTf.font = [UIFont systemFontOfSize:26];
        _textTf.secureTextEntry = YES;
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
    [self setNeedsLayout];
}


@end
