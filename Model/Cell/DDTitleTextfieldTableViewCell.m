//
//  DDTitleTextfieldTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDTitleTextfieldTableViewCell.h"
#import "UIView+NTES.h"
@interface DDTitleTextfieldTableViewCell()
@property(nonatomic,strong)UILabel *titleLb;

@property(nonatomic,assign)NSInteger limitCount;
@end


@implementation DDTitleTextfieldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.textTf];
    }
    return self;
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.textColor = UIColorFromRGB(0x3A424D);
    }
    return _titleLb;
}

-(UITextField *)textTf
{
    if (!_textTf) {
        _textTf = [UITextField new];
        _textTf.font = [UIFont systemFontOfSize:14];
        _textTf.textColor = UIColorFromRGB(0x3A424D);
        _textTf.textAlignment = NSTextAlignmentRight;
        [_textTf addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textTf;
}
-(void)changeValue:(UITextField *)tf
{
    if (_limitCount > 0) {
        if (_limitCount < tf.text.length) {
             tf.text = [tf.text substringToIndex:_limitCount];
        }
       
    }
    if (_textChangeallBack) {
        _textChangeallBack(@{@"obj":tf});
    }
}

-(void)dealloc
{
    _textTf.delegate = nil;
}

-(void)refresh:(NSDictionary *)dic
{
    self.titleLb.text = dic[@"title"];
    self.textTf.text = dic[@"text"];
    self.textTf.placeholder = dic[@"placeholder"];
    if(dic[@"limit"])
    {
        _limitCount = [dic[@"limit"] integerValue];
    }
        
    if (dic[@"mark"]) {
        NSString *st = dic[@"title"];
        NSRange rg = [st rangeOfString:dic[@"mark"]];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:st];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:UIColorFromRGB(0x3A424D)
                        range:NSMakeRange(0, attrStr.length)];
        [attrStr addAttribute:NSForegroundColorAttributeName
                        value:UIColorFromRGB(0xDC4141)
                        range:rg];
        _titleLb.attributedText =  attrStr;
    }
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLb.width = 100;
    self.titleLb.height = 20;
    self.titleLb.left = 18;
    self.titleLb.centerY = self.height/2.0;
    
    self.textTf.width = self.width/2.0 + 40;
    self.textTf.height = 20;
    self.textTf.centerY = self.height/2.0;
    self.textTf.left = self.width - 18 - self.textTf.width;
    
}

@end
