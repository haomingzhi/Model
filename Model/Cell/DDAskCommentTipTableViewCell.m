//
//  DDAskCommentTipTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDAskCommentTipTableViewCell.h"
#import "UIView+NTES.h"

@interface DDAskCommentTipTableViewCell()
@property(nonatomic,strong)UILabel *titleLb;

@property(nonatomic,strong)UIView *lineV;

@end
@implementation DDAskCommentTipTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.lineV];
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
    
    _titleLb.top = 18;
    _titleLb.width = 200;
    _titleLb.height = 22;
    _titleLb.textColor = UIColorFromRGB(0x3A424D);
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.left = 18;
    
    _lineV.top = _titleLb.top + _titleLb.height + 2;
    _lineV.left = _titleLb.left;
    
    
    
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
    }
    return _titleLb;
}


-(UIView *)lineV
{
    if (!_lineV) {
        _lineV = [UIView new];
        _lineV.width = 35;
        _lineV.height = 4;
        _lineV.layer.cornerRadius = _lineV.height/2.0;
        _lineV.layer.masksToBounds = YES;
        _lineV.backgroundColor = UIColorFromRGB(0x20A0FF);
    }
    return _lineV;
}

@end
