//
//  SelectStreetTableViewCell.m
//  chenxiaoer
//
//  Created by sunmax on 16/3/17.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "SelectStreetTableViewCell.h"

@implementation SelectStreetTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCell:(NSString *)geograhicalNames street:(NSString *)street
{
    _geograhicalNames.text =geograhicalNames;
    _street.text =street;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
