//
//  FiveBtnTableViewCell.m
//  oranllcshoping
//
//  Created by air on 2017/7/21.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "FiveBtnTableViewCell.h"

@implementation FiveBtnTableViewCell
{

    IBOutlet UIButton *_eBtn;
    IBOutlet UIButton *_dBtn;
    IBOutlet UIButton *_cBtn;
    IBOutlet UIButton *_bBtn;
    IBOutlet UIButton *_aBtn;
    NSDictionary *_dataDic;
     UIButton *_curBtn;
     NSInteger _state;//1:商品详情
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
    _dataDic = dataDic;
}

-(void)fitMineModeA
{
    self.height = 100;
    _aBtn.width = (__SCREEN_SIZE.width - 10)/5.0;
    _bBtn.width = _aBtn.width;
     _cBtn.width = _aBtn.width;
     _dBtn.width = _aBtn.width;
     _eBtn.width = _aBtn.width;
    
    _aBtn.height = 100;
    _bBtn.height = _aBtn.height;
     _cBtn.height = _aBtn.height;
     _dBtn.height = _aBtn.height;
     _eBtn.height = _aBtn.height;
    
    _aBtn.x = 5;
    _bBtn.x = _aBtn.x + _aBtn.width;
    _cBtn.x = _bBtn.x + _bBtn.width;
    _dBtn.x = _cBtn.x + _cBtn.width;
    _eBtn.x = _dBtn.x + _dBtn.width;
    
    [self setBtnFitMode:_aBtn withTitle:_dataDic[@"aTitle"] withImg:_dataDic[@"aimg"] withNum:[_dataDic[@"anum"] integerValue]];
     [self setBtnFitMode:_bBtn withTitle:_dataDic[@"bTitle"] withImg:_dataDic[@"bimg"] withNum:[_dataDic[@"bnum"] integerValue]];
     [self setBtnFitMode:_cBtn withTitle:_dataDic[@"cTitle"] withImg:_dataDic[@"cimg"] withNum:[_dataDic[@"cnum"] integerValue]];
     [self setBtnFitMode:_dBtn withTitle:_dataDic[@"dTitle"] withImg:_dataDic[@"dimg"] withNum:[_dataDic[@"dnum"] integerValue]];
     [self setBtnFitMode:_eBtn withTitle:_dataDic[@"eTitle"] withImg:_dataDic[@"eimg"] withNum:[_dataDic[@"enum"] integerValue]];
    
}

-(void)setBtnFitMode:(UIButton *)btn withTitle:(NSString *)title withImg:(NSString *)img withNum:(NSInteger) num
{
    [btn fitImgAndTitleMode];
    btn.customTitleLb.text = title;
    btn.customTitleLb.textColor = kUIColorFromRGB(color_7);
    btn.customTitleLb.font = [UIFont systemFontOfSize:12];
    btn.customTitleLb.y = 57;
     btn.customTitleLb.height = 12;
    btn.customImgV.y = 29;
    btn.customImgV.image = [UIImage imageContentWithFileName:img];
    btn.customImgV.height = 20;
    btn.customImgV.width = 20;
     btn.customImgV.x = btn.width/2.0 - btn.customImgV.width/2.0;
    btn.customImgV.contentMode =UIViewContentModeCenter;
         btn.y = 0;
     UILabel *nub = [btn viewWithTag:1200];
     if (!nub) {
          nub = [UILabel new];
          nub.tag = 1200;
          nub.width = 12;
          nub.height = 12;
          if (__SCREEN_SIZE.width == 320) {
               nub.x = btn.width - 25;
               nub.y = 25;
          }
          else
          {
               nub.x =  btn.width/2.0 + 3;
               nub.y = 25;
          }

          nub.layer.cornerRadius = nub.width/2.0;
          nub.backgroundColor = kUIColorFromRGB(color_0xff7167);
          nub.layer.masksToBounds = YES;
          nub.textColor = kUIColorFromRGB(color_2);
          nub.textAlignment = NSTextAlignmentCenter;
          nub.font = [UIFont systemFontOfSize:7 ];
     }
     nub.text = [NSString stringWithFormat:@"%ld",num];
     if (num == 0) {
          nub.hidden = YES;
     }
     else
     {
          nub.hidden = NO;
     }
     [btn addSubview:nub];
}

-(void)setBtnFitMode:(UIButton *)btn withTitle:(NSString *)title withDetial:(NSString *)detail
{
      [btn fitImgAndTitleMode];
    btn.customTitleLb.text = title;
    btn.customTitleLb.textColor = kUIColorFromRGB(color_5);
    btn.customTitleLb.font = [UIFont systemFontOfSize:14];
    btn.customTitleLb.height = 14;
    btn.customTitleLb.y = 20;
    btn.customDetailLb.y = 47;
    btn.customDetailLb.font = [UIFont systemFontOfSize:13];
    btn.customDetailLb.height = 12;
    btn.customDetailLb.textColor = kUIColorFromRGB(color_5);
    btn.customDetailLb.text = detail;
     btn.y = 0;
}
-(void)fitMineModeB
{
     self.height = 100;
     _aBtn.width = (__SCREEN_SIZE.width - 10)/5.0;
     _bBtn.width = _aBtn.width;
     _cBtn.width = _aBtn.width;
     _dBtn.width = _aBtn.width;
     _eBtn.width = _aBtn.width;

     _aBtn.height = 100;
     _bBtn.height = _aBtn.height;
     _cBtn.height = _aBtn.height;
     _dBtn.height = _aBtn.height;
     _eBtn.height = _aBtn.height;

     _aBtn.x = 5;
     _bBtn.x = _aBtn.x + _aBtn.width;
     _cBtn.x = _bBtn.x + _bBtn.width;
     _dBtn.x = _cBtn.x + _cBtn.width;
     _eBtn.x = _dBtn.x + _dBtn.width;

     [self setBtnFitMode:_aBtn withTitle:_dataDic[@"aTitle"] withImg:_dataDic[@"aimg"] withNum:0];

     UIImageView *imgv = [self.contentView viewWithTag:9173];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
          imgv.tag = 9173;

          imgv.y = 25;


     }
     if (__SCREEN_SIZE.width == 320) {
          imgv.x = _aBtn.width - 25;
          imgv.y = 25;
     }
     else
     {
          imgv.x =  _aBtn.width/2.0 + 3 ;
          imgv.y = 25;
     }
//       imgv.backgroundColor = kUIColorFromRGB(color_0xff7167);
     imgv.image = [UIImage imageContentWithFileName:@"alert"];
     if ([_dataDic[@"anum"] integerValue] == 0) {
          imgv.hidden = YES;
     }
     else
     {
          imgv.hidden = NO;
     }
     [_aBtn addSubview:imgv];

     [self setBtnFitMode:_bBtn withTitle:_dataDic[@"bTitle"] withImg:_dataDic[@"bimg"] withNum:[_dataDic[@"bnum"] integerValue]];
     [self setBtnFitMode:_cBtn withTitle:_dataDic[@"cTitle"] withImg:_dataDic[@"cimg"] withNum:[_dataDic[@"cnum"] integerValue]];
     [self setBtnFitMode:_dBtn withTitle:_dataDic[@"dTitle"] withImg:_dataDic[@"dimg"] withNum:[_dataDic[@"dnum"] integerValue]];
     [self setBtnFitMode:_eBtn withTitle:_dataDic[@"eTitle"] withImg:_dataDic[@"eimg"] withNum:[_dataDic[@"enum"] integerValue]];
}

-(void)fitMineTitleDetailMode
{
    self.height = 73;
    _aBtn.width = (__SCREEN_SIZE.width - 10)/5.0;
    _bBtn.width = _aBtn.width;
    _cBtn.width = _aBtn.width;
    _dBtn.width = _aBtn.width;
    _eBtn.width = _aBtn.width;
    
    _aBtn.height = 72;
    _bBtn.height = _aBtn.height;
    _cBtn.height = _aBtn.height;
    _dBtn.height = _aBtn.height;
    _eBtn.height = _aBtn.height;
    
    _aBtn.x = 5;
    _bBtn.x = _aBtn.x + _aBtn.width;
    _cBtn.x = _bBtn.x + _bBtn.width;
    _dBtn.x = _cBtn.x + _cBtn.width;
    _eBtn.x = _dBtn.x + _dBtn.width;
     [self setBtnFitMode:_aBtn withTitle:_dataDic[@"aTitle"] withImg:_dataDic[@"aimg"] withNum:0];
       [self setBtnFitMode:_bBtn withTitle:_dataDic[@"bTitle"] withDetial:_dataDic[@"bDetail"]];
       [self setBtnFitMode:_cBtn withTitle:_dataDic[@"cTitle"] withDetial:_dataDic[@"cDetail"]];
       [self setBtnFitMode:_dBtn withTitle:_dataDic[@"dTitle"] withDetial:_dataDic[@"dDetail"]];
       [self setBtnFitMode:_eBtn withTitle:_dataDic[@"eTitle"] withDetial:_dataDic[@"eDetail"]];
}


-(void)fitGoodsInfoMode
{
     self.height = 45;
     _aBtn.width = (__SCREEN_SIZE.width - 10)/5.0;
     _bBtn.width = _aBtn.width;
     _cBtn.width = _aBtn.width;
     _dBtn.width = _aBtn.width;
     _eBtn.width = _aBtn.width;
     
     _aBtn.height = 45;
     _bBtn.height = _aBtn.height;
     _cBtn.height = _aBtn.height;
     _dBtn.height = _aBtn.height;
     _eBtn.height = _aBtn.height;
     
     _aBtn.x = 5;
     _bBtn.x = _aBtn.x + _aBtn.width;
     _cBtn.x = _bBtn.x + _bBtn.width;
     _dBtn.x = _cBtn.x + _cBtn.width;
     _eBtn.x = _dBtn.x + _dBtn.width;
     [self setBtnFitGoodsInfoMode:_aBtn withTitle:_dataDic[@"aTitle"] withDetial:_dataDic[@"aDetail"]];
     [self setBtnFitGoodsInfoMode:_bBtn withTitle:_dataDic[@"bTitle"] withDetial:_dataDic[@"bDetail"]];
     [self setBtnFitGoodsInfoMode:_cBtn withTitle:_dataDic[@"cTitle"] withDetial:_dataDic[@"cDetail"]];
     [self setBtnFitGoodsInfoMode:_dBtn withTitle:_dataDic[@"dTitle"] withDetial:_dataDic[@"dDetail"]];
     [self setBtnFitGoodsInfoMode:_eBtn withTitle:_dataDic[@"eTitle"] withDetial:_dataDic[@"eDetail"]];
     _curBtn = _aBtn;
     _curBtn.customTitleLb.textColor = kUIColorFromRGB(color_3);
     _curBtn.customDetailLb.textColor = kUIColorFromRGB(color_3);
     _state = 1;
}

-(void)setBtnFitGoodsInfoMode:(UIButton *)btn withTitle:(NSString *)title withDetial:(NSString *)detail
{
     [btn fitImgAndTitleMode];
     btn.customTitleLb.text = title;
     btn.customTitleLb.textColor = kUIColorFromRGB(color_8);
     btn.customTitleLb.font = [UIFont systemFontOfSize:13];
     btn.customTitleLb.height = 13;
     btn.customTitleLb.y = 7;
     btn.customDetailLb.y = 24;
     btn.customDetailLb.font = [UIFont systemFontOfSize:13];
     btn.customDetailLb.height = 13;
     btn.customDetailLb.textColor = kUIColorFromRGB(color_8);
     btn.customDetailLb.text = detail;
     btn.y = 0;
}


- (IBAction)btnHandle:(id)sender {
     if (_state == 1) {//商品详情
          if (_curBtn != sender) {
               UIButton *btn = sender;
               btn.customTitleLb.textColor = kUIColorFromRGB(color_3);
               btn.customDetailLb.textColor = kUIColorFromRGB(color_3);
               _curBtn.customTitleLb.textColor = kUIColorFromRGB(color_8);
               _curBtn.customDetailLb.textColor = kUIColorFromRGB(color_8);
               _curBtn = btn;
          }
     }
    if (self.handleAction) {
         self.handleAction(@{@"obj":sender});
    }
}

-(void)fitVIPCenterMode
{
     self.height = 195;
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 195)];
          imgv.tag = 973;
          
          imgv.y = 0;
          
          
     }
     imgv.x = 0;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"vipBg"];
     [self.contentView insertSubview:imgv atIndex:0];
   
     

 
     [self setBtnFitModeC:_aBtn withTitle:_dataDic[@"aTitle"] withImg:_dataDic[@"aimg"]];
     _aBtn.y = 15;
     _aBtn.x = __SCREEN_SIZE.width/2.0 - _aBtn.width/2.0;
     [_bBtn setTitle:_dataDic[@"bTitle"] forState:UIControlStateNormal];
     _bBtn.backgroundColor = kUIColorFromRGB(color_F5E852);
     [_bBtn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     _bBtn.titleLabel.font = [UIFont systemFontOfSize:12];
     _bBtn.width = 71;
     _bBtn.height = 22;
     _bBtn.layer.cornerRadius = _bBtn.height/2.0;
     _bBtn.layer.masksToBounds = YES;
     _bBtn.x = 0;
     _bBtn.y = 0;
     UIView *bcV = [UIView new];
     bcV.width = __SCREEN_SIZE.width;
     bcV.height = 22;
     [bcV addSubview:_bBtn];
     [bcV addSubview:_cBtn];
     [self.contentView addSubview:bcV];
     _cBtn.width = 170;
     _cBtn.height = 22;
     _cBtn.titleLabel.font = [UIFont systemFontOfSize:11];
     [_cBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
   [_cBtn setTitle:_dataDic[@"cTitle"] forState:UIControlStateNormal];
   CGSize ss = [_dataDic[@"cTitle"] size:[UIFont systemFontOfSize:11] constrainedToSize:CGSizeMake(320, 22)];
     _cBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
     bcV.width = _bBtn.width + 10 + ss.width ;
     _cBtn.x = _bBtn.width + 10;
     _cBtn.y = 0;
     bcV.y = 90;
     bcV.x = __SCREEN_SIZE.width/2.0 - bcV.width/2.0;

     

     _dBtn.width = 120;
     _dBtn.height = 11;
     _dBtn.titleLabel.font = [UIFont systemFontOfSize:11];
     [_dBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     [_dBtn setTitle:_dataDic[@"dTitle"] forState:UIControlStateNormal];
     _dBtn.x = __SCREEN_SIZE.width/2.0 - _dBtn.width/2.0;
     _dBtn.y = 121;
     
     _eBtn.hidden = YES;
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     
//     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_bBtn.x + 10, 112, __SCREEN_SIZE.width - (_bBtn.x + 10) * 2, 1)];
//     line.backgroundColor = kUIColorFromRGB(color_2);
//     [self.contentView insertSubview:line atIndex:1];
}


-(void)setBtnFitModeB:(UIButton *)btn withTitle:(NSString *)title withImg:(NSString *)img
{
     btn.height = 50;
     btn.width = 50;
     
     [btn fitImgAndTitleMode];
     btn.customTitleLb.text = title;
     btn.customTitleLb.textColor = kUIColorFromRGB(color_2);
     btn.customTitleLb.font = [UIFont systemFontOfSize:10];
     btn.customTitleLb.y = 40;
     btn.customTitleLb.height = 10;
     btn.customTitleLb.x = 0;
     btn.customTitleLb.width = btn.width;
     btn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     
     btn.customImgV.y = 0;

     btn.customImgV.height = 30;
     btn.customImgV.width = 30;
       btn.customImgV.image = [UIImage imageContentWithFileName:img];
     btn.customImgV.x = btn.width/2.0 - btn.customImgV.width/2.0;
     btn.customImgV.contentMode =UIViewContentModeCenter;
  
}


-(void)setBtnFitModeC:(UIButton *)btn withTitle:(NSString *)title withImg:(NSString *)img
{
     btn.height = 70;
     btn.width = 90;
     
     [btn fitImgAndTitleMode];
     btn.customTitleLb.text = title;
     btn.customTitleLb.textColor = kUIColorFromRGB(color_2);
     btn.customTitleLb.font = [UIFont systemFontOfSize:13];
     btn.customTitleLb.y = 60;
     btn.customTitleLb.height = 13;
     btn.customTitleLb.x = 0;
     btn.customTitleLb.width = btn.width;
         btn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     
     btn.customImgV.y = 0;
     btn.customImgV.height = 48;
     btn.customImgV.width = 48;
     if ([img isKindOfClass:[BUImageRes class]]) {
          BUImageRes *im = img;
          [im displayRemoteImage: btn.customImgV imageName:@"defaultHead" thumb:YES size:CGSizeMake(48, 48)];
          btn.customImgV.height = 48;
          btn.customImgV.width = 48;
          btn.customImgV.layer.cornerRadius = btn.customImgV.width/2.0;
          btn.customImgV.layer.masksToBounds = YES;
     }
     else
     btn.customImgV.image = [UIImage imageContentWithFileName:img];

     btn.customImgV.x = btn.width/2.0 - btn.customImgV.width/2.0;
     btn.customImgV.contentMode =UIViewContentModeCenter;
     
}

-(void)fitRecordInfoModeB
{
     [self setBtnFitModeC:_aBtn withTitle:_dataDic[@"aTitle"] withImg:_dataDic[@"aimg"] withDetail:_dataDic[@"aDetail"] withIsSelect:[_dataDic[@"check"] integerValue]];
     [self setBtnFitModeC:_bBtn withTitle:_dataDic[@"bTitle"] withImg:_dataDic[@"bimg"] withDetail:_dataDic[@"bDetail"] withIsSelect:[_dataDic[@"check"] integerValue]];
     
     _aBtn.y = 0;
     _aBtn.x = __SCREEN_SIZE.width/2.0 -  205/2.0;
     
     _bBtn.x = _aBtn.x + _aBtn.width + 85;
     _bBtn.y = _aBtn.y;
     if([_dataDic[@"bimg"] isEqualToString:@"unDone"])
     {
          _bBtn.customTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     }

      _cBtn.hidden = YES;
     
     _dBtn.hidden = YES;
     
     _eBtn.hidden = YES;
     
     
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_aBtn.x + 45, 46, 115, 1)];
     line.backgroundColor = kUIColorFromRGB(color_3);
     [self.contentView insertSubview:line atIndex:0];
     
}

-(void)fitRecordInfoMode
{
     [self setBtnFitModeC:_aBtn withTitle:_dataDic[@"aTitle"] withImg:_dataDic[@"aimg"] withDetail:_dataDic[@"aDetail"] withIsSelect:[_dataDic[@"check"] integerValue]];
     [self setBtnFitModeC:_bBtn withTitle:_dataDic[@"bTitle"] withImg:_dataDic[@"bimg"] withDetail:_dataDic[@"bDetail"] withIsSelect:[_dataDic[@"check"] integerValue]];
     [self setBtnFitModeC:_cBtn withTitle:_dataDic[@"cTitle"] withImg:_dataDic[@"cimg"] withDetail:_dataDic[@"cDetail"] withIsSelect:[_dataDic[@"check"] integerValue]];
     [self setBtnFitModeC:_dBtn withTitle:_dataDic[@"dTitle"] withImg:_dataDic[@"dimg"] withDetail:_dataDic[@"dDetail"] withIsSelect:[_dataDic[@"check"] integerValue]];
     [self setBtnFitModeC:_eBtn withTitle:_dataDic[@"eTitle"] withImg:_dataDic[@"eimg"] withDetail:_dataDic[@"eDetail"]  withIsSelect:[_dataDic[@"check"] integerValue]];
     CGFloat vv = 14;
     if (__SCREEN_SIZE.width == 320) {
          vv = 8;

     }
     _aBtn.y = 0;
     _aBtn.x = (__SCREEN_SIZE.width - (_bBtn.width * 5 + vv * 4))/2.0;


     _bBtn.x = _aBtn.x + _aBtn.width + vv;
     _bBtn.y = _aBtn.y;

     _cBtn.x = _bBtn.x + _bBtn.width + vv;
     _cBtn.y = _bBtn.y;

     _dBtn.x = _cBtn.x + _cBtn.width + vv;
     _dBtn.y = _cBtn.y;

     _eBtn.x = _dBtn.x + _dBtn.width + vv;
     _eBtn.y = _dBtn.y;

     self.contentView.backgroundColor = kUIColorFromRGB(color_2);

     UIView *line =[self.contentView viewWithTag:7733];
     if (!line) {
          line = [[UIView alloc] initWithFrame:CGRectMake(_aBtn.x + 20, 46, __SCREEN_SIZE.width - (_aBtn.x + 20) * 2, 1)];
          line.tag = 7733;
     }
     line.backgroundColor = kUIColorFromRGB(color_0xb0b0b0);
     [self.contentView insertSubview:line atIndex:0];

     UIView *line2 =[self.contentView viewWithTag:7755];
     if (!line2) {
          line2 = [[UIView alloc] initWithFrame:CGRectMake(_aBtn.x + 20, 46, __SCREEN_SIZE.width - (_aBtn.x + 20) * 2, 1)];
          line2.tag = 7755;
     }
     line2.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     NSInteger cc = MIN([_dataDic[@"check"] integerValue], 4);
     line2.width =  (_cBtn.width + vv) * cc;
     [self.contentView insertSubview:line2 atIndex:1];


}
-(void)setBtnFitModeC:(UIButton *)btn withTitle:(NSString *)title withImg:(NSString *)img withDetail:(NSString *)detail withIsSelect:(NSInteger )isS
{
     btn.height = 114;
     btn.width = 60;
     if (__SCREEN_SIZE.width == 320) {
          btn.width = 56;
     }
     [btn fitImgAndTitleMode];
     btn.customImgV.backgroundColor = kUIColorFromRGB(color_2);
     btn.customTitleLb.text = title;
     if (btn.tag - 100 <= isS) {
          if ([img isEqualToString:@"wrong"]) {
btn.customTitleLb.textColor = kUIColorFromRGB(color_0xf82D45);
          }
          else
          btn.customTitleLb.textColor = kUIColorFromRGB(color_0xf82D45);
     }
else
{

         btn.customTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
}
     btn.customTitleLb.font = [UIFont systemFontOfSize:12];
     btn.customTitleLb.y = 70;
     btn.customTitleLb.height = 12;
     btn.customTitleLb.x = 0;
     btn.customTitleLb.width = btn.width;
     btn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     
     btn.customImgV.y = 34;
     if (!img || [img isEqualToString:@""]) {
          btn.customImgV.image = [UIImage imageContentWithFileName:@"unDone"];;
     }
     else
     {
     btn.customImgV.image = [UIImage imageContentWithFileName:img];
     }
     btn.customImgV.height = 25;
     btn.customImgV.width = 25;
     btn.customImgV.x = btn.width/2.0 - btn.customImgV.width/2.0;
     btn.customImgV.contentMode =UIViewContentModeCenter;
     
     btn.customDetailLb.text = detail;
     btn.customDetailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     btn.customDetailLb.font = [UIFont systemFontOfSize:11];
     btn.customDetailLb.y = 88;
     btn.customDetailLb.height = 30;
     btn.customDetailLb.numberOfLines = 2;
     btn.customDetailLb.x = 0;
     btn.customDetailLb.width = btn.width;
     btn.customDetailLb.textAlignment = NSTextAlignmentCenter;
     
     UIImageView *imgv2 = [btn viewWithTag:974];
     if (!imgv2) {
          imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 39, 20)];
          imgv2.tag = 974;
          
          imgv2.y = 10;
     }
     imgv2.x = btn.width/2.0 - imgv2.width/2.0;;
     //    if (upDown) {
     imgv2.image = [UIImage imageContentWithFileName:nil];
     imgv2.highlightedImage = [UIImage imageContentWithFileName:_dataDic[@"hMark"]];
     [btn addSubview:imgv2];

     btn.customImgV.highlighted = isS == btn.tag - 100;
     imgv2.highlighted = isS == btn.tag - 100;
      UILabel *lb = [imgv2 viewWithTag:12113];
     if (imgv2.highlighted) {
     
    
     if (!lb) {
          lb = [UILabel new];
          lb.width = 40;
          lb.height = 11;
          lb.tag = 12113;
     }
     lb.textAlignment = NSTextAlignmentCenter;
     lb.text = _dataDic[@"mark"];
          if(lb.text.length >3)
          {
           lb.width = 50;
               imgv2.width = 50;
                imgv2.x = btn.width/2.0 - imgv2.width/2.0;;
          }
     lb.textColor = kUIColorFromRGB(color_2);
     lb.font =  [UIFont systemFontOfSize:11];
     lb.x = 0;
     lb.y = 3;
     [imgv2 addSubview:lb];
     }else
     {
          [lb removeFromSuperview];
          imgv2.image = nil;
     }
     
}

-(void)fitVipHelpModeA
{
     self.height = 43;
     _aBtn.width = (__SCREEN_SIZE.width - 30)/5.0;
     _aBtn.height = 43;
     _aBtn.x = 15;
     _aBtn.y = 0;
     [_aBtn fitImgAndTitleMode];
     _aBtn.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _aBtn.customTitleLb.height = _aBtn.height;
     _aBtn.customTitleLb.width = _aBtn.width;
     _aBtn.customTitleLb.x = 0;
     _aBtn.customTitleLb.y = 0;
     _aBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _aBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _aBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _aBtn.customTitleLb.numberOfLines = 0;
     _aBtn.customTitleLb.text = _dataDic[@"aTitle"];
        _aBtn.x = 15;
     _bBtn.width = _aBtn.width;
     _bBtn.height = 43;
     _bBtn.x = 15;
     _bBtn.y = 0;
     [_bBtn fitImgAndTitleMode];
     _bBtn.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _bBtn.customTitleLb.height = _bBtn.height;
     _bBtn.customTitleLb.width = _bBtn.width;
     _bBtn.customTitleLb.x = 0;
     _bBtn.customTitleLb.y = 0;
     _bBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _bBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _bBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _bBtn.customTitleLb.numberOfLines = 0;
     _bBtn.customTitleLb.text = _dataDic[@"bTitle"];
        _bBtn.x = _aBtn.x + _aBtn.width;
     
     _cBtn.width = _aBtn.width;
     _cBtn.height = 43;
     _cBtn.x = 15;
     _cBtn.y = 0;
     [_cBtn fitImgAndTitleMode];
     _cBtn.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _cBtn.customTitleLb.height = _cBtn.height;
     _cBtn.customTitleLb.width = _cBtn.width;
     _cBtn.customTitleLb.x = 0;
     _cBtn.customTitleLb.y = 0;
     _cBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _cBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _cBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _cBtn.customTitleLb.numberOfLines = 0;
     _cBtn.customTitleLb.text = _dataDic[@"cTitle"];
        _cBtn.x = _bBtn.x + _bBtn.width;
     
     _dBtn.width = _aBtn.width;
     _dBtn.height = 43;
     _dBtn.x = 15;
     _dBtn.y = 0;
     [_dBtn fitImgAndTitleMode];
     _dBtn.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _dBtn.customTitleLb.height = _dBtn.height;
     _dBtn.customTitleLb.width = _dBtn.width;
     _dBtn.customTitleLb.x = 0;
     _dBtn.customTitleLb.y = 0;
     _dBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _dBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _dBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _dBtn.customTitleLb.numberOfLines = 0;
     _dBtn.customTitleLb.text = _dataDic[@"dTitle"];
        _dBtn.x = _cBtn.x + _cBtn.width;
     
     _eBtn.width = _aBtn.width;
     _eBtn.height = 43;
     _eBtn.x = 15;
     _eBtn.y = 0;
     [_eBtn fitImgAndTitleMode];
     _eBtn.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _eBtn.customTitleLb.height = _eBtn.height;
     _eBtn.customTitleLb.width = _eBtn.width;
     _eBtn.customTitleLb.x = 0;
     _eBtn.customTitleLb.y = 0;
     _eBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _eBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _eBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _eBtn.customTitleLb.numberOfLines = 0;
     _eBtn.customTitleLb.text = _dataDic[@"eTitle"];
        _eBtn.x = _dBtn.x + _dBtn.width;
     CGFloat height = 43;
     
     UIView *line = [self.contentView viewWithTag:9992];
     if (!line) {
          line  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line.tag = 9992;
     }
     line.x = _aBtn.x;
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line];
     
     
     UIView *line2 = [self.contentView viewWithTag:9993];
     if (!line2) {
          line2  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line2.tag = 9993;
     }
     line2.x = _bBtn.x;
     line2.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line2];
     
     UIView *line3 = [self.contentView viewWithTag:9994];
     if (!line3) {
          line3  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line3.tag = 9994;
     }
     line3.x = _cBtn.x;
     line3.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line3];
     
     UIView *line4 = [self.contentView viewWithTag:9995];
     if (!line4) {
          line4  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line4.tag = 9995;
     }
     line4.x = _dBtn.x;
     line4.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line4];
     
     UIView *line5 = [self.contentView viewWithTag:9996];
     if (!line5) {
          line5  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line5.tag = 9996;
     }
     line5.x = _eBtn.x;
     line5.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line5];
     
     
     UIView *line6 = [self.contentView viewWithTag:9997];
     if (!line6) {
          line6  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line6.tag = 9997;
     }
     line6.x = _eBtn.x + _eBtn.width;
     line6.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line6];

}

-(void)fitVipHelpModeB
{
     self.height = 43;
     _aBtn.width = (__SCREEN_SIZE.width - 30)/5.0;
     _aBtn.height = 43;
     _aBtn.x = 15;
     _aBtn.y = 0;
     [_aBtn fitImgAndTitleMode];
     _aBtn.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _aBtn.customTitleLb.height = _aBtn.height;
     _aBtn.customTitleLb.width = _aBtn.width;
     _aBtn.customTitleLb.x = 0;
     _aBtn.customTitleLb.y = 0;
     _aBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _aBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _aBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _aBtn.customTitleLb.numberOfLines = 0;
     _aBtn.customTitleLb.text = _dataDic[@"aTitle"];
        _aBtn.x = 15;
     _bBtn.width = _aBtn.width;
     _bBtn.height = 43;
     _bBtn.x = 15;
     _bBtn.y = 0;
     [_bBtn fitImgAndTitleMode];
     _bBtn.backgroundColor = kUIColorFromRGB(color_2);
     _bBtn.customTitleLb.height = _bBtn.height;
     _bBtn.customTitleLb.width = _bBtn.width;
     _bBtn.customTitleLb.x = 0;
     _bBtn.customTitleLb.y = 0;
     _bBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _bBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _bBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _bBtn.customTitleLb.numberOfLines = 0;
     _bBtn.customTitleLb.text = _dataDic[@"bTitle"];
        _bBtn.x = _aBtn.x + _aBtn.width;
     
     _cBtn.width = _aBtn.width;
     _cBtn.height = 43;
     _cBtn.x = 15;
     _cBtn.y = 0;
     [_cBtn fitImgAndTitleMode];
     _cBtn.backgroundColor = kUIColorFromRGB(color_2);
     _cBtn.customTitleLb.height = _cBtn.height;
     _cBtn.customTitleLb.width = _cBtn.width;
     _cBtn.customTitleLb.x = 0;
     _cBtn.customTitleLb.y = 0;
     _cBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _cBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _cBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _cBtn.customTitleLb.numberOfLines = 0;
     _cBtn.customTitleLb.text = _dataDic[@"cTitle"];
        _cBtn.x = _bBtn.x + _bBtn.width;
     
     _dBtn.width = _aBtn.width;
     _dBtn.height = 43;
     _dBtn.x = 15;
     _dBtn.y = 0;
     [_dBtn fitImgAndTitleMode];
     _bBtn.backgroundColor = kUIColorFromRGB(color_2);
     _dBtn.customTitleLb.height = _dBtn.height;
     _dBtn.customTitleLb.width = _dBtn.width;
     _dBtn.customTitleLb.x = 0;
     _dBtn.customTitleLb.y = 0;
     _dBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _dBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _dBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _dBtn.customTitleLb.numberOfLines = 0;
     _dBtn.customTitleLb.text = _dataDic[@"dTitle"];
        _dBtn.x = _cBtn.x + _cBtn.width;
     
     _eBtn.width = _aBtn.width;
     _eBtn.height = 43;
     _eBtn.x = 15;
     _eBtn.y = 0;
     [_eBtn fitImgAndTitleMode];
     _eBtn.backgroundColor = kUIColorFromRGB(color_2);
     _eBtn.customTitleLb.height = _eBtn.height;
     _eBtn.customTitleLb.width = _eBtn.width;
     _eBtn.customTitleLb.x = 0;
     _eBtn.customTitleLb.y = 0;
     _eBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _eBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _eBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _eBtn.customTitleLb.numberOfLines = 0;
     _eBtn.customTitleLb.text = _dataDic[@"eTitle"];
        _eBtn.x = _dBtn.x + _dBtn.width;
     CGFloat height = 43;
     
     UIView *line = [self.contentView viewWithTag:9992];
     if (!line) {
          line  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line.tag = 9992;
     }
     line.x = _aBtn.x;
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line];
     
     UIView *line2 = [self.contentView viewWithTag:9993];
     if (!line2) {
          line2  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line2.tag = 9993;
     }
     line2.x = _bBtn.x;
     line2.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line2];
     
     UIView *line3 = [self.contentView viewWithTag:9994];
     if (!line3) {
          line3  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line3.tag = 9994;
     }
     line3.x = _cBtn.x;
     line3.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line3];
     
     UIView *line4 = [self.contentView viewWithTag:9995];
     if (!line4) {
          line4  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line4.tag = 9995;
     }
     line4.x = _dBtn.x;
     line4.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line4];
     
     UIView *line5 = [self.contentView viewWithTag:9996];
     if (!line5) {
          line5  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line5.tag = 9996;
     }
     line5.x = _eBtn.x;
     line5.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line5];
     
     
     UIView *line6 = [self.contentView viewWithTag:9997];
     if (!line6) {
          line6  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line6.tag = 9997;
     }
     line6.x = _eBtn.x + _eBtn.width;
     line6.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line6];
     
     
}

-(void)fitVipHelpModeC:(CGFloat)height
{
     self.height = height;
     _aBtn.width = (__SCREEN_SIZE.width - 30)/5.0;
     _aBtn.height = height;
     _aBtn.x = 15;
     _aBtn.y = 0;
     [_aBtn fitImgAndTitleMode];
     _aBtn.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _aBtn.customTitleLb.height = _aBtn.height;
     _aBtn.customTitleLb.width = _aBtn.width;
     _aBtn.customTitleLb.x = 0;
     _aBtn.customTitleLb.y = 0;
     _aBtn.customTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     _aBtn.customTitleLb.font = [UIFont systemFontOfSize:14];
     _aBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _aBtn.customTitleLb.numberOfLines = 0;
     _aBtn.customTitleLb.text = _dataDic[@"aTitle"];
     _aBtn.x = 15;
     _bBtn.width = _aBtn.width;
     _bBtn.height = height;
     _bBtn.x = 15;
     _bBtn.y = 0;
     [_bBtn fitImgAndTitleMode];
     _bBtn.backgroundColor = kUIColorFromRGB(color_2);
     _bBtn.customImgV.height = _bBtn.height;
     _bBtn.customImgV.width = _bBtn.width;
     _bBtn.customImgV.x = 0;
     _bBtn.customImgV.y = 0;
     _bBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"bimg"]];
     _bBtn.customImgV.contentMode = UIViewContentModeCenter;
     _bBtn.customTitleLb.text = @"";
        _bBtn.x = _aBtn.x + _aBtn.width;
     
     _cBtn.width = _aBtn.width;
     _cBtn.height = height;
     _cBtn.x = 15;
     _cBtn.y = 0;
     [_cBtn fitImgAndTitleMode];
     _cBtn.backgroundColor = kUIColorFromRGB(color_2);
     _cBtn.customImgV.height = _cBtn.height;
     _cBtn.customImgV.width = _cBtn.width;
     _cBtn.customImgV.x = 0;
     _cBtn.customImgV.y = 0;
     _cBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"cimg"]];
     _cBtn.customImgV.contentMode = UIViewContentModeCenter;
      _cBtn.customTitleLb.text = @"";
        _cBtn.x = _bBtn.x + _bBtn.width;
     _dBtn.width = _aBtn.width;
     _dBtn.height = height;
     _dBtn.x = 15;
     _dBtn.y = 0;
     [_dBtn fitImgAndTitleMode];
     _bBtn.backgroundColor = kUIColorFromRGB(color_2);
     _dBtn.customImgV.height = _dBtn.height;
     _dBtn.customImgV.width = _dBtn.width;
     _dBtn.customImgV.x = 0;
     _dBtn.customImgV.y = 0;
     _dBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"dimg"]];
     _dBtn.customImgV.contentMode = UIViewContentModeCenter;
      _dBtn.customTitleLb.text = @"";
        _dBtn.x = _cBtn.x + _cBtn.width;
     
     _eBtn.width = _aBtn.width;
     _eBtn.height = height;
     _eBtn.x = 15;
     _eBtn.y = 0;
     [_eBtn fitImgAndTitleMode];
     _eBtn.backgroundColor = kUIColorFromRGB(color_2);
     _eBtn.customImgV.height = _eBtn.height;
     _eBtn.customImgV.width = _eBtn.width;
     _eBtn.customImgV.x = 0;
     _eBtn.customImgV.y = 0;
     _eBtn.customImgV.image = [UIImage imageContentWithFileName:_dataDic[@"eimg"]];
     _eBtn.customImgV.contentMode = UIViewContentModeCenter;
      _eBtn.customTitleLb.text = @"";
     _eBtn.x = _dBtn.x + _dBtn.width;
     UIView *line = [self.contentView viewWithTag:9992];
     if (!line) {
          line  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line.tag = 9992;
     }
     line.x = _aBtn.x;
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line];
     
     UIView *line2 = [self.contentView viewWithTag:9993];
     if (!line2) {
          line2  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line2.tag = 9993;
     }
     line2.x = _bBtn.x;
     line2.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line2];
     
     UIView *line3 = [self.contentView viewWithTag:9994];
     if (!line3) {
          line3  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line3.tag = 9994;
     }
     line3.x = _cBtn.x;
     line3.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line3];
     
     UIView *line4 = [self.contentView viewWithTag:9995];
     if (!line4) {
          line4  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line4.tag = 9995;
     }
     line4.x = _dBtn.x;
     line4.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line4];
     
     UIView *line5 = [self.contentView viewWithTag:9996];
     if (!line5) {
          line5  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line5.tag = 9996;
     }
     line5.x = _eBtn.x;
     line5.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line5];
     
     
     UIView *line6 = [self.contentView viewWithTag:9997];
     if (!line6) {
          line6  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, height)];
          line6.tag = 9997;
     }
     line6.x = _eBtn.x + _eBtn.width;
     line6.backgroundColor = kUIColorFromRGB(color_lineColor);
     [self.contentView addSubview:line6];

}

@end
