//
//  UpTableViewCell.m
//  yihui
//
//  Created by air on 15/9/11.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "UpTableViewCell.h"

@implementation UpTableViewCell
{
    IBOutlet UIButton *_upBtn;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)handleAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (self.handleAction) {
        self.handleAction(btn);
    }
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _upBtn.selected = [dataDic[@"isChecked"] boolValue];
    [super setCellData:dataDic];
}


@end
