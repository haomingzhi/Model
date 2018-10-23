//
//  ImgAndThreeTitleTableViewCell.m
//  taihe
//
//  Created by air on 2016/11/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ImgAndThreeTitleTableViewCell.h"
#import "BUImageRes.h"
#import "BUSystem.h"
@implementation ImgAndThreeTitleTableViewCell
{
    IBOutlet UILabel *_timeLb;
    BUImageRes *_curImgRes;
    IBOutlet UILabel *_dataSourceLb;
    IBOutlet UILabel *_titleLb;
//    IBOutlet UIImageView *_imgV;
    CWStarRateView *_starView;
    NSDictionary *_dataDic;
    UIImageView *_arrowImgV;
     NSInteger _hour;
     NSInteger _second;
     NSInteger _minute;
     NSTimer *_timer;
}
- (void)awakeFromNib {
    [super awakeFromNib];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(imgChangeHandle:) name:@"imgChange" object:self];
       _imgV.contentMode = UIViewContentModeCenter;
    // Initialization code
}


-(void)imgChangeHandle:(NSNotification *)noti
{
     if (self.imgChangeHandle) {
          self.imgChangeHandle(nil);
     }
     else
     {

     }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCellData:(NSDictionary *)dataDic
{
          _imgV.contentMode = UIViewContentModeCenter;
    _dataDic = dataDic;
    if (dataDic[@"time"]) {
        _timeLb.text = dataDic[@"time"];
    }
    if (dataDic[@"source"]) {
        _dataSourceLb.text = dataDic[@"source"];
    }
    if (dataDic[@"title"]) {
        _titleLb.text = dataDic[@"title"];
    }
    
    _imgV.image = [UIImage imageContentWithFileName:dataDic[@"default"]];
//    _imgV.contentMode = UIViewContentModeCenter;
      _imgV.backgroundColor = kUIColorFromRGB(color_f8f8f8);
    id imgObjc = dataDic[@"img"];
    if ([imgObjc isKindOfClass:[BUImageRes class]]) {
        BUImageRes *img = (BUImageRes *)imgObjc;
        _curImgRes = img;
        if (img.isCached) {
            UIImage *im =  [UIImage imageWithContentsOfFile:img.cacheFile];
            if (im) {
                _imgV.image = im;
                 _imgV.contentMode = UIViewContentModeScaleToFill;
//                 _imgV.backgroundColor = kUIColorFromRGB(color_2);
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
            _imgV.image = im;
//             _imgV.contentMode = UIViewContentModeScaleToFill;
        }
        
    }
    else if([imgObjc isKindOfClass:[UIImage class]])
    {
        _imgV.image = imgObjc;
//          _imgV.contentMode = UIViewContentModeScaleToFill;
    }
    
    
    
    
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
                 _imgV.contentMode = UIViewContentModeScaleToFill;
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"imgChange" object:self];
//                 _imgV.backgroundColor = kUIColorFromRGB(color_2);
            }
            
        }
    }
}

-(void)fitEvalutionMode{
     self.contentView.backgroundColor = kUIColorFromRGB(color_4);
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 15;
     _imgV.y = 10;
     _imgV.width = 31;
     _imgV.height = 31;
     _imgV.layer.masksToBounds = YES;
     _imgV.layer.cornerRadius = 15.5;
     
     
     
     _timeLb.y = 19;
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.numberOfLines = 1;
     [_timeLb sizeToFit];
     _timeLb.x = __SCREEN_SIZE.width - _timeLb.width -15;
     _timeLb.textColor = kUIColorFromRGB(color_8);
     
     if (_starView == nil) {
          _starView = [[CWStarRateView alloc]initWithFrame:CGRectMake(_timeLb.x - 12 - 103, 19, 103, 15) numberOfStars:5];
          _starView.userInteractionEnabled = NO;
          [self.contentView addSubview:_starView];
     }
     _starView.scorePercent = [_dataDic[@"starNumber"] floatValue];
     
     
     _starView.x =  _timeLb.x - 12 - _starView.width;
     //    _starView.y = _titleLb.y +_titleLb.height+10;
     
     
     
     _titleLb.x = _imgV.x +_imgV.width +10;
     _titleLb.y = 19;
     _titleLb.width = _starView.x - _titleLb.x -12;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     
     
     
     
     
     
     _dataSourceLb.x = 15;
     _dataSourceLb.y = _imgV.y  + _imgV.height +10;
     _dataSourceLb.width = __SCREEN_SIZE.width - 30;
     _dataSourceLb.font = [UIFont systemFontOfSize:14];
     _dataSourceLb.textColor = kUIColorFromRGB(color_7);
     _dataSourceLb.numberOfLines = 0;
     CGSize size = [_dataSourceLb.text size:_dataSourceLb.font constrainedToSize:CGSizeMake(_dataSourceLb.width, __SCREEN_SIZE.height*3)];
     _dataSourceLb.height = size.height;
     
     self.height = _dataSourceLb.y +_dataSourceLb.height + 8;
     
     
}
-(void)fitNoCashApproveMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 0;
     _imgV.y = 0;
     _imgV.width = __SCREEN_SIZE.width;
     _imgV.height = 160 + NAVBARHEIGHT;
     [self.contentView sendSubviewToBack:_imgV];
     _titleLb.width = __SCREEN_SIZE.width;
     _titleLb.textColor = kUIColorFromRGB(color_2);
     _titleLb.y = 20 + NAVBARHEIGHT;
     _titleLb.x = 0;
   _titleLb.textAlignment = NSTextAlignmentCenter;
     _imgV.contentMode = UIViewContentModeScaleToFill;
     _timeLb.width = __SCREEN_SIZE.width;
     _timeLb.textColor = kUIColorFromRGB(color_2);
     _timeLb.y = 20 + _titleLb.y + _titleLb.height;
     _timeLb.x = 0;
     _timeLb.font = [UIFont systemFontOfSize:18];
     _timeLb.textAlignment = NSTextAlignmentCenter;

     _dataSourceLb.width = __SCREEN_SIZE.width;
     _dataSourceLb.textColor = kUIColorFromRGB(color_2);
     _dataSourceLb.y = 20 + _timeLb.y + _timeLb.height;
     _dataSourceLb.x = 0;
   _dataSourceLb.textAlignment = NSTextAlignmentCenter;

     self.height = 160 + NAVBARHEIGHT;
}
-(void)fitGoodsInfoMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.hidden = YES;
     
      self.height = 85;
 
     
     _titleLb.x = 15;
     _titleLb.y = 10;
     _titleLb.width = __SCREEN_SIZE.width-30;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     _titleLb.textAlignment = NSTextAlignmentLeft;
//     [_titleLb sizeToFit];
     
     
     
     
     _dataSourceLb.x = 15;
     _dataSourceLb.y = 34;
     _dataSourceLb.width = __SCREEN_SIZE.width - 30;
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     _dataSourceLb.textColor = kUIColorFromRGB(color_6);
     _dataSourceLb.numberOfLines = 1;
     _dataSourceLb.height = 12;
     _dataSourceLb.textAlignment = NSTextAlignmentLeft;
//     [_dataSourceLb sizeToFit];
    
     _timeLb.y = 56;
     _timeLb.font = [UIFont systemFontOfSize:18];
     _timeLb.numberOfLines = 1;
     _timeLb.x = 15;
     _timeLb.width = __SCREEN_SIZE.width/2.0 - 8-15;
     _timeLb.height = 20;
     _timeLb.textColor = kUIColorFromRGB(color_0xec7e3b);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     [_timeLb sizeToFit];
     
     UILabel *priceLb = [self.contentView viewWithTag:7930];
     if (!priceLb) {
          priceLb = [[UILabel alloc]init];
          priceLb.tag = 7930;
          priceLb.y = _timeLb.y;
          priceLb.width = 200;
          priceLb.height = _timeLb.height;
          priceLb.font = [UIFont systemFontOfSize:13];;
          priceLb.textColor = kUIColorFromRGB(color_6);
          [self.contentView addSubview:priceLb];
     }
     priceLb.x= _timeLb.x  +_timeLb.width + 12;
     priceLb.text = _dataDic[@"price"];
     
     
     NSString *stateStr = _dataDic[@"state"];
     if (stateStr.length != 0) {
          UILabel *stateLb = [self.contentView viewWithTag:1636];
          if (!stateLb) {
               stateLb = [[UILabel alloc]init];
               stateLb.tag = 1636;
               stateLb.x= __SCREEN_SIZE.width - 55 - 15;;
               stateLb.y = 52;
               stateLb.width = 55;
               stateLb.height = 20;
               stateLb.font = [UIFont systemFontOfSize:9];;
               stateLb.textColor = kUIColorFromRGB(color_3);
               stateLb.layer.cornerRadius = 6.0;
               stateLb.layer.masksToBounds = YES;
               stateLb.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
               stateLb.layer.borderWidth = 0.5;
               stateLb.textAlignment = NSTextAlignmentCenter;
               [self.contentView addSubview:stateLb];
          }
          stateLb.hidden = NO;
          stateLb.text = _dataDic[@"state"];
          
          
          UILabel *vipPriceLb = [self.contentView viewWithTag:1643];
          if (!vipPriceLb) {
               vipPriceLb = [[UILabel alloc]init];
               vipPriceLb.tag = 1643;
              
               vipPriceLb.y = 52;
               vipPriceLb.width = 55;
               
               vipPriceLb.font = [UIFont systemFontOfSize:9];;
               vipPriceLb.textColor = kUIColorFromRGB(color_2);
               vipPriceLb.backgroundColor = kUIColorFromRGB(color_3);
               vipPriceLb.layer.cornerRadius = 6.0;
               vipPriceLb.layer.masksToBounds = YES;
               vipPriceLb.textAlignment = NSTextAlignmentCenter;
               [self.contentView addSubview:vipPriceLb];
          }
          vipPriceLb.text = _dataDic[@"vipPrice"];
          [vipPriceLb sizeToFit];
          vipPriceLb.height = 20;
          vipPriceLb.width +=20;
           vipPriceLb.x= stateLb.x - 15- vipPriceLb.width;
     }else{
          UILabel *vipPriceLb = [self.contentView viewWithTag:1643];
          if (!vipPriceLb) {
               vipPriceLb = [[UILabel alloc]init];
               vipPriceLb.tag = 1643;
               
               vipPriceLb.y = 52;
               vipPriceLb.font = [UIFont systemFontOfSize:9];;
               vipPriceLb.textColor = kUIColorFromRGB(color_2);
               vipPriceLb.backgroundColor = kUIColorFromRGB(color_3);
               vipPriceLb.layer.cornerRadius = 6.0;
               vipPriceLb.layer.masksToBounds = YES;
               vipPriceLb.textAlignment = NSTextAlignmentCenter;
               [self.contentView addSubview:vipPriceLb];
          }
          vipPriceLb.text = _dataDic[@"vipPrice"];
          [vipPriceLb sizeToFit];
          vipPriceLb.height = 20;
          vipPriceLb.width +=15;
          vipPriceLb.x= __SCREEN_SIZE.width - vipPriceLb.width - 15;;
          
          UILabel *stateLb = [self.contentView viewWithTag:1636];
           stateLb.hidden = YES;
     }
     
     
}


-(void)fitGoodsInfoModeA{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     self.height = 70;
     
     _imgV.x = 14;
     _imgV.y = self.height/2.0 - 17;
     _imgV.width = 34;
     _imgV.height = 34;
     _imgV.layer.masksToBounds = YES;
     _imgV.layer.cornerRadius = 17;
     
     _titleLb.x = 64;
     _titleLb.y = 18;
     _titleLb.width = 200;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.numberOfLines = 1;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     
     
     
     
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = 40;
     _dataSourceLb.width = 200;
     _dataSourceLb.font = [UIFont systemFontOfSize:13];
     _dataSourceLb.textColor = kUIColorFromRGB(color_7);
     _dataSourceLb.numberOfLines = 1;
     _dataSourceLb.height = 14;
     _dataSourceLb.textAlignment = NSTextAlignmentLeft;
     
     
     _timeLb.width = 200;
     _timeLb.height = 20;
     _timeLb.y = self.height/2.0 -_timeLb.height/2.0;
     _timeLb.x = __SCREEN_SIZE.width - _timeLb.width -40;
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.numberOfLines = 1;
     _timeLb.textColor = kUIColorFromRGB(color_7);
     _timeLb.textAlignment = NSTextAlignmentRight;
     

     if (!_arrowImgV) {
          _arrowImgV = [[UIImageView alloc]init];
         
          _arrowImgV.width = 10;
          _arrowImgV.height = 18;
          _arrowImgV.x= __SCREEN_SIZE.width-15-_arrowImgV.width;
          _arrowImgV.y = self.height/2.0 - _arrowImgV.height/2.0;
          _arrowImgV.image = [UIImage imageNamed:@"rightArrow2"];
          [self.contentView addSubview:_arrowImgV];
     }

     
}


-(void)fitSpecialEvalutionMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 15;
     _imgV.y = 10;
     _imgV.width = 31;
     _imgV.height = 31;
     _imgV.layer.masksToBounds = YES;
     _imgV.layer.cornerRadius = 15.5;
     
     
     
     
     
     UIButton *reportBtn = [self.contentView viewWithTag:1553];
     if(!reportBtn){
          reportBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 25- 15, 20, 25, 15)];
          reportBtn.tag = 1553;
          [reportBtn setImage:[UIImage imageNamed:@"icon_report"] forState:UIControlStateNormal];
          [reportBtn addTarget:self action:@selector(reportAction) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:reportBtn];
     }
     
     
     _titleLb.x = _imgV.x +_imgV.width +10;
     _titleLb.y = 20;
     _titleLb.width = reportBtn.x - _titleLb.x -12;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     
     
     
     
     
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y  + _titleLb.height +8;
     _dataSourceLb.width = __SCREEN_SIZE.width - _dataSourceLb.x  -17;
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     _dataSourceLb.textColor = kUIColorFromRGB(color_7);
     _dataSourceLb.numberOfLines = 0;
     [_dataSourceLb sizeToFit];
     
     
     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height +10 ;
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.numberOfLines = 1;
     _timeLb.x = _titleLb.x;
     _titleLb.height = 13;
     _timeLb.textColor = kUIColorFromRGB(color_8);
     
     self.height = _timeLb.y +_timeLb.height + 6;
     
     UIImageView *loveImg =[self.contentView viewWithTag:1605];
     if(!loveImg){
          loveImg = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 126-12, _timeLb.y, 14, 12)];
          loveImg.tag = 1605;
          loveImg.image = [UIImage imageNamed:@"icon_love"];
          [self.contentView addSubview:loveImg];
     }
     
     UILabel *loveLb = [self.contentView viewWithTag:1607];
     if(!loveLb){
          loveLb = [[UILabel alloc]initWithFrame:CGRectMake(loveImg.x+loveImg.width+10, _timeLb.y, 50, 12)];
          loveLb.tag = 1607;
          loveLb.font = [UIFont systemFontOfSize:13];
          loveLb.textColor = kUIColorFromRGB(color_8);
          [self.contentView addSubview:loveLb];
     }
     
     
     
     
     UIImageView *evalutionImg =[self.contentView viewWithTag:1611];
     if(!evalutionImg){
          evalutionImg = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 54-15, _timeLb.y, 17, 15)];
          evalutionImg.tag = 1611;
          evalutionImg.image = [UIImage imageNamed:@"icon_chat"];
          [self.contentView addSubview:evalutionImg];
     }
     
     UILabel *evalutionLb = [self.contentView viewWithTag:1612];
     if(!evalutionLb){
          evalutionLb = [[UILabel alloc]initWithFrame:CGRectMake(evalutionImg.x+evalutionImg.width+10, _timeLb.y, 50, 12)];
          evalutionLb.tag = 1612;
          evalutionLb.font = [UIFont systemFontOfSize:13];
          evalutionLb.textColor = kUIColorFromRGB(color_8);
          [self.contentView addSubview:evalutionLb];
     }
     
     
     loveLb.text = _dataDic[@"love"];
     evalutionLb.text = _dataDic[@"evalution"];
     
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zangAction:)];
     [loveLb addGestureRecognizer:tap];
     [loveImg addGestureRecognizer:tap];
     
     UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(evaAction:)];
     [loveLb addGestureRecognizer:tap2];
     [loveImg addGestureRecognizer:tap2];
}

-(void)fitTopicModeB
{
     [self fitAnswerInfoMode];
     UIButton *aBtn = [self.contentView viewWithTag:2999];
     if(!aBtn)
     {
          aBtn = [UIButton new];
          aBtn.width = _titleLb.width + 10;
          aBtn.height = _titleLb.height + 8;
          aBtn.x = _titleLb.x - 5;
          aBtn.y = _titleLb.y - 4;
          aBtn.tag = 2999;
          [aBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
     }
     [self.contentView addSubview:aBtn];

}
-(void)fitAnswerInfoMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 15;
     _imgV.y = 10;
     _imgV.width = 31;
     _imgV.height = 31;
     _imgV.layer.masksToBounds = YES;
     _imgV.layer.cornerRadius = 15.5;

     UIButton *reportBtn = [self.contentView viewWithTag:1553];
     if(!reportBtn){
          reportBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 25- 15, 20, 25, 15)];
          reportBtn.tag = 1553;
          [reportBtn setImage:[UIImage imageNamed:@"icon_report"] forState:UIControlStateNormal];
          [reportBtn addTarget:self action:@selector(reportAction) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:reportBtn];
     }
     
     
     _titleLb.x = _imgV.x +_imgV.width + 15;
     _titleLb.y = 20;
     _titleLb.width = reportBtn.x - _titleLb.x -12;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     
     
     
     
     
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y  + _titleLb.height +8;
     _dataSourceLb.width = __SCREEN_SIZE.width - _dataSourceLb.x  -17;
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     _dataSourceLb.textColor = kUIColorFromRGB(color_7);
     _dataSourceLb.numberOfLines = 0;
     [_dataSourceLb sizeToFit];
     
     
     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height +10 ;
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.numberOfLines = 1;
     _timeLb.x = _titleLb.x;
     _titleLb.height = 13;
     _timeLb.textColor = kUIColorFromRGB(color_8);
     _timeLb.hidden = YES;
     self.height = _dataSourceLb.y +_dataSourceLb.height + 10;
     
    }


-(void)fitEvaMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     
     _imgV.x = 15;
     _imgV.y = 10;
     _imgV.width = 30;
     _imgV.height = 30;
     _imgV.layer.masksToBounds = YES;
     _imgV.layer.cornerRadius = _imgV.height/2.0;
     _imgV.contentMode = UIViewContentModeScaleToFill;
     
//     UIButton *reportBtn = [self.contentView viewWithTag:1553];
//     if(!reportBtn){
//          reportBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 25- 15, 20, 25, 15)];
//          reportBtn.tag = 1553;
//          [reportBtn setImage:[UIImage imageNamed:@"icon_report"] forState:UIControlStateNormal];
//          [reportBtn addTarget:self action:@selector(reportAction) forControlEvents:UIControlEventTouchUpInside];
//          [self.contentView addSubview:reportBtn];
//     }
//
     
     _titleLb.x = 60;
     _titleLb.y = 12;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.numberOfLines = 1;
     
     
     
     
     
     
     _dataSourceLb.x = 15;
     _dataSourceLb.y = 60;
     _dataSourceLb.width = __SCREEN_SIZE.width - _dataSourceLb.x - 15;
     _dataSourceLb.font = [UIFont systemFontOfSize:13];
     _dataSourceLb.textColor = kUIColorFromRGB(color_5);
     _dataSourceLb.numberOfLines = 0;
     [_dataSourceLb sizeToFit];
     
     
     
     _timeLb.x = _titleLb.x;
     _timeLb.y = _titleLb.y + _titleLb.height +10;
     _timeLb.width = 200;
     _timeLb.height = 12;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _timeLb.numberOfLines = 1;
     _timeLb.textAlignment = NSTextAlignmentLeft;
     
    self.height = _dataSourceLb.y + _dataSourceLb.height +10;
}


-(void)fitSelectAddressModeA{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 55;
     
     _imgV.hidden = YES;
     
     UIButton *reportBtn = [self.contentView viewWithTag:1553];
     if(!reportBtn){
          reportBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 45, 0, 45, self.height)];
          reportBtn.tag = 1553;
          [reportBtn setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
          [reportBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:reportBtn];
     }
     
     
     _titleLb.x = 15;
     _titleLb.y = 10;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     
     
     
     
     
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y  + _titleLb.height +10;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     _dataSourceLb.textColor = kUIColorFromRGB(color_8);
     _dataSourceLb.numberOfLines = 1;
     
     
     _timeLb.hidden = YES;
     
     
}

-(void)fitTopicMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
//     self.height = 60;
     
     _imgV.x = 15;
     _imgV.y = 10;
     _imgV.width = __SCREEN_SIZE.width-30;
     _imgV.height = 110/330.0*_imgV.width;
     
     
     
     
     
//     UIButton *reportBtn = [self.contentView viewWithTag:1553];
//     if(!reportBtn){
//          reportBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 25- 15, 20, 25, 15)];
//          reportBtn.tag = 1553;
//          [reportBtn setImage:[UIImage imageNamed:@"icon_report"] forState:UIControlStateNormal];
//          [reportBtn addTarget:self action:@selector(reportAction) forControlEvents:UIControlEventTouchUpInside];
//          [self.contentView addSubview:reportBtn];
//     }
     
     
     _titleLb.x = 35;
     _titleLb.y = 10;
     _titleLb.width = 75;
     _titleLb.height = 20;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_2);
     _titleLb.numberOfLines = 1;
     _titleLb.backgroundColor = kUIColorFromRGB(color_3);
     _titleLb.textAlignment = NSTextAlignmentCenter;
     
     UILabel *label = [self.contentView viewWithTag:1404];
     if (!label) {
          label = [UILabel new];
          label.text = @"最佳回答";
          label.textColor = kUIColorFromRGB(color_1);
          label.font = [UIFont systemFontOfSize:13];
          label.tag = 1404;
          label.x = 15;
          label.y = _imgV.y + _imgV.height +10;
          label.width = 200;
          label.height = 13;
          [self.contentView addSubview:label];
     }
     
     
     
     _dataSourceLb.x = 15;
     _dataSourceLb.y = label.y  + label.height +10;
     _dataSourceLb.width = __SCREEN_SIZE.width - 30;
     _dataSourceLb.font = [UIFont systemFontOfSize:13];
     _dataSourceLb.textColor = kUIColorFromRGB(color_1);
     _dataSourceLb.numberOfLines = 0;
     [_dataSourceLb sizeToFit];
     
     _timeLb.x = 15;
     _timeLb.y = _dataSourceLb.y  + _dataSourceLb.height +10;
     _timeLb.width = __SCREEN_SIZE.width - 30;
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.textColor = kUIColorFromRGB(color_3);
     
     NSRange range = [_timeLb.text rangeOfString:@"标签："];
     NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:_timeLb.text];
     [attr addAttribute:NSForegroundColorAttributeName  //文字颜色
                               value:kUIColorFromRGB(color_1)
                               range:range];
     _timeLb.attributedText = attr;
     
     self.height = _timeLb.y + _timeLb.height +15;
}



-(void)fitFavEvaMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 60;
     
     _imgV.x = 15;
     _imgV.y = 15;
     _imgV.width = 31;
     _imgV.height = 31;
     _imgV.layer.masksToBounds = YES;
     _imgV.layer.cornerRadius = 15.5;

     
     _titleLb.x = _imgV.x +_imgV.width +10;
     _titleLb.y = 15;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.numberOfLines = 1;
     

     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y  + _titleLb.height + 10;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     _dataSourceLb.height = 12;
     _dataSourceLb.textColor = kUIColorFromRGB(color_7);
     _dataSourceLb.numberOfLines = 1;
     
     
     _timeLb.hidden = YES;
     
     
}

-(void)fitMyEvaModeC
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 56;

     _imgV.x = 15;
     _imgV.y = 15;
     _imgV.width = 31;
     _imgV.height = 31;
     _imgV.layer.masksToBounds = YES;
     _imgV.layer.cornerRadius = 15.5;
     _imgV.contentMode = UIViewContentModeScaleToFill;

     //     UIButton *reportBtn = [self.contentView viewWithTag:1553];
     //     if(!reportBtn){
     //          reportBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 25- 15, 15, 25, 15)];
     //          reportBtn.tag = 1553;
     //          [reportBtn setImage:[UIImage imageNamed:@"icon_report"] forState:UIControlStateNormal];
     //          [reportBtn addTarget:self action:@selector(reportAction) forControlEvents:UIControlEventTouchUpInside];
     //          [self.contentView addSubview:reportBtn];
     //     }


     _titleLb.x = _imgV.x +_imgV.width +10;
     _titleLb.y = 15;
     _titleLb.width = __SCREEN_SIZE.width - 50 - _titleLb.x -12;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.numberOfLines = 1;






     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y  + _titleLb.height +8;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _dataSourceLb.numberOfLines = 0;
     _dataSourceLb.height = 12;


     _timeLb.hidden = YES;
      UIView *v = [self.contentView viewWithTag:9211];
     [v removeFromSuperview];

}

-(void)fitEvaInfoMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 45;
     
     _imgV.x = 15;
     _imgV.y = 6;
     _imgV.width = 31;
     _imgV.height = 31;
     _imgV.layer.masksToBounds = YES;
     _imgV.layer.cornerRadius = 15.5;
     
     
//     UIButton *reportBtn = [self.contentView viewWithTag:1553];
//     if(!reportBtn){
//          reportBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 25- 15, 15, 25, 15)];
//          reportBtn.tag = 1553;
//          [reportBtn setImage:[UIImage imageNamed:@"icon_report"] forState:UIControlStateNormal];
//          [reportBtn addTarget:self action:@selector(reportAction) forControlEvents:UIControlEventTouchUpInside];
//          [self.contentView addSubview:reportBtn];
//     }

     
     _titleLb.x = _imgV.x +_imgV.width +10;
     _titleLb.y = 7;
     _titleLb.width = __SCREEN_SIZE.width - 50 - _titleLb.x -12;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.numberOfLines = 1;
     
     
     
     
     
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y  + _titleLb.height +5;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     _dataSourceLb.textColor = kUIColorFromRGB(color_7);
     _dataSourceLb.numberOfLines = 0;
     _dataSourceLb.height = 12;
     
     
     _timeLb.hidden = YES;
     
     
}


-(void)reportAction{
     if (self.handleAction) {
          self.handleAction(@{@"index":@"0"});
     }
}

-(void)zangAction:(UIGestureRecognizer *)gesture{
     if (self.handleAction) {
          self.handleAction(@{@"index":@"1"});
     }
}

-(void)evaAction:(UIGestureRecognizer *)gesture{
     if (self.handleAction) {
          self.handleAction(@{@"index":@"2"});
     }
}

-(void)fitEvaluationInfoMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 85;
     
     _imgV.width = 31;
     _imgV.height = 31;
     _imgV.x = 15;
     _imgV.y = 15;
     
     _titleLb.x = 60;
     _titleLb.y = 10;
     _titleLb.width = __SCREEN_SIZE.width - 15 - _titleLb.x;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     _titleLb.height = 15;
     _titleLb.numberOfLines = 1;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +8;
     _dataSourceLb.font = [UIFont systemFontOfSize:13];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0x757575);
     _dataSourceLb.numberOfLines = 0;
     _dataSourceLb.textAlignment = NSTextAlignmentLeft;
     CGSize s = [_dataSourceLb.text size:_dataSourceLb.font constrainedToSize:CGSizeMake(_dataSourceLb.width, __SCREEN_SIZE.height)];
     _dataSourceLb.height = s.height;
     
     NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:_dataSourceLb.text];;
     NSRange range = [_dataSourceLb.text rangeOfString:_dataDic[@"text"]];
     //设置字号
     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range];
     //设置文字颜色
     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_3) range:range];
     _dataSourceLb.attributedText = str;
     
     _timeLb.x = _titleLb.x;
     _timeLb.y = _dataSourceLb.y+_dataSourceLb.height+8;
     _timeLb.width = _titleLb.width;
     _timeLb.font = [UIFont systemFontOfSize:11];
     _timeLb.textColor = kUIColorFromRGB(color_8);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.numberOfLines = 1;
     _timeLb.height = 12;
     
     self.height = _timeLb.y +_timeLb.height +15;
     
}

-(void)fitAddressMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.height = 68;
    
    _imgV.width = 7.5;
    _imgV.height = 14;
    _imgV.x = __SCREEN_SIZE.width - _imgV.width-15;
    _imgV.y = self.height/2.0 - _imgV.height/2.0;
    _imgV.image = [UIImage imageNamed:@"rightArrow2"];
    
    _titleLb.x = 15;
    _titleLb.y = 10;
    _titleLb.width = 200;
    _titleLb.font = [UIFont systemFontOfSize:13];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.height = 15;
    _titleLb.numberOfLines = 1;
    _titleLb.textAlignment = NSTextAlignmentLeft;
    
    _dataSourceLb.width = 200;
    _dataSourceLb.height = 10;
    _dataSourceLb.x = _imgV.x - _dataSourceLb.width - 10;
    _dataSourceLb.y = _titleLb.y;
    _dataSourceLb.font = [UIFont systemFontOfSize:13];
    _dataSourceLb.textColor = kUIColorFromRGB(color_1);
    _dataSourceLb.numberOfLines = 1;
    _dataSourceLb.textAlignment = NSTextAlignmentRight;
    
    _timeLb.x = _titleLb.x;
    _timeLb.y = _titleLb.y+_titleLb.height+7;
    _timeLb.width = _imgV.x - 2*_timeLb.x;
    _timeLb.font = [UIFont systemFontOfSize:13];
    _timeLb.textColor = kUIColorFromRGB(color_1);
    _timeLb.textAlignment = NSTextAlignmentLeft;
    _timeLb.numberOfLines = 2;
    CGSize size = [_timeLb.text size:_timeLb.font constrainedToSize:CGSizeMake(_timeLb.width, 40)];
    _timeLb.height = size.height;
    
    _dataSourceLb.hidden = NO;
    _timeLb.hidden = NO;
    
  

}

-(void)fitNoAddressMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.height = 90;
    
    _imgV.width = 7.5;
    _imgV.height = 14;
    _imgV.x = __SCREEN_SIZE.width - _imgV.width-15;
    _imgV.y = self.height/2.0 - _imgV.height/2.0;
    _imgV.image = [UIImage imageNamed:@"rightArrow2"];
    
     
     UIImageView *locationImgV = [self.contentView viewWithTag:1031];
     if (!locationImgV) {
          locationImgV = [UIImageView new];
          
          locationImgV.tag = 1031;
          [self.contentView addSubview:locationImgV];
     }
     locationImgV.hidden = NO;
     locationImgV.x= 15;
     
     locationImgV.width = 15;
     locationImgV.height  = 15;
     locationImgV.y = self.height/2.0 - locationImgV.height/2.0;
     locationImgV.image = [UIImage imageContentWithFileName:@"addr_warn"];
     
     
    _titleLb.x = locationImgV.x + locationImgV.width +10;
    _titleLb.y = 0;
    _titleLb.width = 200;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_0xf82D45);
    _titleLb.height = self.height;
    _titleLb.numberOfLines = 1;
    _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.text = @"请填写收货人信息";
    _dataSourceLb.hidden = YES;
    _timeLb.hidden = YES;
     
   
    
}

-(void)fitProductMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.x = 15;
    _imgV.y = 10;
    _imgV.width = 100;
    _imgV.height = 70;
    //    _imgV.layer.borderWidth = 0.5;
    //    _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _imgV.layer.masksToBounds = YES;
    _imgV.layer.cornerRadius = 6.0;
    
    _titleLb.x = _imgV.x +_imgV.width +10;
    _titleLb.y = 17;
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
    _titleLb.height = size.height;
    _titleLb.numberOfLines = 2;
    
    _dataSourceLb.x = _titleLb.x;
    _dataSourceLb.y = 58;
    _dataSourceLb.width = 200;
    _dataSourceLb.height = 15;
    _dataSourceLb.font = [UIFont systemFontOfSize:14];
    _dataSourceLb.textColor = kUIColorFromRGB(color_3);
    _dataSourceLb.numberOfLines = 1;
    
    _timeLb.x = __SCREEN_SIZE.width-165;
    _timeLb.y = 58;
    _timeLb.width = 150;
    _timeLb.height = 15;
    _timeLb.font = [UIFont systemFontOfSize:14];
    _timeLb.textColor = kUIColorFromRGB(color_1);
    _timeLb.textAlignment = NSTextAlignmentRight;
    _timeLb.hidden = NO;
    _timeLb.numberOfLines = 1;
    
}

-(void)fitActMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.x = 15;
    _imgV.y = 10;
    _imgV.width = 80;
    _imgV.height = 68;
    //    _imgV.layer.borderWidth = 0.5;
    //    _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _imgV.layer.masksToBounds = YES;
    _imgV.layer.cornerRadius = 6.0;
    
    _titleLb.x = _imgV.x +_imgV.width +10;
    _titleLb.y = 10;
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.height = 68;
    _titleLb.numberOfLines = 0;
    
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    _dataSourceLb.hidden = YES;
    _timeLb.hidden = YES;
    
}


-(void)fitTeacherMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 15;
     _imgV.y = 10;
     _imgV.width = 100;
     _imgV.height = 70;
     //    _imgV.layer.borderWidth = 0.5;
     //    _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _imgV.layer.masksToBounds = YES;
     _imgV.layer.cornerRadius = 6.0;
     
     _titleLb.x = _imgV.x +_imgV.width +10;
     _titleLb.y = 17;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = size.height;
     _titleLb.numberOfLines = 2;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +4;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.height = 15;
     _dataSourceLb.font = [UIFont systemFontOfSize:14];
     _dataSourceLb.textColor = kUIColorFromRGB(color_1);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.x = _titleLb.x;
     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height +12;
     _timeLb.width = 150;
     _timeLb.height = 15;
     _timeLb.font = [UIFont systemFontOfSize:14];
     _timeLb.textColor = kUIColorFromRGB(color_3);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.hidden = NO;
     _timeLb.numberOfLines = 1;
     
}


-(void)fitShopListMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     self.height = 118;
     _imgV.x = 15;
     _imgV.y = 15;
     _imgV.width = 100;
     _imgV.height = 95;
     //    _imgV.layer.borderWidth = 0.5;
     //    _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     //     _imgV.layer.masksToBounds = YES;
     //     _imgV.layer.cornerRadius = 6.0;
     
     _titleLb.x = 156;
     _titleLb.y =  27;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 50;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 15;
     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +16;
     _dataSourceLb.width =  __SCREEN_SIZE.width - _dataSourceLb.x -15;
     _dataSourceLb.height = 12;
     _dataSourceLb.font = [UIFont systemFontOfSize:13];
     _dataSourceLb.textColor = kUIColorFromRGB(color_7);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.x = 130;
     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height +18;
     _timeLb.width = __SCREEN_SIZE.width - _timeLb.x -15;
     _timeLb.height = 13;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.textColor = kUIColorFromRGB(color_7);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.hidden = NO;
     _timeLb.numberOfLines = 1;
     
     UIImageView *imgVA = [self.contentView viewWithTag:1118];
     if (!imgVA) {
          imgVA = [[UIImageView alloc]initWithFrame:CGRectMake(130, 27, 16, 13)];
          imgVA.image = [UIImage imageNamed:@"icon_shop"];
          imgVA.tag = 1118;
          [self.contentView addSubview:imgVA];
     }
     
     
     UIImageView *imgVB = [self.contentView viewWithTag:1119];
     if (!imgVB) {
          imgVB = [[UIImageView alloc]initWithFrame:CGRectMake(130, 53, 13, 17)];
          imgVB.image = [UIImage imageNamed:@"icon_location"];
          imgVB.tag = 1119;
          [self.contentView addSubview:imgVB];
     }
     
     
     UIImageView *imgVC = [self.contentView viewWithTag:1117];
     if (!imgVC) {
          imgVC = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width- 15- 32, 15, 32, 29)];
          
          imgVC.tag = 1117;
          [self.contentView addSubview:imgVC];
     }
     if ([_dataDic[@"isOpen"] boolValue]) {
          imgVC.image = [UIImage imageNamed:@"icon_open"];
     }else
          imgVC.image = [UIImage imageNamed:@"icon_unOpen"];
     
     
}


-(void)fitErrandServerListListMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     self.height = 100;
     
     
     
     
     _imgV.width = 65;
     _imgV.height = 65;
     _imgV.x = 15;
     _imgV.y = self.height/2.0 - _imgV.height/2.0;
    
//    _imgV.layer.borderWidth = 0.5;
//    _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _imgV.layer.masksToBounds = YES;
     _imgV.layer.cornerRadius = _imgV.height/2.0;
     
     _titleLb.x = 90;
     _titleLb.y =  20;
     _titleLb.width = 200;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 15;
     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +13;
     _dataSourceLb.width =  __SCREEN_SIZE.width - _dataSourceLb.x -15;
     _dataSourceLb.height = 13;
     _dataSourceLb.font = [UIFont systemFontOfSize:13];
     _dataSourceLb.textColor = kUIColorFromRGB(color_8);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.x = _titleLb.x;
     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height +11;
     _timeLb.width = __SCREEN_SIZE.width - _timeLb.x -15;
     _timeLb.height = 13;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.textColor = kUIColorFromRGB(color_7);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.hidden = NO;
     _timeLb.numberOfLines = 1;
     
     UILabel *label = [self.contentView viewWithTag:1841];
     if (!label) {
          label = [UILabel new];
          label.textColor = kUIColorFromRGB(color_3);
          label.font = [UIFont systemFontOfSize:15];
          label.y = 17;
          label.tag = 1841;
          label.numberOfLines = 1;
          [self.contentView addSubview:label];
     }

     label.text = _dataDic[@"distant"];
     [label sizeToFit];
     label.height = 17;
     label.x = __SCREEN_SIZE.width - 15 - label.width;



     UIImageView *imgVA = [self.contentView viewWithTag:1118];
     if (!imgVA) {
          imgVA = [[UIImageView alloc]initWithFrame:CGRectMake(130, 17, 13, 17)];
          imgVA.image = [UIImage imageNamed:@"icon_location"];
          imgVA.tag = 1118;
          [self.contentView addSubview:imgVA];
     }
     imgVA.x = label.x - 10 - imgVA.width;
     
     
}

-(void)fitShopInfoMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 110;
     
     _imgV.width = 100;
     _imgV.height = 95;
     _imgV.x = 15;
     _imgV.y = self.height/2.0 - _imgV.height/2.0;
     
//     _imgV.layer.borderWidth = 0.5;
//     _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     //     _imgV.layer.masksToBounds = YES;
     //     _imgV.layer.cornerRadius = 6.0;
     
     _titleLb.x = 130;
     _titleLb.y =  20;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 15;
     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +15;
     _dataSourceLb.width =  __SCREEN_SIZE.width - _dataSourceLb.x -15;
     _dataSourceLb.height = 15;
     _dataSourceLb.font = [UIFont systemFontOfSize:15];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xfd7400);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.x = 130;
     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height +18;
     _timeLb.width = __SCREEN_SIZE.width - _timeLb.x -15;
     _timeLb.height = 13;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.textColor = kUIColorFromRGB(color_7);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.hidden = NO;
     _timeLb.numberOfLines = 1;
     
     UIButton *btn = [self.contentView viewWithTag:1533];
     if (!btn) {
          btn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width-48, 58, 48, 48)];
          [btn setImage:[UIImage imageNamed:@"cart_add"] forState:UIControlStateNormal];
          btn.tag = 1533;
          [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:btn];
     }
     
     
     
     
     
}



-(void)fitServerListMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 110;
     
     _imgV.width = 100;
     _imgV.height = 95;
     _imgV.x = 15;
     _imgV.y = self.height/2.0 - _imgV.height/2.0;
     
     _imgV.layer.borderWidth = 0.5;
     _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     //     _imgV.layer.masksToBounds = YES;
     //     _imgV.layer.cornerRadius = 6.0;
     
     _titleLb.x = 130;
     _titleLb.y =  20;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 15;
     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +15;
     _dataSourceLb.width =  __SCREEN_SIZE.width - _dataSourceLb.x -15;
     _dataSourceLb.height = 15;
     _dataSourceLb.font = [UIFont systemFontOfSize:15];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xfd7400);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.x = 130;
     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height +18;
     _timeLb.width = __SCREEN_SIZE.width - _timeLb.x -15;
     _timeLb.height = 13;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.textColor = kUIColorFromRGB(color_7);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.hidden = NO;
     _timeLb.numberOfLines = 1;
     
     UIButton *btn = [self.contentView viewWithTag:1533];
     if (!btn) {
          btn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width-75, 58, 60, 22)];
//          [btn setImage:[UIImage imageNamed:@"cart_add"] forState:UIControlStateNormal];
          btn.titleLabel.font = [UIFont systemFontOfSize:12];
          [btn setTitle:@"立即预约" forState:UIControlStateNormal];
          [btn  setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
          btn.layer.cornerRadius = btn.height/2.0;
          btn.layer.masksToBounds = YES;
          btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
          btn.layer.borderWidth = 0.5;
          btn.tag = 1533;
          [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:btn];
     }
     
     
     
     
     
}


-(void)fitErrandServerInfoMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 50;
     
     
     
//     UILabel *label = [self.contentView viewWithTag:1841];
//     if (!label) {
//          label = [UILabel new];
//          label.textColor = kUIColorFromRGB(color_1);
//          label.font = [UIFont systemFontOfSize:15];
//          label.y = 9;
//          label.tag = 1841;
//          label.numberOfLines = 1;
//          [self.contentView addSubview:label];
//     }
//
//     label.text = _dataDic[@"distant"];
//     [label sizeToFit];
//     label.height = 17;
//     label.x = __SCREEN_SIZE.width - 15 - label.width;
     
     
     
//     _imgV.width = 13;
//     _imgV.height = 17;
//     _imgV.x = label.x - 10 - _imgV.width;
//     _imgV.y = 9;
     
     _imgV.hidden  = YES;
     
     _titleLb.x = 15;
     _titleLb.y =  10;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 15;
     _titleLb.numberOfLines = 1;
     
//     _dataSourceLb.x = _titleLb.x;
//     _dataSourceLb.y = _titleLb.y +_titleLb.height +5;
//     _dataSourceLb.width =  __SCREEN_SIZE.width - _dataSourceLb.x -15;
//     _dataSourceLb.height = 13;
//     _dataSourceLb.font = [UIFont systemFontOfSize:12];
//     _dataSourceLb.textColor = kUIColorFromRGB(color_0xf82d45);
//     _dataSourceLb.numberOfLines = 1;
     _dataSourceLb.hidden = YES;
     
     _timeLb.x = _titleLb.x;
     _timeLb.y = _titleLb.y +_titleLb.height +5;
     _timeLb.width = __SCREEN_SIZE.width - _timeLb.x -15;
     _timeLb.height = 13;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.textColor = kUIColorFromRGB(color_1);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.hidden = NO;
     _timeLb.numberOfLines = 1;
     
     
     
     
     
}

-(void)fitGoodsMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 50;
     
     _imgV.hidden = YES;
     
     //标题
     _titleLb.x = 15;
     _titleLb.y =  13;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.height = 15;
     _titleLb.numberOfLines = 2;
     [_titleLb sizeToFit];
     
     
     //全新 二手
     UILabel *markLb = [self.contentView viewWithTag:1116];
     if (!markLb) {
          markLb = [UILabel new];
          
          markLb.font = [UIFont systemFontOfSize:14];
          markLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
          markLb.textAlignment = NSTextAlignmentLeft;
          markLb.numberOfLines = 1;
          markLb.tag = 1116;
          markLb.x = 15;
          markLb.height = 14;
          markLb.width = 100;
          [self.contentView addSubview:markLb];
     }
     markLb.y = _titleLb.y + _titleLb.height +10;
     markLb.text = _dataDic[@"mark"];
     
     
     //销量
     _dataSourceLb.x = __SCREEN_SIZE.width - 200-15;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +10;
     _dataSourceLb.width = 200;
     _dataSourceLb.height = 15;
     _dataSourceLb.font = [UIFont systemFontOfSize:14];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0x48a3ef);
     _dataSourceLb.numberOfLines = 1;
     _dataSourceLb.textAlignment = NSTextAlignmentRight;
     _dataSourceLb.attributedText = [_dataSourceLb richText:[UIFont systemFontOfSize:14] text:@"笔" color:kUIColorFromRGB(color_0xb0b0b0)];
     
     //租金
     _timeLb.x = 15;
     _timeLb.y = 74;
     _timeLb.font = [UIFont systemFontOfSize:27];
     _timeLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.width = 200;
     [_timeLb sizeToFit];
     _timeLb.height = 27;
     _timeLb.numberOfLines = 1;
     
     
     //规格
     UILabel *standardsLb = [self.contentView viewWithTag:1117];
     if (!standardsLb) {
          standardsLb = [UILabel new];
          
          standardsLb.font = [UIFont systemFontOfSize:14];
          standardsLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
          standardsLb.textAlignment = NSTextAlignmentLeft;
          standardsLb.numberOfLines = 1;
          standardsLb.tag = 1117;
          
          standardsLb.height = 14;
          standardsLb.width = 100;
          [self.contentView addSubview:standardsLb];
     }
     standardsLb.x = _timeLb.x + _timeLb.width;
     standardsLb.y = 82;
     standardsLb.text = _dataDic[@"standards"];
     
     //价值
     UILabel *priceLb = [self.contentView viewWithTag:1118];
     if (!priceLb) {
          priceLb = [UILabel new];
          priceLb.y = standardsLb.y ;
          priceLb.font = [UIFont systemFontOfSize:14];
          priceLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
          priceLb.textAlignment = NSTextAlignmentRight;
          priceLb.numberOfLines = 1;
          priceLb.tag = 1118;
          priceLb.x = __SCREEN_SIZE.width - 215 ;
          priceLb.height = 14;
          priceLb.width = 200;
          [self.contentView addSubview:priceLb];
     }
     priceLb.text = _dataDic[@"price"];
     
     self.height = priceLb.y + priceLb.height +20;
}


-(void)fitGoodsModeA
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 72;
     
     _imgV.hidden = YES;
     
//     _imgV.layer.borderWidth = 0.5;
//     _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     //     _imgV.layer.masksToBounds = YES;
     //     _imgV.layer.cornerRadius = 6.0;
     
     _titleLb.x = 27;
     _titleLb.y =  14;
     _titleLb.width = 100;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _titleLb.height = 15;
     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = 27;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +4;
     _dataSourceLb.width =  __SCREEN_SIZE.width - _dataSourceLb.x -80;
     _dataSourceLb.height = 15;
     _dataSourceLb.font = [UIFont systemFontOfSize:15];
     _dataSourceLb.textColor = kUIColorFromRGB(color_1);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.x = 15;
     _timeLb.y = 0;
     _timeLb.width =  __SCREEN_SIZE.width - 30;
     _timeLb.height = 60;
     _timeLb.text = @"";
     _timeLb.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _timeLb.layer.borderWidth = 0.5;
     [self.contentView sendSubviewToBack:_timeLb];
     
     UIButton *btn = [self.contentView viewWithTag:1533];
     if (!btn) {
          btn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width-60-22, 15, 60, 24)];
          [btn setTitle:@"选择规格" forState:UIControlStateNormal];
          [btn setTitleColor:kUIColorFromRGB(color_0x48a3ff) forState:UIControlStateNormal];
          btn.layer.cornerRadius = btn.height/2.0;
          btn.layer.masksToBounds = YES;
          btn.layer.borderColor = kUIColorFromRGB(color_0x48a3ff).CGColor;
          btn.layer.borderWidth = 0.5;
          btn.titleLabel.font = [UIFont systemFontOfSize:10];
          btn.tag = 1533;
          [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:btn];
     }
     
     
     
     
     
}


-(void)fitNoCartMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = __SCREEN_SIZE.width/2.0 - 40;
     _imgV.y = 20;
     _imgV.width = 80;
     _imgV.height = 80;
     //    _imgV.layer.borderWidth = 0.5;
     //    _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
//     _imgV.layer.masksToBounds = YES;
//     _imgV.layer.cornerRadius = 6.0;
     
     _titleLb.x = 15;
     _titleLb.y = _imgV.y +_imgV.height +10;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.numberOfLines = 1;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +10;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.height = 15;
     _dataSourceLb.font = [UIFont systemFontOfSize:13];
     _dataSourceLb.textColor = kUIColorFromRGB(color_7);
     _dataSourceLb.numberOfLines = 1;
     _dataSourceLb.textAlignment = NSTextAlignmentCenter;
     
     _timeLb.hidden = YES;
     
     UIButton *btn = [self.contentView viewWithTag:1535];
     if (!btn) {
          btn = [UIButton new];
          btn.width = 100;
          btn.height = 30;
          btn.x = __SCREEN_SIZE.width/2.0 - 50;
          btn.y = 170;
          btn.tag = 1535;
          btn.layer.cornerRadius = 6.0;
          btn.layer.masksToBounds = YES;
          btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
          btn.layer.borderWidth = 0.5;
//          btn.backgroundColor = kUIColorFromRGB(color_3);
          btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
          [btn setTitle:@"去首页逛逛" forState:UIControlStateNormal];
          [btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
          [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:btn];
     }
     
}


-(void)fitCartMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.hidden = YES;
     self.height = 45;
     _titleLb.x = 20;
     _titleLb.y = 6;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(100, 100)];
     _titleLb.width = size.width;
     
     
     _dataSourceLb.x = _titleLb.x+_titleLb.width+2;
     _dataSourceLb.y = _titleLb.y;
     _dataSourceLb.width = 200;
     _dataSourceLb.height = 15;
     _dataSourceLb.font = [UIFont systemFontOfSize:15];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xec7e3b);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.x = _titleLb.x;
     _timeLb.y = 25;
     _timeLb.width = 200;
     _timeLb.height = 13;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.textColor = kUIColorFromRGB(color_7);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.numberOfLines = 1;
     _timeLb.hidden = NO;
     
     
     UIButton *btn = [self.contentView viewWithTag:1535];
     if (!btn) {
          btn = [UIButton new];
          btn.width = 70;
          btn.height = 30;
          btn.x = __SCREEN_SIZE.width - 15 - btn.width;
          btn.y = self.height/2.0 - btn.height/2.0;
          btn.tag = 1535;
          btn.layer.cornerRadius = 6.0;
          btn.layer.masksToBounds = YES;
          btn.backgroundColor = kUIColorFromRGB(color_3);
          btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
          [btn setTitle:@"去结算" forState:UIControlStateNormal];
          [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:btn];
     }
     btn.hidden = NO;
}


-(void)fitCartModeA{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 55;
     _imgV.hidden = NO;
     
     _imgV.x = 15;
     _imgV.y = 5;
     _imgV.width = 45;
     _imgV.height = 45;
     
     
     _titleLb.x = 78;
     _titleLb.y = 0;
     _titleLb.height = self.height;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(100, 100)];
     _titleLb.width = size.width;
     
     _dataSourceLb.width = 200;
     _dataSourceLb.x = __SCREEN_SIZE.width - _dataSourceLb.width - 15;
     _dataSourceLb.y = _titleLb.y;
     _dataSourceLb.textAlignment = NSTextAlignmentRight;
     _dataSourceLb.height = self.height;
     _dataSourceLb.font = [UIFont systemFontOfSize:15];
     _dataSourceLb.textColor = kUIColorFromRGB(color_8);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.hidden = YES;
     
     
     UIButton *btn = [self.contentView viewWithTag:1535];
     btn.hidden = YES;
}


-(void)fitBrandMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 75;
     
     _imgV.width = 40;
     _imgV.height = 40;
     _imgV.x = 15;
     _imgV.y = self.height/2.0 - _imgV.height/2.0;
     
     //    _imgV.layer.borderWidth = 0.5;
     //    _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _imgV.layer.masksToBounds = YES;
     _imgV.layer.cornerRadius = 20;
     
     _titleLb.x = _imgV.x +_imgV.width +10;
     _titleLb.y = 10;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15 - 80;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.height = 15;
     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +10;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.height = 12;
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     _dataSourceLb.textColor = kUIColorFromRGB(color_8);
     _dataSourceLb.numberOfLines = 1;
     
     UIImageView *locationImgV = [self.contentView viewWithTag:1102];
     if (!locationImgV) {
          locationImgV = [[UIImageView alloc]initWithFrame:CGRectMake(64, 51, 12, 16)];
          locationImgV.image = [UIImage imageNamed:@"icon_address_order"];
          locationImgV.tag = 1102;
          [self.contentView addSubview:locationImgV];
     }
     
     _timeLb.x = locationImgV.x+locationImgV.width +10;
     _timeLb.y = 52;
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.textColor = kUIColorFromRGB(color_8);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.numberOfLines = 1;
     [_timeLb sizeToFit];
     
     UIImageView *loveImgV = [self.contentView viewWithTag:1114];
     if (!loveImgV) {
          loveImgV = [[UIImageView alloc]initWithFrame:CGRectMake(120, 54, 14, 12)];
          loveImgV.image = [UIImage imageNamed:@"icon_love"];
          loveImgV.tag = 1114;
          [self.contentView addSubview:loveImgV];
     }
     loveImgV.x = _timeLb.x +_timeLb.y +10;
     
     
     UILabel *loveNumLb = [self.contentView viewWithTag:1116];
     if (!loveNumLb) {
          loveNumLb = [UILabel new];
          
          loveNumLb.y = 52;
          loveNumLb.font = [UIFont systemFontOfSize:13];
          loveNumLb.textColor = kUIColorFromRGB(color_8);
          loveNumLb.textAlignment = NSTextAlignmentLeft;
          loveNumLb.numberOfLines = 1;
          loveNumLb.tag = 1116;
          [self.contentView addSubview:loveNumLb];
     }
     loveNumLb.x = loveImgV.x+loveImgV.width +10;
     loveNumLb.text = _dataDic[@"love"];
     [loveNumLb sizeToFit];
     
     UIButton *btn = [self.contentView viewWithTag:1119];
     if (!btn) {
          btn = [UIButton new];
          btn.width = 80;
          btn.height = 30;
          btn.x = __SCREEN_SIZE.width - 15 - btn.width;
          btn.y = self.height/2.0 - btn.height/2.0;
          btn.tag = 1119;
          btn.layer.cornerRadius = 6.0;
          btn.layer.masksToBounds = YES;
          btn.backgroundColor = kUIColorFromRGB(color_3);
          btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
          [btn setTitle:@"关注" forState:UIControlStateNormal];
          [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          [self.contentView addSubview:btn];
     }
}


-(void)fitSepcialMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 0;
     _imgV.y = 0;
     _imgV.width = __SCREEN_SIZE.width;
     _imgV.height = 105/360.0*__SCREEN_SIZE.width;
     
     
     _titleLb.x = 15;
     _titleLb.y = _imgV.y +_imgV.height +10;
     _titleLb.width = __SCREEN_SIZE.width -30;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = size.height;
     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +10;
     _dataSourceLb.width = __SCREEN_SIZE.width - 30;
     _dataSourceLb.numberOfLines =0;
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     size = [_dataSourceLb.text size:_dataSourceLb.font constrainedToSize:CGSizeMake(_dataSourceLb.width, 100)];
     _dataSourceLb.height = size.height;
     _dataSourceLb.textColor = kUIColorFromRGB(color_8);
     
     
     _timeLb.x = __SCREEN_SIZE.width - 15 -200;
     _timeLb.y = _titleLb.y;
     _timeLb.width = 200;
     _timeLb.height = 15;
     _timeLb.font = [UIFont systemFontOfSize:15];
     _timeLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _timeLb.textAlignment = NSTextAlignmentRight;
     _timeLb.numberOfLines = 1;
     
     
     UIImageView *markImgV = [self.contentView viewWithTag:1547];
     if (_dataDic[@"new"]) {
          if (!markImgV) {
               markImgV = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 13 - 31, 10, 31, 18)];
               markImgV.image = [UIImage imageNamed:_dataDic[@"new"]];
               markImgV.tag = 1547;
               markImgV.hidden = NO;
               [self.contentView addSubview:markImgV];
          }
     }else{
          markImgV.hidden = YES;
     }
     
}


-(void)fitFillInServiceOrderMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 106;
     
     _imgV.x = 15;
     _imgV.y = 10;
     _imgV.width = 85;
     _imgV.height = 85;
     
     
     _titleLb.x = _imgV.x +_imgV.width +20;
     _titleLb.y = 32;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 15;
     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +15;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.height = 15;
     _dataSourceLb.font = [UIFont systemFontOfSize:15];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xfd7400);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.x = __SCREEN_SIZE.width - 15 -100;
     _timeLb.y = 22;
     _timeLb.width = 100;
     _timeLb.height = 13;
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.textColor = kUIColorFromRGB(color_0xfd7400);
     _timeLb.textAlignment = NSTextAlignmentRight;
     _timeLb.numberOfLines = 1;
     
//     UILabel *numLb = [self.contentView viewWithTag:100000];
//     if (!numLb) {
//          numLb = [UILabel new];
//          numLb.x= __SCREEN_SIZE.width -100 -15;
//          numLb.y = _titleLb.y;
//          numLb.width = 100;
//          numLb.height  = 13;
//          numLb.font = [UIFont systemFontOfSize:13];
//          numLb.textColor = kUIColorFromRGB(color_0xfd7400);
//          numLb.tag = 100000;
//          numLb.textAlignment = NSTextAlignmentRight;
//          [self.contentView addSubview:numLb];
//     }
//     numLb.text = _dataDic[@"num"];
}


-(void)fitFillInOrderMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 136;
     
     _imgV.x = 18;
     _imgV.y = 25;
     _imgV.width = 85;
     _imgV.height = 85;

     
     _titleLb.x = _imgV.x +_imgV.width +18;
     _titleLb.y = 25;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -27;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
//     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 30;
     _titleLb.numberOfLines = 2;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = 77;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.height = 14;
     _dataSourceLb.font = [UIFont systemFontOfSize:14];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _dataSourceLb.numberOfLines = 1;
     
//     _timeLb.x = _titleLb.x;
//     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height +15;
//     _timeLb.width = _titleLb.width;
//     _timeLb.height = 13;
//     _timeLb.font = [UIFont systemFontOfSize:13];
//     _timeLb.textColor = kUIColorFromRGB(color_0xfd7400);
//     _timeLb.textAlignment = NSTextAlignmentLeft;
//     _timeLb.numberOfLines = 1;
     _timeLb.hidden = YES;
     
     NSArray *arr = _dataDic[@"arr"];
     
     __block CGFloat x = 120;
     __block CGFloat y = 104;
     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          NSString *str = obj;
          UILabel *secondMarkLb = [UILabel new];
          secondMarkLb.tag = 9124;
          secondMarkLb.height = 15;
          secondMarkLb.width = 35;
          secondMarkLb.layer.cornerRadius = 4.0;
           secondMarkLb.layer.masksToBounds = YES;
//          secondMarkLb.layer.borderWidth = 0.5;
          
          secondMarkLb.font = [UIFont systemFontOfSize:10];
          secondMarkLb.textAlignment = NSTextAlignmentCenter;
          secondMarkLb.backgroundColor = kUIColorFromRGB(color_0x48a3ff);
          secondMarkLb.textColor = kUIColorFromRGB(color_2);
          secondMarkLb.text = str;
          [self.contentView addSubview:secondMarkLb];
          if (x+secondMarkLb.width +15>__SCREEN_SIZE.width) {
               y = y+secondMarkLb.height +10;
               x = 120;
          }
          secondMarkLb.y = y;
          secondMarkLb.x = x;
          x += 45;
          
     }];
    
     
}


-(void)fitEvaInfoModeA{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 116;
     
     _imgV.x = 15;
     _imgV.y = 10;
     _imgV.width = 100;
     _imgV.height = 95;
     
     
     _titleLb.x = _imgV.x +_imgV.width +15;
     _titleLb.y = 15;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 13;
     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +15;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.height = 12;
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     _dataSourceLb.textColor = kUIColorFromRGB(color_8);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.x = _titleLb.x;
     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height +13;
     _timeLb.width = _titleLb.width;
     _timeLb.height = 13;
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.numberOfLines = 1;
     
     NSMutableAttributedString *aAttributedString = [[NSMutableAttributedString alloc]initWithString:_timeLb.text];
     [aAttributedString addAttribute:NSForegroundColorAttributeName  //文字颜色
                               value:kUIColorFromRGB(color_8)
                               range:NSMakeRange(0,3)];
     _timeLb.attributedText = aAttributedString;
     
//     [aAttributedString addAttribute:NSFontAttributeName             //文字字体
//                               value:[UIFont systemFontOfSize:16]
//                               range:NSMakeRange(0, str.length)];

}


-(void)fitSpecialModeA{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 112;
     
     _imgV.x = 15;
     _imgV.y = 10;
     _imgV.width = 95;
     _imgV.height = 95;
     //    _imgV.layer.borderWidth = 0.5;
     //    _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     //     _imgV.layer.masksToBounds = YES;
     //     _imgV.layer.cornerRadius = 6.0;
     
     _titleLb.x = _imgV.x +_imgV.width +15;
     _titleLb.y = 25;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.height = 13;
     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +10;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.height = 12;
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     _dataSourceLb.textColor = kUIColorFromRGB(color_8);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.x = _titleLb.x;
     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height +10;
     _timeLb.width = _titleLb.width;
     _timeLb.height = 13;
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.numberOfLines = 1;
     
     UIButton *loveBtn = [self.contentView viewWithTag:1151];
     if (!loveBtn) {
          loveBtn = [UIButton new];
          loveBtn.x= _titleLb.x;
          loveBtn.y = 90;
          loveBtn.width = 14;
          loveBtn.height  = 12;
          loveBtn.tag = 1151;
          [loveBtn addTarget:self action:@selector(loveAction) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:loveBtn];
     }
     if ([_dataDic[@"love"] boolValue]) {
          [loveBtn setBackgroundImage:[UIImage imageNamed:@"icon_love_selected"] forState:UIControlStateNormal];
     }else{
          [loveBtn setBackgroundImage:[UIImage imageNamed:@"icon_love_unselected"] forState:UIControlStateNormal];
     }
     
     
     UIButton *cartBtn = [self.contentView viewWithTag:1155];
     if (!cartBtn) {
          cartBtn = [UIButton new];
          cartBtn.x= 160;
          cartBtn.y = 90;
          cartBtn.width = 14;
          cartBtn.height  = 12;	
          cartBtn.tag = 1155;
          [cartBtn addTarget:self action:@selector(cartAction) forControlEvents:UIControlEventTouchUpInside];
          [cartBtn setBackgroundImage:[UIImage imageNamed:@"icon_cart_special"] forState:UIControlStateNormal];
          [self.contentView addSubview:cartBtn];
     }
     
     UIButton *typeBtn = [self.contentView viewWithTag:1350];
     if (!typeBtn) {
          typeBtn = [UIButton new];
          typeBtn.x= __SCREEN_SIZE.width - 15-56;
          typeBtn.y = 70;
          typeBtn.width = 56;
          typeBtn.height  = 18;
          typeBtn.tag = 1350;
          typeBtn.layer.borderWidth = 0.5;
          typeBtn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
          [typeBtn setTitle:@"4色可选" forState:UIControlStateNormal];
          [typeBtn addTarget:self action:@selector(typeAction) forControlEvents:UIControlEventTouchUpInside];
          [typeBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
          typeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
          [self.contentView addSubview:typeBtn];
     }
}

-(void)cartAction{
     if (self.handleAction) {
          self.handleAction(@{@"index":@"1"});
     }
}

-(void)loveAction{
     if (self.handleAction) {
          self.handleAction(@{@"index":@"0"});
     }
}


-(void)typeAction{
     if (self.handleAction) {
          self.handleAction(@{@"index":@"2"});
     }
}


-(void)fitOrderAddressMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 85;
     
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = __SCREEN_SIZE.width - 25;
     _imgV.y = 32;
     _imgV.width = 10;
     _imgV.height = 18;
     _imgV.image = [UIImage imageNamed:@"rightArrow2"];

     //电话
     _titleLb.x = 15;
     _titleLb.y = 18;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     [_titleLb sizeToFit];
//     _titleLb.height = 13;
     _titleLb.numberOfLines = 1;
     
     
     
     //默认
//     if (_dataDic[@"source"]) {
//          _dataSourceLb.x = _titleLb.x+_titleLb.width + 7;
//          _dataSourceLb.y = 15;
//          _dataSourceLb.width = 46;
//          _dataSourceLb.height = 19;
//          _dataSourceLb.font = [UIFont systemFontOfSize:13];
//          _dataSourceLb.textColor = kUIColorFromRGB(color_3);
//          _dataSourceLb.numberOfLines = 1;
//          _dataSourceLb.text = @"默认";
//          _dataSourceLb.layer.cornerRadius = 6.0;
//          _dataSourceLb.layer.masksToBounds = YES;
//          _dataSourceLb.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
//          _dataSourceLb.layer.borderWidth = 0.5;
//          _dataSourceLb.hidden = NO;
//          _dataSourceLb.textAlignment = NSTextAlignmentCenter;
//           _dataSourceLb.hidden = NO;
//     }else{
//          _dataSourceLb.hidden = YES;
//     }
     
      _dataSourceLb.hidden = YES;
     
     
     UIImageView *locationImgV = [self.contentView viewWithTag:1031];
     if (!locationImgV) {
          locationImgV = [UIImageView new];
       
          locationImgV.tag = 1031;
          [self.contentView addSubview:locationImgV];
     }
     locationImgV.hidden = NO;
     locationImgV.x= 15;
     locationImgV.y = 43;
     locationImgV.width = 12;
     locationImgV.height  = 16;
     locationImgV.image = [UIImage imageContentWithFileName:@"icon_location"];
     //地址
     _timeLb.x = 39;
     _timeLb.y = 44;
     _timeLb.width = _imgV.x - _timeLb.x -15;
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.textColor = kUIColorFromRGB(color_0x757575);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.numberOfLines = 2;
     [_timeLb sizeToFit];
     
     
     UIImageView *lineImgV = [self.contentView viewWithTag:1039];
     if (!lineImgV) {
          lineImgV = [UIImageView new];
          lineImgV.x= 0;
          lineImgV.y = 81;
          lineImgV.width = __SCREEN_SIZE.width;
          lineImgV.height  = 4;
          lineImgV.tag = 1039;
          lineImgV.image = [UIImage imageContentWithFileName:@"icon_address_bg"];
          [self.contentView addSubview:lineImgV];
     }
     
//
     _timeLb.hidden = NO;
     locationImgV.hidden = NO;
}


-(void)fitNoOrderAddressMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 85;
     
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = __SCREEN_SIZE.width - 25;
     _imgV.y = 32;
     _imgV.width = 10;
     _imgV.height = 18;
     _imgV.image = [UIImage imageNamed:@"rightArrow2"];
     
     //电话
     _titleLb.x = 60;
     _titleLb.y = 0;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.height = self.height;
     _titleLb.width = 300;
     _titleLb.text = @"请新增服务地址";
     
     
     
    
    _dataSourceLb.hidden = YES;
     
     //地址
     _timeLb.hidden = YES;
     
     
     UIImageView *locationImgV = [self.contentView viewWithTag:1031];
     locationImgV.width = 19;
     locationImgV.height  = 19;
     locationImgV.x= 15;
     locationImgV.y = self.height/2.0 -locationImgV.height/2.0;
     
     locationImgV.image = [UIImage imageContentWithFileName:@"adr_add"];
     
     
     UIImageView *lineImgV = [self.contentView viewWithTag:1039];
     if (!lineImgV) {
          lineImgV = [UIImageView new];
          lineImgV.x= 0;
          lineImgV.y = 81;
          lineImgV.width = __SCREEN_SIZE.width;
          lineImgV.height  = 4;
          lineImgV.tag = 1039;
          lineImgV.image = [UIImage imageContentWithFileName:@"icon_address_bg"];
          [self.contentView addSubview:lineImgV];
     }
}



-(void)fitChoseAddressMode:(BOOL) isSelected{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 80;
     
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 15;
     _imgV.y = 33;
     _imgV.width = 15;
     _imgV.height = 15;
     if (isSelected) {
          _imgV.image = [UIImage imageContentWithFileName:@"icon_selected"];
     }else{
          _imgV.image = [UIImage imageContentWithFileName:@"icon_unselected"];
     }

     //电话
     _titleLb.x = 48;
     _titleLb.y = 18;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     [_titleLb sizeToFit];
     //     _titleLb.height = 13;
     _titleLb.numberOfLines = 1;
     
     
     
     //默认
     if (_dataDic[@"source"]) {
          _dataSourceLb.x = _titleLb.x+_titleLb.width + 7;
          _dataSourceLb.y = 15;
          _dataSourceLb.width = 46;
          _dataSourceLb.height = 19;
          _dataSourceLb.font = [UIFont systemFontOfSize:13];
          _dataSourceLb.textColor = kUIColorFromRGB(color_0xf82D45);
          _dataSourceLb.numberOfLines = 1;
          _dataSourceLb.text = @"默认";
          _dataSourceLb.layer.cornerRadius = 6.0;
          _dataSourceLb.layer.masksToBounds = YES;
          _dataSourceLb.layer.borderColor = kUIColorFromRGB(color_0xf82D45).CGColor;
          _dataSourceLb.layer.borderWidth = 0.5;
          _dataSourceLb.hidden = NO;
          _dataSourceLb.textAlignment = NSTextAlignmentCenter;
     }else{
          _dataSourceLb.hidden = YES;
     }
     
    
     //地址
     _timeLb.x = _titleLb.x;
     _timeLb.y = 44;
     _timeLb.width = __SCREEN_SIZE.width - 16 - 15 - 15 - _timeLb.x;
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.textColor = kUIColorFromRGB(color_0x757575);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.numberOfLines = 2;
     [_timeLb sizeToFit];
     
     
     UIButton *editBtn = [self.contentView viewWithTag:1521];
     if (!editBtn) {
          editBtn = [UIButton new];
          editBtn.x= __SCREEN_SIZE.width - 18 - 15;
          editBtn.y = 32;
          editBtn.width = 18;
          editBtn.height  = 18;
          editBtn.tag = 1521;
          [editBtn setImage:[UIImage imageNamed:@"editAdr"] forState:UIControlStateNormal];
          [editBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:editBtn];
     }
}

-(void)btnAction{
     if (self.handleAction) {
          self.handleAction(@{@"row":_dataDic[@"row"]?:@""});
     }
}

-(void)fitLiveAndEatMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.x = 15;
    _imgV.y = 10;
    _imgV.width = 100;
    _imgV.height = 70;
    
    _titleLb.x = _imgV.x +_imgV.width +10;
    _titleLb.y = 15;
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
    _titleLb.height = 16;
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.numberOfLines = 1;
    
    _dataSourceLb.x = _titleLb.x;
    _dataSourceLb.y = _titleLb.y  + _titleLb.height +13;
    _dataSourceLb.width = _titleLb.width;
    _dataSourceLb.font = [UIFont systemFontOfSize:15];
    _dataSourceLb.textColor = kUIColorFromRGB(color_7);
    _dataSourceLb.numberOfLines = 2;
    CGSize size = [_dataSourceLb.text size:_dataSourceLb.font constrainedToSize:CGSizeMake(_dataSourceLb.width, 40)];
    _dataSourceLb.height = size.height;
    
    _timeLb.hidden = YES;
    
}

-(void)fitExclusiveMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.x = 15;
    _imgV.y = 10;
    _imgV.width = 80;
    _imgV.height = 68;
    
    _titleLb.x = _imgV.x +_imgV.width +10;
    _titleLb.y = 10;
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
    _titleLb.height = 16;
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.numberOfLines = 1;
    
    _dataSourceLb.x = _titleLb.x;
    _dataSourceLb.y = _titleLb.y  + _titleLb.height +8;
    _dataSourceLb.width = _titleLb.width;
    _dataSourceLb.font = [UIFont systemFontOfSize:14];
    _dataSourceLb.textColor = kUIColorFromRGB(color_1);
    _dataSourceLb.numberOfLines = 3;
    CGSize size = [_dataSourceLb.text size:_dataSourceLb.font constrainedToSize:CGSizeMake(_dataSourceLb.width, 60)];
    _dataSourceLb.height = size.height;
    
    _timeLb.hidden = YES;
    self.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitRentMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.x = 15;
    _imgV.y = 10;
    _imgV.width = 100;
    _imgV.height = 70;
    
    _titleLb.x = _imgV.x +_imgV.width +10;
    _titleLb.y = 15;
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
   
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 32)];
     _titleLb.height = size.height;
    _titleLb.numberOfLines = 2;
    
    _dataSourceLb.x = _titleLb.x;
    _dataSourceLb.y = _titleLb.y  + _titleLb.height +15;
    _dataSourceLb.width = _titleLb.width;
    _dataSourceLb.height = 15;
    _dataSourceLb.font = [UIFont systemFontOfSize:15];
    _dataSourceLb.textColor = kUIColorFromRGB(color_7);
    
    _timeLb.hidden = YES;
}


-(void)fitTalentMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.x = 15;
    _imgV.y = 10;
    _imgV.width = 80;
    _imgV.height = 68;
    
    _titleLb.x = _imgV.x +_imgV.width +10;
    _titleLb.y = 15;
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
    _titleLb.font =  [UIFont systemFontOfSize:14];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.numberOfLines = 2;
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 40)];
    _titleLb.height = size.height;

    
    _dataSourceLb.x = _titleLb.x;
    _dataSourceLb.y = 55;
    _dataSourceLb.width = _titleLb.width;
    _dataSourceLb.height = 15;
    _dataSourceLb.font = [UIFont systemFontOfSize:15];
    _dataSourceLb.textColor = kUIColorFromRGB(color_3);
    
    _timeLb.hidden = YES;
}



-(void)fitGreenRentMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.x = 15;
    _imgV.y = 10;
    _imgV.width = 100;
    _imgV.height = 70;
    _imgV.layer.borderWidth = 0.5;
    _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    
    _titleLb.x = _imgV.x +_imgV.width +10;
    _titleLb.y = 15;
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
    
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
    _titleLb.height = size.height;
    _titleLb.numberOfLines = 0;
    
    _dataSourceLb.x = _titleLb.x;
    _dataSourceLb.y = 63;
    _dataSourceLb.width = 200;
    _dataSourceLb.height = 15;
    _dataSourceLb.font = [UIFont systemFontOfSize:15];
    _dataSourceLb.textColor = kUIColorFromRGB(color_3);
    _dataSourceLb.numberOfLines = 1;
    
    _timeLb.x = __SCREEN_SIZE.width-165;
    _timeLb.y = 63;
    _timeLb.width = 150;
    _timeLb.height = 15;
    _timeLb.font = [UIFont systemFontOfSize:15];
    _timeLb.textColor = kUIColorFromRGB(color_7);
    _timeLb.textAlignment = NSTextAlignmentRight;
    _timeLb.hidden = NO;
    _timeLb.numberOfLines = 1;
}

-(void)fitNetMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.x = 15;
    _imgV.y = 10;
    _imgV.width = 100;
    _imgV.height = 70;
    
    _titleLb.x = _imgV.x +_imgV.width +10;
    _titleLb.y = 15;
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
    
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
    _titleLb.height = size.height;
    _titleLb.numberOfLines = 3;
    
    _dataSourceLb.hidden = YES;
    _timeLb.hidden = YES;
}


-(void)fitLiveMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.x = 15;
    _imgV.y = 10;
    _imgV.width = 100;
    _imgV.height = 70;
    
    _titleLb.x = _imgV.x +_imgV.width +10;
    _titleLb.y = 15;
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
    
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_1);
//    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
    _titleLb.height = 16;
    _titleLb.numberOfLines = 1;
    
    
    _dataSourceLb.x = _titleLb.x;
    _dataSourceLb.y = _titleLb.y  + _titleLb.height +10;
    _dataSourceLb.width = _titleLb.width;
    _dataSourceLb.height = 15;
    _dataSourceLb.font = [UIFont systemFontOfSize:15];
    _dataSourceLb.textColor = kUIColorFromRGB(color_7);
    _dataSourceLb.numberOfLines = 1;
    
    _timeLb.x = _titleLb.x;
    _timeLb.y = _dataSourceLb.y  + _dataSourceLb.height +10;
    _timeLb.width = _titleLb.width;
    _timeLb.height = 15;
    _timeLb.font = [UIFont systemFontOfSize:15];
    _timeLb.textColor = kUIColorFromRGB(color_7);
    _timeLb.numberOfLines = 1;
    
}

-(void)fitMeetingMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;

    
    _imgV.x = 15;
    _imgV.y = 10;
    _imgV.width = 100;
    _imgV.height = 70;
    
    _titleLb.x = _imgV.x +_imgV.width +10;
    _titleLb.y = 15;
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
    
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
    _titleLb.height = 16;
    _timeLb.numberOfLines = 1;
    
    _dataSourceLb.x = _titleLb.x;
    _dataSourceLb.y = _titleLb.y  + _titleLb.height +10;
    _dataSourceLb.width = _titleLb.width;
    _dataSourceLb.height = 15;
    _dataSourceLb.numberOfLines = 1;
    _dataSourceLb.font = [UIFont systemFontOfSize:15];
    _dataSourceLb.textColor = kUIColorFromRGB(color_7);
//    [_dataSourceLb sizeToFit];
    
    _timeLb.x = _titleLb.x;
    _timeLb.y = _dataSourceLb.y  + _dataSourceLb.height +10;
    _timeLb.width = _titleLb.width;
    _timeLb.height = 15;
    _timeLb.font = [UIFont systemFontOfSize:13];
    _timeLb.textColor = kUIColorFromRGB(color_6);
    _timeLb.numberOfLines = 1;
}

-(void)fitLawMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    
    _imgV.x = 15;
    _imgV.y = 10;
    _imgV.width = 100;
    _imgV.height = 70;
    
    _titleLb.x = _imgV.x +_imgV.width +10;
    _titleLb.y = 15;
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
    
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
    _titleLb.height = 16;
    _timeLb.numberOfLines = 1;
    
    _dataSourceLb.x = _titleLb.x;
    _dataSourceLb.y = _titleLb.y  + _titleLb.height +10;
    _dataSourceLb.width = _titleLb.width;
    _dataSourceLb.height = 15;
    _dataSourceLb.font = [UIFont systemFontOfSize:15];
    _dataSourceLb.textColor = kUIColorFromRGB(color_7);
    _dataSourceLb.numberOfLines = 1;
    
    _timeLb.x = _titleLb.x;
    _timeLb.y = _dataSourceLb.y  + _dataSourceLb.height +10;
    _timeLb.width = _titleLb.width;
    _timeLb.height = 15;
    _timeLb.font = [UIFont systemFontOfSize:15];
    _timeLb.textColor = kUIColorFromRGB(color_7);
    _timeLb.numberOfLines = 1;
}

-(void)fitCleanMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _imgV.x = 15;
    _imgV.y = 10;
    _imgV.width = 100;
    _imgV.height = 70;
    _imgV.layer.borderWidth = 0.5;
    _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    
    _titleLb.x = _imgV.x +_imgV.width +10;
    _titleLb.y = 15;
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
    
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
    _titleLb.height = size.height;
    _timeLb.numberOfLines = 0;
    
    _dataSourceLb.x = _titleLb.x;
    _dataSourceLb.y = 63;
    _dataSourceLb.width = _titleLb.width;
    _dataSourceLb.height = 15;
    _dataSourceLb.font = [UIFont systemFontOfSize:15];
    _dataSourceLb.textColor = kUIColorFromRGB(color_3);
    _dataSourceLb.numberOfLines = 1;
    
    _timeLb.hidden = YES;
}

-(void)fitGovCenterMode
{
    _imgV.x = 15;
    _imgV.y = 10;
    _imgV.width = 100;
    _imgV.height = 70;
    
    _titleLb.x = _imgV.x +_imgV.width +10;
    _titleLb.y = 15;
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
    
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
    _titleLb.height = size.height;
    
    _timeLb.textColor = kUIColorFromRGB(color_6);
    _timeLb.font = [UIFont systemFontOfSize:14];
    _timeLb.width = 140;
    _timeLb.textAlignment = NSTextAlignmentRight;
    _timeLb.x = __SCREEN_SIZE.width - 15 - _timeLb.width;
    _dataSourceLb.hidden = YES;
//    _dataSourceLb.x = _titleLb.x;
//    _dataSourceLb.y = 63;
//    _dataSourceLb.width = _titleLb.width;
//    _dataSourceLb.height = 15;
//    _dataSourceLb.font = [UIFont systemFontOfSize:15];
//    _dataSourceLb.textColor = kUIColorFromRGB(color_3);
}

-(void)fitNoticeMode
{
    _imgV.x = 15;
    _imgV.y = 10;
    _imgV.width = 100;
    _imgV.height = 70;
    
    _titleLb.x = _imgV.x +_imgV.width +10;
    _titleLb.y = 15;
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
    
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
    _titleLb.height = size.height;
    
    _timeLb.textColor = kUIColorFromRGB(color_6);
    _timeLb.font = [UIFont systemFontOfSize:14];
    _timeLb.width = 140;
    _timeLb.textAlignment = NSTextAlignmentRight;
    _timeLb.x = __SCREEN_SIZE.width - 15 - _timeLb.width;
    
    _dataSourceLb.y = 61;
    _dataSourceLb.x = _titleLb.x;
    _dataSourceLb.textColor = kUIColorFromRGB(color_6);
    _dataSourceLb.font = [UIFont systemFontOfSize:14];
}

-(void)fitWarnMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    
    _titleLb.x = 15;
    _titleLb.y = 16;
    _titleLb.height = 15;
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
    _titleLb.width = size.width;
    _titleLb.textColor = kUIColorFromRGB(color_6);
    
    _dataSourceLb.x = _titleLb.x +_titleLb.width +2;
    _dataSourceLb.y = _titleLb.y;
    _dataSourceLb.width = __SCREEN_SIZE.width -15-_dataSourceLb.x;
    _dataSourceLb.height = 15;
    _dataSourceLb.textColor = kUIColorFromRGB(color_3);
    
    _timeLb.x = 15;
    _timeLb.y = _titleLb.y+_titleLb.height;
    _timeLb.width = __SCREEN_SIZE.width -30;
    _timeLb.height = 44;
    _timeLb.textColor = kUIColorFromRGB(color_6);
    _timeLb.numberOfLines = 2;
    
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    _imgV.hidden = YES;
}


-(void)fitMyAccountMode
{
    self.height = 60;
    _imgV.x = 24 + 15;
    _imgV.width = 20;
    _imgV.height = 20;
    _imgV.y = self.height/2.0 - _imgV.height/2.0;
    
    _titleLb.width = 54;
    _titleLb.textColor = kUIColorFromRGB(color_5);
    _titleLb.font = [UIFont systemFontOfSize:15];
    [_titleLb sizeToFit];
    _titleLb.x = _imgV.x + _imgV.width + 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _dataSourceLb.x = _titleLb.x + _titleLb.width + 10;
    _dataSourceLb.textColor = kUIColorFromRGB(color_5);
    _dataSourceLb.font = [UIFont systemFontOfSize:15];
    _dataSourceLb.width = 50;
    [_dataSourceLb sizeToFit];
    _dataSourceLb.y = self.height/2.0 - _dataSourceLb.height/2.0;
    
    _timeLb.x = _dataSourceLb.x + _dataSourceLb.width + 10;
    _timeLb.textColor = kUIColorFromRGB(color_3);
    _timeLb.font = [UIFont systemFontOfSize:15];
    _timeLb.width = __SCREEN_SIZE.width - 15 - _timeLb.x;
    [_timeLb sizeToFit];
    _timeLb.y = self.height/2.0 - _timeLb.height/2.0;
    
    
    UIImageView *imgv = [self.contentView viewWithTag:9711];
    if (!imgv) {
        imgv = [UIImageView new];
        imgv.tag = 9711;
    }
    imgv.layer.cornerRadius = 3;
    imgv.layer.masksToBounds = YES;
    imgv.backgroundColor = kUIColorFromRGB(color_4);
    imgv.x = 15;
    imgv.width = __SCREEN_SIZE.width - 30;
    imgv.height = 40;
    imgv.y = 10;
    [self.contentView insertSubview:imgv atIndex:0];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = kUIColorFromRGB(color_9);
}
-(void)fitMyAccountModeB
{
    self.height = 60;
    _imgV.x = 24 + 15;
    _imgV.width = 19;
    _imgV.height = 19.5;
    
    _imgV.y = self.height/2.0 - _imgV.height/2.0;
    _imgV.hidden = NO;
    _titleLb.width = 54;
    _titleLb.textColor = kUIColorFromRGB(color_8);
    _titleLb.font = [UIFont systemFontOfSize:15];
    [_titleLb sizeToFit];
    _titleLb.x = __SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _dataSourceLb.hidden = YES;
    _timeLb.hidden = YES;
    
    
    UIImageView *imgv = [self.contentView viewWithTag:9711];
    if (!imgv) {
        imgv = [UIImageView new];
        imgv.tag = 9711;
    }
//    imgv.image = [UIImage imageContentWithFileName:_dataDic[@"bgImg"]];
    imgv.layer.cornerRadius = 3;
    imgv.layer.masksToBounds = YES;
    imgv.backgroundColor = kUIColorFromRGB(color_4);
    imgv.x = 15;
    imgv.width = __SCREEN_SIZE.width - 30;
    imgv.height = 40;
    imgv.y = 10;
    [self.contentView insertSubview:imgv atIndex:0];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = kUIColorFromRGB(color_9);
}

-(void)fitMyOrderMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 136;

     _imgV.x = 15;
     _imgV.y = 20;
     _imgV.width = 97;
     _imgV.height = 97;
//  _imgV.contentMode = UIViewContentModeCenter;

     _titleLb.x = _imgV.x +_imgV.width +20;
     _titleLb.y = 20;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_0x111111);
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 16;
     _titleLb.numberOfLines = 1;

     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +15;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.height = 14;
     _dataSourceLb.font = [UIFont systemFontOfSize:13];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _dataSourceLb.numberOfLines = 1;

     _timeLb.x = _titleLb.x;
     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height +15;
     _timeLb.width = _titleLb.width;
     _timeLb.height = 17;
     _timeLb.font = [UIFont systemFontOfSize:16];
     _timeLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.numberOfLines = 1;

     UILabel *numLb = [self.contentView viewWithTag:100000];
     if (!numLb) {
          numLb = [UILabel new];
          numLb.x= _imgV.x +_imgV.width +20;
          numLb.y = _timeLb.y + _timeLb.height + 15;
          numLb.width = 180;
          numLb.height  = 11;
          numLb.font = [UIFont systemFontOfSize:10];
          numLb.textColor = kUIColorFromRGB(color_0x48a3ff);
          numLb.tag = 100000;
          numLb.textAlignment = NSTextAlignmentLeft;
          [self.contentView addSubview:numLb];
     }
     numLb.text = _dataDic[@"num"];

      UIImageView *loveImg =[self.contentView viewWithTag:1605];
     loveImg.hidden = YES;
//    self.height = 106;
//
//    _imgV.x = 15;
//    _imgV.width = 85;
//    _imgV.height = 85;
//    _imgV.y = 10;
//
//
//    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
//    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
//    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
//
//    _titleLb.x = _imgV.x + _imgV.width + 20;
//    _titleLb.y = 22;
//    _titleLb.font = [UIFont systemFontOfSize:13];
//    _titleLb.height = 13;
//    _titleLb.numberOfLines = 1;
////    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
//    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
//    _titleLb.textColor = kUIColorFromRGB(color_5);
//
//    _dataSourceLb.x = _titleLb.x;
//    _dataSourceLb.y = _titleLb.y + _titleLb.height + 15;
//    _dataSourceLb.width = __SCREEN_SIZE.width - 15 - _dataSourceLb.x;
//    _dataSourceLb.height = 11;
//    _dataSourceLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
//    _dataSourceLb.font = [UIFont systemFontOfSize:11];
//
//
//    _timeLb.x = _titleLb.x;
//    _timeLb.y = _dataSourceLb.y+_dataSourceLb.height + 15;
//    _timeLb.width = __SCREEN_SIZE.width - 15 - _timeLb.x;
//    _timeLb.height = 13;
//    _timeLb.font = [UIFont systemFontOfSize:13];
//    _timeLb.textColor = kUIColorFromRGB(color_0xf82D45);
//    _timeLb.numberOfLines = 1;
//
//
//     UILabel *nlb = [self.contentView viewWithTag:3123];
////    if (_dataDic[@"price"]) {
////
//        if (!nlb) {
//            nlb = [UILabel new];
//
//            nlb.width = 90;
//            nlb.height = 13;
//             nlb.x = __SCREEN_SIZE.width - 15 - nlb.width;
//             nlb.y = 23;
//             nlb.textAlignment = NSTextAlignmentRight;
//            nlb.font = [UIFont systemFontOfSize:13];
//            nlb.textColor = kUIColorFromRGB(color_3);
//        }
//     nlb.text = _dataDic[@"price"];
//     [self.contentView addSubview:nlb];
////        nlb.hidden = NO;_titleLb strikeout
////        _timeLb.x = nlb.x = ;
////
////    }
////    else
////    {
////        nlb.hidden = YES;
////    }
////    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
//    self.backgroundColor = kUIColorFromRGB(color_2);
}
-(void)fitPayOrderModeB
{
     self.height = 185;



     _imgV.width = 75;
     _imgV.height = 75;
     _imgV.x = __SCREEN_SIZE.width/2.0 - _imgV.width/2.0;;
     _imgV.y = 15;
     _imgV.backgroundColor = [UIColor clearColor];

     _titleLb.height = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.x = 15;
     _titleLb.y = _imgV.y + _imgV.height +15;
     _titleLb.textAlignment = NSTextAlignmentCenter;

     _dataSourceLb.hidden = YES;

     if(_dataDic[@"m"])
     {
          _hour = 0;
          _minute = [_dataDic[@"m"] integerValue];
          _second =  [_dataDic[@"s"] integerValue];
     }
     else
     {
//          _hour = 0;
//          _minute = busiSystem.agent.config.payLimit - 1;
//          _second = 59;
     }
     _timeLb.textColor = kUIColorFromRGB(color_7);
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.textAlignment = NSTextAlignmentCenter;
     _timeLb.width = __SCREEN_SIZE.width -30;
     _timeLb.height = 40;
     _timeLb.y = _titleLb.y + _titleLb.height +10;
     _timeLb.x = 15;
     _timeLb.numberOfLines = 0;
     _timeLb.text = [NSString stringWithFormat:@"支付金额 %@",_dataDic[@"time"]];
     NSMutableAttributedString *str =  [[NSMutableAttributedString alloc] initWithString:_timeLb.text];
     NSRange range = [_timeLb.text rangeOfString:_dataDic[@"time"]];

//     if ([_timer isValid]) {
//          [_timer invalidate];
//     }
//
//     _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
     //设置字号
     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
     //设置文字颜色
     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_0xf82D45) range:range];
     _timeLb.attributedText = str;
}
-(void)fitPayOrderMode
{
     self.height = 185;
     
     
     
     _imgV.width = 75;
     _imgV.height = 75;
     _imgV.x = __SCREEN_SIZE.width/2.0 - _imgV.width/2.0;;
     _imgV.y = 15;
     _imgV.backgroundColor = [UIColor clearColor];
     
     _titleLb.height = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.x = 15;
     _titleLb.y = _imgV.y + _imgV.height +15;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     
     _dataSourceLb.hidden = YES;
     
     if(_dataDic[@"m"])
     {
          _hour = 0;
          _minute = [_dataDic[@"m"] integerValue];
          _second =  [_dataDic[@"s"] integerValue];
     }
     else
     {
          _hour = 0;
          _minute = busiSystem.agent.config.payLimit - 1;
          _second = 59;
     }
     _timeLb.textColor = kUIColorFromRGB(color_7);
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.textAlignment = NSTextAlignmentCenter;
     _timeLb.width = __SCREEN_SIZE.width -30;
     _timeLb.height = 40;
     _timeLb.y = _titleLb.y + _titleLb.height +10;
     _timeLb.x = 15;
     _timeLb.numberOfLines = 0;
     _timeLb.text = [NSString stringWithFormat:@"请在%2ld分%2ld秒内完成支付\n支付金额 %@",(long)_minute,(long)_second,_dataDic[@"time"]];
     NSMutableAttributedString *str =  [[NSMutableAttributedString alloc] initWithString:_timeLb.text];
     NSRange range = [_timeLb.text rangeOfString:_dataDic[@"time"]];
   
     if ([_timer isValid]) {
          [_timer invalidate];
     }
     
     _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
     //设置字号
     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range];
     //设置文字颜色
     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_0xf82D45) range:range];
     _timeLb.attributedText = str;
}

-(void)timeChange{
     _second --;
     if (_second < 0) {
          _second = 59;
          _minute --;
          if (_minute <0) {
               _minute = 0;//busiSystem.agent.config.payLimit;
               _hour --;
               if (_hour <0) {
                    [_timer invalidate];
                    _hour = 0;
                    _minute = 0;
                    _second = 0;
               }
          }
     }
     _timeLb.text = [NSString stringWithFormat:@"请在%2ld分%2ld秒内完成支付\n支付金额 %@",(long)_minute,(long)_second,_dataDic[@"time"]];
     NSMutableAttributedString *str =  [[NSMutableAttributedString alloc] initWithString:_timeLb.text];
     NSRange range = [_timeLb.text rangeOfString:_dataDic[@"time"]];
     //设置字号
     [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range];
     //设置文字颜色
     [str addAttribute:NSForegroundColorAttributeName value:kUIColorFromRGB(color_0xf82D45) range:range];
     _timeLb.attributedText = str;
}

-(void)fitSureOrderMode
{
    self.height = 90;
    
    _imgV.x = 15;
    _imgV.width = 80;
    _imgV.height = 68;
    _imgV.y = 10;
    _imgV.layer.cornerRadius = 4;
    _imgV.layer.masksToBounds = YES;
    
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    
    _titleLb.x = _imgV.x + _imgV.width + 6;
    _titleLb.y = 6;
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.height = 30;
    _titleLb.numberOfLines = 2;
    //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
    _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    
    _dataSourceLb.x = _titleLb.x;
    _dataSourceLb.y = _titleLb.y + _titleLb.height + 10;
    _dataSourceLb.width = __SCREEN_SIZE.width - 100 - _dataSourceLb.x;
    _dataSourceLb.height = 15;
    _dataSourceLb.textColor = kUIColorFromRGB(color_3);
    _dataSourceLb.font = [UIFont systemFontOfSize:14];
    
     _timeLb.width = 80;
    _timeLb.x = __SCREEN_SIZE.width - 15 - _timeLb.width;
    _timeLb.y = _dataSourceLb.y;
   
    _timeLb.height = 17;
    _timeLb.font = [UIFont systemFontOfSize:14];
    _timeLb.textColor = kUIColorFromRGB(color_1);
    _timeLb.numberOfLines = 1;
    _timeLb.textAlignment = NSTextAlignmentRight;
    
    //    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    self.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitMsgMode
{
    self.height = 65;
    _imgV.x = 15;
    _imgV.width = 45;
    _imgV.height = 45;
    _imgV.y = self.height/2.0 - _imgV.height/2.0;
    
    _titleLb.height = 18;
    _titleLb.width = __SCREEN_SIZE.width - 80;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    [_titleLb sizeToFit];
    _titleLb.x = _imgV.x + _imgV.width + 20;
    _titleLb.y = 10;
    
    _dataSourceLb.x = _titleLb.x;
    _dataSourceLb.textColor = kUIColorFromRGB(color_8);
    _dataSourceLb.font = [UIFont systemFontOfSize:13];
    _dataSourceLb.width = __SCREEN_SIZE.width - 80;
    _dataSourceLb.height = 15;
    [_dataSourceLb sizeToFit];
    _dataSourceLb.y = _titleLb.y + _titleLb.height + 15;
    
    
    _timeLb.textColor = kUIColorFromRGB(color_8);
    _timeLb.font = [UIFont systemFontOfSize:13];
    _timeLb.textAlignment = NSTextAlignmentRight;
    _timeLb.width = 160;
    _timeLb.height = _dataSourceLb.height;
    _timeLb.y = _dataSourceLb.y;
    _timeLb.x = __SCREEN_SIZE.width - 15 - _timeLb.width;
    
    UILabel *numMarkLb = [self.contentView viewWithTag:9711];
    if (!numMarkLb) {
        numMarkLb = [UILabel new];
        numMarkLb.tag = 9711;
    }
    numMarkLb.layer.cornerRadius = 6;
    numMarkLb.layer.masksToBounds = YES;
    numMarkLb.backgroundColor = kUIColorFromRGB(color_mainTheme);
    numMarkLb.text = @"2";//_dataDic[@"num"];
    numMarkLb.textColor = kUIColorFromRGB(color_5);
    numMarkLb.font = [UIFont systemFontOfSize:10];
    numMarkLb.x = 51;
    numMarkLb.width = 12;
    numMarkLb.height = 12;
    numMarkLb.y = 10;
    numMarkLb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:numMarkLb];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)dealloc
{
    _titleLb = nil;
}

-(void)fitHeadMode
{
     _starView.hidden = YES;
     self.height = 64;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = __SCREEN_SIZE.width - 15-7;
     _imgV.y = 15;
     _imgV.width = 7;
     _imgV.height = 15;
     _imgV.image = [UIImage imageNamed:@"arrow_right_gray"];
     
     _titleLb.x = 15;
     _titleLb.y = 15;
     _titleLb.width = __SCREEN_SIZE.width - 90;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.font = [UIFont boldSystemFontOfSize:17];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.height = 17;
     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = 40;
     _dataSourceLb.width = __SCREEN_SIZE.width -30;
     _dataSourceLb.height = 12;
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.y = 15;
      _timeLb.x = _imgV.x-10-25;
     _timeLb.width = 25;
     _timeLb.height = 15;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _timeLb.text = @"更多";
//     [_timeLb sizeToFit];

//     UILabel *prLb = [self.contentView viewWithTag:9010];
//     if (!prLb) {
//          prLb = [UILabel new];
//          prLb.tag = 9010;
//          prLb.height = 12;
//          prLb.width = 50;
//     }
//       prLb.text = _dataDic[@"nPrice"];
//     prLb.font = [UIFont systemFontOfSize:12];
//     prLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
//     [prLb sizeToFit];
//     prLb.x = _timeLb.x +_timeLb.width + 10;
//     prLb.y = 75;
//     [prLb strikeout];
//     [self.contentView addSubview:prLb];
//     UILabel *markLb = [self.contentView viewWithTag:9123];
//     if (!markLb) {
//          markLb = [UILabel new];
//          markLb.tag = 9123;
//          markLb.height = 14;
//          markLb.width = 36;
//     }
//     markLb.layer.cornerRadius = markLb.height/2.0;
//     markLb.layer.borderWidth = 0.5;
//     markLb.textColor = kUIColorFromRGB(color_3);
//     markLb.font = [UIFont systemFontOfSize:12];
//     markLb.textAlignment = NSTextAlignmentCenter;
//     markLb.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
//     [self.contentView addSubview:markLb];
//     markLb.text = @"会员";
//     markLb.y = 75;
//     markLb.x = __SCREEN_SIZE.width - 101 - markLb.width;
//
//     UILabel *nwprLb = [self.contentView viewWithTag:9020];
//     if (!nwprLb) {
//          nwprLb = [UILabel new];
//          nwprLb.tag = 9020;
//          nwprLb.height = 12;
//          nwprLb.width = 50;
//          nwprLb.y = 76;
//          nwprLb.x = markLb.x + markLb.width + 10;
//     }
//      nwprLb.text = _dataDic[@"nwPrice"];
//     nwprLb.font = [UIFont systemFontOfSize:12];
//     nwprLb.textColor = kUIColorFromRGB(color_3);
//
//
//     [self.contentView addSubview:nwprLb];
//
//     UIButton *btn = [self.contentView viewWithTag:9030];
//     if (!btn) {
//          btn = [UIButton new];
//          btn.tag = 9030;
//          btn.width = 40;
//          btn.height = 40;
//          btn.y = 60;
//          btn.x = __SCREEN_SIZE.width - 20 - btn.width;
//          btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//     }
//     [btn setImage:[UIImage imageContentWithFileName:_dataDic[@"btnImg"]] forState:UIControlStateNormal];
//     [btn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
//     [self.contentView addSubview:btn];
}




-(void)fitSearchResultMode
{
     _starView.hidden = YES;
     self.height = 135;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 18;
     _imgV.width = 85;
     _imgV.height = 85;
     _imgV.y = self.height/2.0 - _imgV.height/2.0;
     
     _titleLb.x = _imgV.x +_imgV.width+18;
     _titleLb.y = 25;
     _titleLb.width = __SCREEN_SIZE.width - 18 -  _titleLb.x;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.height = 35;
     _titleLb.numberOfLines = 2;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = 75;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.font = [UIFont systemFontOfSize:16];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _dataSourceLb.numberOfLines = 1;
     [_dataSourceLb sizeToFit];
     
     _timeLb.y = _dataSourceLb.y;
     _timeLb.x = _dataSourceLb.x+_dataSourceLb.width;
     _timeLb.width = 100;
     _timeLb.height = _dataSourceLb.height;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.textColor = kUIColorFromRGB(color_0xb0b0b0);

   
  
     
     //是否二手
     UILabel *secondMarkLb = [self.contentView viewWithTag:9124];
     if (!secondMarkLb) {
          secondMarkLb = [UILabel new];
          secondMarkLb.tag = 9124;
          secondMarkLb.height = 15;
          secondMarkLb.width = 35;
          secondMarkLb.layer.cornerRadius = 4.0;
          secondMarkLb.layer.borderWidth = 0.5;
          
          secondMarkLb.font = [UIFont systemFontOfSize:12];
          secondMarkLb.textAlignment = NSTextAlignmentCenter;
         
          [self.contentView addSubview:secondMarkLb];
          
          secondMarkLb.y = 100;
          secondMarkLb.x = _titleLb.x;
     }
     if ([_dataDic[@"isSecondHand"] boolValue]) {
          
          secondMarkLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
          secondMarkLb.layer.borderColor = kUIColorFromRGB(color_0xb0b0b0).CGColor;
          secondMarkLb.text = @"二手";

     }else{
          secondMarkLb.textColor = kUIColorFromRGB(color_0x48a3ff);
          secondMarkLb.layer.borderColor = kUIColorFromRGB(color_0x48a3ff).CGColor;
          secondMarkLb.text = @"全新";
     }
     
     
     
     //是否包邮
     UILabel *markLb = [self.contentView viewWithTag:9123];
     if ([_dataDic[@"isPost"] boolValue]) {
          if (!markLb) {
               markLb = [UILabel new];
               markLb.tag = 9123;
               markLb.height = 15;
               markLb.width = 35;
               markLb.layer.cornerRadius = 4.0;
               markLb.layer.borderWidth = 0.5;
               markLb.textColor = kUIColorFromRGB(color_0xfd7400);
               markLb.font = [UIFont systemFontOfSize:12];
               markLb.textAlignment = NSTextAlignmentCenter;
               markLb.layer.borderColor = kUIColorFromRGB(color_0xfd7400).CGColor;
               [self.contentView addSubview:markLb];
               markLb.text = @"包邮";
               markLb.y = 100;
               markLb.x = _titleLb.x;
          }
          
          markLb.hidden = NO;
          secondMarkLb.x = markLb.x+markLb.width +11;
     }else{
          markLb.hidden = YES;
          secondMarkLb.x = _titleLb.x;
     }
}



-(void)fitOptimizationMode
{
     _starView.hidden = YES;
     self.height = 135;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 20;
     _imgV.width = 97;
     _imgV.height = 86;
     _imgV.y = 25;
    
     
     _titleLb.x = _imgV.x +_imgV.width +20;
     _titleLb.y = 25;
     _titleLb.width = __SCREEN_SIZE.width - 15 -  _titleLb.x -15;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.height = 35;
     _titleLb.numberOfLines = 2;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = 75;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.font = [UIFont systemFontOfSize:15];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _dataSourceLb.numberOfLines = 1;
     [_dataSourceLb sizeToFit];
     
     _timeLb.y = _dataSourceLb.y;
     _timeLb.x = _dataSourceLb.x+_dataSourceLb.width;
     _timeLb.width = 100;
     _timeLb.height = _dataSourceLb.height;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     
     
     
     
     //是否二手
     UILabel *secondMarkLb = [self.contentView viewWithTag:9124];
     if (!secondMarkLb) {
          secondMarkLb = [UILabel new];
          secondMarkLb.tag = 9124;
          secondMarkLb.height = 15;
          secondMarkLb.width = 35;
          secondMarkLb.layer.cornerRadius = 4.0;
          secondMarkLb.layer.borderWidth = 0.5;
          
          secondMarkLb.font = [UIFont systemFontOfSize:12];
          secondMarkLb.textAlignment = NSTextAlignmentCenter;
          
          [self.contentView addSubview:secondMarkLb];
          
          secondMarkLb.y = 100;
          secondMarkLb.x = _titleLb.x;
     }
     if ([_dataDic[@"isSecondHand"] boolValue]) {
          
          secondMarkLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
          secondMarkLb.layer.borderColor = kUIColorFromRGB(color_0xb0b0b0).CGColor;
          secondMarkLb.text = @"二手";
          
     }else{
          secondMarkLb.textColor = kUIColorFromRGB(color_0x48a3ff);
          secondMarkLb.layer.borderColor = kUIColorFromRGB(color_0x48a3ff).CGColor;
          secondMarkLb.text = @"全新";
     }
     
     
     
     //是否包邮
     UILabel *markLb = [self.contentView viewWithTag:9123];
     if ([_dataDic[@"isPost"] boolValue]) {
          if (!markLb) {
               markLb = [UILabel new];
               markLb.tag = 9123;
               markLb.height = 15;
               markLb.width = 35;
               markLb.layer.cornerRadius = 4.0;
               markLb.layer.borderWidth = 0.5;
               markLb.textColor = kUIColorFromRGB(color_0xfd7400);
               markLb.font = [UIFont systemFontOfSize:12];
               markLb.textAlignment = NSTextAlignmentCenter;
               markLb.layer.borderColor = kUIColorFromRGB(color_0xfd7400).CGColor;
               [self.contentView addSubview:markLb];
               markLb.text = @"包邮";
               markLb.y = 100;
               markLb.x = _titleLb.x;
          }
          
          markLb.hidden = NO;
          secondMarkLb.x = markLb.x+markLb.width +11;
     }else{
          markLb.hidden = YES;
          secondMarkLb.x = _titleLb.x;
     }
     
     
     UIView *backView = [self.contentView viewWithTag:1442];
     if (!backView) {
          backView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, __SCREEN_SIZE.width-30, 135)];
          backView.tag = 1442;
          backView.layer.cornerRadius = 6.0;
//          backView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
//          backView.layer.borderWidth = 0.5;
          backView.backgroundColor = kUIColorFromRGB(color_2);
          backView.layer.shadowColor = kUIColorFromRGB(color_0x0a0204).CGColor;
          backView.layer.shadowRadius = 6.0;
          backView.layer.shadowOpacity = 0.23;
          backView.layer.shadowOffset = CGSizeMake(0,0);
          [self.contentView addSubview:backView];
          [self.contentView sendSubviewToBack:backView];

     }
     self.contentView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
}


-(void)handleAction:(UIButton*)btn
{
     if (self.handleAction) {
          self.handleAction(@{});
     }
}

-(void)fitClassifyDetailMode
{
     _starView.hidden = YES;
     self.height = 110;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 15;
     _imgV.y = 10;
     _imgV.width = 100;
     _imgV.height = 95;
     //     _imgV.layer.borderWidth = 0.5;
     //     _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     
     _titleLb.x = _imgV.x +_imgV.width + 15;
     _titleLb.y = 25;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15 - 78;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 15;
     //     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y + _titleLb.height +13;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.height = 13;
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height +13;
     _timeLb.x = _titleLb.x;
     _timeLb.width = 140;
     _timeLb.height = 10;
     _timeLb.font = [UIFont systemFontOfSize:15];
     [_timeLb sizeToFit];
     _timeLb.textColor = kUIColorFromRGB(color_3);
     
     UILabel *markLb = [self.contentView viewWithTag:9123];
     if (!markLb) {
          markLb = [UILabel new];
          markLb.tag = 9123;
          markLb.font = [UIFont systemFontOfSize:13];
          markLb.textAlignment = NSTextAlignmentCenter;
          markLb.textColor = kUIColorFromRGB(color_6);
          [self.contentView addSubview:markLb];
     }
     
     markLb.text = _dataDic[@"marketPrice"];
     [markLb sizeToFit];
     markLb.y = _timeLb.y +2;
     markLb.x = _timeLb.width + _timeLb.x +10;

     //中划线

     NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
     NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString: markLb.text attributes:attribtDic];
     markLb.attributedText = attribtStr;
     
     UIButton *btn = [self.contentView viewWithTag:16001];
     if (!btn) {
          btn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width-78 - 45, _timeLb.center.y-22.5, 45, 45)];
          btn.tag = 16001;
          [btn setImage:[UIImage imageNamed:@"cart_blue"] forState:UIControlStateNormal];
          [self.contentView addSubview:btn];
          [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
     }
}

-(void)btnAction:(UIButton *)btn{
     if (self.handleAction) {
          self.handleAction(@{@"btn":btn});
     }
}

-(void)fitSecondCallMode
{
     [self fitOrderInfoMode];
}
-(void)fitOrderInfoMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 136;

     _imgV.x = 15;
     _imgV.y = 20;
     _imgV.width = 97;
     _imgV.height = 97;
//  _imgV.contentMode = UIViewContentModeCenter;

     _titleLb.x = _imgV.x +_imgV.width +20;
     _titleLb.y = 20;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_0x111111);
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 44;
     _titleLb.numberOfLines = 0;
     [_titleLb sizeToFit];
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +15;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.height = 14;
     _dataSourceLb.font = [UIFont systemFontOfSize:13];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _dataSourceLb.numberOfLines = 1;
     _dataSourceLb.hidden = YES;

     _timeLb.x = _titleLb.x;
     _timeLb.y = _titleLb.y + _titleLb.height + 20;
     _timeLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
     _timeLb.height = 16;
     _timeLb.font = [UIFont systemFontOfSize:14];
     _timeLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.numberOfLines = 1;

     UIView *cv = [self.contentView viewWithTag:3666];
     [cv removeFromSuperview];
     cv = nil;
     if (!cv) {
          cv = [UIView new];
          cv.width = 184;
          cv.height = 16;
          cv.x = _timeLb.x;
          cv.y = _timeLb.y + _timeLb.height + 14;
     }
     [self.contentView addSubview:cv];
     NSArray *arr = _dataDic[@"markArr"];
     for (NSInteger i = 0; i < arr.count; i++) {
          UILabel *numLb;// = [self.contentView viewWithTag:100000];
          if (!numLb) {
               numLb = [UILabel new];
               numLb.x = i * (35 + 11);
               numLb.y = 0;
               numLb.width = 35;
               numLb.height  = 15;
               numLb.font = [UIFont systemFontOfSize:10];
               numLb.textColor = kUIColorFromRGB(color_2);
//               numLb.tag = 100000;
               numLb.textAlignment = NSTextAlignmentCenter;
               [cv addSubview:numLb];
               numLb.layer.cornerRadius = 5;
               numLb.layer.masksToBounds = YES;
          }
//          NSString *ts = arr[i];

             numLb.backgroundColor = kUIColorFromRGB(color_0x48a3ff);

          numLb.text = arr[i];
     }


     UIImageView *loveImg =[self.contentView viewWithTag:1605];
     loveImg.hidden = YES;
}

-(void)fitSelledServerMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 136;

     _imgV.x = 15;
     _imgV.y = 20;
     _imgV.width = 97;
     _imgV.height = 97;
//     _imgV.contentMode = UIViewContentModeCenter;

     _titleLb.x = _imgV.x +_imgV.width +20;
     _titleLb.y = 20;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_0x111111);
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 16;
     _titleLb.numberOfLines = 1;

     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y +_titleLb.height +15;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.height = 14;
     _dataSourceLb.font = [UIFont systemFontOfSize:13];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _dataSourceLb.numberOfLines = 1;

     _timeLb.x = _titleLb.x;
     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height +15;
     _timeLb.width = _titleLb.width;
     _timeLb.height = 17;
     _timeLb.font = [UIFont systemFontOfSize:16];
     _timeLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     _timeLb.numberOfLines = 1;

     UILabel *numLb = [self.contentView viewWithTag:100000];
     if (!numLb) {
          numLb = [UILabel new];
          numLb.x = _timeLb.x;
          numLb.y = _timeLb.y + _timeLb.height + 15;
          numLb.width = 160;
          numLb.height  = 12;
          numLb.font = [UIFont systemFontOfSize:10];
          numLb.textColor = kUIColorFromRGB(color_0x48a3ff);
          numLb.tag = 100000;
//          numLb.textAlignment = NSTextAlignmentRight;
          [self.contentView addSubview:numLb];
     }
     numLb.text = _dataDic[@"num"];

     UIImageView *loveImg =[self.contentView viewWithTag:1605];
     loveImg.hidden = YES;
}

-(void)fitTraceOrderMode
{
     self.height = 101;
     
     _imgV.x = 15;
     _imgV.width = 85;
     _imgV.height = 85;
     _imgV.y = 8;
     
     
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     _titleLb.x = _imgV.x + _imgV.width + 20;
     _titleLb.y = 20;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.numberOfLines = 1;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y + _titleLb.height + 10;
     _dataSourceLb.width = __SCREEN_SIZE.width - 15 - _dataSourceLb.x;
     _dataSourceLb.height = 15;
     _dataSourceLb.textColor = kUIColorFromRGB(color_5);
     _dataSourceLb.font = [UIFont systemFontOfSize:15];
     
     
     _timeLb.x = _titleLb.x;
     _timeLb.y = _dataSourceLb.y+_dataSourceLb.height + 10;
     _timeLb.width = __SCREEN_SIZE.width - 15 - _timeLb.x;
     _timeLb.height = 15;
     _timeLb.font = [UIFont systemFontOfSize:15];
     _timeLb.textColor = kUIColorFromRGB(color_5);
     _timeLb.numberOfLines = 1;
     
     self.backgroundColor = kUIColorFromRGB(color_2);
     
     UILabel *markLb = [self.contentView viewWithTag:9123];
     if (!markLb) {
          markLb = [UILabel new];
          markLb.tag = 9123;
          markLb.height = 25;
          markLb.width = 85;
          markLb.y = _imgV.height - markLb.height;
     }
//     markLb.layer.borderWidth = 0.5;
     markLb.textColor = kUIColorFromRGB(color_2);
     markLb.font = [UIFont systemFontOfSize:15];
     markLb.textAlignment = NSTextAlignmentCenter;
     markLb.backgroundColor = kUIColorFromRGBWithAlpha(color_0x434343, 0.7);
     [_imgV addSubview:markLb];
     markLb.text = _dataDic[@"count"];
}

-(void)fitMyHisMode:(BOOL)isEdit
{
     self.height = 112;
     if(isEdit)
     {
          _imgV.x = 47;
     }
     else
     {
     _imgV.x = 15;
     }
     _imgV.width = 95;
     _imgV.height = 95;
     _imgV.y = 10;
     
     
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     _titleLb.x = _imgV.x + _imgV.width + 10;
     _titleLb.y = 20;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.height = 12;
     _titleLb.numberOfLines = 1;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y + _titleLb.height + 15;
     _dataSourceLb.width = __SCREEN_SIZE.width - 15 - _dataSourceLb.x;
     _dataSourceLb.height = 12;
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     
     
     _timeLb.x = _titleLb.x;
     _timeLb.y = _dataSourceLb.y+_dataSourceLb.height + 15;
     _timeLb.width = __SCREEN_SIZE.width - 15 - _timeLb.x;
     _timeLb.height = 12;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _timeLb.numberOfLines = 1;
     
     self.backgroundColor = kUIColorFromRGB(color_2);
     
     UIButton *editBtn = [self.contentView viewWithTag:1521];
     if (!editBtn) {
          editBtn = [UIButton new];
         
          editBtn.width = 56;
          editBtn.height  = 18;
          editBtn.tag = 1521;
          editBtn.x = __SCREEN_SIZE.width - editBtn.width - 15;
          editBtn.y = 70;
          editBtn.titleLabel.font = [UIFont systemFontOfSize:13];
          [editBtn setTitle:@"找相似" forState:UIControlStateNormal];
          editBtn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
          editBtn.layer.borderWidth = 0.5;
          [editBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
          [editBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:editBtn];
     }
     
     UIImageView *imgv = [self.contentView viewWithTag:9711];
     if (!imgv) {
          imgv = [UIImageView new];
          imgv.tag = 9711;
     }
     imgv.x = 15;
     imgv.width = 15;
     imgv.height = 15;
     imgv.y = 46;
     imgv.highlightedImage = [UIImage imageContentWithFileName:@"check"];
     imgv.image = [UIImage imageContentWithFileName:@"unCheck2"];
     [self.contentView insertSubview:imgv atIndex:0];
     imgv.highlighted = [_dataDic[@"isCheck"] boolValue];
     if (isEdit) {
          editBtn.hidden = YES;
          imgv.hidden = NO;
     }
     else
     {
          editBtn.hidden = NO;
          imgv.hidden = YES;
     }

}

-(void)fitMyFavMode
{
     [self fitMyHisMode:NO];
}

-(void)fitMyFavModeB
{
     self.height = 112;

    _imgV.x = 15;
     _imgV.width = 95;
     _imgV.height = 95;
     _imgV.y = 10;
     
     
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     _titleLb.x = _imgV.x + _imgV.width + 15;
     _titleLb.y = 20;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.height = 12;
     _titleLb.numberOfLines = 1;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y + _titleLb.height + 15;
     _dataSourceLb.width = __SCREEN_SIZE.width - 15 - _dataSourceLb.x;
     _dataSourceLb.height = 12;
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     
     
//     _timeLb.x = _titleLb.x;
//     _timeLb.y = _dataSourceLb.y+_dataSourceLb.height + 15;
//     _timeLb.width = __SCREEN_SIZE.width - 15 - _timeLb.x;
//     _timeLb.height = 12;
//     _timeLb.font = [UIFont systemFontOfSize:12];
//     _timeLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _timeLb.hidden = YES;
     
     self.backgroundColor = kUIColorFromRGB(color_2);
     
     UIButton *aBtn = [self.contentView viewWithTag:1521];
     if (!aBtn) {
          aBtn = [UIButton new];
          
          
          aBtn.tag = 1521;
         
     }
     aBtn.x = _imgV.x +_imgV.width + 15;
     aBtn.y = _dataSourceLb.y + _dataSourceLb.height;
     [self setBtnFitMode:aBtn withTitle:_dataDic[@"aTitle"] withImg:_dataDic[@"aimg"]];
     [aBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
     [self.contentView addSubview:aBtn];

     
     UIButton *bBtn = [self.contentView viewWithTag:1522];
     if (!bBtn) {
          bBtn = [UIButton new];
          
          
          bBtn.tag = 1522;
          
     }
     bBtn.x = aBtn.x +aBtn.width + 10;
     bBtn.y = _dataSourceLb.y + _dataSourceLb.height;
     [self setBtnFitMode:bBtn withTitle:_dataDic[@"bTitle"] withImg:_dataDic[@"bimg"]];
     [bBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
     [self.contentView addSubview:bBtn];
     
     
     UIButton *cBtn = [self.contentView viewWithTag:1523];
     if (!cBtn) {
          cBtn = [UIButton new];
          
          
          cBtn.tag = 1523;
          
     }
     cBtn.x = bBtn.x +bBtn.width + 10;
     cBtn.y = _dataSourceLb.y + _dataSourceLb.height;
     [self setBtnFitMode:cBtn withTitle:_dataDic[@"cTitle"] withImg:_dataDic[@"cimg"]];
     [cBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
     [self.contentView addSubview:cBtn];

}

-(void)setBtnFitMode:(UIButton *)btn withTitle:(NSString *)title withImg:(NSString *)img
{
     btn.width = 56;
     btn.height  = 37;
     btn.customImgV.y = 12;
     btn.customImgV.x = 0;
     btn.customImgV.height = 13;
     btn.customImgV.width = 17;
     btn.customImgV.image = [UIImage imageContentWithFileName:img];
     btn.customImgV.contentMode = UIViewContentModeCenter;
     
     btn.customTitleLb.x = btn.customImgV.width + 10;
     btn.customTitleLb.y = 12;
     btn.customTitleLb.height = 13;
     btn.customTitleLb.font = [UIFont systemFontOfSize:13];
     btn.customTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     btn.customTitleLb.width = 50;
     btn.customTitleLb.text = title;
     [btn.customTitleLb sizeToFit];
     
     btn.width = btn.customTitleLb.x + btn.customTitleLb.width;
     
}

-(void)fitMyFavModeC
{
     [self fitMyFavModeB];
}

-(void)fitSearchMode
{
    [self fitMyHisMode:NO];
          UIButton *editBtn = [self.contentView viewWithTag:1521];
     [editBtn removeFromSuperview];
}

-(void)fitSelledSeverMode
{
     [self fitMyOrderMode];
}

-(void)fitMyEvaMode
{
     self.height = 135;
     
     _imgV.x = 15;
    
     _imgV.width = 97;
     _imgV.height = 97;
     _imgV.y = 20;
     
     
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     _titleLb.x = _imgV.x + _imgV.width + 10;
     _titleLb.y = 28;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 12;
     _titleLb.numberOfLines = 0;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     [_titleLb sizeToFit];

     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = 63;//_titleLb.y + _titleLb.height + 12;
     _dataSourceLb.width = __SCREEN_SIZE.width - 15 - _dataSourceLb.x;
     _dataSourceLb.height = 13;
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     
     
     _timeLb.x = _titleLb.x;
     _timeLb.y = 89;//_dataSourceLb.y+_dataSourceLb.height + 15;
     _timeLb.width = __SCREEN_SIZE.width - 15 - _timeLb.x;
     _timeLb.height = 12;
     _timeLb.font = [UIFont systemFontOfSize:16];
     _timeLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _timeLb.numberOfLines = 1;
     if([_timeLb.text containsString:@"元/天"])
     {
  _timeLb.attributedText = [_timeLb richText:[UIFont systemFontOfSize:12] text:@"元/天" color:kUIColorFromRGB(color_0xb0b0b0)];
     }else
    _timeLb.attributedText = [_timeLb richText:[UIFont systemFontOfSize:12] text:@"元/月" color:kUIColorFromRGB(color_0xb0b0b0)];
     self.backgroundColor = kUIColorFromRGB(color_2);
     
     UIButton *editBtn = [self.contentView viewWithTag:1521];
     if (!editBtn) {
          editBtn = [UIButton new];
          
          editBtn.width = 80;
          editBtn.height  = 31;
          editBtn.tag = 1521;
          editBtn.x = __SCREEN_SIZE.width - editBtn.width - 15;
          editBtn.y = 70;
          editBtn.titleLabel.font = [UIFont systemFontOfSize:13];
          [editBtn setTitle:@"发布评价" forState:UIControlStateNormal];
          editBtn.backgroundColor = kUIColorFromRGB(color_0xf82D45);
//          editBtn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
//          editBtn.layer.borderWidth = 0.5;
          editBtn.layer.cornerRadius = 5;
          editBtn.layer.masksToBounds = YES;
          [editBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          [editBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:editBtn];
     }
}



-(void)fitSelectAddressMode
{
     self.height = 55;
     

     
     
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     _titleLb.x = 15;
     _titleLb.y = 10;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.height = 12;
     _titleLb.numberOfLines = 1;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_8);
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y + _titleLb.height + 10;
     _dataSourceLb.width = __SCREEN_SIZE.width - 15 -90;
     _dataSourceLb.height = 15;
     _dataSourceLb.textColor = kUIColorFromRGB(color_1);
     _dataSourceLb.font = [UIFont systemFontOfSize:15];
     
     
     
     _timeLb.y = 32;
     _timeLb.width = __SCREEN_SIZE.width - 30;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _timeLb.numberOfLines = 1;
     [_timeLb sizeToFit];
     _timeLb.x = __SCREEN_SIZE.width - 15 - _timeLb.width;
     _timeLb.height = 12;
     
     self.backgroundColor = kUIColorFromRGB(color_2);
     
    
     
     _imgV.width = 18;
     _imgV.height = 18;
     _imgV.y = 32;
     _imgV.x = _timeLb.x - 10- _imgV.width;
     UIButton *editBtn = [self.contentView viewWithTag:1521];
     if (!editBtn) {
          editBtn = [UIButton new];
          
          editBtn.width = 120;
          editBtn.height  = 30;
          editBtn.tag = 1521;
          editBtn.x = __SCREEN_SIZE.width - editBtn.width - 15;
          editBtn.y = 25;
//          editBtn.backgroundColor = kUIColorFromRGB(color_3);
//          editBtn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
//          editBtn.layer.borderWidth = 0.5;
//          editBtn.layer.cornerRadius = 5;
//          editBtn.layer.masksToBounds = YES;
//          [editBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          [editBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:editBtn];
     }
}

-(void)fitPointRankModeB
{
     self.height = 229/360.0 *__SCREEN_SIZE.width;
     _imgV.x = 0;

     _imgV.width = __SCREEN_SIZE.width;
     _imgV.height = 229/360.0 *__SCREEN_SIZE.width;
     _imgV.y = 0;

     UIImageView *imgv2 = [self.contentView viewWithTag:9811];
     if (!imgv2) {
          imgv2 = [UIImageView new];
          imgv2.tag = 9811;
     }
     imgv2.contentMode = UIViewContentModeScaleToFill;
     imgv2.width = 131;
     imgv2.height = 131;
     imgv2.y = self.height/2.0 - imgv2.height/2.0;
     imgv2.x = __SCREEN_SIZE.width / 2.0 - imgv2.width/2.0;
     //          imgv.highlightedImage = [UIImage imageContentWithFileName:@"check"];
     imgv2.image = [UIImage imageContentWithFileName:@"pointRkMark"];
     [self.contentView insertSubview:imgv2 aboveSubview:_imgV];
     imgv2.layer.cornerRadius = imgv2.height/2.0;
     imgv2.layer.masksToBounds = YES;

     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;


     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.numberOfLines = 1;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _titleLb.x = __SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
     _titleLb.y = imgv2.y + 20;

        _dataSourceLb.textAlignment = NSTextAlignmentCenter;

     _dataSourceLb.y = _titleLb.y + _titleLb.height + 12;
     _dataSourceLb.width = 160;
     _dataSourceLb.height = 24;
     _dataSourceLb.textColor = kUIColorFromRGB(color_3);
     _dataSourceLb.font = [UIFont systemFontOfSize:24];
 _dataSourceLb.x = __SCREEN_SIZE.width/2.0 - _dataSourceLb.width/2.0;


     _timeLb.width = 140;
     _timeLb.height = 12;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.textColor = kUIColorFromRGB(color_3);
     _timeLb.numberOfLines = 1;
     _timeLb.x = __SCREEN_SIZE.width/2.0 - _timeLb.width/2.0;
     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height + 19;
     _timeLb.textAlignment = NSTextAlignmentCenter;

     self.backgroundColor = kUIColorFromRGB(color_2);



}

-(void)fitPointRankMode
{
     self.height = 46;
     _imgV.x = 45;
     __weak ImgAndThreeTitleTableViewCell *weakSelf = self;
     _imgV.width = 35;
     _imgV.height = 35;
     _imgV.y = 4;
     _imgV.layer.cornerRadius = _imgV.height/2.0;
     _imgV.layer.masksToBounds = YES;
     UIImage *img = _imgV.image;
     if (img.size.height/(img.size.width*1.0) == 1.0) {
          
     }
     else
          _imgV.image = [img getSubImage:CGRectMake(0, 0, _imgV.width, _imgV.height) centerBool:YES canScale:YES];
     
     [self setImgChangeHandle:^(id sender) {
          UIImage *img = weakSelf.imgV.image;
          if (img.size.height/(img.size.width*1.0) == 1.0) {
               
          }
          else
               weakSelf.imgV.image = [img getSubImage:CGRectMake(0, 0, weakSelf.imgV.width, weakSelf.imgV.height) centerBool:YES canScale:YES];
     }];

     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     _titleLb.x = _imgV.x + _imgV.width + 15;

     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = 14;
     _titleLb.numberOfLines = 1;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y + _titleLb.height + 7;
     _dataSourceLb.width = __SCREEN_SIZE.width - 15 - _dataSourceLb.x;
     _dataSourceLb.height = 14;
     _dataSourceLb.textColor = kUIColorFromRGB(color_0x757575);
     _dataSourceLb.font = [UIFont systemFontOfSize:14];
     
     
    
     _timeLb.width = 140;
     _timeLb.height = 16;
     _timeLb.font = [UIFont systemFontOfSize:16];
     _timeLb.textColor = kUIColorFromRGB(color_0xfe605d);
     _timeLb.numberOfLines = 1;
     _timeLb.x = __SCREEN_SIZE.width - 15 - _timeLb.width;
     _timeLb.y = self.height/2.0 - _timeLb.height/2.0;
     _timeLb.textAlignment = NSTextAlignmentRight;
     _dataSourceLb.hidden = YES;
     self.backgroundColor = kUIColorFromRGB(color_2);
     
//     UIImageView *imgv = [_imgV viewWithTag:9711];
//     if (!imgv) {
//          imgv = [UIImageView new];
//          imgv.tag = 9711;
//     }
//     imgv.x = 28;
//     imgv.width = 15;
//     imgv.height = 15;
//     imgv.y = 0;
//     imgv.highlightedImage = [UIImage imageContentWithFileName:@"rank_vip"];
//     imgv.image = nil;//[UIImage imageContentWithFileName:@"unCheck2"];
//     [_imgV addSubview:imgv];

     if ([_dataDic[@"row"] integerValue] > 3) {
//          imgv.highlighted = NO;
          UILabel *markLb = [self.contentView viewWithTag:9123];
          if (!markLb) {
               markLb = [UILabel new];
               markLb.tag = 9123;
               markLb.height = 18;
               markLb.width = 22;
               markLb.y = self.height/2.0 - markLb.height/2.0;
               markLb.x = 20;
          }
          //     markLb.layer.borderWidth = 0.5;
          markLb.textColor = kUIColorFromRGB(color_1);
          markLb.font = [UIFont systemFontOfSize:18];
          markLb.textAlignment = NSTextAlignmentLeft;
          [self.contentView addSubview:markLb];
          markLb.text = [NSString stringWithFormat:@"%ld",[_dataDic[@"row"] integerValue]];
          UIImageView *imgv = [self.contentView viewWithTag:9811];
          [imgv removeFromSuperview];
     }
     else
     {
//          imgv.highlighted = YES;
          UIImageView *imgv2 = [self.contentView viewWithTag:9811];
          if (!imgv2) {
               imgv2 = [UIImageView new];
               imgv2.tag = 9811;
          }
          imgv2.x = 15;
          imgv2.width = 20;
          imgv2.height = 35;
          imgv2.y = 6;
//          imgv.highlightedImage = [UIImage imageContentWithFileName:@"check"];
          imgv2.image = [UIImage imageContentWithFileName:[NSString stringWithFormat:@"rank%ld",[_dataDic[@"row"] integerValue]]];
          [self.contentView addSubview:imgv2];
          UILabel *markLb = [self.contentView viewWithTag:9123];
          [markLb removeFromSuperview];
          
     }
     
}

-(void)fitRecycleRecMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;

     self.height = 100;
     _imgV.width = 70;
     _imgV.height = 70;
     _imgV.x = 15;
     _imgV.y = 15;

     _titleLb.x =  _imgV.x + _imgV.width + 15;
     _titleLb.y = 27;
     _titleLb.width = __SCREEN_SIZE.width- _titleLb.x - 15;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     //     [_titleLb sizeToFit];




     _dataSourceLb.x =  _titleLb.x;
     _dataSourceLb.y = _titleLb.y + _titleLb.height + 10;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.font = [UIFont systemFontOfSize:15];
     _dataSourceLb.textColor = kUIColorFromRGB(color_1);
     _dataSourceLb.numberOfLines = 2;
     _dataSourceLb.height = 40;
     _dataSourceLb.textAlignment = NSTextAlignmentLeft;
          [_dataSourceLb sizeToFit];

     _timeLb.hidden = YES;
}

-(void)fitOddsRecMode
{
     _starView.hidden = YES;
     self.height = 109;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 15;
     _imgV.y = 8;
     _imgV.width = 101;
     _imgV.height = 95;
     //     _imgV.layer.borderWidth = 0.5;
     //     _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     
     _titleLb.x = _imgV.x +_imgV.width + 15;
     _titleLb.y = 23;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 13;
     //     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = 50;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.height = 11;
     _dataSourceLb.font = [UIFont systemFontOfSize:11];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.y = 75;
     _timeLb.x = _titleLb.x;
     _timeLb.width = 140;
     _timeLb.height = 10;
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.textColor = kUIColorFromRGB(color_0xf82D45);
     
     UILabel *markLb = [self.contentView viewWithTag:9123];
     if (!markLb) {
          markLb = [UILabel new];
          markLb.tag = 9123;
          markLb.height = 17;
          markLb.width = 55;
     }
     markLb.layer.borderWidth = 0.5;
     markLb.textColor = kUIColorFromRGB(color_0xeb7f00);
     markLb.font = [UIFont systemFontOfSize:13];
     markLb.textAlignment = NSTextAlignmentCenter;
     markLb.layer.borderColor = kUIColorFromRGB(color_0xeb7f00).CGColor;
     [self.contentView addSubview:markLb];
     markLb.text = @"4色可选";
     markLb.y = 68;
     markLb.x = __SCREEN_SIZE.width - 15 - markLb.width;
}


-(void)fitAwardDetailMode
{
     self.height = 45;
     _imgV.x = 15;
     
     _imgV.width = 37;
     _imgV.height = 37;
     _imgV.y = 4;
     
     
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     _titleLb.x = _imgV.x + _imgV.width + 15;
     _titleLb.y = 7;
     if (__SCREEN_SIZE.width == 320) {
           _titleLb.font = [UIFont systemFontOfSize:11];
     }
     else
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = 14;
     _titleLb.numberOfLines = 1;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
     _titleLb.width = 100;//__SCREEN_SIZE.width - _titleLb.x - 15;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y + _titleLb.height + 7;
     _dataSourceLb.width = 100;//__SCREEN_SIZE.width - 15 - _dataSourceLb.x;
     _dataSourceLb.height = 14;
     _dataSourceLb.textColor = kUIColorFromRGB(color_0x757575);
     if (__SCREEN_SIZE.width == 320) {
          _dataSourceLb.font = [UIFont systemFontOfSize:11];
     }
     else
     _dataSourceLb.font = [UIFont systemFontOfSize:14];
     
     
     
     if (__SCREEN_SIZE.width == 320) {
          _timeLb.width = 140;
     }else
     {
          _timeLb.width = 180;
     }
     _timeLb.height = 14;
     if (__SCREEN_SIZE.width == 320) {
          _timeLb.font = [UIFont systemFontOfSize:11];
     }
     else
     _timeLb.font = [UIFont systemFontOfSize:14];
     _timeLb.textColor = kUIColorFromRGB(color_0x757575);
     _timeLb.numberOfLines = 1;
     _timeLb.x = __SCREEN_SIZE.width - 15 - _timeLb.width;
     _timeLb.y = _dataSourceLb.y;
     _timeLb.textAlignment = NSTextAlignmentLeft;
      _timeLb.attributedText = [_timeLb richText:@"时间" color:kUIColorFromRGB(color_0xb0b0b0)];
     
     self.backgroundColor = kUIColorFromRGB(color_2);
     
    
          UILabel *markLb = [self.contentView viewWithTag:9123];
          if (!markLb) {
               markLb = [UILabel new];
               markLb.tag = 9123;
               markLb.height = 14;
               markLb.width = _timeLb.width;
               markLb.y = 7;
               markLb.x = _timeLb.x;
          }
          //     markLb.layer.borderWidth = 0.5;
          markLb.textColor = kUIColorFromRGB(color_0x757575);
     if (__SCREEN_SIZE.width == 320) {
          markLb.font = [UIFont systemFontOfSize:11];
     }
     else
          markLb.font = [UIFont systemFontOfSize:14];
          markLb.textAlignment = NSTextAlignmentLeft;
          [self.contentView addSubview:markLb];
     markLb.text = _dataDic[@"type"];
     markLb.attributedText = [markLb richText:@"类型" color:kUIColorFromRGB(color_0xb0b0b0)];
          
}
-(void)fitMyEvaModeB
{
     [self fitSimilarityGoodsMode];
     _imgV.layer.masksToBounds = NO;
     _imgV.layer.cornerRadius = 0;
}
-(void)fitSimilarityGoodsMode
{
     _starView.hidden = YES;
     self.height = 101;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 25;
     _imgV.y = 15;
     _imgV.width = 70;
     _imgV.height = 70;
     //     _imgV.layer.borderWidth = 0.5;
     //     _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     
     _titleLb.x = _imgV.x +_imgV.width + 10;
     _titleLb.y = 21;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 13;
     //     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = 45;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.height = 12;
     _dataSourceLb.font = [UIFont systemFontOfSize:12];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.y = 69;
     _timeLb.x = _titleLb.x;
     _timeLb.width = 140;
     _timeLb.height = 12;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _imgV.backgroundColor = kUIColorFromRGB(color_2);
     UIView *v = [self.contentView viewWithTag:9211];
     if (!v) {
          v = [UIView new];
          v.tag = 9211;
          v.height = 80;
          v.width =__SCREEN_SIZE.width - 30;
     }
     v.x = 15;
     v.y = 10;
     v.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     [self.contentView insertSubview:v atIndex:0];
}

-(void)fitSeconKillMode
{
     _starView.hidden = YES;
     self.height = 115;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.x = 15;
     _imgV.y = 10;
     _imgV.width = 101;
     _imgV.height = 95;
     //     _imgV.layer.borderWidth = 0.5;
     //     _imgV.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     
     _titleLb.x = _imgV.x +_imgV.width + 15;
     _titleLb.y = 25;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x -15;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
     _titleLb.height = 13;
     //     _titleLb.numberOfLines = 1;
     
     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = 52;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.height = 11;
     _dataSourceLb.font = [UIFont systemFontOfSize:11];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _dataSourceLb.numberOfLines = 1;
     
     _timeLb.y = 76;
     _timeLb.x = _titleLb.x;
     _timeLb.width = 140;
     _timeLb.height = 10;
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.textColor = kUIColorFromRGB(color_0xf82D45);
     
     UIButton *markBtn = [self.contentView viewWithTag:9123];
     if (!markBtn) {
          markBtn = [UIButton new];
          markBtn.tag = 9123;
          markBtn.height = 18;
          markBtn.width = 56;
     }
     [markBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     [markBtn setTitle:@"马上抢" forState:UIControlStateNormal];
     markBtn.titleLabel.font = [UIFont systemFontOfSize:13];
     [self.contentView addSubview:markBtn];
     markBtn.backgroundColor = kUIColorFromRGB(color_3);
     markBtn.y = 70;
     markBtn.x = __SCREEN_SIZE.width - 15 - markBtn.width;
     
     UIView *v = [self.contentView viewWithTag:9211];
     if (!v) {
          v = [UIView new];
          v.tag = 9211;
          v.height = 11;
          v.width = 76;
     }
     v.x = 15 + _imgV.width + _imgV.x;
     v.y = 6 + _timeLb.y + _timeLb.height;
     v.layer.cornerRadius = 5;
     v.layer.masksToBounds = YES;
     v.layer.borderColor = kUIColorFromRGB(color_0xeb7f00).CGColor;
     v.layer.borderWidth = 0.5;
     v.backgroundColor = kUIColorFromRGB(color_2);
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     [self.contentView addSubview:v];
     
     UILabel *markLb = [v viewWithTag:9125];
     if (!markLb) {
          markLb = [UILabel new];
          markLb.tag = 9125;
          markLb.height = 11;
          markLb.width = 48;
          markLb.y = 0;
          markLb.x = 11;
     }
     //     markLb.layer.borderWidth = 0.5;
     markLb.textColor = kUIColorFromRGB(color_3);
     markLb.font = [UIFont systemFontOfSize:8];
     markLb.textAlignment = NSTextAlignmentCenter;
//     markLb.backgroundColor = kUIColorFromRGB(color_2);
     [v addSubview:markLb];
     markLb.text = _dataDic[@"count"];
    
     UIView *vv = [self.contentView viewWithTag:9231];
     if (!vv) {
          vv = [UIView new];
          vv.tag = 9231;
          vv.height = 11;
          vv.width = 56;
     }
     vv.x = 0;
     vv.y = 0;
     vv.backgroundColor = kUIColorFromRGB(color_0xfece96);
     [v insertSubview:vv atIndex:0];
     
}

-(void)fitMySecHandMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
_imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;

     self.height = 109;
     _imgV.width = 100;
     _imgV.height = 95;
     _imgV.x = 15;
     _imgV.y = 8;

     _titleLb.x =  _imgV.x + _imgV.width + 15;
     _titleLb.y = 22;
     _titleLb.width = __SCREEN_SIZE.width- _titleLb.x - 15;
     _titleLb.height = 14;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     //     [_titleLb sizeToFit];




     _dataSourceLb.x =  _titleLb.x;
     _dataSourceLb.y = _titleLb.y + _titleLb.height + 11;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.font = [UIFont systemFontOfSize:15];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xfd7400);
     _dataSourceLb.numberOfLines = 1;
     _dataSourceLb.height = 15;
     _dataSourceLb.textAlignment = NSTextAlignmentLeft;
     //     [_dataSourceLb sizeToFit];

     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height + 12;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.numberOfLines = 1;
     _timeLb.x =  _titleLb.x  + 23;
     _timeLb.width = _titleLb.width - 23;
     _timeLb.height = 12;
     _timeLb.textColor = kUIColorFromRGB(color_7);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     [_timeLb sizeToFit];


     UIImageView *loveImg =[self.contentView viewWithTag:1605];
     if(!loveImg){
          loveImg = [[UIImageView alloc]initWithFrame:CGRectMake(_imgV.x + _imgV.width + 15, _timeLb.y - 3, 13, 17)];
          loveImg.tag = 1605;
          loveImg.image = [UIImage imageContentWithFileName:@"nav_pos"];

     }
        [self.contentView addSubview:loveImg];

     UILabel *stateLb = [self.contentView viewWithTag:1636];
     if (!stateLb) {
          stateLb = [[UILabel alloc]init];
          stateLb.tag = 1636;
          stateLb.y = 10;
          stateLb.width = 100;
          stateLb.height = 16;
          stateLb.x = __SCREEN_SIZE.width - 15 - stateLb.width;
          stateLb.font = [UIFont systemFontOfSize:14];;
          stateLb.textColor = kUIColorFromRGB(color_0xf82D45);

//          stateLb.layer.masksToBounds = YES;
//          stateLb.backgroundColor = kUIColorFromRGB(color_0xf82D45);
          //          stateLb.layer.borderWidth = 0.5;
          stateLb.textAlignment = NSTextAlignmentRight;
          [self.contentView addSubview:stateLb];
     }

     stateLb.text = _dataDic[@"state"];
//     [stateLb sizeToFit];
}

-(void)fitReplacementConfirmMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;

     self.height = 120;
     _imgV.width = 100;
     _imgV.height = 95;
     _imgV.x = 15;
     _imgV.y = 11;

     _titleLb.x =  _imgV.x + _imgV.width + 15;
     _titleLb.y = 22;
     _titleLb.width = __SCREEN_SIZE.width- _titleLb.x - 15;
     _titleLb.height = 14;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     //     [_titleLb sizeToFit];

     UIImage *img = _imgV.image;
     if (img.size.height/(img.size.width*1.0 )== 190/(200* 1.0 )) {

     }
     else
          _imgV.image = [img getSubImage:CGRectMake(0, 0, _imgV.width, _imgV.height) centerBool:YES];

     __weak ImgAndThreeTitleTableViewCell *weakSelf = self;
     [self setImgChangeHandle:^(id sender) {
          UIImage *img = weakSelf.imgV.image;
          if (img.size.height/(img.size.width * 0.1 )== 190/(200* 0.1 )) {

          }
          else
               weakSelf.imgV.image = [img getSubImage:CGRectMake(0, 0, weakSelf.imgV.width, weakSelf.imgV.height) centerBool:YES];
     }];


     _dataSourceLb.x =  _titleLb.x;
     _dataSourceLb.y = _titleLb.y + _titleLb.height + 11;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.font = [UIFont systemFontOfSize:15];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xfd7400);
     _dataSourceLb.numberOfLines = 1;
     _dataSourceLb.height = 15;
     _dataSourceLb.textAlignment = NSTextAlignmentLeft;
     //     [_dataSourceLb sizeToFit];

     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height + 12;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.numberOfLines = 1;
     _timeLb.x =  _titleLb.x  + 23;
     _timeLb.width = _titleLb.width - 23;
     _timeLb.height = 12;
     _timeLb.textColor = kUIColorFromRGB(color_7);
     _timeLb.textAlignment = NSTextAlignmentLeft;
     [_timeLb sizeToFit];


     UIImageView *loveImg =[self.contentView viewWithTag:1605];
     if(!loveImg){
          loveImg = [[UIImageView alloc]initWithFrame:CGRectMake(_imgV.x + _imgV.width + 15, _timeLb.y - 3, 13, 17)];
          loveImg.tag = 1605;
          loveImg.image = [UIImage imageContentWithFileName:@"nav_pos"];

     }
     [self.contentView addSubview:loveImg];
}

-(void)fitMySecHandDealMode{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _imgV.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;

     self.height = 109;
     _imgV.width = 100;
     _imgV.height = 95;
     _imgV.x = 15;
     _imgV.y = 8;

     _titleLb.x =  _imgV.x + _imgV.width + 15;
     _titleLb.y = 22;
     _titleLb.width = __SCREEN_SIZE.width- _titleLb.x - 15;
     _titleLb.height = 14;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     //     [_titleLb sizeToFit];




     _dataSourceLb.x =  _titleLb.x;
     _dataSourceLb.y = _titleLb.y + _titleLb.height + 11;
     _dataSourceLb.width = _titleLb.width;
     _dataSourceLb.font = [UIFont systemFontOfSize:15];
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xfd7400);
     _dataSourceLb.numberOfLines = 1;
     _dataSourceLb.height = 15;
     _dataSourceLb.textAlignment = NSTextAlignmentLeft;
     //     [_dataSourceLb sizeToFit];

     _timeLb.y = _dataSourceLb.y + _dataSourceLb.height + 12;
     _timeLb.font = [UIFont systemFontOfSize:12];
     _timeLb.numberOfLines = 2;
     _timeLb.x =  _titleLb.x  + 23;
     _timeLb.width = _titleLb.width - 23;
     if (__SCREEN_SIZE.width == 320) {
          _timeLb.width = _titleLb.width - 60;
     }
     _timeLb.height = 36;
     _timeLb.textColor = kUIColorFromRGB(color_7);
     _timeLb.textAlignment = NSTextAlignmentLeft;

     [_timeLb sizeToFit];
     UIImage *img = _imgV.image;
     if (img.size.height/(img.size.width*1.0 )== 190/(200* 1.0 )) {

     }
     else
          _imgV.image = [img getSubImage:CGRectMake(0, 0, _imgV.width, _imgV.height) centerBool:YES];

     __weak ImgAndThreeTitleTableViewCell *weakSelf = self;
     [self setImgChangeHandle:^(id sender) {
          UIImage *img = weakSelf.imgV.image;
          if (img.size.height/(img.size.width * 0.1 )== 190/(200* 0.1 )) {

          }
          else
               weakSelf.imgV.image = [img getSubImage:CGRectMake(0, 0, weakSelf.imgV.width, weakSelf.imgV.height) centerBool:YES];
     }];
     UIImageView *loveImg =[self.contentView viewWithTag:1605];
     if(!loveImg){
          loveImg = [[UIImageView alloc]initWithFrame:CGRectMake(_imgV.x + _imgV.width + 15, _timeLb.y - 3, 13, 17)];
          loveImg.tag = 1605;
          loveImg.image = [UIImage imageContentWithFileName:@"nav_pos"];

     }
     [self.contentView addSubview:loveImg];

     UILabel *stateLb = [self.contentView viewWithTag:1636];
     if (!stateLb) {
          stateLb = [[UILabel alloc]init];
          stateLb.tag = 1636;

          stateLb.y = 70;
          stateLb.width = 60;
          stateLb.height = 18;
            stateLb.x= __SCREEN_SIZE.width - 15 - stateLb.width;
          stateLb.font = [UIFont systemFontOfSize:9];;
          stateLb.textColor = kUIColorFromRGB(color_2);

          stateLb.layer.masksToBounds = YES;
          stateLb.backgroundColor = kUIColorFromRGB(color_3);
//          stateLb.layer.borderWidth = 0.5;
          stateLb.textAlignment = NSTextAlignmentCenter;
          [self.contentView addSubview:stateLb];
     }

     stateLb.text = _dataDic[@"distance"];
     [stateLb sizeToFit];
     if (!_dataDic[@"distance"]||[_dataDic[@"distance"] isEqualToString:@""]) {
          stateLb.hidden = YES;
     }
     else
     {
  stateLb.hidden = NO;
     }
     stateLb.height = stateLb.height + 10;
     stateLb.width = MIN(60, stateLb.width + 12);
     stateLb.layer.cornerRadius = 4.0;
      stateLb.x= __SCREEN_SIZE.width - 15 - stateLb.width;
}

-(void)fitMyfavMode{
     self.height = 135;

     _imgV.x = 15;

     _imgV.width = 97;
     _imgV.height = 97;
     _imgV.y = 20;

//     _imgV.contentMode = UIViewContentModeCenter;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _timeLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _dataSourceLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;

     _titleLb.x = _imgV.x + _imgV.width + 10;
     _titleLb.y = 20;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 32;
     _titleLb.numberOfLines = 0;
     [_titleLb sizeToFit];
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
     _titleLb.textColor = kUIColorFromRGB(color_5);

     _dataSourceLb.x = _titleLb.x;
     _dataSourceLb.y = _titleLb.y + _titleLb.height + 15;
     _dataSourceLb.width = __SCREEN_SIZE.width - 15 - _dataSourceLb.x;
     _dataSourceLb.height = 12;
     _dataSourceLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _dataSourceLb.font = [UIFont systemFontOfSize:15];


     _timeLb.x = _titleLb.x;
     _timeLb.y = _dataSourceLb.y+_dataSourceLb.height + 15;
     _timeLb.width = __SCREEN_SIZE.width - 15 - _timeLb.x;
     _timeLb.height = 12;
     _timeLb.font = [UIFont systemFontOfSize:13];
     _timeLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _timeLb.numberOfLines = 1;
//     _timeLb.attributedText = [_timeLb richText:[UIFont systemFontOfSize:12] text:@"元/月" color:kUIColorFromRGB(color_0xb0b0b0)];
     self.backgroundColor = kUIColorFromRGB(color_2);

     UIButton *editBtn = [self.contentView viewWithTag:1521];
     if (!editBtn) {
          editBtn = [UIButton new];

          editBtn.width = 80;
          editBtn.height  = 31;
          editBtn.tag = 1521;
          editBtn.x = __SCREEN_SIZE.width - editBtn.width - 15;
          editBtn.y = 70;
          editBtn.titleLabel.font = [UIFont systemFontOfSize:13];
          [editBtn setTitle:@"删除" forState:UIControlStateNormal];
          editBtn.backgroundColor = kUIColorFromRGB(color_0xf82D45);
          //          editBtn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
          //          editBtn.layer.borderWidth = 0.5;
          editBtn.layer.cornerRadius = 5;
          editBtn.layer.masksToBounds = YES;
          [editBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          [editBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:editBtn];
     }
}

-(void)toPhoto
{
     [self.addPhotoManager toPhoto];
}
-(void)initAddPhotoManager:(NSInteger)count withImgArr:(NSMutableArray *)aimgArr withVC:(UIViewController *)vc withTableView:(UITableView*)tableView
{
     //    __weak id weakSelf = vc;
     _addPhotoManager = [[AddPhotoManager alloc] initWith:vc withImgArr:aimgArr withCell:self withTableView:tableView];
     _addPhotoManager.count = count;
}

-(void)toCheckOption:(id)userInfo
{
     [_addPhotoManager toCheckOption:userInfo];
}

-(void)delImg:(NSInteger )indexPath
{
     [self delImg:indexPath withImgArr:nil];
}

-(void)delImg:(NSInteger )indexPath withImgArr:(NSArray *)arr
{
     [_addPhotoManager delImg:indexPath withImgArr:arr];
}

- (void) setupPhotoBrowser:(NSDictionary *)dic
{
     [_addPhotoManager setupPhotoBrowser:dic];
}

@end
