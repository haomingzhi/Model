//
//  IconTitleAndImgTableViewCell.m
//  lovecommunity
//
//  Created by air on 16/6/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "IconTitleAndImgTableViewCell.h"
#import "BUImageRes.h"
@implementation IconTitleAndImgTableViewCell
{
    BUImageRes *_curImgRes;
    IBOutlet UIImageView *_arrowImgV;
    IBOutlet UIImageView *_imgV;
    IBOutlet UILabel *_titleLb;

    IBOutlet UIView *_containerView;
    IBOutlet UILabel *_markLb;
     NSDictionary *_dataDic;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _markLb.backgroundColor = kUIColorFromRGB(color_2);
    _markLb.textColor = kUIColorFromRGB(color_8);
    _markLb.layer.cornerRadius = 7;
    _markLb.layer.masksToBounds = YES;
    _titleLb.textColor = kUIColorFromRGB(color_1);
     _markLb.hidden = YES;
}

-(void)setCellData:(NSDictionary *)dataDic
{
     _dataDic = dataDic;
    _titleLb.text = dataDic[@"title"];
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

    _markLb.text = dataDic[@"mark"];
    
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

-(void)iconTitleMode:(CGFloat )height withImgHeight:(CGFloat)iHeihgt withColor:(UIColor *)color withNeedDot:(BOOL)b
{
    [self iconTitleMode:height withImgHeight:iHeihgt withColor:color];
    UIView *mv = [self.contentView viewWithTag:21144];
    if (!mv) {
        mv = [[UIView alloc] initWithFrame:CGRectMake(35, 5, 6, 6)];
        mv.tag = 21144;
        mv.layer.cornerRadius = 3;
        mv.backgroundColor = kUIColorFromRGB(color_8);
        mv.layer.masksToBounds = YES;
    }
    [self.contentView addSubview:mv];
    mv.hidden = !b;
    
}

-(void)iconTitleMode:(CGFloat )height withImgHeight:(CGFloat)iHeihgt withColor:(UIColor *)color
{
//    _markLb.hidden = YES;
    _markLb.height = 13;
    _markLb.width = 20;
    _markLb.textColor = kUIColorFromRGB(color_2);
    _markLb.backgroundColor = color;
    _markLb.layer.cornerRadius = 4;
    _markLb.layer.masksToBounds = YES;
   
    _imgV.height = iHeihgt;
    _imgV.width = iHeihgt;
    _imgV.y = height/2.0 - _imgV.height/2.0;
    _titleLb.y = height/2.0 - _titleLb.height/2.0;
    _titleLb.x = _imgV.x + _imgV.width + 12;
    _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_7);
    self.height = height;
    _markLb.y = self.height/2.0 - _markLb.height/2;
    _markLb.x = __SCREEN_SIZE.width - 51;
    if (!_markLb.text ||[_markLb.text isEqualToString:@"0"] || [_markLb.text isEqualToString:@""]) {
        _markLb.hidden = YES;
    }
    else
    {
        _markLb.hidden = NO;
    }
    _arrowImgV.hidden = NO;
    _arrowImgV.image = [UIImage imageContentWithFileName:@"rightArrow2"];
    _arrowImgV.y = self.height/2.0 - _arrowImgV.height/2;
    _arrowImgV.x = __SCREEN_SIZE.width - 15 - 9;
//    _arrowImgV.backgroundColor = kUIColorFromRGB(color_3);
    UIView *mv = [self.contentView viewWithTag:21144];
    mv.hidden = YES;
}

-(void)fitMode
{
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _containerView.x = 15;
    _containerView.height = 35;
    _containerView.width = __SCREEN_SIZE.width - 30;
    [self iconTitleMode:36 withImgHeight:18 withColor:kUIColorFromRGB(color_3)];
    
}

-(void)fitMineMode
{
     _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _containerView.x = 0;
     _containerView.height = 43;
     _containerView.width = __SCREEN_SIZE.width;
     [self iconTitleMode:44 withImgHeight:17 withColor:kUIColorFromRGB(color_3)];
     UILabel *detailLb = [_containerView viewWithTag:9890];
     if(!detailLb)
     {
          detailLb = [UILabel new];
          detailLb.width = 120;
          detailLb.height = 15;
          detailLb.x = __SCREEN_SIZE.width - 40 - detailLb.width;
          detailLb.y = _containerView.height/2.0 - detailLb.height/2.0;
          detailLb.tag = 9890;
          detailLb.font = [UIFont systemFontOfSize:15];
          detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     }
     detailLb.textAlignment = NSTextAlignmentRight;
     detailLb.text = _dataDic[@"detail"];
     [_containerView addSubview:detailLb];
}

-(void)fitSettingMode
{
     self.height = 60;
     _containerView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _containerView.x = 0;
     _containerView.height = 60;
     _containerView.width = __SCREEN_SIZE.width;
     [self iconTitleMode:60 withImgHeight:50 withColor:kUIColorFromRGB(color_1)];
     _imgV.layer.cornerRadius = _imgV.height/2.0;
     _imgV.layer.masksToBounds = YES;
     UIImage *img = _imgV.image;
     if (img.size.height/(img.size.width*1.0) == 1.0) {

     }
     else
          _imgV.image = [img getSubImage:CGRectMake(0, 0, _imgV.width, _imgV.height) centerBool:YES  canScale:YES];

     UILabel *detailLb = [_containerView viewWithTag:9890];
     if(!detailLb)
     {
          detailLb = [UILabel new];
          detailLb.width = 120;
          detailLb.height = 15;
          detailLb.x = __SCREEN_SIZE.width - 40 - detailLb.width;
          detailLb.y = _containerView.height/2.0 - detailLb.height/2.0;
          detailLb.tag = 9890;
          detailLb.font = [UIFont systemFontOfSize:15];
          detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     }
     detailLb.textAlignment = NSTextAlignmentRight;
     detailLb.text = _dataDic[@"detail"];
     [_containerView addSubview:detailLb];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)fitconfirmOrderMode:(BOOL)isSelected{
    _arrowImgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.height = 40;
    _imgV.width = _imgV.height = 30;
    _imgV.x = 15;
    _imgV.y = self.height/2.0 - _imgV.height/2.0;
    
    _titleLb.x = _imgV.x+_imgV.width +10;
    _titleLb.y = 0;
    _titleLb.height = self.height;
    _titleLb.width = 200;
    
    _markLb.hidden = YES;
    
    _arrowImgV.width = _arrowImgV.height = 18.5;
    _arrowImgV.x = __SCREEN_SIZE.width - _arrowImgV.width - 15;
    _arrowImgV.y = self.height/2.0 - _arrowImgV.height/2.0;
    if (isSelected) {
        _arrowImgV.image = [UIImage imageNamed:@"icon_round_selected"];
    }else{
        _arrowImgV.image = [UIImage imageNamed:@"icon_round_normal"];
    }
    _arrowImgV.hidden = NO;
    
}

-(void)fitBuyStyleMode{
    self.height = 40;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    _arrowImgV.hidden = YES;
    
    _titleLb.x = 15;
    _titleLb.y = 0;
    _titleLb.height = self.height;
    _titleLb.width = 300;
    
    _markLb.hidden = YES;
    
    _imgV.width = _imgV.height = 18.5;
    _imgV.x = __SCREEN_SIZE.width - _imgV.width - 15;
    _imgV.y = self.height/2.0 - _imgV.height/2.0;
    
}

@end
