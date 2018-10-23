//
//  ImgTitleAndDetailCollectionViewCell.m
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgTitleAndDetailCollectionViewCell.h"
#import "BUImageRes.h"
@implementation ImgTitleAndDetailCollectionViewCell
{
     NSInteger _row;
    IBOutlet UILabel *_titleLb;
    BUImageRes *_curImgRes;
    IBOutlet UILabel *_detailLb;
    IBOutlet UIImageView *_imgV;
    UIImageView *_lineTop;
    UIImageView *_lineBottom;
    UIImageView *_lineRight;
    NSIndexPath *_curIndexPath;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellData:(NSDictionary *)dataDic
{
    _titleLb.text = dataDic[@"title"];
    _detailLb.text = dataDic[@"detail"];
    _imgV.image = [UIImage imageNamed:@"default"];
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

-(UIImageView *)imageView
{
    return _imgV;
}

-(void)fitMode
{
    _detailLb.textColor = kUIColorFromRGB(color_6);
    _detailLb.font = [UIFont systemFontOfSize:13];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:14];
    if (__SCREEN_SIZE.width > 320) {
        _titleLb.y = 122;
        _detailLb.y = 150;
    }
     _titleLb.width = self.width + 12;
    _titleLb.x = self.width/2.0 - _titleLb.width/2.0;
    _detailLb.x = self.width/2.0 - _detailLb.width/2.0;
   
    _imgV.x = self.width/2.0 - _imgV.width/2.0;
    _detailLb.userInteractionEnabled = YES;
    _titleLb.userInteractionEnabled = YES;
    _detailLb.hidden = YES;
//    self.layer.borderColor = kUIColorFromRGB(color_9).CGColor;
//    self.layer.borderWidth = 0.5;
}

-(void)fitPerformanceMode:(NSIndexPath *)indexPath
{
    _detailLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;;
    _imgV.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    
    CGFloat  x = 15;
    if (indexPath.row %2 ==1) {
        x = 10;
    }
    
    _imgV.x = x ;
    _imgV.y = 10;
    _imgV.width = __SCREEN_SIZE.width/2.0 - 25;
    _imgV.height =  _imgV.width/310.0 *290;
    
    _titleLb.x = _imgV.x;
    _titleLb.y = _imgV.y+_imgV.height + 10;
    _titleLb.width = __SCREEN_SIZE.width/2.0 - 25;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.numberOfLines = 2;
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 40)];
    _titleLb.height = size.height;
    
    _detailLb.hidden = YES;
    
    //    self.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    //    self.layer.borderWidth = 0.5;
    
//    if (_lineTop == nil) {
//        _lineTop = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,__SCREEN_SIZE.width/2.0, 0.5)];
//        _lineTop.backgroundColor = kUIColorFromRGB(color_3);
//        [self.contentView addSubview:_lineTop];
//        
//        CGFloat y = (__SCREEN_SIZE.width/2.0 - 25.0)/310.0 *290+70;
//        //        _lineBottom = [[UIImageView alloc]initWithFrame:CGRectMake(0, y-0.5,__SCREEN_SIZE.width/2.0, 0.5)];
//        //        _lineBottom.backgroundColor = kUIColorFromRGB(color_3);
//        //        [self.contentView addSubview:_lineBottom];
//        
//        _lineRight = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width/2.0-0.5, 0,0.5, y)];
//        _lineRight.backgroundColor = kUIColorFromRGB(color_3);
//        [self.contentView addSubview:_lineRight];
//    }
    
    if (indexPath.row == 0 ||indexPath.row == 1) {
        if (!_lineTop) {
            _lineTop = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,__SCREEN_SIZE.width/2.0, 0.5)];
            _lineTop.backgroundColor = kUIColorFromRGB(color_3);
            [self.contentView addSubview:_lineTop];
        }
        _lineTop.hidden = NO;
    }else{
        _lineTop.hidden = YES;
    }
    
    if (_lineBottom == nil) {
        _lineBottom = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.height-0.5,__SCREEN_SIZE.width/2.0, 0.5)];
        _lineBottom.backgroundColor = kUIColorFromRGB(color_3);
        [self.contentView addSubview:_lineBottom];
        
        CGFloat y = (__SCREEN_SIZE.width/2.0 - 25.0)/310.0 *290+70;
        //        _lineBottom = [[UIImageView alloc]initWithFrame:CGRectMake(0, y-0.5,__SCREEN_SIZE.width/2.0, 0.5)];
        //        _lineBottom.backgroundColor = kUIColorFromRGB(color_3);
        //        [self.contentView addSubview:_lineBottom];
        
        _lineRight = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width/2.0-0.5, 0,0.5, y)];
        _lineRight.backgroundColor = kUIColorFromRGB(color_3);
        [self.contentView addSubview:_lineRight];
    }


}


-(void)fitTitleAndDetailMode
{
    _detailLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;;
    _imgV.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    
    _imgV.hidden = YES;
    _titleLb.hidden = NO;
    _detailLb.hidden = NO;
    _lineTop.hidden = YES;
    _lineBottom.hidden = YES;
    _lineRight.hidden = YES;
    
    _titleLb.x = 15;
    _titleLb.y = 10;
    _titleLb.width = __SCREEN_SIZE.width- 30;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.numberOfLines = 0;
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 300)];
    _titleLb.height = size.height;
    
    _detailLb.x = 15;
    _detailLb.y = _titleLb.y + _titleLb.height +10;
    _detailLb.width = __SCREEN_SIZE.width- 30;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:14];
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.numberOfLines = 0;
    size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(_detailLb.width, __SCREEN_SIZE.height)];
    _detailLb.height = size.height;
    
    self.height = _detailLb.y + _detailLb.height+10;
    
    
}

-(void)fitOnlyImageMode
{
    _detailLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;;
    _imgV.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    
    _imgV.x = 15 ;
    _imgV.y = 0;
    _imgV.width = __SCREEN_SIZE.width - 30;
    _imgV.height =  (__SCREEN_SIZE.width -30)/660.0*300;
    
    _titleLb.hidden = YES;
    _detailLb.hidden = YES;
    _lineTop.hidden = YES;
    _lineBottom.hidden = YES;
    _lineRight.hidden = YES;
    
    

    
}

-(void)fitOnlyTitleMode
{
     _detailLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;;
     _imgV.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.contentView.backgroundColor = kUIColorFromRGB(color_4);
     
     _imgV.hidden = YES;
     _detailLb.hidden = YES;
     _lineTop.hidden = YES;
     _lineBottom.hidden = YES;
     _lineRight.hidden = YES;
     
     
     _titleLb.text = @"活动商品";
     _titleLb.y = 0;
     
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:16];
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 0;
     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 300)];
     _titleLb.height = size.height;
     _titleLb.width = size.width;
     _titleLb.x = __SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
     
     UIImageView *lineOne = [self.contentView viewWithTag:2017031501];
     if (!lineOne) {
          lineOne =  [UIImageView new];
          lineOne.x = 15;
          lineOne.y = _titleLb.height/2.0 +_titleLb.y;
          lineOne.width = _titleLb.x  - 10 -lineOne.x;
          lineOne.height = 2;
          lineOne.backgroundColor = kUIColorFromRGB(color_3);
          [self.contentView addSubview:lineOne];
     }
     
     UIImageView *lineTwo = [self.contentView viewWithTag:2017031502];
     if (!lineTwo) {
          lineTwo = [UIImageView new];
          lineTwo.x = _titleLb.x + _titleLb.width +10;
          lineTwo.y = lineOne.y;
          lineTwo.width = lineOne.width;
          lineTwo.height = 2;
          lineTwo.backgroundColor = kUIColorFromRGB(color_3);
          [self.contentView addSubview:lineTwo];
     }
     
}

-(void)fitTypeMode
{
     _detailLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;;
     _imgV.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     _imgV.hidden = YES;
     _detailLb.hidden = YES;
     _lineTop.hidden = YES;
     _lineBottom.hidden = YES;
     _lineRight.hidden = YES;
     
     self.height = 25;
     _titleLb.y = 0;
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.numberOfLines = 0;
     _titleLb.height = 25;
     _titleLb.width = 70;
     _titleLb.x = 0;
     _titleLb.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _titleLb.layer.cornerRadius = 6.0;
     _titleLb.layer.masksToBounds = YES;
     

}

-(void)fitTypeModeA
{
     _detailLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;;
     _imgV.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     _imgV.hidden = YES;
     _detailLb.hidden = YES;
     _lineTop.hidden = YES;
     _lineBottom.hidden = YES;
     _lineRight.hidden = YES;
     
     self.height = 25;
     _titleLb.y = 0;
     _titleLb.textColor = kUIColorFromRGB(color_2);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.numberOfLines = 0;
     _titleLb.height = 25;
     _titleLb.width = 70;
     _titleLb.x = 0;
     _titleLb.backgroundColor = kUIColorFromRGB(color_3);
     _titleLb.layer.cornerRadius = 6.0;
     _titleLb.layer.masksToBounds = YES;
     
     
}


-(void)fitShopMode:(NSIndexPath*)indexPath
{
    _detailLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;;
    _imgV.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    
    _imgV.hidden = NO;
    _detailLb.hidden = NO;
    _titleLb.hidden = NO;
    
    CGFloat  x = 15;
    if (indexPath.row %2 ==1) {
        x = 10;
    }
    
    _imgV.x = x ;
    _imgV.y = 10;
    _imgV.width = __SCREEN_SIZE.width/2.0 - 25;
    _imgV.height =  _imgV.width/310.0 *290;
    
    _titleLb.x = _imgV.x;
    _titleLb.y = _imgV.y+_imgV.height + 10;
    _titleLb.width = __SCREEN_SIZE.width/2.0 - 25;
    _titleLb.height = 15;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    
    _detailLb.textColor = kUIColorFromRGB(color_5);
    _detailLb.font = [UIFont systemFontOfSize:18];
    _detailLb.x = _imgV.x;
    _detailLb.y = _titleLb.y+_titleLb.height + 10;
    _detailLb.width = __SCREEN_SIZE.width/2.0 - 25;
    _detailLb.height = 18;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    
//    self.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
//    self.layer.borderWidth = 0.5;
    
    if (indexPath.row == 0 ||indexPath.row == 1) {
        if (!_lineTop) {
            _lineTop = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,__SCREEN_SIZE.width/2.0, 0.5)];
            _lineTop.backgroundColor = kUIColorFromRGB(color_3);
            [self.contentView addSubview:_lineTop];
        }
        _lineTop.hidden = NO;
    }else{
        _lineTop.hidden = YES;
    }
    
    if (_lineBottom == nil) {
        _lineBottom = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.height-1.0,__SCREEN_SIZE.width/2.0, 0.5)];
        _lineBottom.backgroundColor = kUIColorFromRGB(color_3);
        [self.contentView addSubview:_lineBottom];
        
        CGFloat y = (__SCREEN_SIZE.width/2.0 - 25.0)/310.0 *290+70;
//        _lineBottom = [[UIImageView alloc]initWithFrame:CGRectMake(0, y-0.5,__SCREEN_SIZE.width/2.0, 0.5)];
//        _lineBottom.backgroundColor = kUIColorFromRGB(color_3);
//        [self.contentView addSubview:_lineBottom];
        
        _lineRight = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width/2.0-0.5, 0,0.5, y)];
        _lineRight.backgroundColor = kUIColorFromRGB(color_3);
        [self.contentView addSubview:_lineRight];
    }
}

-(void)fitHistoryShopMode:(NSIndexPath*)indexPath
{
    _curIndexPath = indexPath;
    _detailLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;;
    _imgV.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    
    _imgV.hidden = NO;
    _detailLb.hidden = NO;
    _titleLb.hidden = NO;
    
    
    CGFloat  x = 15;
    if (indexPath.row %2 ==1) {
        x = 10;
    }
    
    _imgV.x = x ;
    _imgV.y = 10;
    _imgV.width = __SCREEN_SIZE.width/2.0 - 25;
    _imgV.height =  _imgV.width/310.0 *290;
    
    _titleLb.x = _imgV.x;
    _titleLb.y = _imgV.y+_imgV.height + 10;
    _titleLb.width = __SCREEN_SIZE.width/2.0 - 25;
    _titleLb.height = 15;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    
    _detailLb.textColor = kUIColorFromRGB(color_5);
    _detailLb.font = [UIFont systemFontOfSize:18];
    _detailLb.x = _imgV.x;
    _detailLb.y = _titleLb.y+_titleLb.height + 10;
    _detailLb.width = __SCREEN_SIZE.width/2.0 - 25;
    _detailLb.height = 18;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    
    //    self.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    //    self.layer.borderWidth = 0.5;
    
    if (indexPath.row == 0 ||indexPath.row == 1) {
        if (!_lineTop) {
            _lineTop = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,__SCREEN_SIZE.width/2.0, 0.5)];
            _lineTop.backgroundColor = kUIColorFromRGB(color_3);
            [self.contentView addSubview:_lineTop];
        }
        _lineTop.hidden = NO;
    }else{
        _lineTop.hidden = YES;
    }
    
    if (_lineBottom == nil) {
        _lineBottom = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.height-0.5,__SCREEN_SIZE.width/2.0, 0.5)];
        _lineBottom.backgroundColor = kUIColorFromRGB(color_3);
        [self.contentView addSubview:_lineBottom];
        
        CGFloat y = (__SCREEN_SIZE.width/2.0 - 25.0)/310.0 *290+70;
        //        _lineBottom = [[UIImageView alloc]initWithFrame:CGRectMake(0, y-0.5,__SCREEN_SIZE.width/2.0, 0.5)];
        //        _lineBottom.backgroundColor = kUIColorFromRGB(color_3);
        //        [self.contentView addSubview:_lineBottom];
        
        _lineRight = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width/2.0-0.5, 0,0.5, y)];
        _lineRight.backgroundColor = kUIColorFromRGB(color_3);
        [self.contentView addSubview:_lineRight];
    }
    
    UIButton *btn = [self.contentView viewWithTag:54333];
    if (!btn) {
        btn = [UIButton new];
        btn.tag = 54333;
    }
    btn.width = 30;
    btn.height = 30;
    btn.x = __SCREEN_SIZE.width/2.0 - 25 - 12;
    btn.y = _detailLb.y - 10;
    [btn setImage:[UIImage imageContentWithFileName:@"iconfontdel"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
}


-(void)fitFavShopMode:(NSIndexPath*)indexPath
{
    _curIndexPath = indexPath;
    _detailLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;;
    _imgV.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    
    _imgV.hidden = NO;
    _detailLb.hidden = NO;
    _titleLb.hidden = NO;
    
    
    CGFloat  x = 15;
    if (indexPath.row %2 ==1) {
        x = 10;
    }
    
    _imgV.x = x ;
    _imgV.y = 10;
    _imgV.width = __SCREEN_SIZE.width/2.0 - 25;
    _imgV.height =  _imgV.width/310.0 *290;
    
    _titleLb.x = _imgV.x;
    _titleLb.y = _imgV.y+_imgV.height + 10;
    _titleLb.width = __SCREEN_SIZE.width/2.0 - 25;
    _titleLb.height = 15;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    
    _detailLb.textColor = kUIColorFromRGB(color_5);
    _detailLb.font = [UIFont systemFontOfSize:18];
    _detailLb.x = _imgV.x;
    _detailLb.y = _titleLb.y+_titleLb.height + 10;
    _detailLb.width = __SCREEN_SIZE.width/2.0 - 25;
    _detailLb.height = 18;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    
    //    self.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    //    self.layer.borderWidth = 0.5;
    
    if (indexPath.row == 0 ||indexPath.row == 1) {
        if (!_lineTop) {
            _lineTop = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,__SCREEN_SIZE.width/2.0, 0.5)];
            _lineTop.backgroundColor = kUIColorFromRGB(color_3);
            [self.contentView addSubview:_lineTop];
        }
        _lineTop.hidden = NO;
    }else{
        _lineTop.hidden = YES;
    }
    
    if (_lineBottom == nil) {
        _lineBottom = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.height-0.5,__SCREEN_SIZE.width/2.0, 0.5)];
        _lineBottom.backgroundColor = kUIColorFromRGB(color_3);
        [self.contentView addSubview:_lineBottom];
        
        CGFloat y = (__SCREEN_SIZE.width/2.0 - 25.0)/310.0 *290+70;
        //        _lineBottom = [[UIImageView alloc]initWithFrame:CGRectMake(0, y-0.5,__SCREEN_SIZE.width/2.0, 0.5)];
        //        _lineBottom.backgroundColor = kUIColorFromRGB(color_3);
        //        [self.contentView addSubview:_lineBottom];
        
        _lineRight = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width/2.0-0.5, 0,0.5, y)];
        _lineRight.backgroundColor = kUIColorFromRGB(color_3);
        [self.contentView addSubview:_lineRight];
    }
    
    UIButton *btn = [self.contentView viewWithTag:54333];
    if (!btn) {
        btn = [UIButton new];
        btn.tag = 54333;
    }
    btn.width = 30;
    btn.height = 30;
    btn.x = __SCREEN_SIZE.width/2.0 - 25 - 12;
    btn.y = _detailLb.y - 10;
    [btn setImage:[UIImage imageContentWithFileName:@"icon_star_selected@2x"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
}


-(void)btnHandle:(UIButton *)btn
{
    if (_callBack) {
        _callBack(@{@"row":_curIndexPath?:@""});
    }
}
@end
