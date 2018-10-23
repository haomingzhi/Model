//
//  ImgAndBtnCollectionViewCell.m
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgAndBtnCollectionViewCell.h"
#import "BUImageRes.h"
@implementation ImgAndBtnCollectionViewCell
{
    IBOutlet UIButton *_btn;
 BUImageRes *_curImgRes;
    IBOutlet UIImageView *_imgV;
    NSInteger _curRow;
      UIImage *_img;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setCellData:(NSDictionary *)dataDic
{
    [_btn setTitle: dataDic[@"title"] forState:UIControlStateNormal];
    _curRow = [dataDic[@"row"] integerValue];
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
    
//    _row = [dataDic[@"row"] integerValue];
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

-(UIImageView *)imageView
{
    return _imgV;
}
- (IBAction)btnHandle:(id)sender {
    if (_handleAction) {
        _handleAction(@{@"row":@(_curRow),@"img":_img?:[NSNull new]});
    }
}

-(void)fitMode
{
    _imgV.x = self.width/2.0 - _imgV.width/2.0;
    _btn.x = self.width/2.0                                                                                                                                                                                                                                          - _btn.width/2.0;
    [_btn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:16];
    _btn.layer.cornerRadius = 3;
    _btn.backgroundColor = kUIColorFromRGB(color_3);
//    _btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
//    _btn.layer.borderWidth = 0.5;
    _btn.layer.masksToBounds = YES;
}


-(void)fitModeB
{
    _imgV.x = 0;//self.width/2.0 - _imgV.width/2.0;
    _btn.x = 0;//self.width/2.0 - _btn.width/2.0;
    [_btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:16];
    _btn.layer.cornerRadius = 3;
    _btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    _btn.layer.borderWidth = 0.5;
    _btn.layer.masksToBounds = YES;
    _btn.hidden = YES;
}

-(void)fitShopMode{
    _btn.frame = CGRectMake(15, 10,__SCREEN_SIZE.width-30, 33);
    [_btn setTitle:@"搜索商品" forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    _btn.backgroundColor = kUIColorFromRGB(color_4);
    [_btn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    self.backgroundColor = kUIColorFromRGB(color_9);
    _imgV.hidden = YES;
    _btn.userInteractionEnabled = NO;
}

@end
