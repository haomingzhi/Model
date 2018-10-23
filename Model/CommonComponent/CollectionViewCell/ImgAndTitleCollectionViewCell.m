//
//  ImgAndTitleCollectionViewCell.m
//  lovecommunity
//
//  Created by air on 16/5/13.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgAndTitleCollectionViewCell.h"
#import "BUImageRes.h"
//#import "UIImage+ImageWithColor.h"
@implementation ImgAndTitleCollectionViewCell
{
    IBOutlet UILabel *_titleLb;
    BUImageRes *_curImgRes;
    IBOutlet UIImageView *_imgV;
    IBOutlet UIButton *_delBtn;
    NSIndexPath *_curIndexPath;
     NSDictionary *_dataDic;
//     NSString *_detail;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   }


-(void)fitClassityMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     //    if (__SCREEN_SIZE.width == 375) {
     _imgV.height = 55;
     _imgV.width = 55;
     _imgV.x = self.width/2.0 - _imgV.width/2.0;
     _imgV.y = 15;
    _imgV.layer.cornerRadius = _imgV.height/2.0;
    _imgV.layer.masksToBounds = YES;
     _imgV.backgroundColor = kUIColorFromRGB(color_4);
     
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = self.width;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.y = _imgV.y  + _imgV.height +15;
     _titleLb.x = 0;
     _titleLb.height = 13;
     _titleLb.font = [UIFont systemFontOfSize:13];
}

-(void)fitTwoMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     
     _imgV.height = self.height;
     _imgV.width = self.width;
     _imgV.x = 0;
     _imgV.y = 0;
     
     _titleLb.hidden = YES;
     
     //    if (__SCREEN_SIZE.width == 375) {
//     _imgV.height = 58;
//     _imgV.width = 58;
//     _imgV.x = __SCREEN_SIZE.width/2.0 - _imgV.width -15-9;
//     _imgV.y = 6;
     //    _imgV.layer.cornerRadius = 22.5;
     //    _imgV.layer.masksToBounds = YES;
     
//     UIColor *mainColor = kUIColorFromRGB(color_0x555555);
//     NSInteger index = [_dataDic[@"index"] integerValue];
//     if (index == 1) {
//          mainColor = kUIColorFromRGB(color_0x3ac999);
//     }
//     else if ( index == 2)   {
//          mainColor = kUIColorFromRGB(color_0xa217fe);
//     }
//     else if ( index == 3)   {
//          mainColor = kUIColorFromRGB(color_0xfd7400);
//     }
     
     
     
//     _titleLb.textColor = mainColor;
//     _titleLb.width = __SCREEN_SIZE.width/2.0 -  15-12-58;
//     _titleLb.textAlignment = NSTextAlignmentLeft;
//     _titleLb.y = 13;
//     _titleLb.x = 7;
//     _titleLb.height = 13;
//     _titleLb.font = [UIFont systemFontOfSize:13];
//
//     UILabel *detailLb = [self.contentView viewWithTag:998];
//     if (!detailLb) {
//          detailLb = [UILabel new];
//          detailLb.tag = 998;
//
//     }
//     detailLb.width = _titleLb.width;
//     detailLb.height = 10;
//     detailLb.x = 7;
//     detailLb.y = 32;
//     detailLb.numberOfLines = 1;
//     detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
//     detailLb.font = [UIFont systemFontOfSize:10];
//     [self.contentView addSubview:detailLb];
//     //    }
//     detailLb.text = _dataDic[@"detail"];
//
//
//     UILabel *goLb = [self.contentView viewWithTag:9989];
//     if (!goLb) {
//          goLb = [UILabel new];
//          goLb.tag = 9989;
//          goLb.width = 27;
//          goLb.height = 13;
//          goLb.x = 7;
//          goLb.y = 50;
//          goLb.numberOfLines = 1;
//          goLb.text = @"Go >";
//          goLb.textAlignment = NSTextAlignmentCenter;
//          goLb.font = [UIFont systemFontOfSize:9];
//          [self.contentView addSubview:goLb];
//          goLb.layer.cornerRadius = 6.5;
//          goLb.layer.masksToBounds = YES;
//          goLb.layer.borderWidth = 1;
//     }
//
//     goLb.layer.borderColor = mainColor.CGColor;
//     goLb.textColor = mainColor;
     

     
     
     self.contentView.backgroundColor= kUIColorFromRGB(color_0xf7f9fa);
}

-(void)fitThreeMode
{
    _titleLb.textAlignment = NSTextAlignmentLeft;
  
    if (__SCREEN_SIZE.width == 375) {
         _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
        _imgV.height = __SCREEN_SIZE.width/3.0 - 30;
        _imgV.width = _imgV.height;
        _titleLb.width = _imgV.width;
    }
    else if(__SCREEN_SIZE.width == 320)
    {
         _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
        _titleLb.y = 100;
    }
    else
    {
        _imgV.height = __SCREEN_SIZE.width/3.0 - 30;
        _imgV.width = _imgV.height;
        _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
        _titleLb.y = _imgV.y + _imgV.height + 4;
        _titleLb.width = _imgV.width;
    }
    

}

-(void)fitThreeModeB
{
    _imgV.y = 8;
    _titleLb.textAlignment = NSTextAlignmentCenter;
//    if (__SCREEN_SIZE.width == 375) {
      _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
        _imgV.height = 66;//__SCREEN_SIZE.width/3.0 - 30;
        _imgV.width = _imgV.height;
        _imgV.x = __SCREEN_SIZE.width/3.0/2 - _imgV.width/2.0;
        _imgV.layer.cornerRadius = _imgV.width/2.0;
        _imgV.layer.masksToBounds = YES;
        _titleLb.y = _imgV.y + _imgV.height;
    _titleLb.x = __SCREEN_SIZE.width/3.0/2 - _titleLb.width/2.0;
//    }
//    else if(__SCREEN_SIZE.width == 320)
//    {
//        _titleLb.y = _imgV.y + _imgV.height;
//    }
}

-(void)fitFourMode
{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;

     _imgV.height = 50;
    _imgV.width = _imgV.height;
    _imgV.x = __SCREEN_SIZE.width/8.0 - 25;
    _imgV.layer.cornerRadius = 25;
    _imgV.layer.masksToBounds = YES;
    _titleLb.textColor = kUIColorFromRGB(color_1);

     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.y = _imgV.y + _imgV.height;
    _titleLb.x = __SCREEN_SIZE.width/4.0/2 - _titleLb.width/2.0;
     
//     _titleLb.hidden = YES;
//     _
     

}

-(void)setCellData:(NSDictionary *)dataDic
{
     _dataDic = dataDic;
//     _detail = dataDic[@"detail"];
    if([dataDic[@"showDel"] boolValue])
    {
        _delBtn.hidden = NO;
    }
    else
    {
         _delBtn.hidden = YES;
    }
    _curIndexPath = dataDic[@"row"];
    _titleLb.text = dataDic[@"title"];
//    _imgV.image = [UIImage imageContentWithFileName:dataDic[@"default"]];
//     _imgV.contentMode = UIViewContentModeCenter;
    if([dataDic[@"img"] isKindOfClass:[BUImageRes class]])
    {
        BUImageRes *img = dataDic[@"img"];
        _curImgRes = img;
        if (_curImgRes.isCached) {
            UIImage *im = [UIImage imageWithContentsOfFile:_curImgRes.cacheFile];
            if (im) {
                 _imgV.contentMode = UIViewContentModeScaleToFill;
                _imgV.image = im;
//                _imgV.image = [UIImage createGrayCopy:im];
            }
        }
        else
        {
            [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
        }
    }
    else if([dataDic[@"img"] isKindOfClass:[NSString class]])
    {
         UIImage *im = [UIImage imageContentWithFileName:dataDic[@"img"]];
         if (im) {
              _imgV.image = im;

         }
    }
}



-(void)setCellDataGray:(NSDictionary *)dataDic
{
    _titleLb.text = dataDic[@"title"];
    _imgV.image = [UIImage imageContentWithFileName:dataDic[@"default"]];
    if([dataDic[@"img"] isKindOfClass:[BUImageRes class]])
    {
        BUImageRes *img = dataDic[@"img"];
        _curImgRes = img;
        if (_curImgRes.isCached) {
            UIImage *im = [UIImage imageWithContentsOfFile:_curImgRes.cacheFile];
            if (im) {
//                _imgV.image = im;
//                 _imgV.contentMode = UIViewContentModeScaleToFill;
                 _imgV.image = [UIImage createGrayCopy:im];
            }
        }
        else
        {
            [img download:self callback:@selector(getImgNotification:) extraInfo:nil];
        }
    }
    else if([dataDic[@"img"] isKindOfClass:[NSString class]])
    {
         UIImage *im = [UIImage imageContentWithFileName:dataDic[@"img"]];
         if (im) {
              _imgV.image = im;

         }
        
    }
}


- (IBAction)handleAction:(id)sender {
    if (_delCallback) {
        _delCallback(@{@"row":_curIndexPath?:[NSNull new]});
    }
}


-(void)setCellData:(NSDictionary *)dataDic IndexPath:(BUImageRes *)seleImg
{
    _titleLb.text = dataDic[@"title"];
     _dataDic = dataDic;
    _imgV.image = [UIImage imageContentWithFileName:dataDic[@"default"]];
    if([dataDic[@"img"] isKindOfClass:[BUImageRes class]])
    {
//        BUImageRes *img = dataDic[@"img"];
        seleImg = dataDic[@"img"];
        _curImgRes = seleImg;
        if (_curImgRes.isCached) {
            UIImage *im = [UIImage imageWithContentsOfFile:_curImgRes.cacheFile];
            if (im) {
                
                _imgV.image = im;
//                _imgV.image = [UIImage createGrayCopy:im];
                
                
                }
                
            }
//        }
        else
        {
            [seleImg download:self callback:@selector(getImgNotification:) extraInfo:nil];
        }
    }
    else if([dataDic[@"img"] isKindOfClass:[NSString class]])
    {
         UIImage *im = [UIImage imageContentWithFileName:dataDic[@"img"]];
         if (im) {
              _imgV.image = im;

         }
        
    }
}
-(void)OldsetCellData:(NSDictionary *)dataDic IndexPath:(BUImageRes *)seleImg
{
    _titleLb.text = dataDic[@"title"];
    _imgV.image = [UIImage imageContentWithFileName:dataDic[@"default"]];
    if([dataDic[@"img"] isKindOfClass:[BUImageRes class]])
    {
        //        BUImageRes *img = dataDic[@"img"];
        seleImg = dataDic[@"img"];
        _curImgRes = seleImg;
        if (_curImgRes.isCached) {
            UIImage *im = [UIImage imageWithContentsOfFile:_curImgRes.cacheFile];
            if (im) {
                
//                _imgV.image = im;
                                _imgV.image = [UIImage createGrayCopy:im];
                
                
            }
            
        }
        //        }
        else
        {
            [seleImg download:self callback:@selector(getImgNotification:) extraInfo:nil];
        }
    }
    else if([dataDic[@"img"] isKindOfClass:[NSString class]])
    {
         UIImage *im = [UIImage imageContentWithFileName:dataDic[@"img"]];
         if (im) {
              _imgV.image = im;

         }
        
    }
}



-(void)getImgNotification:(BSNotification *) noti
{
    if(noti.error.code ==0)
    {
        BUImageRes *res =(BUImageRes *) noti.target;
        if(_curImgRes != res)
            return;
        if (res.isCached) {

            UIImage *im = [UIImage imageWithContentsOfFile:res.cacheFile];
            if (im) {
                _imgV.image = im;
                
                         }

        }
    }
}

-(void)fitServerMode{
    _imgV.width = _imgV.height  = 50;
    _imgV.x = 12.5;
    _imgV.y = 20;
    
    _titleLb.x = 0;
    _titleLb.y = _imgV.y+_imgV.height+15;
    _titleLb.width = 75;
    _titleLb.height = 14;
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    
    
    
}

-(void)fitHeadMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     //    if (__SCREEN_SIZE.width == 375) {
     _imgV.height = 41;
     _imgV.y = 8;
     _imgV.width = _imgV.height;
     _imgV.x = __SCREEN_SIZE.width/8.0 - _imgV.width/2.0;
     //     _imgV.layer.cornerRadius = 25;
     //     _imgV.layer.masksToBounds = YES;
     _titleLb.textColor = kUIColorFromRGB(color_7);
     //    }
     //    else if(__SCREEN_SIZE.width == 320)
     //    {
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.y = _imgV.y + _imgV.height + 9;
     _titleLb.height = 12;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.x = __SCREEN_SIZE.width/4.0/2 - _titleLb.width/2.0;
}

-(void)setServerData:(NSDictionary *)dataDic{
    _titleLb.text = dataDic[@"title"];
     UIImage *im = [UIImage imageContentWithFileName:dataDic[@"img"]];
     if (im) {
          _imgV.image = im;

     }
}

@end
