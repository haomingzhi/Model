//
//  ContactGroupTableViewCell.m
//  yihui
//
//  Created by orange on 15/10/19.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ContactGroupTableViewCell.h"
#import "BUImageRes.h"


#import "BUSystem.h"
@implementation ContactGroupTableViewCell{
    BUImageRes *_curImgRes;
}

- (void)awakeFromNib {
    // Initialization code
    [self.logoImage corner:[UIColor clearColor] radius:self.logoImage.frame.size.width/2.0];
    [self.content setTextColor:kUIColorFromRGB(color_unSelColor)];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)handleClick:(UIButton *)sender {
    if (_contactGroupBlock) {
        self.contactGroupBlock(sender.selected);
    }
}

-(void)setCellData:(NSDictionary *)dic{
    
    _name.text=dic[@"name"];
    BUImageRes *img = dic[@"img"];
    _contactBtn.selected=[dic[@"btn"] boolValue];
    [_contactBtn setImage:[UIImage imageNamed:[dic[@"btn"] boolValue]?@"icon_liebiao":@"icon_tel"] forState:UIControlStateNormal];
    _content.text=dic[@"label"];
    _curImgRes = img;
    if (img.isCached) {
        self.logoImage.image =  [UIImage imageWithContentsOfFile:img.cacheThumbFile];
    }
    else {
        [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
        self.logoImage.image=[UIImage imageNamed:@"bg_logo_default"];
    }
    self.selectImage.image=[UIImage imageNamed:[dic[@"select"] boolValue]?@"icon_Choose_people_sel":@""];
    
}

-(void)getImgNotification:(BSNotification *)noti
{
    ISTOLOGIN;
    if(noti.error.code ==0)
    {
        BUImageRes *res =(BUImageRes *) noti.target;
        if (_curImgRes != res) {
            return;
        }
        if (res.isCached) {
            self.logoImage.image =  [UIImage imageWithContentsOfFile:res.cacheThumbFile];
        }
    }
}

@end
