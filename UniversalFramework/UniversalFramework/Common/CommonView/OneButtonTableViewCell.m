//
//  OnlyBottomBtnTableViewCell.m
//  ChaoLiu
//
//  Created by air on 15/7/27.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "OneButtonTableViewCell.h"

@implementation OneButtonTableViewCell
{

    IBOutlet UIButton *btn;
}
- (void)awakeFromNib {
    // Initialization code
    btn.width = __SCREEN_SIZE.width;
    self.width = __SCREEN_SIZE.width;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)handleAction:(id)sender {
    if (self.handleAction) {
        self.handleAction(sender);
    }
}

-(void)setPadding:(CGFloat)padding
{
    btn.x = padding;
    btn.width = __SCREEN_SIZE.width - padding * 2;
}
-(void)setHeightPadding:(CGFloat)padding
{
    btn.y = padding;
    btn.height = self.height - padding * 2;
}
-(void)setBtnBackgroundColor:(UIColor *)color
{

    
    btn.backgroundColor = color;
}

-(void)btnLayer:(BOOL)J
{
    if (J==YES)
    {
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [[UIColor colorWithRed:0.831f green:0.831f blue:0.843f alpha:1.00f] CGColor];
    }
    else
    {
        btn.layer.borderWidth = 0;
        btn.layer.borderColor = [[UIColor blackColor] CGColor];
    }
}

-(void)setBtnTitleColor:(UIColor *)color
{
    [btn setTitleColor:color forState:UIControlStateNormal];
}

-(void)setCellData:(NSDictionary *)dataDic
{
    [super setCellData:dataDic];
    [btn setTitle:dataDic[OneButtonTableViewCell_Title] forState:UIControlStateNormal];
    if (dataDic[OneButtonTableViewCell_XPadding]) {
        CGFloat XPadding = [dataDic[OneButtonTableViewCell_XPadding] floatValue];
        [self setPadding:XPadding];
    }
    if (dataDic[OneButtonTableViewCell_YPadding]) {
        CGFloat YPadding = [dataDic[OneButtonTableViewCell_XPadding] floatValue];
        [self setHeightPadding:YPadding];
    }
    if (dataDic[OneButtonTableViewCell_TitleColor]) {
        [self setBtnTitleColor:dataDic[OneButtonTableViewCell_TitleColor]];
    }
}

+(NSDictionary *) defaultCellData:(NSString *) title
{
    return @{OneButtonTableViewCell_Title:title,OneButtonTableViewCell_TitleColor:[UIColor whiteColor],OneButtonTableViewCell_XPadding:@(5),OneButtonTableViewCell_YPadding:@(8),@"btn.backgroundColor":kUIColorFromRGB(color_mainTheme)};
}

@end
