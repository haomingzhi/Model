//
//  DDToDownloadTableViewCell.m
//  NIM
//
//  Created by apple on 2018/7/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "DDToDownloadTableViewCell.h"
#import "UIView+NTES.h"

@interface DDToDownloadTableViewCell()
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UIButton *btn;
@end

@implementation DDToDownloadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imgV];
        [self.contentView addSubview:self.btn];
    }
    return self;
}

-(void)refresh:(NSDictionary *)dic
{
    self.imgV.image = [UIImage imageNamed:dic[@"img"]];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imgV.left = 18;
    _imgV.height = 195;
    _imgV.width = self.width - 36;
    _btn.left = self.width - 40 - _btn.width;
    _btn.top = self.height - 5- _btn.height;
}
-(UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [UIImageView new];
        _imgV.height = 195;
        _imgV.width = self.width - 36;
    }
    return _imgV;
}

-(UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton new];
        _btn.width = 120;
        _btn.height = 30;
       
    }
    return _btn;
}

@end
