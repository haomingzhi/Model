//
//  TitleAndSwichTableViewCell.m
//  yihui
//
//  Created by air on 15/9/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleAndSwichTableViewCell.h"

@implementation TitleAndSwichTableViewCell
{

    IBOutlet UILabel *_titleLb;
    IBOutlet UISwitch *_Sw;
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
    [super setCellData:dataDic];
    _titleLb.text = dataDic[@"title"];
   _Sw.on = [dataDic[@"isOn"] boolValue];
   _indexPath = [(UITableView *)self.superview.superview indexPathForCell:self];
    
}
- (IBAction)handleAction:(UISwitch *)sender {
    if(self.handleAction)
    {
        self.handleAction(@{@"obj":sender,@"indexPath":sender});
    }
}

-(void)fitCellMode{
    _Sw.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.y = 0;
    _titleLb.height = 44;
    
//    _Sw.on = NO;
//    _Sw.x = __SCREEN_SIZE.width  - _Sw.width - 15;
//    _Sw.y = (44 - _Sw.height)/2.0;
    
    
}

@end
