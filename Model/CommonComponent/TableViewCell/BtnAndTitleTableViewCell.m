//
//  BtnAndTitleTableViewCell.m
//  ChaoLiu
//
//  Created by air on 15/7/15.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BtnAndTitleTableViewCell.h"

@interface BtnAndTitleTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewLeft;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;


@end


@implementation BtnAndTitleTableViewCell
{

}
- (void)awakeFromNib {
    // Initialization code
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

-(void) setCellData:(NSDictionary *)dataDic
{
    self.labelTitle.text = dataDic[@"title"];
    [self.labelTitle setTextColor:dataDic[@"titleColor"]];
    id img = dataDic[@"normalImg"];
    if ([img isKindOfClass:[NSString class]]) {
        self.imageViewLeft.image = [UIImage imageNamed:img];
    }
    else {
        [(BURes *)img displayRemoteImage:self.imageViewLeft imageName:@""];
    }
}

@end
