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

 

-(void)refresh:(NSDictionary *)dic
{
     
}

-(void)layoutSubviews
{
     [super layoutSubviews];
}
@end
