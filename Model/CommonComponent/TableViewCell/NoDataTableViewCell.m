//
//  NoDataTableViewCell.m
//  taihe
//
//  Created by LinFeng on 2016/12/9.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "NoDataTableViewCell.h"

@implementation NoDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fitCellMode{
    _noDataImageView.y = 70;
    _noDataImageView.x = __SCREEN_SIZE.width/2.0 - _noDataImageView.width/2.0;
    
    _warnLb. x = 0;
    _warnLb.y = _noDataImageView.y+_noDataImageView.height +15;
    _warnLb.width = __SCREEN_SIZE.width;
    _warnLb.height = 16;
    _warnLb.textColor = kUIColorFromRGB(color_6);
    [self.contentView setBackgroundColor:kUIColorFromRGB(color_2)];
}


-(void)fitClassifyMode{
     _noDataImageView.y = 70;
     _noDataImageView.x = __SCREEN_SIZE.width/2.0 - _noDataImageView.width/2.0;
     
     _warnLb. x = 0;
     _warnLb.y = _noDataImageView.y+_noDataImageView.height +15;
     _warnLb.width = __SCREEN_SIZE.width;
     _warnLb.height = 16;
     _warnLb.textColor = kUIColorFromRGB(color_6);
     [self.contentView setBackgroundColor:kUIColorFromRGB(color_2)];
}



-(void)fitCellModeA{
    _noDataImageView.width = _noDataImageView.height = 135;
    _noDataImageView.y = 25;
    _noDataImageView.x = __SCREEN_SIZE.width/2.0 - _noDataImageView.width/2.0;
    
    _warnLb. x = 0;
    _warnLb.y = _noDataImageView.y+_noDataImageView.height +15;
    _warnLb.width = __SCREEN_SIZE.width;
    _warnLb.height = 16;
    _warnLb.textColor = kUIColorFromRGB(color_1);
    [self.contentView setBackgroundColor:kUIColorFromRGB(color_4)];
}

-(void)setCellData:(NSDictionary *)dataDic{
    if (dataDic[@"title"]) {
        _warnLb.text = dataDic[@"title"];
    }
    if (dataDic[@"img"]) {
        _noDataImageView.image = [UIImage imageNamed:dataDic[@"img"]];
    }
}

@end
