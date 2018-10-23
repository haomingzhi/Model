//
//  MyCircleTableViewCell.m
//  yihui
//
//  Created by orange on 15/9/24.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "MyCircleTableViewCell.h"
#import "BUImageRes.h"
//#import "BULabels.h"
@implementation MyCircleTableViewCell{
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
-(void)setCellData:(NSDictionary *)dic{
    
    _name.text=dic[@"name"];
    _time.text=dic[@"time"];
    BUImageRes *img = dic[@"img"];
    _content.text=dic[@"label"];
    _curImgRes = img;
    if (img.isCached) {
        self.logoImage.image =  [UIImage imageWithContentsOfFile:img.cacheFile];
    }
    else {
        [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
        self.logoImage.image=[UIImage imageNamed:@"bg_logo_default"];
    }
    self.selectImage.image=[UIImage imageNamed:[dic[@"select"] boolValue]?@"icon_Choose_people_sel":@""];

}
-(void)getImgNotification:(BSNotification *)noti
{
    if(noti.error.code ==0)
    {ISTOLOGIN;
        BUImageRes *res =(BUImageRes *) noti.target;
        if (_curImgRes != res) {
            return;
        }
        if (res.isCached) {
            self.logoImage.image =  [UIImage imageWithContentsOfFile:res.cacheFile];
        }
    }
}
@end
