//
//  TipImgAndImgsCollectionViewCell.m
//  yihui
//
//  Created by air on 15/9/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TipImgAndImgsCollectionViewCell.h"
#import "BUImageRes.h"
@implementation TipImgAndImgsCollectionViewCell
{
  BUImageRes *_curImgRes;
    IBOutlet UIImageView *_markImgV;
    IBOutlet UIImageView *_imgV;
}
- (void)awakeFromNib {
    // Initialization code
    _imgV.layer.cornerRadius = _imgV.height/2.0;
    _imgV.layer.masksToBounds = YES;
}


-(void)setCellData:(NSDictionary *)dataDic
{
   id ob = dataDic[@"img"];
    if ([ob isKindOfClass:[BUImageRes class]]) {
        BUImageRes *img = dataDic[@"img"];
 
        _curImgRes = img;
        _imgV.image = [UIImage imageNamed:@"bg_logo_default"];
        if (img.isCached) {
            _imgV.image =  [UIImage imageWithContentsOfFile:img.cacheThumbFile];
            //         self.height = [self heightOfCellWithImg:_imgV.image];
        }
        else {
            [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
        }
    }
    _markImgV.hidden = ![dataDic[@"isChecked"] boolValue];
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
            _imgV.image =  [UIImage imageWithContentsOfFile:res.cacheThumbFile];
            //             self.height = [self heightOfCellWithImg:_imgV.image];
        }
    }
}
@end
