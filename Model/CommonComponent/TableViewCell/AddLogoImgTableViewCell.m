//
//  AddLogoImgTableViewCell.m
//  yihui
//
//  Created by air on 15/9/9.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "AddLogoImgTableViewCell.h"
#import "BUImageRes.h"
@implementation AddLogoImgTableViewCell
{
    IBOutlet UIButton *_logoBtn;

    IBOutlet UIImageView *_imgV;
}

- (void)awakeFromNib {
    // Initialization code
    [_imgV addHeightConstraint:JYLayoutRelationEqual width:99];
    [_imgV addWidthConstraint:JYLayoutRelationEqual width:99
     ];
    [_imgV alignViewCenter];
    [_logoBtn addHeightConstraint:JYLayoutRelationEqual width:90];
    [_logoBtn addWidthConstraint:JYLayoutRelationEqual width:90];
    [_logoBtn alignViewCenter];
    _logoBtn.layer.cornerRadius = 90/2;
    self.contentView.backgroundColor = kUIColorFromRGB(color_0xf5f5f5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    if ( [dataDic[@"img"] isKindOfClass:[UIImage class]]) {
        [_logoBtn setImage:dataDic[@"img"] forState:UIControlStateNormal];
    }
    else if([dataDic[@"img"] isKindOfClass:[BUImageRes class]])
    {
    
    }
    else if([dataDic[@"img"] isKindOfClass:[NSString class]])
    {
       [_logoBtn setImage:[UIImage imageNamed:dataDic[@"img"]] forState:UIControlStateNormal];
    }
    [super setCellData:dataDic];
}
- (IBAction)handleAction:(id)sender {
    if (self.handleAction) {
        self.handleAction(sender);
    }
}

@end
