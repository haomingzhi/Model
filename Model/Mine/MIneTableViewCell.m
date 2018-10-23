//
//  MIneTableViewCell.m
//  ulife
//
//  Created by sunmax on 15/12/11.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "MIneTableViewCell.h"

@implementation MIneTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellImage:(NSString *)image name:(NSString *)name
{
    _image.image =[UIImage imageNamed:image];
    _name.text =name;
    
    NSLog(@"%@",_name.text);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
