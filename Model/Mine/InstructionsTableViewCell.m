//
//  InstructionsTableViewCell.m
//  ulife
//
//  Created by sunmax on 15/12/11.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "InstructionsTableViewCell.h"

@implementation InstructionsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellInstructions:(NSString *)instructions
{
    _instructionsLabel.text =instructions;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
