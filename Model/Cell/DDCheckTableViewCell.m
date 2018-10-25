//
//  DDCheckTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDCheckTableViewCell.h"
#import "UIView+NTES.h"

@interface DDCheckTableViewCell()
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UILabel *detailLb;
@property(nonatomic,strong)UIImageView *arrowImgV;
@end


@implementation DDCheckTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.detailLb];
        [self.contentView addSubview:self.arrowImgV];
    }
    return self;
}

-(UIImageView *)arrowImgV
{
    if (!_arrowImgV) {
        _arrowImgV = [UIImageView new];
        _arrowImgV.height = 14;
        _arrowImgV.width = 14;
        _arrowImgV.image = [UIImage imageNamed:@"进入 copy"];
    }
    return _arrowImgV;
}


-(UILabel *)detailLb
{
    if (!_detailLb) {
        _detailLb = [UILabel new];
        _detailLb.font = [UIFont systemFontOfSize:14];
        _detailLb.textColor = UIColorFromRGB(0x3A424D);
        _detailLb.textAlignment = NSTextAlignmentRight;
    }
    return _detailLb;
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
-(void)refresh:(NSDictionary *)dic
{
    self.titleLb.text = dic[@"title"];
    self.detailLb.text = dic[@"detail"];
    if ([dic[@"detail"] isEqualToString:@"请选择"]) {
        self.detailLb.textColor = UIColorFromRGB(0xA2A3A7);
    }
    else
    {
         _detailLb.textColor = UIColorFromRGB(0x3A424D);
    }
    if (dic[@"font"]) {
        self.titleLb.font = dic[@"font"];
        _detailLb.font = dic[@"font"];
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
    
    self.detailLb.width = self.width/2.0 + 40;
    self.detailLb.height = 20;
    self.detailLb.left = self.width - 18 - self.arrowImgV.width - 4 - self.detailLb.width;
    self.detailLb.centerY = self.height/2.0;
    
    _arrowImgV.left = UIScreenWidth - 18 - _arrowImgV.width;
    _arrowImgV.centerY = self.height/2.0;
}
@end
