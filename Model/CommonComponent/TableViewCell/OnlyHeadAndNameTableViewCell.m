//
//  OnlyHeadAndNameTableViewCell.m
//  yihui
//
//  Created by air on 15/8/31.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "OnlyHeadAndNameTableViewCell.h"
#import "BUImageRes.h"
@implementation OnlyHeadAndNameTableViewCell
{
  
    IBOutlet UIImageView *_headBkImgV;
    IBOutlet UIImageView *_backgroundImgV;
    IBOutlet UILabel *_titleLb;
    IBOutlet UIImageView *_headImgV;
     BUImageRes *_curImgRes;
}
- (void)awakeFromNib {
    // Initialization code
//    _headImgV.borderWidth = 1;
//    _headImgV.borderColor = kUIColorFromRGB(mainColor);
    _headImgV.layer.cornerRadius = _headImgV.height/2.0;
    _headImgV.layer.masksToBounds = YES;
//    self.backgroundColor = kUIColorFromRGB(color_backgroundView);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _backgroundImgV.hidden = ![dataDic[@"isChecked"] boolValue];
    _titleLb.text = dataDic[@"title"];
    if (_backgroundImgV.hidden) {
//        _titleLb.textColor = kUIColorFromRGB(mainColor);
    }
    else
    {
        _titleLb.textColor = [UIColor blackColor];
    }
    
   if( [dataDic[@"img"] isKindOfClass:[BUImageRes class]])
   {
          _headBkImgV.hidden = NO;
//       _headImgV.borderWidth = 1;
    BUImageRes *img = dataDic[@"img"];
    _curImgRes = img;
    _headImgV.image = [UIImage imageNamed:@"bg_logo_default"];
    if (img.isCached) {
        _headImgV.image =  [UIImage imageWithContentsOfFile:img.cacheThumbFile];
        //         self.height = [self heightOfCellWithImg:_imgV.image];
    }
    else {
        [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
    }
   }
    else if ([dataDic[@"img"] isKindOfClass:[NSString class]])
    {
     _headImgV.image = [UIImage imageNamed:dataDic[@"img"]];
        _headBkImgV.hidden = YES;
        _headImgV.borderWidth = 0;
        _titleLb.textColor = kUIColorFromRGB(color_unSelColor);
    }

    [super setCellData:dataDic];
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
            _headImgV.image =  [UIImage imageWithContentsOfFile:res.cacheThumbFile];
            //             self.height = [self heightOfCellWithImg:_imgV.image];
        }
    }
}
@end
