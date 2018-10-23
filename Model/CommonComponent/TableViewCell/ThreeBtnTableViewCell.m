//
//  ThreeBtnTableViewCell.m
//  ulife
//
//  Created by air on 15/12/22.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ThreeBtnTableViewCell.h"
#import "BUImageRes.h"
@implementation ThreeBtnTableViewCell
{
    IBOutlet UIImageView *_bgImgV;
    IBOutlet UIButton *_twoBtn;

    IBOutlet UIButton *_threeBtn;
    IBOutlet UIButton *_oneBtn;
    NSInteger _objRow;
    NSDictionary *_dataDic;
    UIButton *_curBtn;
     UIColor *_norColor;
     UIColor *_selColor;
}
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
     _curBtn = _oneBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCellData:(NSDictionary *)dataDic
{
    _objRow = [dataDic[@"row"] integerValue];
    _dataDic = dataDic;
    [_oneBtn setTitleColor:kUIColorFromRGB(color_mainTheme) forState:UIControlStateNormal];
//    _oneBtn.layer.borderColor = kUIColorFromRGB(color_0xcdcdcd).CGColor;
//    _oneBtn.layer.borderWidth = 0.5;
//    _oneBtn.layer.cornerRadius = 4;
//    _oneBtn.layer.masksToBounds = YES;
    
//    _threeBtn.backgroundColor = kUIColorFromRGB(color_mainTheme);
//    _threeBtn.layer.cornerRadius = 4;
//    _threeBtn.layer.masksToBounds = YES;
    
//    _twoBtn.backgroundColor = kUIColorFromRGB(color_mainTheme);
//    _twoBtn.layer.cornerRadius = 4;
//    _twoBtn.layer.masksToBounds = YES;
    [_oneBtn setTitle:dataDic[@"oneTitle"] forState:UIControlStateNormal];
    [_twoBtn setTitle:dataDic[@"twoTitle"] forState:UIControlStateNormal];
    [_threeBtn setTitle:dataDic[@"threeTitle"] forState:UIControlStateNormal];
    [_bgImgV imageWithContent:@"downChat@2x" withUIEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
    _bgImgV.width = __SCREEN_SIZE.width - 45 - 15;
      _bgImgV.x = 45;
}
- (IBAction)handleAction:(id)sender {
    if (self.handleAction) {
         if (_norColor) {
              _curBtn.customTitleLb.textColor  = _norColor;
              [_curBtn setTitleColor:_norColor forState:UIControlStateNormal];
         }
        
         _curBtn.customImgV.highlighted = NO;
        _curBtn = sender;
        UIView *v = [self.contentView viewWithTag:999];
         v.width = _curBtn.width;
         [_curBtn addSubview:v];
          _curBtn.customImgV.highlighted = YES;
           if (_norColor) {
         [_curBtn setTitleColor:_selColor forState:UIControlStateNormal];
         _curBtn.customTitleLb.textColor  = _selColor;
           }
        self.handleAction(@{@"row":@(_objRow),@"sender":sender});
    }
}

-(void)fitMode
{
    self.height = 95;
    _bgImgV.hidden = YES;
    _oneBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _twoBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _threeBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    _oneBtn.width = __SCREEN_SIZE.width/3.0;
    _twoBtn.width = __SCREEN_SIZE.width/3.0;
    _threeBtn.width = __SCREEN_SIZE.width/3.0;
    
    _oneBtn.height = 95;
    _twoBtn.height = 95;
    _threeBtn.height = 95;
    
    _oneBtn.y = 0;
    _twoBtn.y = 0;
    _threeBtn.y = 0;
    
    
    _oneBtn.imageView.image = [UIImage imageContentWithFileName:@"defaultHead"];
    _twoBtn.imageView.image = [UIImage imageContentWithFileName:@"defaultHead"];
    _threeBtn.imageView.image = [UIImage imageContentWithFileName:@"defaultHead"];
    
    _oneBtn.x = __SCREEN_SIZE.width/3.0/2.0 - _oneBtn.width/2.0;
       _twoBtn.x = __SCREEN_SIZE.width/3.0 ;
       _threeBtn.x = __SCREEN_SIZE.width/3.0 * 2 ;
    [_oneBtn fitImgAndTitleMode];
    _oneBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
    _oneBtn.customTitleLb.font = [UIFont systemFontOfSize:15];
    _oneBtn.customTitleLb.y = 95;
    _oneBtn.customTitleLb.x = 0;
    _oneBtn.customTitleLb.width = _oneBtn.width;
    //        btn.customImgV.image = [UIImage imageContentWithFileName:@"qqLogin"];
    id img = _dataDic[@"oneImg"];
    if ([img isKindOfClass:[NSString class]]) {
         _oneBtn.customImgV.image = [UIImage imageContentWithFileName:img];
    }
    else
    {
    BUImageRes *curImgRes = _oneBtn.userInfo;
    curImgRes.isValid = NO;
    curImgRes = img;
         curImgRes.isValid = YES;
    _oneBtn.userInfo = img;
    [curImgRes displayRemoteImage:_oneBtn.customImgV imageName:@"default" thumb:YES];
    }
    
    _oneBtn.customImgV.width = 45;
    _oneBtn.customImgV.height = 45;
    _oneBtn.customImgV.x = _oneBtn.width/2.0 - _oneBtn.customImgV.width/2.0;
    _oneBtn.customImgV.y = 10;
    _oneBtn.customTitleLb.y = _oneBtn.customImgV.y + _oneBtn.customImgV.height + 10;
    _oneBtn.customTitleLb.text = _dataDic[@"oneTitle"];
    [_twoBtn fitImgAndTitleMode];
    _twoBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
    _twoBtn.customTitleLb.font = [UIFont systemFontOfSize:15];
    _twoBtn.customTitleLb.y = 95;
    _twoBtn.customTitleLb.x = 0;
    _twoBtn.customTitleLb.width = _twoBtn.width;
      _twoBtn.customTitleLb.text = _dataDic[@"twoTitle"];
    //        btn.customImgV.image = [UIImage imageContentWithFileName:@"qqLogin"];
    id img2 = _dataDic[@"twoImg"];
    if ([img2 isKindOfClass:[NSString class]]) {
        _twoBtn.customImgV.image = [UIImage imageContentWithFileName:img2];
    }
    else
    {
    BUImageRes *curImgRes2 = _twoBtn.userInfo;
    curImgRes2.isValid = NO;
    curImgRes2 = img2;
        curImgRes2.isValid = YES;
    _twoBtn.userInfo = img2;
    [curImgRes2 displayRemoteImage:_twoBtn.customImgV imageName:@"default" thumb:YES];
    }
    
    _twoBtn.customImgV.width = 45;
    _twoBtn.customImgV.height = 45;
    _twoBtn.customImgV.x = _twoBtn.width/2.0 - _twoBtn.customImgV.width/2.0;
    _twoBtn.customImgV.y = 10;
    _twoBtn.customTitleLb.y = _twoBtn.customImgV.y + _twoBtn.customImgV.height + 10;
    
    
    [_threeBtn fitImgAndTitleMode];
    _threeBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
    _threeBtn.customTitleLb.font = [UIFont systemFontOfSize:15];
    _threeBtn.customTitleLb.y = 95;
    _threeBtn.customTitleLb.x = 0;
    _threeBtn.customTitleLb.width = _threeBtn.width;
      _threeBtn.customTitleLb.text = _dataDic[@"threeTitle"];
    //        btn.customImgV.image = [UIImage imageContentWithFileName:@"qqLogin"];
    id img3 = _dataDic[@"threeImg"];
    if ([img3 isKindOfClass:[NSString class]]) {
        _threeBtn.customImgV.image = [UIImage imageContentWithFileName:img3];
    }
    else
    {
    BUImageRes *curImgRes3 = _threeBtn.userInfo;
    curImgRes3.isValid = NO;
    curImgRes3 = img3;
         curImgRes3.isValid = YES;
    _threeBtn.userInfo = img3;
    [curImgRes3 displayRemoteImage:_threeBtn.customImgV imageName:@"default" thumb:YES];
    }
    
    _threeBtn.customImgV.width = 45;
    _threeBtn.customImgV.height = 45;
    _threeBtn.customImgV.x = _threeBtn.width/2.0 - _threeBtn.customImgV.width/2.0;
    _threeBtn.customImgV.y = 10;
    _threeBtn.customTitleLb.y = _threeBtn.customImgV.y + _threeBtn.customImgV.height + 10;
    
    UIView *line1 = [self viewWithTag:4422];
    if (!line1) {
        line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, self.height)];
        line1.tag = 4422;
        line1.x = _twoBtn.x;
        line1.y = 0;
        line1.backgroundColor = kUIColorFromRGB(color_3);
    }
     [self.contentView addSubview:line1];
    
    UIView *line2 = [self viewWithTag:4423];
    if (!line2) {
        line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, self.height)];
        line2.tag = 4423;
        line2.x = _threeBtn.x;
        line2.y = 0;
        line2.backgroundColor = kUIColorFromRGB(color_3);
    }
    [self.contentView addSubview:line2];
    
    
    
    self.backgroundColor = kUIColorFromRGB(color_4);
}


-(void)fitMineMode
{
     _bgImgV.hidden = YES;
     _oneBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _twoBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _threeBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;

     _oneBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _twoBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _threeBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;


     self.height = 60;

     _oneBtn.width = __SCREEN_SIZE.width/3.0;
     _twoBtn.width = __SCREEN_SIZE.width/3.0;
     _threeBtn.width = __SCREEN_SIZE.width/3.0;


     _oneBtn.height = self.height - 1;
     _twoBtn.height = self.height - 1;
     _threeBtn.height = self.height - 1;


     _oneBtn.y = 0;
     _twoBtn.y = 0;
     _threeBtn.y = 0;

     [_oneBtn fitImgAndTitleMode];
     //    _firstBtn.customImgV;
     [_twoBtn fitImgAndTitleMode];
     [_threeBtn fitImgAndTitleMode];


     _oneBtn.x = 0;
     _twoBtn.x = __SCREEN_SIZE.width/3.0 ;
     _threeBtn.x = __SCREEN_SIZE.width/3.0 * 2 ;


     [self setBtnFitMode:_oneBtn withText:_dataDic[@"oneDetail"]];
     [self setBtnFitMode:_twoBtn withText:_dataDic[@"twoDetail"]];
     [self setBtnFitMode:_threeBtn withText:_dataDic[@"threeDetail"]];

     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)setBtnFitMode:(UIButton *)btn withText:(NSString *)txt
{
     btn.customTitleLb.textColor = kUIColorFromRGB(color_1);
     btn.customTitleLb.font = [UIFont systemFontOfSize:18];
     btn.customTitleLb.y = 13;
     btn.customTitleLb.height = 18;
     btn.customDetailLb.y = 35;
     btn.customDetailLb.font = [UIFont systemFontOfSize:12];
     btn.customDetailLb.height = 12;
     btn.customDetailLb.textColor = kUIColorFromRGB(color_7);
     btn.customDetailLb.text = txt;
}

-(void)fitRecycleRecMode
{
     self.height = 45;
     _bgImgV.hidden = YES;
     _oneBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _twoBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _threeBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     if (__SCREEN_SIZE.width == 320) {
          _oneBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            _twoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            _threeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
     }
     [_oneBtn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
     [_twoBtn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
     [_threeBtn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
     _oneBtn.x = 0;
     _oneBtn.width = __SCREEN_SIZE.width/3.0;
     _twoBtn.width = _oneBtn.width;
     _twoBtn.x = _oneBtn.width;
     _threeBtn.width = _oneBtn.width;
     _threeBtn.x = _twoBtn.x + _twoBtn.width;
     _oneBtn.height = 44;
     _oneBtn.y = 0;
     _twoBtn.height = _oneBtn.height;
     _twoBtn.y = _oneBtn.y;
     _threeBtn.height = _oneBtn.height;
     _threeBtn.y = _oneBtn.y;
     self.backgroundColor = kUIColorFromRGB(color_2);

     UIView *selectLine = [self.contentView viewWithTag:9999];
     selectLine.hidden = YES;
//     if (!selectLine) {
//          selectLine = [UIView new];
//          selectLine.tag = 9999;
//          selectLine.x = 0;
//          selectLine.y = 43;
//          selectLine.height = 2;
//          selectLine.width = _oneBtn.width;
//          selectLine.backgroundColor = kUIColorFromRGB(color_mainTheme);
//     }
//     [_curBtn addSubview:selectLine];
//     [_curBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
}
-(void)fitClassifyMode
{
     self.height = 100;
     _bgImgV.hidden = YES;
     _oneBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _twoBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _threeBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     _oneBtn.width = __SCREEN_SIZE.width/3.0;
     _twoBtn.width = __SCREEN_SIZE.width/3.0;
     _threeBtn.width = __SCREEN_SIZE.width/3.0;
     
     _oneBtn.height = self.height;
     _twoBtn.height = self.height;
     _threeBtn.height = self.height;
     
     _oneBtn.y = 0;
     _twoBtn.y = 0;
     _threeBtn.y = 0;
     
     
     _oneBtn.imageView.image = [UIImage imageContentWithFileName:@"default"];
     _twoBtn.imageView.image = [UIImage imageContentWithFileName:@"default"];
     _threeBtn.imageView.image = [UIImage imageContentWithFileName:@"default"];
     
     _oneBtn.x = __SCREEN_SIZE.width/3.0/2.0 - _oneBtn.width/2.0;
     _twoBtn.x = __SCREEN_SIZE.width/3.0 ;
     _threeBtn.x = __SCREEN_SIZE.width/3.0 * 2 ;
     [_oneBtn fitImgAndTitleMode];
     _oneBtn.customTitleLb.textColor = kUIColorFromRGB(color_1);
     _oneBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _oneBtn.customTitleLb.y = 87;
     _oneBtn.customTitleLb.x = 0;
     _oneBtn.customTitleLb.width = _oneBtn.width;

     id img = _dataDic[@"oneImg"];
     if ([img isKindOfClass:[NSString class]]) {
          _oneBtn.customImgV.image = [UIImage imageContentWithFileName:img];
     }
     else
     {
          BUImageRes *curImgRes = _oneBtn.userInfo;
          curImgRes.isValid = NO;
          curImgRes = img;
          curImgRes.isValid = YES;
          _oneBtn.userInfo = img;
          [curImgRes displayRemoteImage:_oneBtn.customImgV imageName:@"default" thumb:YES];
     }
     
     _oneBtn.customImgV.width = 62;
     _oneBtn.customImgV.height = 62;
     _oneBtn.customImgV.x = _oneBtn.width/2.0 - _oneBtn.customImgV.width/2.0;
     _oneBtn.customImgV.y = 15;
     _oneBtn.customTitleLb.y = _oneBtn.customImgV.y + _oneBtn.customImgV.height + 10;
     _oneBtn.customTitleLb.text = _dataDic[@"oneTitle"];
     
     
     [_twoBtn fitImgAndTitleMode];
     _twoBtn.customTitleLb.textColor = kUIColorFromRGB(color_1);
     _twoBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _twoBtn.customTitleLb.y = 87;
     _twoBtn.customTitleLb.x = 0;
     _twoBtn.customTitleLb.width = _twoBtn.width;
     _twoBtn.customTitleLb.text = _dataDic[@"twoTitle"];
     //        btn.customImgV.image = [UIImage imageContentWithFileName:@"qqLogin"];
     id img2 = _dataDic[@"twoImg"];
     if ([img2 isKindOfClass:[NSString class]]) {
          _twoBtn.customImgV.image = [UIImage imageContentWithFileName:img2];
     }
     else
     {
          BUImageRes *curImgRes2 = _twoBtn.userInfo;
          curImgRes2.isValid = NO;
          curImgRes2 = img2;
          curImgRes2.isValid = YES;
          _twoBtn.userInfo = img2;
          [curImgRes2 displayRemoteImage:_twoBtn.customImgV imageName:@"default" thumb:YES];
     }
     
     _twoBtn.customImgV.width = 62;
     _twoBtn.customImgV.height = 62;
     _twoBtn.customImgV.x = _twoBtn.width/2.0 - _twoBtn.customImgV.width/2.0;
     _twoBtn.customImgV.y = 15;
     _twoBtn.customTitleLb.y = _twoBtn.customImgV.y + _twoBtn.customImgV.height + 10;
     
     
     [_threeBtn fitImgAndTitleMode];
     _threeBtn.customTitleLb.textColor = kUIColorFromRGB(color_1);
     _threeBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _threeBtn.customTitleLb.y = 87;
     _threeBtn.customTitleLb.x = 0;
     _threeBtn.customTitleLb.width = _threeBtn.width;
     _threeBtn.customTitleLb.text = _dataDic[@"threeTitle"];
     //        btn.customImgV.image = [UIImage imageContentWithFileName:@"qqLogin"];
     id img3 = _dataDic[@"threeImg"];
     if ([img3 isKindOfClass:[NSString class]]) {
          _threeBtn.customImgV.image = [UIImage imageContentWithFileName:img3];
     }
     else
     {
          BUImageRes *curImgRes3 = _threeBtn.userInfo;
          curImgRes3.isValid = NO;
          curImgRes3 = img3;
          curImgRes3.isValid = YES;
          _threeBtn.userInfo = img3;
          [curImgRes3 displayRemoteImage:_threeBtn.customImgV imageName:@"default" thumb:YES];
     }
     
     _threeBtn.customImgV.width = 62;
     _threeBtn.customImgV.height = 62;
     _threeBtn.customImgV.x = _threeBtn.width/2.0 - _threeBtn.customImgV.width/2.0;
     _threeBtn.customImgV.y = 15;
     _threeBtn.customTitleLb.y = _threeBtn.customImgV.y + _threeBtn.customImgV.height + 10;
     
     
     if (_oneBtn.customTitleLb.text.length == 0) {
          _oneBtn.hidden = YES;
          _oneBtn.userInteractionEnabled = NO;
     }else{
          _oneBtn.hidden = NO;
          _oneBtn.userInteractionEnabled = YES;
     }
     
     if (_twoBtn.customTitleLb.text.length == 0) {
          _twoBtn.hidden = YES;
          _twoBtn.userInteractionEnabled = NO;
     }else{
          _twoBtn.hidden = NO;
          _twoBtn.userInteractionEnabled = YES;
     }
     
     if (_threeBtn.customTitleLb.text.length == 0) {
          _threeBtn.hidden = YES;
          _threeBtn.userInteractionEnabled = NO;
     }else{
          _threeBtn.hidden = NO;
          _threeBtn.userInteractionEnabled = YES;
     }
     
}



-(void)fitHeadMode:(NSString *)defaultImg
{
      self.height = 125;
    if (__SCREEN_SIZE.width == 320) {
        self.height = 96;
    }
  
    _bgImgV.hidden = YES;
    _oneBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    _twoBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    _threeBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    _oneBtn.width = __SCREEN_SIZE.width/3.0;
    _twoBtn.width = _oneBtn.width;
    _threeBtn.width = _oneBtn.width;
    
    
    _oneBtn.height = 115;
    _twoBtn.height = 115;
    _threeBtn.height = 115;
    
    if (__SCREEN_SIZE.width == 320) {
        _oneBtn.height = 95;
        _twoBtn.height = 95;
        _threeBtn.height = 95;
    }
    
    _oneBtn.x = __SCREEN_SIZE.width/3.0/2.0 - _oneBtn.width/2.0;
    _twoBtn.x = __SCREEN_SIZE.width/3.0 ;
    _threeBtn.x = __SCREEN_SIZE.width/3.0 * 2 ;
    
    _oneBtn.y = 0;
    _twoBtn.y = 0;
    _threeBtn.y = 0;
    
    [_oneBtn fitImgAndTitleMode];
    _oneBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
    _oneBtn.customTitleLb.font = [UIFont systemFontOfSize:15];
    _oneBtn.customTitleLb.y = 95;
     if (__SCREEN_SIZE.width == 320) {
     _oneBtn.customTitleLb.y = 72;
     }
    _oneBtn.customTitleLb.x = 0;
    _oneBtn.customTitleLb.width = _oneBtn.width;
     _oneBtn.customTitleLb.text = _dataDic[@"oneTitle"];
    //        btn.customImgV.image = [UIImage imageContentWithFileName:@"qqLogin"];
    id img = _dataDic[@"oneImg"];
    BUImageRes *curImgRes = _oneBtn.userInfo;
    curImgRes.isValid = NO;
    curImgRes = img;
     curImgRes.isValid = YES;
    _oneBtn.userInfo = img;
    [curImgRes displayRemoteImage:_oneBtn.customImgV imageName:defaultImg thumb:YES];
    
    CGFloat wf = 95;
    if(__SCREEN_SIZE.width == 320)
    {
        wf = 77;
    }
    _oneBtn.customImgV.width = wf;
    _oneBtn.customImgV.height = 85/100.0 * _oneBtn.customImgV.width;
    _oneBtn.customImgV.x = _oneBtn.width/2.0 - _oneBtn.customImgV.width/2.0;
    _oneBtn.customImgV.y = 0;
    UIImageView *img1 = [self viewWithTag:4422];
    if (!img1) {
        img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _oneBtn.customImgV.width, _oneBtn.customImgV.height)];
        img1.tag = 4422;
        img1.x = 0;
        img1.y = 0;
    }
    img1.image =  [UIImage imageContentWithFileName:@"cborder"];
    
    [_oneBtn.customImgV addSubview:img1];
    
    
    [_twoBtn fitImgAndTitleMode];
    _twoBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
    _twoBtn.customTitleLb.font = [UIFont systemFontOfSize:15];
    _twoBtn.customTitleLb.y = _oneBtn.customTitleLb.y;
    _twoBtn.customTitleLb.x = 0;
    _twoBtn.customTitleLb.width = _twoBtn.width;
          _twoBtn.customTitleLb.text = _dataDic[@"twoTitle"];
    //        btn.customImgV.image = [UIImage imageContentWithFileName:@"qqLogin"];
    id imgb = _dataDic[@"twoImg"];
    BUImageRes *curImgResb = _twoBtn.userInfo;
    curImgResb.isValid = NO;
    curImgResb = imgb;
     curImgResb.isValid = YES;
    _twoBtn.userInfo = imgb;
    [curImgResb displayRemoteImage:_twoBtn.customImgV imageName:defaultImg thumb:YES];
    
    
    _twoBtn.customImgV.width = _oneBtn.customImgV.width;
    _twoBtn.customImgV.height =  _oneBtn.customImgV.height;
    _twoBtn.customImgV.x = _twoBtn.width/2.0 - _twoBtn.customImgV.width/2.0;
    _twoBtn.customImgV.y = 0;
    UIImageView *img2 = [self viewWithTag:4423];
    if (!img2) {
        img2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _twoBtn.customImgV.width, _twoBtn.customImgV.height)];
        img2.tag = 4423;
        img2.x = 0;
        img2.y = 0;
    }
    img2.image =  [UIImage imageContentWithFileName:@"cborder"];
    
    [_twoBtn.customImgV addSubview:img2];
    
    
    
    
    [_threeBtn fitImgAndTitleMode];
    _threeBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
    _threeBtn.customTitleLb.font = [UIFont systemFontOfSize:15];
    _threeBtn.customTitleLb.y = _oneBtn.customTitleLb.y;
    _threeBtn.customTitleLb.x = 0;
    _threeBtn.customTitleLb.width = _oneBtn.width;
      _threeBtn.customTitleLb.text = _dataDic[@"threeTitle"];
    //        btn.customImgV.image = [UIImage imageContentWithFileName:@"qqLogin"];
    id imgc = _dataDic[@"threeImg"];
    BUImageRes *curImgResc = _oneBtn.userInfo;
    curImgResc.isValid = NO;
    curImgResc = imgc;
     curImgResc.isValid = YES;
    _threeBtn.userInfo = imgc;
    [curImgResc displayRemoteImage:_threeBtn.customImgV imageName:defaultImg thumb:YES];
    
    
    _threeBtn.customImgV.width = _oneBtn.customImgV.width;
    _threeBtn.customImgV.height =  _oneBtn.customImgV.height;
    _threeBtn.customImgV.x = _threeBtn.width/2.0 - _threeBtn.customImgV.width/2.0;
    _threeBtn.customImgV.y = 0;
    UIImageView *img3 = [self viewWithTag:4424];
    if (!img3) {
        img3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _threeBtn.customImgV.width, _threeBtn.customImgV.height)];
        img3.tag = 4424;
        img3.x = 0;
        img3.y = 0;
    }
    img3.image =  [UIImage imageContentWithFileName:@"cborder"];
    
    [_threeBtn.customImgV addSubview:img3];
    
    self.backgroundColor = kUIColorFromRGB(color_2);
    if ([_twoBtn.customTitleLb.text isEqualToString:@""]) {
        _twoBtn.hidden = YES;
        _threeBtn.hidden = YES;
    }
    else
    {
        _twoBtn.hidden = NO;
    }
    
    if ([_twoBtn.customTitleLb.text isEqualToString:@""] ||[_threeBtn.customTitleLb.text isEqualToString:@""]) {
          _threeBtn.hidden = YES;
    }
    else
    {
      _threeBtn.hidden = NO;
    }
}

-(void)fitInfoSettingMode
{
    self.height = 45;
    _bgImgV.hidden = YES;
    _oneBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    _twoBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    _threeBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
   
    [_oneBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
        [_twoBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
        [_threeBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    _oneBtn.x = 0;
    _oneBtn.width = __SCREEN_SIZE.width/3.0;
    _twoBtn.width = _oneBtn.width;
    _twoBtn.x = _oneBtn.width;
    _threeBtn.width = _oneBtn.width;
    _threeBtn.x = _twoBtn.x + _twoBtn.width;
    _oneBtn.height = 44;
    _oneBtn.y = 0;
    _twoBtn.height = _oneBtn.height;
    _twoBtn.y = _oneBtn.y;
    _threeBtn.height = _oneBtn.height;
    _threeBtn.y = _oneBtn.y;
    self.backgroundColor = kUIColorFromRGB(color_4);
    
    UIView *selectLine = [self.contentView viewWithTag:9999];
    if (!selectLine) {
       selectLine = [UIView new];
        selectLine.tag = 9999;
        selectLine.x = 0;
        selectLine.y = 43;
        selectLine.height = 2;
        selectLine.width = _oneBtn.width;
        selectLine.backgroundColor = kUIColorFromRGB(color_mainTheme);
    }
    [_curBtn addSubview:selectLine];
        [_curBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
}

-(void)fitShareMode
{
     self.height = 100;
     _bgImgV.hidden = YES;
     _oneBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _twoBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _threeBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _oneBtn.width = 82;
     _twoBtn.width = 82;
     _threeBtn.width = 82;
     
     _oneBtn.height = 100;
     _twoBtn.height = 100;
     _threeBtn.height = 100;
     
     _oneBtn.x = (__SCREEN_SIZE.width - _oneBtn.width * 3)/2.0;
//     if (__SCREEN_SIZE.width == 320) {
//          _oneBtn.x = 35;
//     }
     _twoBtn.x = _oneBtn.x + _oneBtn.width;
     _threeBtn.x =  _twoBtn.x + _twoBtn.width;
     
     _oneBtn.y = 0;
     _twoBtn.y = 0;
     _threeBtn.y = 0;
     
     [_oneBtn fitImgAndTitleMode];
     _oneBtn.customTitleLb.textColor = kUIColorFromRGB(color_1);
     _oneBtn.customTitleLb.font = [UIFont systemFontOfSize:12];
     _oneBtn.customTitleLb.y = 72;
     _oneBtn.customTitleLb.x = 0;
     _oneBtn.customTitleLb.width = _oneBtn.width;
     _oneBtn.customTitleLb.text = _dataDic[@"oneTitle"];
     _oneBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"oneImg"]];
     _oneBtn.customImgV.width = 41.5;
     _oneBtn.customImgV.height =41.5;
     _oneBtn.customImgV.x = _oneBtn.width/2.0 - _oneBtn.customImgV.width/2.0;
     _oneBtn.customImgV.y = 20;
     
     
     [_twoBtn fitImgAndTitleMode];
     _twoBtn.customTitleLb.textColor = kUIColorFromRGB(color_1);
     _twoBtn.customTitleLb.font = [UIFont systemFontOfSize:12];
     _twoBtn.customTitleLb.y = 72;
     _twoBtn.customTitleLb.x = 0;
     _twoBtn.customTitleLb.width = _twoBtn.width;
     _twoBtn.customTitleLb.text = _dataDic[@"twoTitle"];
     _twoBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"twoImg"]];
     
     _twoBtn.customImgV.width = 41.5;
     _twoBtn.customImgV.height = 41.5;
     _twoBtn.customImgV.x = _twoBtn.width/2.0 - _twoBtn.customImgV.width/2.0;
     _twoBtn.customImgV.y = 20;
     
     [_threeBtn fitImgAndTitleMode];
     _threeBtn.customTitleLb.textColor = kUIColorFromRGB(color_1);
     _threeBtn.customTitleLb.font = [UIFont systemFontOfSize:12];
     _threeBtn.customTitleLb.y = 72;
     _threeBtn.customTitleLb.x = 0;
     _threeBtn.customTitleLb.width = _oneBtn.width;
     _threeBtn.customTitleLb.text = _dataDic[@"threeTitle"];
     _threeBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"threeImg"]];
     
     
     
     _threeBtn.customImgV.width = 41.5;
     _threeBtn.customImgV.height = 41.5;
     _threeBtn.customImgV.x = _threeBtn.width/2.0 - _threeBtn.customImgV.width/2.0;
     _threeBtn.customImgV.y = 20;
     
     
     self.backgroundColor = kUIColorFromRGB(color_0xf7f7f7);
     if ([_twoBtn.customTitleLb.text isEqualToString:@""]) {
          _twoBtn.hidden = YES;
          _threeBtn.hidden = YES;
     }
     else
     {
          _twoBtn.hidden = NO;
     }
     
     if ([_twoBtn.customTitleLb.text isEqualToString:@""] ||[_threeBtn.customTitleLb.text isEqualToString:@""]) {
          _threeBtn.hidden = YES;
     }
     else
     {
          _threeBtn.hidden = NO;
     }
     
}
-(UIButton *)getBtn:(NSInteger)index
{
    UIButton *btn = [self.contentView viewWithTag:100 + index];
    return btn;
}

-(void)fitMyYoubiMode
{
     self.height = 46;
     _oneBtn.width = __SCREEN_SIZE.width/3.0;
     _twoBtn.width = _oneBtn.width;
     _threeBtn.width = _oneBtn.width;
     _oneBtn.x = 0;
     _oneBtn.height = 46;
     _twoBtn.height = _oneBtn.height;
     _threeBtn.height = _oneBtn.height;
     _twoBtn.x = _oneBtn.width;
     _threeBtn.x = _twoBtn.x + _twoBtn.width;
     
     _oneBtn.y = 0;
     _twoBtn.y = _oneBtn.y;
       _threeBtn.y = _oneBtn.y;
     [_oneBtn fitImgAndTitleMode];
      [_twoBtn fitImgAndTitleMode];
      [_threeBtn fitImgAndTitleMode];
     [self setBtnFitMode:_oneBtn withDetail:_dataDic[@"aDetail"]];
     [self setBtnFitMode:_twoBtn withDetail:_dataDic[@"bDetail"]];
     [self setBtnFitMode:_threeBtn withDetail:_dataDic[@"cDetail"]];
     UIView *line = [self.contentView viewWithTag:4081];
     if (!line) {
          line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 46)];
          line.tag = 4081;
          line.backgroundColor = kUIColorFromRGB(color_lineColor);
          line.x = __SCREEN_SIZE.width / 3.0;
     }
     [self.contentView addSubview:line];
     
     UIView *line2 = [self.contentView viewWithTag:4082];
     if (!line2) {
          line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 46)];
          line2.tag = 4082;
          line2.backgroundColor = kUIColorFromRGB(color_lineColor);
          line2.x = __SCREEN_SIZE.width / 3.0 * 2;
     }
     [self.contentView addSubview:line2];
     _oneBtn.userInteractionEnabled = NO;
      _twoBtn.userInteractionEnabled = NO;
      _threeBtn.userInteractionEnabled = NO;
}

-(void)setBtnFitMode:(UIButton *)btn withDetail:(NSString *)detail
{
     btn.customTitleLb.x = btn.width/2.0 - btn.customTitleLb.width/2.0;
     btn.customTitleLb.y = 6;
     btn.customTitleLb.font = [UIFont systemFontOfSize:13];
     btn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     btn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     
     btn.customDetailLb.text = detail;
     btn.customDetailLb.x = btn.width/2.0 - btn.customDetailLb.width/2.0;
     btn.customDetailLb.y = 29;
     btn.customDetailLb.font = [UIFont systemFontOfSize:13];
     btn.customDetailLb.textColor = kUIColorFromRGB(color_3);
     btn.customDetailLb.height = 13;
     btn.customDetailLb.textAlignment = NSTextAlignmentCenter;
}

-(void)fitVipCenterMode
{
     self.height = 46;
     _oneBtn.width = __SCREEN_SIZE.width/3.0;
     _twoBtn.width = _oneBtn.width;
     _threeBtn.width = _oneBtn.width;
     _oneBtn.x = 0;
     _oneBtn.height = 60;
     _twoBtn.height = _oneBtn.height;
     _threeBtn.height = _oneBtn.height;
     _twoBtn.x = _oneBtn.width;
     _threeBtn.x = _twoBtn.x + _twoBtn.width;
     
     _oneBtn.y = 0;
     _twoBtn.y = _oneBtn.y;
     _threeBtn.y = _oneBtn.y;
     [_oneBtn fitImgAndTitleMode];
     [_twoBtn fitImgAndTitleMode];
     [_threeBtn fitImgAndTitleMode];
     
     [self setBtnFitModeB:_oneBtn withImg:_dataDic[@"aimg"] withMarkImg:_dataDic[@"aMark"]];
     [self setBtnFitModeB:_twoBtn withImg:_dataDic[@"bimg"] withMarkImg:_dataDic[@"bMark"]];
     [self setBtnFitModeB:_threeBtn withImg:_dataDic[@"cimg"] withMarkImg:_dataDic[@"cMark"]];
     UIView *line = [self.contentView viewWithTag:4081];
     if (!line) {
          line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 60)];
          line.tag = 4081;
          line.backgroundColor = kUIColorFromRGB(color_lineColor);
          line.x = __SCREEN_SIZE.width / 3.0;
     }
     [self.contentView addSubview:line];
     
     UIView *line2 = [self.contentView viewWithTag:4082];
     if (!line2) {
          line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 60)];
          line2.tag = 4082;
          line2.backgroundColor = kUIColorFromRGB(color_lineColor);
          line2.x = __SCREEN_SIZE.width / 3.0 * 2;
     }
     [self.contentView addSubview:line2];
}

-(void)setBtnFitModeB:(UIButton *)btn withImg:(NSString *)img withMarkImg:(NSString*)mimg
{
     btn.customTitleLb.width = btn.width;
     btn.customTitleLb.height = 11;
     btn.customTitleLb.x = btn.width/2.0 - btn.customTitleLb.width/2.0;
     btn.customTitleLb.y = 43;
     btn.customTitleLb.font = [UIFont systemFontOfSize:11];
     btn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     btn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     
     btn.customImgV.height = 30;
     btn.customImgV.width = 30;
     btn.customImgV.x =  btn.width/2.0 - btn.customImgV.width/2.0;
     btn.customImgV.y = 11;
          btn.customImgV.image = [UIImage imageContentWithFileName:img];
          btn.customImgV.contentMode =UIViewContentModeCenter;
     btn.backgroundColor = kUIColorFromRGB(color_2);
     
     if (mimg) {
          UIImageView *imgv2 = [btn viewWithTag:974];
          if (!imgv2) {
               imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
               imgv2.tag = 974;
               
               imgv2.y = 0;
          }
          imgv2.x = btn.width - imgv2.width;
          //    if (upDown) {
          imgv2.image = [UIImage imageContentWithFileName:mimg];
          [btn addSubview:imgv2];
     }
     else
     {
        UIImageView *imgv2 = [btn viewWithTag:974];
          [imgv2 removeFromSuperview];
     }
}

-(void)fitLuckMode
{
     self.height = 241;
     _oneBtn.width = 54;
     _oneBtn.height = 12;
     _oneBtn.titleLabel.font = [UIFont systemFontOfSize:12];
     [_oneBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     _oneBtn.x = __SCREEN_SIZE.width - 15 - _oneBtn.width;
     _oneBtn.y = 16;
     _oneBtn.customTitleLb.text = @"";
//     _oneBtn.userInteractionEnabled = NO;
     _twoBtn.userInteractionEnabled = NO;
     
     _twoBtn.width = 160;
     _twoBtn.height = 15;
     _twoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
       [_twoBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     _twoBtn.x = __SCREEN_SIZE.width/2.0 - _twoBtn.width/2.0;
     _twoBtn.y = 41;
     
     _threeBtn.height = 128;
     _threeBtn.width = 160;
     _threeBtn.x = __SCREEN_SIZE.width/2.0 - _threeBtn.width/2.0;
     _threeBtn.y = 84;
     [_threeBtn fitImgAndTitleMode];
     _threeBtn.customImgV.y = 0;
     _threeBtn.customImgV.width = 95;
     _threeBtn.customImgV.height = 95;
     _threeBtn.customImgV.x = _threeBtn.width/2.0 - _threeBtn.customImgV.width/2.0;
     _threeBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"img"]];
     
     [_threeBtn sendSubviewToBack:_threeBtn.customImgV];
     _threeBtn.customTitleLb.y = 30;
     _threeBtn.customTitleLb.width = 95;
     _threeBtn.customTitleLb.height = 36;
     _threeBtn.customTitleLb.font = [UIFont systemFontOfSize:36];
     _threeBtn.customTitleLb.text = _dataDic[@"threeTitle"];
     _threeBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _threeBtn.customTitleLb.x = _threeBtn.width/2.0 - _threeBtn.customTitleLb.width/2.0;
     _threeBtn.customTitleLb.textColor = kUIColorFromRGB(color_2);
    _threeBtn.customTitleLb.attributedText = [_threeBtn.customTitleLb richText:[UIFont systemFontOfSize:12] text:@"次" color:kUIColorFromRGB(color_2)];
     
     
     _threeBtn.customDetailLb.text = @"点击翻开卡牌抽奖";
     _threeBtn.customDetailLb.font = [UIFont systemFontOfSize:15];
     _threeBtn.customDetailLb.height = 15;
     _threeBtn.customDetailLb.width = 160;
     _threeBtn.customDetailLb.x = _threeBtn.width/2.0 - _threeBtn.customDetailLb.width/2.0;
     _threeBtn.customDetailLb.y = _threeBtn.customImgV.height + 15;
     _threeBtn.customDetailLb.textColor = kUIColorFromRGB(color_3);
     
     UIImageView *imgv2 = [self.contentView viewWithTag:974];
     if (!imgv2) {
          imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, self.height)];
          imgv2.tag = 974;
          
          imgv2.y = 0;
     }
     
     //    if (upDown) {
     imgv2.image = [UIImage imageContentWithFileName:_dataDic[@"bgImg"]];
     [self.contentView insertSubview:imgv2 atIndex:0];
}


-(void)fitSubmitSuccessMode
{
     
     self.height = 223;
     _oneBtn.width = 120;
     _oneBtn.height = 103;
     [_oneBtn fitImgAndTitleMode];
     _oneBtn.x = __SCREEN_SIZE.width/2.0 - _oneBtn.width/2.0;
     _oneBtn.y = 15;
     
     _oneBtn.customTitleLb.width = _oneBtn.width + 20;
     _oneBtn.customTitleLb.height = 15;
     _oneBtn.customTitleLb.x = _oneBtn.width/2.0 - _oneBtn.customTitleLb.width/2.0;
     _oneBtn.customTitleLb.y = 91;
     _oneBtn.customTitleLb.font = [UIFont systemFontOfSize:15];
     _oneBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     _oneBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     
     _oneBtn.customImgV.height = 76;
     _oneBtn.customImgV.width = 76;
     _oneBtn.customImgV.x =  _oneBtn.width/2.0 - _oneBtn.customImgV.width/2.0;
     _oneBtn.customImgV.y = 0;
     _oneBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"aimg"]];
     _oneBtn.customImgV.contentMode = UIViewContentModeCenter;
     _oneBtn.backgroundColor = kUIColorFromRGB(color_2);
     
     _twoBtn.width = 86;
     _twoBtn.height = 31;
     [_twoBtn setTitleColor:kUIColorFromRGB(color_0xf82D45) forState:UIControlStateNormal];
     _twoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
     _twoBtn.x = 65;
     _twoBtn.y = 151;
     _twoBtn.backgroundColor = kUIColorFromRGB(color_2);
     _twoBtn.layer.cornerRadius = 6;
     _twoBtn.layer.borderWidth = 0.5;
     _twoBtn.layer.borderColor = kUIColorFromRGB(color_0xf82D45).CGColor;

     _threeBtn.width = 86;
     _threeBtn.height = 31;
     [_threeBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     _threeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
     _threeBtn.x = __SCREEN_SIZE.width - 65 - _threeBtn.width;
     _threeBtn.y = 151;
     _threeBtn.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     _threeBtn.layer.cornerRadius = 6;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);

}

-(void)fitPopularityRecMode
{
      self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     self.height = 31;
     _oneBtn.width = 60;
     _twoBtn.width = _oneBtn.width + 30;
     _threeBtn.width = _oneBtn.width;
     _oneBtn.x = 66;
     _oneBtn.height = 30;
     _twoBtn.height = _oneBtn.height;
     _threeBtn.height = _oneBtn.height;
     _twoBtn.x = __SCREEN_SIZE.width/2.0 - _twoBtn.width/2.0;
     _threeBtn.x = __SCREEN_SIZE.width - 66 - _threeBtn.width;
     _norColor = kUIColorFromRGB(color_5);
     _selColor = kUIColorFromRGB(color_3);
     [_twoBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
     [_threeBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
     _oneBtn.titleLabel.font = [UIFont systemFontOfSize:13];
     _twoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
     _threeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
     _threeBtn.customTitleLb.text = @"";
     _oneBtn.customTitleLb.text = @"";
     
     _oneBtn.y = 0;
     _twoBtn.y = _oneBtn.y;
     _threeBtn.y = _oneBtn.y;
     UIView *line = [self.contentView viewWithTag:999];
     if (!line) {
          line  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 2)];
          line.tag = 999;
     }
     line.y = 29;
     line.backgroundColor = kUIColorFromRGB(color_3);
     [_oneBtn addSubview:line];
     
     [_twoBtn fitImgAndTitleMode];
     _twoBtn.customTitleLb.x = 8;
     _twoBtn.customTitleLb.width = 59;
     _twoBtn.customTitleLb.height = 13;
     _twoBtn.customTitleLb.y = _twoBtn.height/2.0 - _twoBtn.customTitleLb.height/2.0;
     
     _twoBtn.customImgV.highlightedImage = [UIImage imageContentWithFileName:@"rec_sortSel"];
     _twoBtn.customImgV.image = [UIImage imageContentWithFileName:@"rec_sort"];
     _twoBtn.customImgV.height = 15;
     _twoBtn.customImgV.width = 10;
     _twoBtn.customImgV.x = _twoBtn.customTitleLb.x + _twoBtn.customTitleLb.width + 4;
     _twoBtn.customImgV.y = _twoBtn.height/2.0 - _twoBtn.customImgV.height/2.0;
}

-(void)fitBrandMakeShopMode
{
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     self.height = 36;
     _oneBtn.width = 57;
     _twoBtn.width = _oneBtn.width;
     _threeBtn.width = 100;
     _oneBtn.x = 15;
     _oneBtn.height = 36;
     _twoBtn.height = _oneBtn.height;
     _threeBtn.height = _oneBtn.height;
         _norColor = kUIColorFromRGB(color_0xb0b0b0);
     _selColor = kUIColorFromRGB(color_0xb0b0b0);

     [self setFitBtnModeD:_oneBtn withTitle:_dataDic[@"oneTitle"] withImg:_dataDic[@"aimg"]];
     [self setFitBtnModeD:_twoBtn withTitle:_dataDic[@"twoTitle"] withImg:_dataDic[@"bimg"]];
     
     [_threeBtn fitImgAndTitleMode];
     
     _threeBtn.customImgV.width = 10;
     _threeBtn.customImgV.height = 18;
     _threeBtn.customImgV.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     _threeBtn.customImgV.y = _threeBtn.height/2.0 - _threeBtn.customImgV.height/2.0;
     
     _threeBtn.customTitleLb.width = 120;
     _threeBtn.customTitleLb.height = 13;
     _threeBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     _threeBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     _threeBtn.customTitleLb.attributedText = [_threeBtn.customTitleLb richText:_dataDic[@"count"] color:kUIColorFromRGB(color_3)];
     [_threeBtn.customTitleLb sizeToFit];
     
     _threeBtn.customTitleLb.y = _threeBtn.height/2.0 - _threeBtn.customTitleLb.height/2.0;
     
     _threeBtn.width = _threeBtn.customImgV.width + 15 + _threeBtn.customTitleLb.width;
        _threeBtn.customTitleLb.x = _threeBtn.width - 15 - _threeBtn.customImgV.width - _threeBtn.customTitleLb.width;
     _threeBtn.customImgV.x = _threeBtn.width - _threeBtn.customImgV.width;
     
     _twoBtn.x = _oneBtn.x + _oneBtn.width + 10;
     _threeBtn.x = __SCREEN_SIZE.width - 15 - _threeBtn.width;

     _oneBtn.y = 0;
     _twoBtn.y = _oneBtn.y;
     _threeBtn.y = _oneBtn.y;
}

-(void)setFitBtnModeD:(UIButton *)btn withTitle:(NSString *)title withImg:(NSString *)img
{
     [btn fitImgAndTitleMode];
     
     btn.customImgV.width = 17;
     btn.customImgV.height = 17;
     btn.customImgV.x = 0;
     btn.customImgV.y = btn.height/2.0 - btn.customImgV.height/2.0;
     btn.customImgV.image = [UIImage imageContentWithFileName:img];
     btn.customImgV.contentMode = UIViewContentModeCenter;
     btn.customTitleLb.width = 80;
     btn.customTitleLb.height = 13;
     btn.customTitleLb.font = [UIFont systemFontOfSize:13];
     btn.customTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     [btn.customTitleLb sizeToFit];
     
     btn.customTitleLb.x = btn.customImgV.x + btn.customImgV.width + 11;
     btn.customTitleLb.y = btn.height/2.0 - btn.customTitleLb.height/2.0;
     
     btn.width = btn.customImgV.width + 11 + btn.customTitleLb.width;
}
-(void)fitVipHelpModeA
{
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     _oneBtn.width = 89;
     _oneBtn.height = 43;
     _oneBtn.x = 15;
     _oneBtn.y = 0;
     [_oneBtn fitImgAndTitleMode];
     _oneBtn.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _oneBtn.customTitleLb.height = _oneBtn.height;
     _oneBtn.customTitleLb.width = _oneBtn.width;
     _oneBtn.customTitleLb.x = 0;
     _oneBtn.customTitleLb.y = 0;
     _oneBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _oneBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     
     _twoBtn.width = 105;
     _twoBtn.height = 43;
     _twoBtn.x = 15 + _oneBtn.width;
     _twoBtn.y = 0;
     [_twoBtn fitImgAndTitleMode];
     _twoBtn.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _twoBtn.customTitleLb.height = _twoBtn.height;
     _twoBtn.customTitleLb.width = _twoBtn.width;
     _twoBtn.customTitleLb.x = 0;
     _twoBtn.customTitleLb.y = 0;
     _twoBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _twoBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     
     _threeBtn.width = __SCREEN_SIZE.width - 30 - _oneBtn.width - _twoBtn.width;
     _threeBtn.height = 43;
     _threeBtn.x = 15 + _oneBtn.width + _twoBtn.width;
     _threeBtn.y = 0;
     [_threeBtn fitImgAndTitleMode];
     _threeBtn.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _threeBtn.customTitleLb.height = _threeBtn.height;
     _threeBtn.customTitleLb.width = _threeBtn.width;
     _threeBtn.customTitleLb.x = 0;
     _threeBtn.customTitleLb.y = 0;
     _threeBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _threeBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     
     UIView *line = [self.contentView viewWithTag:9992];
     if (!line) {
          line  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 43)];
          line.tag = 999;
     }
     line.x = _oneBtn.x;
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
      [self.contentView addSubview:line];
     
     UIView *line2 = [self.contentView viewWithTag:9993];
     if (!line2) {
          line2  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 43)];
          line2.tag = 999;
     }
     line2.x = _twoBtn.x;
     line2.backgroundColor = kUIColorFromRGB(color_lineColor);
      [self.contentView addSubview:line2];
     
     UIView *line3 = [self.contentView viewWithTag:9994];
     if (!line3) {
          line3  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 43)];
          line3.tag = 999;
     }
     line3.x = _twoBtn.x + _twoBtn.width;
     line3.backgroundColor = kUIColorFromRGB(color_lineColor);
      [self.contentView addSubview:line3];
     
     UIView *line4 = [self.contentView viewWithTag:9995];
     if (!line4) {
          line4  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 43)];
          line4.tag = 999;
     }
     line4.x = __SCREEN_SIZE.width - 15;
     line4.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line4];
     self.height = 43;
}

-(void)fitVipHelpModeB:(CGFloat)height
{
     self.height = height;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     _oneBtn.width = 89;
     _oneBtn.height = height;
     _oneBtn.x = 15;
     _oneBtn.y = 0;
     [_oneBtn fitImgAndTitleMode];
     _oneBtn.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _oneBtn.customTitleLb.height = _oneBtn.height;
     _oneBtn.customTitleLb.width = _oneBtn.width;
     _oneBtn.customTitleLb.x = 0;
     _oneBtn.customTitleLb.y = 0;
     _oneBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _oneBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _oneBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _oneBtn.customTitleLb.numberOfLines = 0;
     
     _twoBtn.width = 105;
     _twoBtn.height = height;
     _twoBtn.x = 15 + _oneBtn.width;
     _twoBtn.y = 0;
     [_twoBtn fitImgAndTitleMode];
     _twoBtn.backgroundColor = kUIColorFromRGB(color_2);
     _twoBtn.customTitleLb.height = _twoBtn.height;
     _twoBtn.customTitleLb.width = _twoBtn.width;
     _twoBtn.customTitleLb.x = 0;
     _twoBtn.customTitleLb.y = 0;
     _twoBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _twoBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
       _twoBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
       _twoBtn.customTitleLb.numberOfLines = 0;
     
     _threeBtn.width = __SCREEN_SIZE.width - 30 - _oneBtn.width - _twoBtn.width;
     _threeBtn.height = height;
     _threeBtn.x = 15 + _oneBtn.width + _twoBtn.width;
     _threeBtn.y = 0;
     [_threeBtn fitImgAndTitleMode];
     _threeBtn.backgroundColor = kUIColorFromRGB(color_2);
     _threeBtn.customTitleLb.height = _threeBtn.height;
     _threeBtn.customTitleLb.width = _threeBtn.width;
     _threeBtn.customTitleLb.x = 0;
     _threeBtn.customTitleLb.y = 0;
     _threeBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _threeBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
       _threeBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
       _threeBtn.customTitleLb.numberOfLines = 0;
     
     UIView *line = [self.contentView viewWithTag:9992];
     if (!line) {
          line  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line.tag = 9992;
     }
     line.x = _oneBtn.x;
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line];
     
     UIView *line2 = [self.contentView viewWithTag:9993];
     if (!line2) {
          line2  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line2.tag = 9993;
     }
     line2.x = _twoBtn.x;
     line2.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line2];
     
     UIView *line3 = [self.contentView viewWithTag:9994];
     if (!line3) {
          line3  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line3.tag = 9994;
     }
     line3.x = _twoBtn.x + _twoBtn.width;
     line3.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line3];
     
     UIView *line4 = [self.contentView viewWithTag:9995];
     if (!line4) {
          line4  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line4.tag = 9995;
     }
     line4.x = __SCREEN_SIZE.width - 15;
     line4.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line4];
}

-(void)fitCheckAddressMode:(BOOL)isCheck
{
     CGFloat height = 35;
     self.height = height;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     _oneBtn.width = 89;
     _oneBtn.height = height;
     _oneBtn.x = 15;
     _oneBtn.y = 0;
     [_oneBtn fitImgAndTitleMode];
     _oneBtn.customTitleLb.height = _oneBtn.height;
     _oneBtn.customTitleLb.width = 54;
     _oneBtn.customTitleLb.x = 30;
     _oneBtn.customTitleLb.y = 0;
     _oneBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _oneBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     _oneBtn.customTitleLb.textAlignment = NSTextAlignmentLeft;
     _oneBtn.customTitleLb.numberOfLines = 1;
     _oneBtn.customImgV.height = 15;
     _oneBtn.customImgV.width = 15;
     _oneBtn.customImgV.x = 0;
     _oneBtn.customImgV.y = 10;
     _oneBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"aimg"]];
     _oneBtn.customImgV.highlightedImage = [UIImage imageContentWithFileName:_dataDic[@"checkImg"]];
     _oneBtn.customImgV.highlighted = isCheck;
     _oneBtn.selected = isCheck;
     _twoBtn.width = 55;
     _twoBtn.height = height;
     _twoBtn.x = __SCREEN_SIZE.width - 74 - _twoBtn.width;
     _twoBtn.y = 0;
     [_twoBtn fitImgAndTitleMode];
     _twoBtn.backgroundColor = kUIColorFromRGB(color_2);
     _twoBtn.customTitleLb.height = _twoBtn.height;
     _twoBtn.customTitleLb.width = 28;
     _twoBtn.customTitleLb.x = 26;
     _twoBtn.customTitleLb.y = 0;
     _twoBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _twoBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     _twoBtn.customTitleLb.textAlignment = NSTextAlignmentLeft;
     _twoBtn.customTitleLb.numberOfLines = 1;
     _twoBtn.customImgV.height = 16;
     _twoBtn.customImgV.width = 16;
     _twoBtn.customImgV.x = 0;
     _twoBtn.customImgV.y = 10;
     _twoBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"bimg"]];
     
     
     _threeBtn.width = 55;
     _threeBtn.height = height;
     _threeBtn.x = __SCREEN_SIZE.width - 15 - _twoBtn.width;
     _threeBtn.y = 0;
     [_threeBtn fitImgAndTitleMode];
     _threeBtn.backgroundColor = kUIColorFromRGB(color_2);
     _threeBtn.customTitleLb.height = _threeBtn.height;
     _threeBtn.customTitleLb.width = 28;
     _threeBtn.customTitleLb.x = 25;
     _threeBtn.customTitleLb.y = 0;
     _threeBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _threeBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     _threeBtn.customTitleLb.textAlignment = NSTextAlignmentLeft;
     _threeBtn.customTitleLb.numberOfLines = 1;
     _threeBtn.customImgV.height = 15;
     _threeBtn.customImgV.width = 15;
     _threeBtn.customImgV.x = 0;
     _threeBtn.customImgV.y = 10;
     _threeBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"cimg"]];
}
@end
