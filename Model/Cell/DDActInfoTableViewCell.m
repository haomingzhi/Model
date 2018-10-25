//
//  DDActInfoTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDActInfoTableViewCell.h"
#import "UIView+NTES.h"

@interface DDActInfoTableViewCell()
@property(nonatomic,strong)UILabel *markLb;
@property(nonatomic,strong)UILabel *infoLb;
@end

@implementation DDActInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.markLb];
        [self.contentView addSubview:self.infoLb];
    }
    return self;
}

-(void)refresh:(NSDictionary *)dic
{
    
    _markLb.text = dic[@"mark"];
    _infoLb.text = dic[@"info"];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _markLb.left = 18;
    _markLb.top = 20;
    
    _infoLb.left = _markLb.width + _markLb.left + 10;
    _infoLb.width = UIScreenWidth - 18 - _infoLb.left;
    _infoLb.height = 20;
    _infoLb.top = _markLb.top;
}

-(UILabel *)markLb
{
    if (!_markLb) {
        _markLb = [UILabel new];
        _markLb.width = 58;
        _markLb.height = 20;
        _markLb.layer.cornerRadius = _markLb.height/2.0;
        _markLb.layer.masksToBounds = YES;
        _markLb.layer.borderColor = UIColorFromRGB(0xFA8E31).CGColor;
        _markLb.layer.borderWidth = 0.5;
        _markLb.textColor = UIColorFromRGB(0xFA8E31);
        _markLb.font = [UIFont systemFontOfSize:12];
        _markLb.textAlignment = NSTextAlignmentCenter;
    }
    return _markLb;
}

-(UILabel *)infoLb
{
    if (!_infoLb) {
        _infoLb = [UILabel new];
        _infoLb.textColor = UIColorFromRGB(0xA2A3A7);
        _infoLb.font = [UIFont systemFontOfSize:12];
    }
    return _infoLb;
}
@end
