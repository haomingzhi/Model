//
//  TitleTableViewCell.m
//  yihui
//
//  Created by air on 15/9/22.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleTableViewCell.h"

@implementation TitleTableViewCell
{
    IBOutlet UILabel *_titleLb;
NSIndexPath *_indexPath;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _titleLb.text = dataDic[@"title"];
      _indexPath = dataDic[@"indexPath"];
    if ([dataDic[@"isChecked"] boolValue]) {
        _titleLb.textColor = kUIColorFromRGB(0x42cec8);//[UIColor blueColor];
    }
    else
    {
      _titleLb.textColor = [UIColor blackColor];
    }
    
    [super setCellData:dataDic];
}

@end
