//
//  HeadPortraitTableViewCell.m
//  ulife
//
//  Created by sunmax on 15/12/11.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "HeadPortraitTableViewCell.h"

@implementation HeadPortraitTableViewCell
{
    __weak IBOutlet UIImageView *imgView;
}

- (void)awakeFromNib {
//    [_headImage corner:kUIColorFromRGB(color_black) radius:5 borderWidth:1];
    // Initialization code
}

-(UIImageView *)imgView
{
    return imgView;
}

- (IBAction)pushLoginAction:(id)sender {
    _pushLogin();
}

- (void)setcell:(BUImageRes *)imageRes userName:(NSString *)userName
{
    [_userName setTitle:userName forState:0];
    [imageRes displayRemoteImage:imgView imageName:@"logo"];
     imgView.image = [UIImage imageContentWithFileName:@"logo"];
}

-(void)fitRegMode
{
     imgView.height = 83;
     imgView.width = 83;
     _headImage.hidden = YES;
     _userName.hidden = YES;
     imgView.x = __SCREEN_SIZE.width/2.0 - imgView.width/2.0;
     imgView.y = 46;
     self.height =172;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
