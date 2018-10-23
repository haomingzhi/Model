//
//  TwoTitleDetailAndImgTableViewCell.m
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "TwoTitleDetailAndImgTableViewCell.h"

@implementation TwoTitleDetailAndImgTableViewCell
{
    IBOutlet UIImageView *_imgV;

    IBOutlet UIImageView *_arrowImgV;
    IBOutlet UILabel *_cerLb;
    IBOutlet UILabel *_cerMarkLb;
    IBOutlet UILabel *_nameMarkLb;
    IBOutlet UILabel *_nameLb;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _cerMarkLb.text = dataDic[@"cerMark"];
    _cerLb.text = dataDic[@"cer"];
    _imgV.image = [UIImage imageContentWithFileName:dataDic[@"img"]];
    _nameLb.text = dataDic[@"name"];
    _nameMarkLb.text = dataDic[@"nameMark"];
}

-(void)fitUserCerMode
{
    _arrowImgV.x = __SCREEN_SIZE.width - 12 - _arrowImgV.width;
    _imgV.x = _arrowImgV.x - 4 - _imgV.width;
    _nameLb.x = _imgV.x - 12 - _nameLb.width;
    _cerLb.x = _imgV.x - 12 - _cerLb.width;
    
    _nameLb.font = [UIFont systemFontOfSize:16];
    _nameLb.textColor = kUIColorFromRGB(color_7);
    
    
    _cerLb.font = [UIFont systemFontOfSize:16];
    _cerLb.textColor = kUIColorFromRGB(color_7);
    
    _nameMarkLb.textColor = kUIColorFromRGB(color_6);
    _nameMarkLb.font = [UIFont systemFontOfSize:15];
    _cerMarkLb.font = [UIFont systemFontOfSize:15];
    _cerMarkLb.textColor = kUIColorFromRGB(color_6);
    _cerMarkLb.width = __SCREEN_SIZE.width -30;
}
@end
