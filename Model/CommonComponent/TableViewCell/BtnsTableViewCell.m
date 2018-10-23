//
//  BtnsTableViewCell.m
//  oranllcshoping
//
//  Created by air on 2017/7/24.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BtnsTableViewCell.h"

@implementation BtnsTableViewCell
{
     NSDictionary *_dataDic;
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
     _dataDic = dataDic;
}

-(void)initPersonInfoMode
{
     NSArray *arr = _dataDic[@"arr"];
     for (NSInteger i = 0; i < arr.count; i ++) {
          NSDictionary *dic = arr[i];
          UIButton *btn = [UIButton new];
          btn.width = 71;
          btn.height = 26;
          btn.titleLabel.font = [UIFont systemFontOfSize:15];
          [btn setTitle:dic[@"title"] forState:UIControlStateNormal];
          [btn setTitleColor:kUIColorFromRGB(color_0x757575) forState:UIControlStateNormal];
          btn.layer.cornerRadius = 6;
          btn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
          btn.layer.borderWidth = 0.5;
          btn.y = i/3 * (btn.height + 15) + 15;
          CGFloat dd = (__SCREEN_SIZE.width - (btn.width * 3) - 30)/2.0;
          btn.x = i%3 * (btn.width + dd) + 15;
          btn.tag = 100 + i;
          [self.contentView addSubview:btn];
     }
     self.height = (arr.count + 2)/3 * (26 + 15) + 15;
}
@end
