//
//  JYMineHeadTableViewCell.m
//  Model
//
//  Created by apple on 2018/10/30.
//  Copyright © 2018 ORANLLC_IOS1. All rights reserved.
//

#import "JYMineHeadTableViewCell.h"
@interface JYMineHeadTableViewCell()
@property(nonatomic,strong)UILabel *phoneLb;
@property(nonatomic,strong)UILabel *nameLb;
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UIImageView *markImgV;

@end
@implementation JYMineHeadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
          [self.contentView addSubview:self.imgV];
          [self.contentView addSubview:self.markImgV];
          [self.contentView addSubview:self.nameLb];
          [self.contentView addSubview:self.phoneLb];
     }
     return self;
}

-(UILabel *)phoneLb
{
     if (!_phoneLb) {
          _phoneLb = [UILabel new];
          _phoneLb.height = 20;
          _phoneLb.width = 160;
     }
     return _phoneLb;
}

-(UIImageView *)imgV
{
     if (!_imgV) {
          _imgV = [UIImageView new];
          _imgV.height = 20;
          _imgV.width = 160;
     }
     return _imgV;
}

-(UILabel *)nameLb
{
     if (!_nameLb) {
          _nameLb = [UILabel new];
          _nameLb.height = 20;
          _nameLb.width = 160;
          _nameLb.y = 0;
          _nameLb.x = 0;
     }
     return _nameLb;
}

-(UIImageView *)markImgV
{
     if (!_markImgV) {
          _markImgV = [UIImageView new];
          _markImgV.height = 20;
          _markImgV.width = 160;
          _markImgV.y = 0;
          _markImgV.x = 0;
     }
     return _markImgV;
}



-(void)refresh:(NSDictionary *)dic
{
     
}

-(void)layoutSubviews
{
     [super layoutSubviews];
}


@end
