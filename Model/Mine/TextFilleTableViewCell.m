//
//  TextFilleTableViewCell.m
//  ulife
//
//  Created by sunmax on 15/12/10.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TextFilleTableViewCell.h"

@implementation TextFilleTableViewCell
{
    __weak IBOutlet UILabel *_myLabel;
}

- (void)awakeFromNib {
    [_myLabel corner:[UIColor colorWithWhite:0.831 alpha:1.000] radius:5 borderWidth:1];
    // Initialization code
}

- (void)setCell:(NSString *)placeHolder
{
    _textField.placeholder =placeHolder;
    _textField.delegate =self;
}

#pragma mark --- textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
