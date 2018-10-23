//
//  AddImgCollectionViewCell.m
//  ChaoLiu
//
//  Created by air on 15/7/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "AddImgCollectionViewCell.h"

@implementation AddImgCollectionViewCell
{
    NSInteger _row;
    IBOutlet UIButton *_deleteBtn;
    IBOutlet UIImageView *_imgV;
}

- (void)awakeFromNib {
    // Initialization code
}
-(void)setCellData:(NSDictionary *)dataDic
{
    //    _titleLb.text = dataDic[@"title"];
    //    _priceLb.text = dataDic[@"price"];
    id imgObjc = dataDic[@"img"];
    if ([imgObjc isKindOfClass:[BURes class]]) {
        BURes *img = (BURes *)imgObjc;
        if (img.isCached) {
            _imgV.image =  [UIImage imageWithContentsOfFile:img.cacheThumbFile];
        }
        else {
            [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
        }
    }
    else if([imgObjc isKindOfClass:[NSString class]])
    {
        _imgV.image =  [UIImage imageNamed:imgObjc];
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
        BURes *res =(BURes *) noti.target;
        if (res.isCached) {
            _imgV.image =  [UIImage imageWithContentsOfFile:res.cacheThumbFile];
        }
    }
}
- (IBAction)deleteHandle:(id)sender {
    if (_deleteHandle) {
        _deleteHandle(_row);
    }
}
@end
