//
//  AddImgCollectionViewCell.m
//  ChaoLiu
//
//  Created by air on 15/7/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "AddImgCollectionViewCell.h"
#import "BUImageRes.h"
@implementation AddImgCollectionViewCell
{
    NSInteger _row;
    IBOutlet UIButton *_deleteBtn;
    IBOutlet UIImageView *_imgV;
    BUImageRes *_curImgRes;
}

- (void)awakeFromNib {
    // Initialization code
}


-(void)setCellData:(NSDictionary *)dataDic
{
    //    _titleLb.text = dataDic[@"title"];
    //    _priceLb.text = dataDic[@"price"];
    id imgObjc = dataDic[@"img"];
     _imgV.image = [UIImage imageContentWithFileName:dataDic[@"default"]];
    if ([imgObjc isKindOfClass:[BUImageRes class]]) {
        BUImageRes *img = (BUImageRes *)imgObjc;
        _curImgRes = img;
        if (img.isCached) {
            UIImage *im =  [UIImage imageWithContentsOfFile:img.cacheFile];
            if (im) {
                _imgV.image = im;
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
        UIImage *im = [UIImage imageNamed:imgObjc];
        if (im) {
            _imgV.image = im;
        }
        
    }
    else if([imgObjc isKindOfClass:[UIImage class]])
    {
        _imgV.image = imgObjc;
    }
    _deleteBtn.hidden = [dataDic[@"hiddenDeleteBtn"] boolValue];
    _row = [dataDic[@"row"] integerValue];
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
                _imgV.image = im;
            }
            
        }
    }
}
- (IBAction)deleteHandle:(id)sender {
    if (_deleteHandle) {
        _deleteHandle(_row);
    }
}
-(UIImageView *)imageView
{
    return _imgV;
}
-(void)fitCommentMode
{
    _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.layer.cornerRadius = 3;
    _imgV.layer.masksToBounds = YES;
    _imgV.x = 0;
    _imgV.y = 5;
    _imgV.width = 100;
    _imgV.height = 85;
    if (__SCREEN_SIZE.width == 320) {
       _imgV.width = __SCREEN_SIZE.width/3 - 18 - 5;
        _imgV.height = _imgV.width * 0.85;
    }
//    _deleteBtn.y = 0;
//    _deleteBtn.x = 110 - _deleteBtn.width;
}
- (void)headSetting{
    _imgV.userInteractionEnabled = NO;
}

@end
