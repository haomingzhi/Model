//
//  DDRegTypeCheckTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDRegTypeCheckTableViewCell.h"
#import "UIView+NTES.h"
@interface DDRegTypeCheckTableViewCell()
@property(nonatomic,strong)UIView *containerView;
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)NSDictionary *dataDic;
@end

@implementation DDRegTypeCheckTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.containerView];
        [self.containerView addSubview:self.imgV];
        [self.containerView addSubview:self.titleLb];
    }
    return self;
}

-(void)refresh:(NSDictionary *)dic
{
    self.imgV.image = [UIImage imageNamed:dic[@"img"]];
    self.titleLb.text = dic[@"title"];
    _dataDic = dic;
    [self setNeedsLayout];
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.width = UIScreenWidth - 36;
        _containerView.height = 170;
        _containerView.layer.cornerRadius = 9;
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.borderWidth = 0.5;
        _containerView.layer.borderColor = UIColorFromRGB(0xE5E5E5).CGColor;
        _containerView.left = 18;
        _containerView.top = 10;
    }
    return _containerView;
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        _imgV.height = 82.5;
        _imgV.width = 82.5;
    }
    return _imgV;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _imgV.top = 28;
    _imgV.centerX = self.containerView.width/2.0;
    
    _titleLb.top = _imgV.top + _imgV.height + 2;
    if ([_dataDic[@"isChecked"] boolValue]) {
        _containerView.backgroundColor = UIColorFromRGBA(0xFA8E31, 0.1);
        _containerView.layer.borderColor = UIColorFromRGB(0xFA8E31).CGColor;
    }
    else
    {
        _containerView.backgroundColor = UIColorFromRGB(0xffffff);
        _containerView.layer.borderColor = UIColorFromRGB(0xE5E5E5).CGColor;
    }
}


-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.height = 24;
        _titleLb.width = self.containerView.width;
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}
@end
