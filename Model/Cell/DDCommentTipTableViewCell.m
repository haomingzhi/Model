//
//  DDCommentTipTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDCommentTipTableViewCell.h"
#import "UIView+NTES.h"
@interface DDCommentTipTableViewCell()
@property(nonatomic,strong)UILabel *titleLb;
@property(nonatomic,strong)UIButton *sortBtn;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)UIView *lineV;
@end
@implementation DDCommentTipTableViewCell

-(id)init
{
    self = [super init];
    if (self) {
        [self.contentView addSubview:self.titleLb];
        [self.contentView addSubview:self.sortBtn];
        [self.contentView addSubview:self.imgV];
         [self.contentView addSubview:self.lineV];
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLb];
         [self.contentView addSubview:self.imgV];
        [self.contentView addSubview:self.sortBtn];
         [self.contentView addSubview:self.lineV];
        
    }
    return self;
}

- (void)refresh:(NSDictionary *)dic{
    _dataDic = dic;
    _titleLb.text = dic[@"title"];
    [_sortBtn setTitle:dic[@"detail"] forState:UIControlStateNormal];
    //    _imgV.image = [UIImage imageNamed:dic[@"img"]];
    [self setNeedsLayout];
}



- (void)layoutSubviews{
    [super layoutSubviews];

    self.titleLb.font = [UIFont boldSystemFontOfSize:17];
    self.titleLb.width = 90;
    self.titleLb.height = 22.5;
    self.titleLb.left = 18;
    self.titleLb.top = 57;
    
    _lineV.top = _titleLb.top + _titleLb.height + 2;
    _lineV.left = _titleLb.left;
    
    self.sortBtn.width = 57;
    self.sortBtn.height = 16.5;
    self.sortBtn.top = 71;
    self.sortBtn.left = self.width - 30 - self.sortBtn.width + 14;
    
    self.imgV.width = 12;
    self.imgV.height = 9;
    self.imgV.top = 74;
    self.imgV.left = self.width - 18 - self.imgV.width;
    
}

-(UILabel*)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel new];
        
    }
    return _titleLb;
}

-(UIButton *)sortBtn
{
    if (!_sortBtn) {
        _sortBtn = [UIButton new];
        _sortBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _sortBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_sortBtn setTitleColor:UIColorFromRGB(0x3A424D) forState:UIControlStateNormal];
        [_sortBtn addTarget:self action:@selector(sortClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortBtn;
}

-(void)sortClick:(UIButton *)btn
{
    if (_onClickCallBack) {
        _onClickCallBack();
    }
}

-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        [_imgV setImage:[UIImage imageNamed:@"下拉小三角"]];
    }
    return _imgV;
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
