//
//  FourIconBtnTableViewCell.m
//  yihui
//
//  Created by air on 15/9/1.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "FourIconBtnTableViewCell.h"
//#import "UIButton+TitleStyle.h"
@implementation FourIconBtnTableViewCell
{
     IBOutlet UIButton *_thirdBtn;
     IBOutlet UIButton *_firstBtn;
     
     IBOutlet UIButton *_secondBtn;
     IBOutlet UIButton *_fourBtn;
     IBOutlet UILabel *_vLineLb1;
     
     IBOutlet UILabel *_vLineLb3;
     IBOutlet UILabel *_vLineLb2;
     
     NSDictionary *_dataDic;
}
- (void)awakeFromNib {
     // Initialization code
     _vLineLb1.width = 0.5;
     _vLineLb2.width = 0.5;
     _vLineLb3.width = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
     [super setSelected:selected animated:animated];
     
     // Configure the view for the selected state
}

- (IBAction)handleAction:(id)sender {
     if (self.handleAction) {
          self.handleAction(@{@"obj":sender});
     }
}


-(void)setCellData:(NSDictionary *)dataDic
{
     
     _fourBtn.selected = [dataDic[@"fourIsChecked"] boolValue];
     //_secondBtn.selected = [dataDic[@"secondIsChecked"] boolValue];
     _dataDic = dataDic;
     [_firstBtn setTitle:dataDic[@"oneTitle"] forState:UIControlStateNormal];
     [_secondBtn setTitle:dataDic[@"twoTitle"] forState:UIControlStateNormal];
     [_thirdBtn setTitle:dataDic[@"threeTitle"] forState:UIControlStateNormal];
     [_fourBtn setTitle:dataDic[@"fourTitle"] forState:UIControlStateNormal];
     [super setCellData:dataDic];
}
-(void)fitMode
{
     _vLineLb1.hidden = YES;
     _vLineLb2.hidden = YES;
     _vLineLb3.hidden = YES;
     
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _thirdBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _fourBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     
     self.height = 60;
     
     _firstBtn.width = __SCREEN_SIZE.width/4.0;
     _secondBtn.width = __SCREEN_SIZE.width/4.0;
     _thirdBtn.width = __SCREEN_SIZE.width/4.0;
     _fourBtn.width = __SCREEN_SIZE.width/4.0;
     
     _firstBtn.height = self.height;
     _secondBtn.height = self.height;
     _thirdBtn.height = self.height;
     _fourBtn.height = self.height;
     
     _firstBtn.y = 0;
     _secondBtn.y = 0;
     _thirdBtn.y = 0;
     _fourBtn.y = 0;
     
     _firstBtn.x = __SCREEN_SIZE.width/4.0/2.0 - _firstBtn.width/2.0;
     _secondBtn.x = __SCREEN_SIZE.width/4.0 ;
     _thirdBtn.x = __SCREEN_SIZE.width/4.0 * 2 ;
     _fourBtn.x = __SCREEN_SIZE.width/4.0 * 3 ;
     
     //    [_firstBtn setImage:[UIImage imageContentWithFileName:@"defaultHead"] forState:UIControlStateNormal];
     _firstBtn.imageView.image = [UIImage imageContentWithFileName:@"huati"];
     _secondBtn.imageView.image = [UIImage imageContentWithFileName:@"youxuan"];
     _thirdBtn.imageView.image = [UIImage imageContentWithFileName:@"tehui"];
     _fourBtn.imageView.image = [UIImage imageContentWithFileName:@"sign"];
     
     [_firstBtn fitImgAndTitleMode];
     //    _firstBtn.customImgV;
     [_secondBtn fitImgAndTitleMode];
     [_thirdBtn fitImgAndTitleMode];
     [_fourBtn fitImgAndTitleMode];
     _firstBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     _firstBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     _firstBtn.customImgV.height = 20;
     _firstBtn.customImgV.width = 20;
     _firstBtn.customImgV.x = _firstBtn.width/2.0 - _firstBtn.customImgV.width/2.0;
     
     _secondBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     _secondBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     _secondBtn.customImgV.height = 20;
     _secondBtn.customImgV.width = 20;
     _secondBtn.customImgV.x = _secondBtn.width/2.0 - _secondBtn.customImgV.width/2.0;
     
     _thirdBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     _thirdBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     _thirdBtn.customImgV.height = 20;
     _thirdBtn.customImgV.width = 20;
     _thirdBtn.customImgV.x = _thirdBtn.width/2.0 - _thirdBtn.customImgV.width/2.0;
     
     _fourBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     _fourBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     _fourBtn.customImgV.height = 20;
     _fourBtn.customImgV.width = 20;
     _fourBtn.customImgV.x = _fourBtn.width/2.0 - _fourBtn.customImgV.width/2.0;
     
}

-(void)fitMineMode
{
     _vLineLb1.hidden = YES;
     _vLineLb2.hidden = YES;
     _vLineLb3.hidden = YES;
     
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _thirdBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _fourBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     
     self.height = 100;
     
     _firstBtn.width = __SCREEN_SIZE.width/4.0;
     _secondBtn.width = __SCREEN_SIZE.width/4.0;
     _thirdBtn.width = __SCREEN_SIZE.width/4.0;
     _fourBtn.width = __SCREEN_SIZE.width/4.0;
     
     _firstBtn.height = self.height - 1;
     _secondBtn.height = self.height - 1;
     _thirdBtn.height = self.height - 1;
     _fourBtn.height = self.height - 1;
     
     _firstBtn.y = 0;
     _secondBtn.y = 0;
     _thirdBtn.y = 0;
     _fourBtn.y = 0;
//     [_firstBtn fitImgAndTitleMode];
//     //    _firstBtn.customImgV;
//     [_secondBtn fitImgAndTitleMode];
//     [_thirdBtn fitImgAndTitleMode];
//     [_fourBtn fitImgAndTitleMode];
     

     [self setBtnFitModeB:_firstBtn withTitle:_dataDic[@"oneTitle"] withImg:_dataDic[@"aimg"] withNum:[_dataDic[@"anum"] integerValue]];
     [self setBtnFitModeB:_secondBtn withTitle:_dataDic[@"twoTitle"] withImg:_dataDic[@"bimg"] withNum:[_dataDic[@"bnum"] integerValue]];
     [self setBtnFitModeB:_thirdBtn withTitle:_dataDic[@"threeTitle"] withImg:_dataDic[@"cimg"] withNum:[_dataDic[@"cnum"] integerValue]];
     [self setBtnFitModeB:_fourBtn withTitle:_dataDic[@"fourTitle"] withImg:_dataDic[@"dimg"] withNum:[_dataDic[@"dnum"] integerValue]];

     _firstBtn.x = (__SCREEN_SIZE.width - _firstBtn.width * 4)/5.0;
     _secondBtn.x = _firstBtn.x + _firstBtn.width + _firstBtn.x ;
     _thirdBtn.x = _secondBtn.x + _firstBtn.width + _firstBtn.x ;
     _fourBtn.x = _thirdBtn.x + _firstBtn.width + _firstBtn.x ;
//     [self setBtnFitMode:_firstBtn withText:_dataDic[@"oneDetail"]];
//     [self setBtnFitMode:_secondBtn withText:_dataDic[@"twoDetail"]];
//     [self setBtnFitMode:_thirdBtn withText:_dataDic[@"threeDetail"]];
//     [self setBtnFitMode:_fourBtn withText:_dataDic[@"fourDetail"]];
     //     _secondBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     //     _secondBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     //
     //
     //     _thirdBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     //     _thirdBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     //
     //
     //     _fourBtn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     //     _fourBtn.customTitleLb.font = [UIFont systemFontOfSize:13];
     
     
}

-(void)setBtnFitMode:(UIButton *)btn withText:(NSString *)txt
{
     btn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     btn.customTitleLb.font = [UIFont systemFontOfSize:13];
     btn.customTitleLb.y = 13;
     btn.customDetailLb.y = 35;
     btn.customDetailLb.font = [UIFont systemFontOfSize:16];
     btn.customDetailLb.height = 16;
     btn.customDetailLb.textColor = kUIColorFromRGB(color_3);
     btn.customDetailLb.text = txt;
}

-(void)fitTraceOrderMode
{
     _vLineLb1.hidden = YES;
     _vLineLb2.hidden = YES;
     _vLineLb3.hidden = YES;
     
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _thirdBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _fourBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     
     self.height = 80;
     
     _firstBtn.width = __SCREEN_SIZE.width/4.0;
     _secondBtn.width = __SCREEN_SIZE.width/4.0;
     _thirdBtn.width = __SCREEN_SIZE.width/4.0;
     _fourBtn.width = __SCREEN_SIZE.width/4.0;
     
     _firstBtn.height = self.height - 1;
     _secondBtn.height = self.height - 1;
     _thirdBtn.height = self.height - 1;
     _fourBtn.height = self.height - 1;
     
     _firstBtn.y = 0;
     _secondBtn.y = 0;
     _thirdBtn.y = 0;
     _fourBtn.y = 0;
     [_firstBtn fitImgAndTitleMode];
     //    _firstBtn.customImgV;
     [_secondBtn fitImgAndTitleMode];
     [_thirdBtn fitImgAndTitleMode];
     [_fourBtn fitImgAndTitleMode];
     
     _firstBtn.x = __SCREEN_SIZE.width/4.0/2.0 - _firstBtn.width/2.0;
     _secondBtn.x = __SCREEN_SIZE.width/4.0 ;
     _thirdBtn.x = __SCREEN_SIZE.width/4.0 * 2 ;
     _fourBtn.x = __SCREEN_SIZE.width/4.0 * 3 ;
     
     [self setBtnFitModeB:_firstBtn withIsSelect:[_dataDic[@"check"] integerValue]];
     [self setBtnFitModeB:_secondBtn withIsSelect:[_dataDic[@"check"] integerValue]];
     [self setBtnFitModeB:_thirdBtn withIsSelect:[_dataDic[@"check"] integerValue]];
     [self setBtnFitModeB:_fourBtn withIsSelect:[_dataDic[@"check"] integerValue]];
     
     UIView *line = [self.contentView viewWithTag:3433];
     if (!line) {
          line  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 1)];
          line.backgroundColor = kUIColorFromRGB(color_0xb0b0b0);
          line.x = _firstBtn.x + [_firstBtn viewWithTag:974].x;
          line.y = 40;
          line .tag = 3433;
     }
     line.width = __SCREEN_SIZE.width - 2 * line.x;
     [self.contentView insertSubview:line atIndex:0];
     
     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 160;
          lb.height = 11;
          lb.tag = 12113;
     }
     lb.textAlignment = NSTextAlignmentCenter;
     lb.text = _dataDic[@"title"];
     lb.textColor = kUIColorFromRGB(color_5);
     lb.font =  [UIFont systemFontOfSize:11];
     [lb sizeToFit];
     lb.x = _firstBtn.x + _firstBtn.width/2.0 - lb.width/2.0;
     lb.y = 58;
     [self.contentView addSubview:lb];
     
     UILabel *lb2 = [self.contentView viewWithTag:12114];
     if (!lb2) {
          lb2 = [UILabel new];
          lb2.width = 160;
          lb2.height = 11;
          lb2.tag = 12114;
     }
     lb2.textAlignment = NSTextAlignmentCenter;
     lb2.text = _dataDic[@"detail"];
     lb2.textColor = kUIColorFromRGB(color_5);
     lb2.font =  [UIFont systemFontOfSize:11];
     [lb2 sizeToFit];
     lb2.x = _fourBtn.x + _fourBtn.width/2.0 - lb2.width/2.0;
     lb2.y = 59;
     [self.contentView addSubview:lb2];
     
}


-(void)setBtnFitModeB:(UIButton *)btn withIsSelect:(NSInteger )isS
{
     //     btn.width = 39;
     btn.height = 60;
     
     btn.customTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     btn.customTitleLb.font = [UIFont systemFontOfSize:11];
     btn.customTitleLb.width = 39;
     btn.customTitleLb.height = 20;
     btn.customTitleLb.y = 4;
     btn.customTitleLb.x = btn.width/2.0 - btn.customTitleLb.width/2.0;
     [btn bringSubviewToFront:btn.customTitleLb];
     btn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     
     btn.customImgV.height = 20;
     btn.customImgV.width = 39;
     btn.customImgV.x = btn.width/2.0 - btn.customImgV.width/2.0;
     btn.customImgV.y = 6;
     btn.customImgV.image = nil;
     btn.customImgV.highlightedImage = [UIImage imageContentWithFileName:_dataDic[@"himg"]];
     UIImageView *imgv2 = [btn viewWithTag:974];
     if (!imgv2) {
          imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
          imgv2.tag = 974;
          
          imgv2.y = 34;
     }
     imgv2.x = btn.width/2.0 - imgv2.width/2.0;;
     //    if (upDown) {
     imgv2.image = [UIImage imageContentWithFileName:_dataDic[@"mark"]];
     imgv2.highlightedImage = [UIImage imageContentWithFileName:_dataDic[@"hMark"]];
     [btn addSubview:imgv2];
     
     btn.customImgV.highlighted = isS == btn.tag - 100;
     imgv2.highlighted = isS == btn.tag - 100;
     if (isS == btn.tag - 100) {
          btn.customTitleLb.textColor = kUIColorFromRGB(color_2);
     }
     else
     {
          btn.customTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     }
}

-(void)fitLuckMode:(CGFloat )y withHeight:(CGFloat)height
{
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _thirdBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _fourBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     self.height = height;
     _firstBtn.y = y;
     _secondBtn.y = _firstBtn.y;
     _thirdBtn.y = _firstBtn.y;
     _fourBtn.y = _firstBtn.y;
     
     [self setBtnFitModeB:_firstBtn withTitle:_dataDic[@"oneTitle"] withImg:_dataDic[@"aimg"]];
     [self setBtnFitModeB:_secondBtn withTitle:_dataDic[@"twoTitle"] withImg:_dataDic[@"bimg"]];
     [self setBtnFitModeB:_thirdBtn withTitle:_dataDic[@"threeTitle"] withImg:_dataDic[@"cimg"]];
     [self setBtnFitModeB:_fourBtn withTitle:_dataDic[@"fourTitle"] withImg:_dataDic[@"dimg"]];
     _firstBtn.x = 15;
     CGFloat dd = (__SCREEN_SIZE.width - 30 - _secondBtn.width * 4)/3.0;
     
     _secondBtn.x = _firstBtn.x + _firstBtn.width +  dd  ;
     _thirdBtn.x =  _secondBtn.x + _secondBtn.width +  dd  ;
     _fourBtn.x =  _thirdBtn.x + _thirdBtn.width +  dd  ;
     _vLineLb1.hidden = YES;
     _vLineLb2.hidden = YES;
     _vLineLb3.hidden = YES;
}
-(void)setBtnFitModeB:(UIButton *)btn withTitle:(NSString *)title withImg:(NSString *)img
{
     [self setBtnFitModeB:btn withTitle:title withImg:img withNum:0];
}

-(void)setBtnFitModeB:(UIButton *)btn withTitle:(NSString *)title withImg:(NSString *)img withNum:(NSInteger)num
{
     
     [btn fitImgAndTitleMode];
     if (__SCREEN_SIZE.width == 320) {
          btn.width = (__SCREEN_SIZE.width - 30 - 30)/4.0;
          btn.height = 101.0/76 * btn.width;
          btn.customTitleLb.y = 56;
          btn.customTitleLb.font = [UIFont systemFontOfSize:13];
     }
     else
     {
          btn.width = 76;
          btn.height = 101;
          btn.customTitleLb.y = 56;
          btn.customTitleLb.font = [UIFont systemFontOfSize:13];
     }
     btn.customImgV.height = 20;
     btn.customImgV.width = 20;
     btn.customImgV.x = btn.width/2.0 - 10;
     btn.customImgV.y = 29;
     btn.customImgV.image = [UIImage imageContentWithFileName:img];
     [btn sendSubviewToBack:btn.customImgV];
     
     btn.customTitleLb.x = 0;
     
     btn.customTitleLb.height = 13;
     
     btn.customTitleLb.textColor = kUIColorFromRGB(color_7);
     btn.customTitleLb.width = btn.width;
     btn.customTitleLb.text = title;

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

-(void)fitVipHelpMode
{
     _vLineLb1.hidden = YES;
     _vLineLb2.hidden = YES;
     _vLineLb3.hidden = YES;
     _firstBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _secondBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _thirdBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _fourBtn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     self.height = 120;
     [self setBtnFitModeC:_firstBtn withTitle:_dataDic[@"oneTitle"] withImg:_dataDic[@"aimg"]];
     
     [self setBtnFitModeC:_secondBtn withTitle:_dataDic[@"twoTitle"] withImg:_dataDic[@"bimg"]];
     
     [self setBtnFitModeC:_thirdBtn withTitle:_dataDic[@"threeTitle"] withImg:_dataDic[@"cimg"]];
     
     [self setBtnFitModeC:_fourBtn withTitle:_dataDic[@"fourTitle"] withImg:_dataDic[@"dimg"]];
     
     _firstBtn.x = 15;
     _fourBtn.x = __SCREEN_SIZE.width - 15 - _fourBtn.width;
     CGFloat dd = (__SCREEN_SIZE.width - 30 - _firstBtn.width * 4)/3.0
     ;
     _secondBtn.x = _firstBtn.x + _firstBtn.width + dd;
     
     _thirdBtn.x = _secondBtn.x + _secondBtn.width + dd;
}

-(void)setBtnFitModeC:(UIButton *)btn withTitle:(NSString *)title withImg:(NSString *)img
{
     [btn fitImgAndTitleMode];
     btn.y = 15;
     if (__SCREEN_SIZE.width == 320) {
          btn.width = 71;
          btn.height = 101;
     }
     else
     {
          btn.width = 75;
          btn.height = 105;
     }
     btn.customImgV.height = 40;
     btn.customImgV.width = 40;
     btn.customImgV.x = btn.width/2.0 - btn.customImgV.width/2.0;
     btn.customImgV.y = 16;
     btn.customImgV.image = [UIImage imageContentWithFileName:img];
     btn.customImgV.contentMode = UIViewContentModeCenter;
     
     btn.customTitleLb.x = 0;
     btn.customTitleLb.y = 65;
     btn.customTitleLb.height = 32;
     btn.customTitleLb.font = [UIFont systemFontOfSize:13];
     btn.customTitleLb.textColor = kUIColorFromRGB(color_5);
     btn.customTitleLb.width = btn.width;
     btn.customTitleLb.text = title;
     btn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     btn.customTitleLb.numberOfLines = 0;
     btn.layer.cornerRadius = 6;
     btn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     btn.layer.borderWidth = 0.5;
     btn.layer.masksToBounds = YES;
}
@end
