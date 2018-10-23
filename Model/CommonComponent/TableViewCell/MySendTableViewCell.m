//
//  MySendTableViewCell.m
//  taihe
//
//  Created by air on 2016/11/8.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "MySendTableViewCell.h"
#import "BUImageRes.h"
@implementation MySendTableViewCell
{
    IBOutlet UILabel *_titleLb;
     IBOutlet UILabel *_timeLb;
       BUImageRes *_curImgRes;
 IBOutlet UIImageView *_imgV;
     IBOutlet UILabel *_recordLb;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setCellData:(NSDictionary *)dataDic
{
    _imgV.image = [UIImage imageContentWithFileName:dataDic[@"default"]];
    id imgObjc = dataDic[@"img"];
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
    _titleLb.text = dataDic[@"title"];
    _timeLb.text = dataDic[@"time"];
    _recordLb.text = dataDic[@"record"];
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

-(void)fitMySendMode:(NSInteger)type
{
    _timeLb.textColor = kUIColorFromRGB(color_6);
    _timeLb.font = [UIFont systemFontOfSize:13];
    _timeLb.height = 13;
    _timeLb.width = 90;
    _timeLb.x = __SCREEN_SIZE.width - 15 - _timeLb.width;
    _timeLb.y = 90 - 15 - _timeLb.height;
    _timeLb.textAlignment = NSTextAlignmentRight;
    
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 16;
    
    _recordLb.textColor = kUIColorFromRGB(color_1);
    _recordLb.font = [UIFont systemFontOfSize:15];
    _recordLb.height = 16;
    
    switch (type) {
        case 0://都显示
        {
            _titleLb.hidden = NO;
            _imgV.hidden = NO;
            _recordLb.hidden = NO;
            _titleLb.x = _imgV.x + _imgV.width + 10;
            _titleLb.y = 15;
            _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
            
            _recordLb.x = _titleLb.x;
            _recordLb.y = 62;
            _recordLb.width = 150;
        }
            break;
        case 1://无录音
        {
            _titleLb.hidden = NO;
            _imgV.hidden = NO;
            _recordLb.hidden = YES;
            _titleLb.x = _imgV.x + _imgV.width + 10;
            _titleLb.y = 15;
            _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
            
        }
            break;
        case 2://无标题
        {
            _titleLb.hidden = YES;
            _imgV.hidden = NO;
            _recordLb.hidden = NO;
            _recordLb.x = _imgV.x + _imgV.width + 10;
            _recordLb.y = 15;
            _recordLb.width = 150;
        }
            break;
        case 3://无图片
        {
            _titleLb.hidden = NO;
            _imgV.hidden = YES;
            _recordLb.hidden = NO;
            
            _titleLb.x = 15;
            _titleLb.y = 15;
            _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
            
            _recordLb.x = _titleLb.x;
            _recordLb.y = 62;
            _recordLb.width = 150;
            
        }
            break;
        case 4://无图片无录音
        {
            _titleLb.hidden = NO;
            _imgV.hidden = YES;
            _recordLb.hidden = YES;
            
            _titleLb.x = 15;
            _titleLb.y = 15;
            _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
        }
            break;
        case 5://无图片无标题
        {
            _recordLb.x = 15;
            _recordLb.y = 15;
            _recordLb.width = __SCREEN_SIZE.width - 30;
            _titleLb.hidden = YES;
            _imgV.hidden = YES;
            _recordLb.hidden = NO;
        }
            break;
        default:
            break;
    }
}

@end
