//
//  DDFAQContentTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDFAQContentTableViewCell.h"
#import "UIView+NTES.h"

@interface DDFAQContentTableViewCell()
@property(nonatomic,strong)UILabel *titleLb;
@end

@implementation DDFAQContentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLb];
    }
    return self;
}

-(void)refresh:(NSDictionary *)dic
{
    self.titleLb.text = dic[@"title"];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _titleLb.left = 18;
    _titleLb.top = 40;
    _titleLb.height = 1000000;
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = UIColorFromRGB(0x3A424D);
    _titleLb.width = self.width - 36;
    [_titleLb sizeToFit];
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}
@end
