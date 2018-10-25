//
//  DDTitleAndMoreTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/27.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDTitleAndMoreTableViewCell.h"
#import "UIView+NTES.h"

@interface DDTitleAndMoreTableViewCell()
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UIButton *moreBtn;
@property(nonatomic,strong)UIImageView *imgV;

@property(nonatomic,strong)NSDictionary *dataDic;
@end

@implementation DDTitleAndMoreTableViewCell

-(id)init
{
    self = [super init];
    if (self) {
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.moreBtn];
        [self.contentView addSubview:self.imgV];
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.moreBtn];
        [self.contentView addSubview:self.imgV];
        
    }
    return self;
}

- (void)refresh:(NSDictionary *)dic{
    _dataDic = dic;
    _titleLb.text = dic[@"title"];
//    _imgV.image = [UIImage imageNamed:dic[@"img"]];
    [self setNeedsLayout];
}



- (void)layoutSubviews{
    [super layoutSubviews];
//    NSValue *lv = _dataDic[@"layout"];
//
//    UIEdgeInsets layout;
//    [lv getValue:&layout];
//    self.titleLb.top = layout.top;
//    self.titleLb.left = layout.left;
//    self.titleLb.width = layout.bottom;
//    self.titleLb.height = layout.right;
   
    self.titleLb.font = [UIFont boldSystemFontOfSize:17];
        self.titleLb.width = 90;
        self.titleLb.height = 24;
        self.titleLb.left = 18;
        self.titleLb.top = 20;
    
    self.moreBtn.width = 34;
    self.moreBtn.height = 17;
    self.moreBtn.top = 22;
    self.moreBtn.left = self.width - 18 - self.moreBtn.width;
    
    self.imgV.width = 8;
    self.imgV.height = 8;
    self.imgV.top = 27;
    self.imgV.left = self.width - 18 - self.imgV.width;
    
}

-(UILabel*)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        
    }
    return _titleLb;
}

-(UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [UIButton new];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_moreBtn setTitleColor:UIColorFromRGB(0xA2A3A7) forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

-(void)moreClick:(UIButton *)btn
{
    if (_onClickCallBack) {
        _onClickCallBack();
    }
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        [_imgV setImage:[UIImage imageNamed:@"目标定位-进入更多"]];
    }
    return _imgV;
}

@end
