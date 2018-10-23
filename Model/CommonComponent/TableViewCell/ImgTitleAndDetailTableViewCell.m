//
//  ImgTitleAndDetailTableViewCell.m
//  yihui
//
//  Created by air on 15/9/2.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgTitleAndDetailTableViewCell.h"
#import "BUImageRes.h"
@implementation ImgTitleAndDetailTableViewCell
{
    IBOutlet UILabel *_titleLb;
    IBOutlet UIImageView *_vipMarkImgV;
 BUImageRes *_curImgRes;
    IBOutlet UILabel *_detailLb;
    IBOutlet UIImageView *_tipImgV;
}

- (void)awakeFromNib {
    // Initialization code

//    [_tipImgV alignViewVCenter:10];
//    [_titleLb addHeightConstraint:JYLayoutRelationGreaterThanOrEqual width:18];
//    [_titleLb addWidthConstraint:JYLayoutRelationGreaterThanOrEqual width:18];
//    [_titleLb addVerticalConstraint];
//    [_titleLb toLeftOnConstraint:_tipImgV withEx:3];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)getImgNotification:(BSNotification *) noti
{
    if(noti.error.code ==0)
    {
        BUImageRes *res =(BUImageRes *) noti.target;
        if (_curImgRes != res) {
            return;
        }
        if (res.isCached) {
            UIImage *im =  [UIImage imageWithContentsOfFile:res.cacheFile];
            if (im) {
                _tipImgV.image = im;
            }
            
        }
    }
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _titleLb.text = dataDic[@"title"];
    _detailLb.text = dataDic[@"detail"];
    id imgObjc = dataDic[@"img"];
    _tipImgV.image = [UIImage imageContentWithFileName:dataDic[@"default"]];
    if ([imgObjc isKindOfClass:[BUImageRes class]]) {
        BUImageRes *img = (BUImageRes *)imgObjc;
        _curImgRes = img;
        if (img.isCached) {
            UIImage *im =  [UIImage imageWithContentsOfFile:img.cacheFile];
            if (im) {
                _tipImgV.image = im;
            }
            
        }
        else {
            [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
        }
    }
    else if([imgObjc isKindOfClass:[NSString class]])
    {
        if ([imgObjc isEqualToString:@""]) {
            return;
        }
        UIImage *im = [UIImage imageContentWithFileName:imgObjc];
        if (im) {
            _tipImgV.image = im;
        }
        
    }
    else if([imgObjc isKindOfClass:[UIImage class]])
    {
        _tipImgV.image = imgObjc;
    }

//    if (dataDic[@"imgSize"]) {
//        CGSize s;
//        [dataDic[@"imgSize"] getValue:&s];
//        [self decorator:s];
//    }
//    else
//    {
//        [_tipImgV addHeightConstraint:JYLayoutRelationEqual width:18];
//        [_tipImgV addWidthConstraint:JYLayoutRelationEqual width:18];
//    }
   

//    [_titleLb updateConstraints];
//    [_titleLb updateConstraints];
//    [self updateConstraintsIfNeeded];
//    [super setCellData:dataDic];
}

-(void)decorator:(CGSize)size
{
    [_tipImgV addWidthConstraint:JYLayoutRelationEqual width:size.width];
    [_tipImgV addHeightConstraint:JYLayoutRelationEqual width:size.height];
}

-(void)fitActivityInfoMode:(BOOL)hasCer//是否认证了
{
    self.height = 50;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textColor = kUIColorFromRGB(color_6);
    _detailLb.font = [UIFont systemFontOfSize:14];
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    
    _tipImgV.width = 40;
    _tipImgV.height = 40;
    _tipImgV.x = 15;
    _tipImgV.y = 5;
    _tipImgV.layer.cornerRadius = _tipImgV.height/2.0;
    _tipImgV.layer.masksToBounds = YES;
   _vipMarkImgV.y = _tipImgV.y + _tipImgV.height - 12;
    _vipMarkImgV.x = _tipImgV.x + _tipImgV.width - 12;
    _titleLb.x = 65;
    if(__SCREEN_SIZE.width == 375)
    {
        _titleLb.width = 140;
    }
    else if (__SCREEN_SIZE.width == 414)
    {
      _titleLb.width = 180;
    }
    else
    {
     _titleLb.width = 120;
    }
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    if(hasCer)
    {
        _vipMarkImgV.hidden = NO;
    }
    else
    {
        _vipMarkImgV.hidden = YES;
    }
}

-(void)fitInvGetGiftMode
{
     self.height = 165;
     _tipImgV.height = 100.5;
     _tipImgV.width = 90.5;
     _tipImgV.y = 25;
     _tipImgV.x = __SCREEN_SIZE.width/2.0 - _tipImgV.width/2.0;
     
     _titleLb.width = 50;
     _titleLb.height = 12;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _titleLb.y = _tipImgV.y + _tipImgV.height + 15;
     _titleLb.x = __SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     
     _detailLb.width = 90;
     _detailLb.height = 15;
     _detailLb.y = _titleLb.y + _titleLb.height + 9;
     _detailLb.textAlignment = NSTextAlignmentCenter;
     _detailLb.x = __SCREEN_SIZE.width/2.0 - _detailLb.width/2.0;
     _detailLb.font = [UIFont systemFontOfSize:15];
     _detailLb.textColor = kUIColorFromRGB(color_0xf82D45);
     
}
@end
