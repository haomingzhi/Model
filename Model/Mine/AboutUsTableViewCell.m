//
//  AboutUsTableViewCell.m
//  ulife
//
//  Created by sunmax on 15/12/10.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "AboutUsTableViewCell.h"

@implementation AboutUsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellEdition:(NSString *)edition
{
    _edition.text =  @"";//[NSString stringWithFormat:@"当前版本 %@",edition];
     _edition.font = [UIFont systemFontOfSize:18];
     _edition.textColor = kUIColorFromRGB(color_0x757575);
}

- (void)setCellIntroduces:(NSString *)introduces
{
    _introduces.text =introduces;
}

- (void)setCellLogo
{
    _introduces.hidden =YES;
}

- (void)setintroducesContent
{
    _logo.hidden =YES;
    _edition.hidden =YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
