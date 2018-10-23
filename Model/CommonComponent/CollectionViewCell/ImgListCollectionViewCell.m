//
//  ImgListCollectionViewCell.m
//  ChaoLiu
//
//  Created by air on 15/7/22.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgListCollectionViewCell.h"
#import "BUImageRes.h"
@implementation ImgListCollectionViewCell
{
    NSInteger _row;
    IBOutlet UIImageView *_imgV;
    BUImageRes *_imgRes;
}
- (void)awakeFromNib {
    // Initialization code
}

- (UIImageView *)imageView
{
    return _imgV;
}
-(void)setCellData:(NSDictionary *)dataDic
{
//    _titleLb.text = dataDic[@"title"];
//    _priceLb.text = dataDic[@"price"];
      _imgV.contentMode = UIViewContentModeCenter;
  id imgObjc = dataDic[@"img"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"default@2x" ofType:@"png"];
    if(!filePath)
    {
        filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",@"default@2x"] ofType:@"png"];
    }
    
    _imgV.image = [UIImage imageWithContentsOfFile:filePath];
    if ([imgObjc isKindOfClass:[BUImageRes class]]) {
        BUImageRes *img = (BUImageRes *)imgObjc;
//        _imgRes.isValid = NO;
        _imgRes = img;
//        _imgRes.isValid = YES;
//        [_imgRes displayRemoteImage:_imgV imageName:@"default@2x" thumb:YES];
        if (img.isCached) {
            _imgV.image =  [UIImage imageWithContentsOfFile:img.cacheFile];
             _imgV.userInteractionEnabled = YES;
              _imgV.contentMode = UIViewContentModeScaleToFill;
//            [img loadImgTo:_imgV];
        }
        else {
            _imgV.userInteractionEnabled = NO;
            [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
        }
    }
    else if([imgObjc isKindOfClass:[NSString class]])
    {
         _imgV.userInteractionEnabled = YES;
       _imgV.image =  [UIImage imageContentWithFileName:imgObjc];
//        [imgObjc loadImgTo:_imgV];
    }
    
    _row = [dataDic[@"row"] integerValue];
}


-(void)getImgNotification:(BSNotification *) noti
{
    if(noti.error.code ==0)
    {
        BUImageRes *res =(BUImageRes *) noti.target;
        if (res != _imgRes) {
            return;
        }
        if (res.isCached) {
            _imgV.image =  [UIImage imageWithContentsOfFile:res.cacheFile];
            _imgV.userInteractionEnabled = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ImgCallBack" object:nil userInfo:@{@"row":@(_row),@"img":[UIImage imageWithContentsOfFile:res.cacheFile],@"imgV":_imgV}];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshImgView" object:nil userInfo:@{@"row":@(_row),@"img":[UIImage imageWithContentsOfFile:res.cacheFile],@"imgV":_imgV}];
               _imgV.contentMode = UIViewContentModeScaleToFill;
//            [res loadImgTo:_imgV];
        }
    }
}
- (IBAction)deleteHandle:(id)sender {
//    if (_deleteHandle) {
//        _deleteHandle(_row);
//    }
}


@end
