//
//  DDSchoolTableViewCell.m
//  DDZX_js
//
//  Created by apple on 2018/9/4.
//  Copyright © 2018年 wjy. All rights reserved.
//

#import "DDSchoolTableViewCell.h"
#import "UIView+NTES.h"

@interface DDSchoolTableViewCell()

@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UIView *containerView;
@end

@implementation DDSchoolTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.containerView];
        [self.containerView addSubview:self.titleLb];

        self.height = 75;
    }
    return self;
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.width = UIScreenWidth - 36;
        _containerView.height = 40;
        _containerView.left = 18;
        _containerView.top = 5;
        _containerView.layer.cornerRadius = 6;
        _containerView.layer.borderColor = UIColorFromRGB(0xe5e5e5).CGColor;
        _containerView.layer.borderWidth = 0.5;
        _containerView.layer.masksToBounds = YES;
    }
    return _containerView;
}

-(UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        _titleLb.width = self.containerView.width;
        _titleLb.height = self.containerView.height;
        _titleLb.textColor = UIColorFromRGB(0x3A424D);
        _titleLb.font = [UIFont systemFontOfSize:14];
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}
-(void)refresh:(NSDictionary *)dic
{
    _titleLb.text = dic[@"title"];
}
@end
