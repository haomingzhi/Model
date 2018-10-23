//
//  TitleDetailTableViewCell.m
//  ChaoLiu
//
//  Created by air on 15/7/15.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleDetailTableViewCell.h"
#import "BUSystem.h"

@implementation TitleDetailTableViewCell
{
    NSString *_detail2;
    IBOutlet UILabel *_detailLb;
    IBOutlet UILabel *_titleLb;
    IBOutlet MyTextField *_textTf;
    UIView *_backView;
    UITapGestureRecognizer *_tap;
    NSDictionary *_dataDic;
    UITextView *_detailTv;
     CWStarRateView *_starView ;
     NSIndexPath *_curIndexPath;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(MyTextField*)getTextTf
{
    return _textTf;
}

-(void)setCellData:(NSDictionary *)dataDic
{
     _curIndexPath = dataDic[@"indexPath"];
    _dataDic = dataDic;
    _titleLb.text = dataDic[@"title"];
    _detailLb.text = dataDic[@"detail"];
    _detail2 = dataDic[@"detail2"];
//    [super setCellData:dataDic];
    if (dataDic[@"detailColor"]) {
        _detailLb.textColor = dataDic[@"detailColor"];
    }
    
}

-(void)fitConfirmOrderMode
{
     self.height = 40;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.width = 156;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 20;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     
     _detailLb.width = 160;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.textColor = kUIColorFromRGB(color_3);
     _detailLb.font = [UIFont systemFontOfSize:15];
     _detailLb.height = 20;
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     
}


-(void)fitFillOrderMode:(CGFloat)y
{
//     self.height = 40;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width-30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.y = y;
     
     _detailLb.width = 200;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.textColor = kUIColorFromRGB(color_0x48a3ef);
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.height = 13;
     _detailLb.y = y;
     
     if (_dataDic[@"rich"]) {
          _detailLb.attributedText = [_detailLb richText:_dataDic[@"rich"] color:kUIColorFromRGB(color_0xb0b0b0)];
     }
     
     
//     self.height = _detailLb.y +_detailLb.height;
}


-(void)fitFillOrderModeA
{
          self.height = 45;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width-30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = self.height;
     _titleLb.y = 0 ;
     
     _detailLb.width = 200;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _detailLb.font = [UIFont systemFontOfSize:15];
     _detailLb.height = self.height;
     _detailLb.y = 0;
     
     _detailLb.attributedText = [_detailLb richText:@"元" color:kUIColorFromRGB(color_0xb0b0b0)];
     
     //     self.height = _detailLb.y +_detailLb.height;
}


-(void)fitFillOrderModeB
{
     self.height = 31;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width-30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.y = 19 ;
     
     _detailLb.width = 200;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.height = 13;
     _detailLb.y = 19;
     
     
     //     self.height = _detailLb.y +_detailLb.height;
}



-(void)fitFillOrderModeC
{
     self.height = 44;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width-30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.y = 13 ;
     
     _detailLb.width = 200;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.textColor = kUIColorFromRGB(color_0x48a3ff);
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.height = 13;
     _detailLb.y = 13;
     
     NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
     NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString: _detailLb.text attributes:attribtDic];
     _detailLb.attributedText = attribtStr;
     //     self.height = _detailLb.y +_detailLb.height;
}



-(void)fitConfirmOrderModeA
{
    self.height = 40;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 156;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = 160;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    
}

-(void)fitCardIDMode
{
    self.height = 60;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.contentView.backgroundColor = kUIColorFromRGB(color_9);
    if (_backView == nil) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, __SCREEN_SIZE.width-30, 40)];
        _backView.backgroundColor = kUIColorFromRGB(color_4);
        [self.contentView addSubview:_backView];
        
    }
    
    if (__SCREEN_SIZE.width == 320) {
        _titleLb.font = [UIFont systemFontOfSize:13];
        _detailLb.font = [UIFont systemFontOfSize:13];
    }else{
        _titleLb.font = [UIFont systemFontOfSize:15];
        _detailLb.font = [UIFont systemFontOfSize:15];
    }
    
//    _titleLb.x = 15;
//    _titleLb.width = 156;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    
    [_titleLb sizeToFit];
//    _titleLb.height = 20;
    _titleLb.y = _backView.height/2.0 - _titleLb.height/2.0;
    
//    _detailLb.width = 160;
//    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.textColor = kUIColorFromRGB(color_3);
    
//    _detailLb.height = 20;
    [_detailLb sizeToFit];
    _detailLb.y = _backView.height/2.0 - _detailLb.height/2.0;
    
    [_backView addSubview:_titleLb];
    [_backView addSubview:_detailLb];
    
    _titleLb.x = (_backView.width - _titleLb.width - _detailLb.width-8)/2.0;
    _detailLb.x = _titleLb.x + _titleLb.width +4;
    
    
}

-(void)fitPersonModeEdit
{
    [self fitPersonModeEdit:kUIColorFromRGB(color_1)];
}
-(void)fitPersonModeEdit:(UIColor *)color
{
      self.height = 41;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 105;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _detailLb.hidden = YES;
    _textTf.text = _detailLb.text;
    _textTf.hidden = NO;
   
    _textTf.x = __SCREEN_SIZE.width - 15 - _textTf.width;
    _textTf.textAlignment = NSTextAlignmentLeft;
    _textTf.textColor = color;
    _textTf.font = [UIFont systemFontOfSize:15];
    _textTf.height = 20;
    _textTf.y = self.height/2.0 - _textTf.height/2.0;
    _textTf.userInteractionEnabled = NO;
     _textTf.x = 101;
    _textTf.width = __SCREEN_SIZE.width - _textTf.x - 15;
    UIImageView *imgv = [self.contentView viewWithTag:973];
    if (!imgv) {
        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 18)];
        imgv.tag = 973;
        
        imgv.y = 10;
        
        
    }
    imgv.x = __SCREEN_SIZE.width - 15 - 10;
    //    if (upDown) {
    imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
    [self.contentView addSubview:imgv];
}
-(void)fitMineMode
{
     self.height = 40;

     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;

     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 36 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;


     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 18)];
          imgv.tag = 973;

          imgv.y = 11;


     }
     imgv.x = __SCREEN_SIZE.width - 15 - 10;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     [self.contentView addSubview:imgv];
}
-(void)fitDiscoveMode
{
     self.height = 40;

     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;

     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:12];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
}
-(void)fitMineModeB
{
     self.height = 40;

     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;

     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;


//     UIImageView *imgv = [self.contentView viewWithTag:973];
//     if (!imgv) {
//          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 18)];
//          imgv.tag = 973;
//
//          imgv.y = 11;
//
//
//     }
//     imgv.x = __SCREEN_SIZE.width - 15 - 10;
//     //    if (upDown) {
//     imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
//     [self.contentView addSubview:imgv];
}
-(void)fitNoCashApproveMode
{
     self.height = 45;

     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;

     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;

}
-(void)fitNoCashApproveModeB
{
     self.height = 45;

     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;

     _detailLb.textColor = kUIColorFromRGB(color_0x48a3ff);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;

}

-(void)fitPersonMode
{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 140;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = 220;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width - 20;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    self.height = 44;
    UIImageView *imgv = [self.contentView viewWithTag:973];
    if (!imgv) {
        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 17)];
        imgv.tag = 973;
        
        imgv.y = 13;
        
        
    }
    imgv.x = __SCREEN_SIZE.width - 10 - 9;
    //    if (upDown) {
    imgv.image = [UIImage imageContentWithFileName:@"icon_arrow_right"];
    [self.contentView addSubview:imgv];
}

-(void)fitMyServerApplyMode
{
    self.height = 46;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.width = 100;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _titleLb.width = 220;
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.textColor = kUIColorFromRGB(color_1);
    
}

-(void)fitMyServerApplyModeS
{
    [self fitMyServerApplyMode];
    if([_detailLb.text isEqualToString:@"已完成"])
    {
    _detailLb.textColor = kUIColorFromRGB(color_3);
    }else if([_detailLb.text isEqualToString:@"受理失败"])
    {
    _detailLb.textColor = kUIColorFromRGB(color_6);
    }
}

-(void)fitMyServerApplyModeB
{
    self.height = 15;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.y = 0;
    _titleLb.height = 15;
    _detailLb.height = 15;
     _detailLb.y = 0;
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.width = __SCREEN_SIZE.width/2.0 + 26;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
}


-(void)fitMyActivityMode:(UIColor *)color
{
    self.height = 26;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.font = [UIFont systemFontOfSize:13];
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.height = 14;
    _titleLb.y = 3;
    _detailLb.width = 140;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.textColor = color;
    _detailLb.y = 3;
    _detailLb.height = 16;
    
}

-(void)fitMyRantInfoMode
{
    self.height = 15;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.height = 15;
    _titleLb.width = 130;
    _titleLb.y = 0;
    
    _detailLb.width = 140;
    _detailLb.x =   _titleLb.width +  _titleLb.x + 20;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.textColor =  kUIColorFromRGB(color_7);
    _detailLb.y = 0;
    _detailLb.height = 16;
}

-(void)fitServerInfoMode
{
     self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 156;
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = 160;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
   
}


-(void)fitErrandServerInfoMode
{
     self.height = 44;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.width = 156;
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.y = 12;
//     [_titleLb sizeToFit];
     
     _detailLb.width = __SCREEN_SIZE.width - 30;
     _detailLb.x = 15;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.textColor = kUIColorFromRGB(color_7);
     _detailLb.font = [UIFont systemFontOfSize:13];
//     _detailLb.height = 20;
     _detailLb.y = _titleLb.y + _titleLb.height +12;
     _detailLb.numberOfLines = 0;
     [_detailLb sizeToFit];
     
     self.height = _detailLb.y + _detailLb.height +10;
     
}

-(void)fitServerInfoModeH
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 100;
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = __SCREEN_SIZE.width - 30 - _titleLb.width;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    
}


-(void)fitServerInfoModeD
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 126;
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = 100;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width - 45;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_3);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    UILabel *lb = [self.contentView viewWithTag:12113];
    lb.hidden = YES;
    UIButton *btn = [self.contentView viewWithTag:13312];
    if(!btn)
    {
        btn = [UIButton new];
        btn.tag = 13312;
    }
    btn.layer.borderWidth = 0;
      [btn setTitle:nil forState:UIControlStateNormal];
    [btn setImage:[UIImage imageContentWithFileName:@"priceEdit"] forState:UIControlStateNormal];
    btn.height = 35;
    btn.width = 35;
    btn.x = __SCREEN_SIZE.width - 15 - btn.width;
    btn.y = self.height/2.0 - btn.height/2.0;
    [self.contentView addSubview:btn];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)fitServerInfoModeE
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 126;
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = 100;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width - 80;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_3);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     UILabel *lb = [self.contentView viewWithTag:12113];
    lb.hidden = YES;
    UIButton *btn = [self.contentView viewWithTag:13312];
    if(!btn)
    {
        btn = [UIButton new];
        btn.tag = 13312;
    }
    [btn setImage:nil forState:UIControlStateNormal];
    [btn setTitle:@"立即支付" forState:UIControlStateNormal];
    [btn setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.width = 70;
    btn.height = 30;
    btn.layer.cornerRadius = 3;
    btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 0.5;
    btn.x = __SCREEN_SIZE.width - 15 - btn.width;
    btn.y = self.height/2.0 - btn.height/2.0;
    [self.contentView addSubview:btn];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    btn.layer.bo
      btn.hidden = NO;
}

-(void)btnAction:(UIButton *)btn
{
    if (self.handleAction) {
         self.handleAction(@{@"indexPath":_curIndexPath?:[NSIndexPath indexPathForRow:0 inSection:0]});
    }
}

-(void)fitServerInfoModeF:(NSString*)str
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 126;
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = 100;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width - 60;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_3);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    
    UILabel *lb = [self.contentView viewWithTag:12113];
    if (!lb) {
        lb = [UILabel new];
        lb.width = 50;
        lb.height = 14;
        lb.tag = 12113;
    }
    lb.textAlignment = NSTextAlignmentRight;
    lb.text = str;
    lb.textColor = kUIColorFromRGB(color_6);
    lb.font =  [UIFont systemFontOfSize:15];
    lb.x = __SCREEN_SIZE.width - 15 - lb.width;
    lb.y = self.height/2.0 - lb.height/2.0;
    [self.contentView addSubview:lb];
    
        UIButton *btn = [self.contentView viewWithTag:13312];
    btn.hidden = YES;
}



-(void)fitServerInfoModeC
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 126;
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = 220;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_3);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    
}


-(void)fitGreenPriceMode{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 126;
    _titleLb.textColor = kUIColorFromRGB(color_3);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _titleLb.numberOfLines = 0;
    
    _detailLb.width = 220;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_7);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    _detailLb.numberOfLines = 0;
    
}

-(void)fitBankAddressMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 15;
    CGSize size = [_titleLb.text size:_titleLb.font  constrainedToSize:CGSizeMake(__SCREEN_SIZE.width, 15)];
    _titleLb.width = size.width;
    _titleLb.y = 15;
    _titleLb.numberOfLines = 0;
    
    
    _detailLb.x = _titleLb.x+_titleLb.width +30;
    _detailLb.width = __SCREEN_SIZE.width - _detailLb.x - 15;
    _detailLb.textColor = kUIColorFromRGB(color_7);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.y = 15;
    size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(_detailLb.width, 100)];
    _detailLb.height = size.height;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.numberOfLines = 0;
    
    self.height =  _detailLb.height + _detailLb.y;
}

-(void)fitServerInfoModeB
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 72;
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = 220;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_3);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    
}

-(void)fitServerInfoModeK
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 50;
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = __SCREEN_SIZE.width - 50 - 30;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_3);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    
}


-(void)fitServerInfoModeG
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 72;
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = 220;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:14];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    
}

-(void)fitSendInfoModeB
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 72;
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = 220;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:14];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    
}




-(void)fitServerInfoStateMode
{
    self.height = 34;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 78;
    _titleLb.textColor = kUIColorFromRGB(color_3);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 15;
    _titleLb.y = 0;
    
    _detailLb.width = 220;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_3);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 15;
    _detailLb.y = 0;
}
-(void)fitServerInfoStateModeB
{
    self.height = 26;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 78;
    _titleLb.textColor = kUIColorFromRGB(color_3);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 15;
    _titleLb.y = 0;
    
    _detailLb.width = 220;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_3);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 15;
    _detailLb.y = 0;
}



-(void)fitThreeTitleMode
{
    self.height = 44;
    
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    [_titleLb richTextMany:@"楼栋" color:kUIColorFromRGB(color_7)];
    _titleLb.height = 15;
    _titleLb.width = (__SCREEN_SIZE.width - 30)/3.0;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = (__SCREEN_SIZE.width - 30)/3.0;
    _detailLb.x =  (__SCREEN_SIZE.width - 30)/3.0 + 15;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.textColor =  kUIColorFromRGB(color_1);
        [_detailLb richTextMany:@"楼层" color:kUIColorFromRGB(color_7)];
     _detailLb.textAlignment = NSTextAlignmentCenter;
    _detailLb.height = 16;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    
    UILabel *detail2 = [self.contentView viewWithTag:3222];
    if (!detail2) {
        detail2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _detailLb.width, 16)];
        detail2.tag = 3222;
        detail2.x = (__SCREEN_SIZE.width - 30)/3.0 * 2 + 15;
          detail2.y = self.height/2.0 - detail2.height/2.0;
    }
    detail2.text = _detail2;
    detail2.font = [UIFont systemFontOfSize:15];
    detail2.textColor =  kUIColorFromRGB(color_1);
    [detail2 richTextMany:@"单元" color:kUIColorFromRGB(color_7)];
    detail2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:detail2];
}

-(void)fitThreeTitleModeB
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    [_titleLb richTextMany:@"区域" color:kUIColorFromRGB(color_7)];
    _titleLb.height = 15;
    _titleLb.width = (__SCREEN_SIZE.width - 30)/3.0;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = (__SCREEN_SIZE.width - 30)/3.0;
    _detailLb.x =  (__SCREEN_SIZE.width - 30)/3.0 + 15;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.textColor =  kUIColorFromRGB(color_1);
    [_detailLb richTextMany:@"楼栋" color:kUIColorFromRGB(color_7)];
    _detailLb.textAlignment = NSTextAlignmentCenter;
    _detailLb.height = 16;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    
    UILabel *detail2 = [self.contentView viewWithTag:3222];
    if (!detail2) {
        detail2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _detailLb.width, 16)];
        detail2.tag = 3222;
        detail2.x = (__SCREEN_SIZE.width - 30)/3.0 * 2 + 15;
        detail2.y = self.height/2.0 - detail2.height/2.0;
    }
        detail2.text = _detail2;
    detail2.font = [UIFont systemFontOfSize:15];
    detail2.textColor =  kUIColorFromRGB(color_1);
    [detail2 richTextMany:@"楼层" color:kUIColorFromRGB(color_7)];
    detail2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:detail2];
}


-(void)fitUpPersonInfoMode
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
   
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.height = 15;
    _titleLb.width = (__SCREEN_SIZE.width - 30)/2.0;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     _titleLb.x = __SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _detailLb.hidden = YES;
    _detailLb.width = (__SCREEN_SIZE.width - 30)/2.0;
    _detailLb.x =  (__SCREEN_SIZE.width - 30)/2.0 + 15;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.font = [UIFont systemFontOfSize:15];
     _detailLb.height = 15;
    _detailLb.textColor =  kUIColorFromRGB(color_7);
    _detailLb.y = self.height/2.0 - _titleLb.height/2.0;
}

-(void)fitMeetingInfo{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    
    _titleLb.x = 15;
    _titleLb.y = 15;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.height = 15;
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width, 15)];
    _titleLb.width = size.width;
    
    
    
    _detailLb.x =  _titleLb.x+_titleLb.width+15;
    _detailLb.width = (__SCREEN_SIZE.width - _detailLb.x -15);
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.font = [UIFont systemFontOfSize:15];
//    _detailLb.textColor =  kUIColorFromRGB(color_1);
    _detailLb.y = _titleLb.y;
    size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(_detailLb.width, 100)];
    _detailLb.height = size.height;
//    _detailLb.backgroundColor = [UIColor yellowColor];
    _detailLb.numberOfLines = 0;
    self.cellHeight = _detailLb.y +_detailLb.height;
    self.height = _detailLb.y +_detailLb.height;
}

-(void)fitPersonCerInfoMode
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width-30;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = 220;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:14];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
}
-(void)fitPersonCerInfoModeB
{
    self.height = 37;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;

    _titleLb.font = [UIFont systemFontOfSize:13];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.height = 15;
    _titleLb.width = (__SCREEN_SIZE.width - 30);
    _titleLb.x = __SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    
    _detailLb.width = (__SCREEN_SIZE.width - 30);
    _detailLb.x =  (__SCREEN_SIZE.width - 30)/2.0 + 15;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 15;
    _detailLb.textColor =  kUIColorFromRGB(color_7);
    _detailLb.y = self.height/2.0 - _titleLb.height/2.0;
}

-(void)fitPersonCerInfoModeC
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.height = 15;
    _titleLb.width = (__SCREEN_SIZE.width - 30);
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = (__SCREEN_SIZE.width - 30)/2.0;
    _detailLb.x =  (__SCREEN_SIZE.width - 30)/2.0 + 15;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 15;
    _detailLb.textColor =  kUIColorFromRGB(color_3);
    _detailLb.y = self.height/2.0 - _titleLb.height/2.0;
}


-(void)fitCerInfoMode
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 86;
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = 220;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
}

-(void)fitPublishMode
{
    [self fitPersonModeEdit];
//    self.height = 44;
//    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
//    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
//    _titleLb.x = 15;
//    _titleLb.width = 86;
//    _titleLb.textColor = kUIColorFromRGB(color_6);
//    _titleLb.font = [UIFont systemFontOfSize:15];
//    _titleLb.height = 20;
//    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
//    
//    _detailLb.width = 220;
//    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
//    _detailLb.textAlignment = NSTextAlignmentRight;
//    _detailLb.textColor = kUIColorFromRGB(color_1);
//    _detailLb.font = [UIFont systemFontOfSize:15];
//    _detailLb.height = 20;
//    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
}

-(void)fitPushSetingMode
{
    self.height = 100;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 86;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 15;
    _titleLb.y = 15;
    
    _detailLb.width = __SCREEN_SIZE.width - 30;
    _detailLb.x = 15;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.numberOfLines = 0;
   CGSize s = [_detailLb.text size:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(_detailLb.width, 100)];
    _detailLb.height = s.height;
    _detailLb.y = 43;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitActInfoMode
{
 
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 86;
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 15;
    _titleLb.y = 3;
    
    _detailLb.width = __SCREEN_SIZE.width - 30 - 40 - 64;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.numberOfLines = 0;
    CGSize s = [_detailLb.text size:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(_detailLb.width, 100)];
    _detailLb.height = s.height;
    _detailLb.y = 0;
    self.height = MAX(28, _detailLb.height + 3 + 6);
}

-(void)fitActInfoModeB
{
    
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 86;
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 15;
    _titleLb.y = 3;
    
    _detailLb.width = __SCREEN_SIZE.width - 30 - 40 - 64;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_3);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.numberOfLines = 0;
    CGSize s = [_detailLb.text size:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(_detailLb.width, 100)];
    _detailLb.height = s.height;
    _detailLb.y = 3;
    self.height = MAX(28, _detailLb.height + 3 + 6);
}
-(void)fitGovInfoMode
{
    self.height = 24;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 86;
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _titleLb.hidden = YES;
    _detailLb.width = 220;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_6);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
}
-(void)fitNoticeInfoMode
{
    self.height = 24;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 86;
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _titleLb.hidden = NO;
    _detailLb.width = 220;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     self.backgroundColor = kUIColorFromRGB(color_9);
       self.contentView.backgroundColor = kUIColorFromRGB(color_9);
}

-(void)fitGoodsInfoMode{
//    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
//    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
//    _titleLb.x = 15;
//    _titleLb.width = __SCREEN_SIZE.width - 30;
//    _titleLb.textColor = kUIColorFromRGB(color_1);
//    _titleLb.font = [UIFont systemFontOfSize:15];
//    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
//    _titleLb.height = size.height;
//    _titleLb.y = 10;
    _titleLb.hidden = YES;
    
    _detailLb.text = @"";
    _detailLb.width = __SCREEN_SIZE.width - 30;
    _detailLb.x = 15;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.textColor = kUIColorFromRGB(color_7);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.numberOfLines = 0;
    _detailLb.y = 0;
    
    if(_dataDic[@"html"]){
        NSString *htmlString = _dataDic[@"detail"];
        if (!_detailTv) {
            _detailTv = [UITextView new];
             [self.contentView addSubview:_detailTv ];
            _detailTv.bounces = NO;
            _detailTv.editable = NO;
            _detailTv.scrollEnabled = NO;
//            _detailTv.userInteractionEnabled = YES;
            _detailTv.textColor = kUIColorFromRGB(color_7);
            _detailTv.backgroundColor = kUIColorFromRGB(color_4);
            _detailTv.dataDetectorTypes = UIDataDetectorTypeLink;
            _detailTv.delegate = self;
//            _detailTv.selectable = NO;
        }
        _detailTv.x = _detailLb.x;
        _detailTv.y = _detailLb.y;
        _detailTv.height = _detailLb.height;
        _detailTv.width =  __SCREEN_SIZE.width - 30;
          _detailTv.font = [UIFont systemFontOfSize:15];
        _detailTv.hidden = NO;
        _detailLb.hidden = YES;
//        if ([htmlString containsString:@"</"] || [htmlString containsString:@"/>"]  ) {
        NSLog(@"img:%@",htmlString);
      NSString *th = [self flattenHTML:htmlString];
        htmlString = th;
          NSLog(@"tttdimg:%@",th);
//            NSString *style = [NSString stringWithFormat:@"<style  type=\"text/css\">img{width:220px,height:200px}</style>"];
//            htmlString = [NSString stringWithFormat:@"%@%@",style,htmlString];
            NSInteger www = __SCREEN_SIZE.width - 30;
        htmlString = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><style  type=\"text/css\">img{width:%ldpx; }</style></head><body>%@</body></html>",www,htmlString];
            NSMutableAttributedString  *attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//            _detailLb.attributedText = attrStr;
//            [_detailLb sizeToFit];
        _detailTv.attributedText = attrStr;
        [_detailTv sizeToFit];
//         _detailTv.width =  __SCREEN_SIZE.width - 30;
//        }
//        else{
//            CGSize size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(_detailLb.width, __SCREEN_SIZE.height*3)];
//            _detailLb.height = size.height;
//            
//        }
    }else{
        _detailTv.hidden = YES;
        _detailLb.hidden = NO;
        CGSize size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(_detailLb.width, __SCREEN_SIZE.height*3)];
        _detailLb.height = size.height;
    }
    if(!_detailTv.hidden)
    {
     self.height = _detailTv.height+_detailTv.y+10;
    }
    else
    self.height = _detailLb.height+_detailLb.y+10;
}

-(void)fitExplainMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
    _titleLb.height = size.height;
    _titleLb.y = 10;
//    _titleLb.hidden = YES;
    
    _detailLb.width = __SCREEN_SIZE.width - 30;
    _detailLb.x = 15;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.textColor = kUIColorFromRGB(color_7);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.numberOfLines = 0;
    _detailLb.y = _titleLb.y + _titleLb.height +10;
    size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(_detailLb.width, __SCREEN_SIZE.height*3)];
    _detailLb.height = size.height;
    
    self.height = _detailLb.height+_detailLb.y+10;
}


-(void)fitGoodsInfoModeB{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.y = 10;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     //    _titleLb.hidden = YES;
     
     _detailLb.width = __SCREEN_SIZE.width - 30;
     _detailLb.x = 15;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.textColor = kUIColorFromRGB(color_7);
     _detailLb.font = [UIFont systemFontOfSize:12];
     _detailLb.numberOfLines = 0;
     
     _detailLb.y = _titleLb.y + _titleLb.height +10;
     CGSize size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(_detailLb.width, __SCREEN_SIZE.height*3)];
     _detailLb.height = size.height;
     
     self.height = _detailLb.height+_detailLb.y+13;
}


-(void)fitClassInfoMode:(BOOL)showMore{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
    _titleLb.height = size.height;
    _titleLb.y = 10;
    
    _detailLb.width = __SCREEN_SIZE.width - 30;
    _detailLb.x = 15;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.textColor = kUIColorFromRGB(color_7);
    _detailLb.font = [UIFont systemFontOfSize:14];
    if (!showMore) {
        _detailLb.numberOfLines = 5;
        NSString *str = _detailLb.text;
        size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(_detailLb.width,__SCREEN_SIZE.height)];
        if (size.height >=90) {
            if (__SCREEN_SIZE.width == 320) {
                str = [str substringToIndex:97];
                str = [str stringByAppendingString:@"..."];
                _detailLb.text = str;
            }else if (__SCREEN_SIZE.width == 375) {
                str = [str substringToIndex:117];
                str = [str stringByAppendingString:@"..."];
                _detailLb.text = str;
            }else{
                str = [str substringToIndex:127];
                str = [str stringByAppendingString:@"..."];
                _detailLb.text = str;
            }
        }
         size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(_detailLb.width,90)];
    }else{
        _detailLb.numberOfLines = 0;
        _detailLb.text = _detail2;
        size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(_detailLb.width, __SCREEN_SIZE.height*3)];
    }
    
    
    
    _detailLb.height = size.height;
    _detailLb.y = _titleLb.y+_titleLb.height+8;
    
    if (_detailLb.height>=13*5) {
        UIButton *btn = (UIButton *)[self.contentView viewWithTag:313];
        if (btn == nil) {
            btn = [UIButton new];
            btn.tag = 313;
            btn.width = 15;
            btn.height = 10;
            [btn setImage:[UIImage imageNamed:@"icon_arrow_double_down"] forState:UIControlStateNormal];
            btn.x = __SCREEN_SIZE.width -15 - btn.width;
            btn.y = _detailLb.y+_detailLb.height - btn.height;
            [btn addTarget:self action:@selector(showMoreAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btn];
        }
    }
    
    
    self.cellHeight = _detailLb.height+_detailLb.y+8;
}


-(void)showMoreAction:(UIButton*)sender{
    if (self.handleAction) {
        self.handleAction(@{});
//        sender.userInteractionEnabled = NO;
//        sender.hidden = YES;
    }
}


-(void)fitCustomMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:16];
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 300)];
    _titleLb.height = size.height;
    _titleLb.y = 15;
    _titleLb.hidden = NO;
    
    _detailLb.width = __SCREEN_SIZE.width - 30;
    _detailLb.x = 15;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_6);
    _detailLb.font = [UIFont systemFontOfSize:14];
    _detailLb.height = 14;
    _detailLb.y = _titleLb.y+_titleLb.height+15;
    self.cellHeight = _detailLb.height+_detailLb.y;
}

-(void)fitWarnMode{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _titleLb.hidden = NO;
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 15)];
    _titleLb.width = size.width;
    
    _detailLb.width = 100;
    _detailLb.x = _titleLb.x+_titleLb.width+2;
//    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_3);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitPersonMainMode
{
    _detailLb.hidden = YES;
     self.height = 60;
 _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.y = 15;
    _titleLb.numberOfLines = 2;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 50)];
    _titleLb.width = size.width;
    _titleLb.height = size.height;
}

-(void)fitPersonMainModeB
{
    _detailLb.hidden = YES;
    self.height = 35;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
  
    _titleLb.numberOfLines = 1;
    _titleLb.textColor = kUIColorFromRGB(color_3);
    _titleLb.font = [UIFont systemFontOfSize:16];
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, 50)];
    _titleLb.height = size.height;
      _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}

-(void)fitClassifyDetailMode:(BOOL)isSelected
{
     self.height = 50;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.textColor = isSelected?kUIColorFromRGB(color_5):kUIColorFromRGB(color_0x999999);
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = self.height;
     _titleLb.y = 0;
     _titleLb.hidden = NO;
     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-100, 15)];
     _titleLb.width = size.width;
     _titleLb.x = 78/2.0 - _titleLb.width/2.0;
     
//     if (_dataDic[@"detail"]) {
//          _detailLb.hidden = NO;
//          _detailLb.width = 15;
//          _detailLb.height = 15;
//          _detailLb.y = 13;
//          _detailLb.x = 5;
//          _detailLb.textAlignment = NSTextAlignmentCenter;
//          _detailLb.textColor = kUIColorFromRGB(color_2);
//          _detailLb.font = [UIFont systemFontOfSize:11];
//          _detailLb.layer.cornerRadius = 3.0;
//          _detailLb.layer.masksToBounds = YES;
//          _detailLb.backgroundColor = kUIColorFromRGB(color_0xf25e74);
//          _titleLb.x = _detailLb.x + _detailLb.width +2;
//     }else{
//          _detailLb.hidden = YES;
//     }
     
     self.contentView.backgroundColor = isSelected?kUIColorFromRGB(color_0xdfdddd):kUIColorFromRGB(color_f8f8f8);

    
     UIImageView *leftLine = [self.contentView viewWithTag:1001];
     if (!leftLine) {
          leftLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 15, 2, 20)];
          leftLine.backgroundColor = kUIColorFromRGB(color_1);
          leftLine.tag = 1001;
          [self.contentView addSubview:leftLine];
     }
     leftLine.hidden = !isSelected;
     
//     UIImageView *topLine = [self.contentView viewWithTag:1002];
//     if (!topLine) {
//          topLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 78, 0.5)];
//          topLine.backgroundColor = kUIColorFromRGB(color_lineColor);
//          topLine.tag = 1002;
//          [self.contentView addSubview:topLine];
//     }
//     topLine.hidden = !isSelected;
//
//
//     UIImageView *rightLine = [self.contentView viewWithTag:1003];
//     if (!rightLine) {
//          rightLine = [[UIImageView alloc]initWithFrame:CGRectMake(77.5,0 , 0.5, 40)];
//          rightLine.backgroundColor = kUIColorFromRGB(color_lineColor);
//          rightLine.tag = 1003;
//          [self.contentView addSubview:rightLine];
//     }
//     rightLine.hidden = isSelected;
//
//
//     UIImageView *bottomLine = [self.contentView viewWithTag:1004];
//     if (!bottomLine) {
//          bottomLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39.5, 78, 0.5)];
//          bottomLine.backgroundColor = kUIColorFromRGB(color_lineColor);
//          bottomLine.tag = 1004;
//          [self.contentView addSubview:bottomLine];
//     }
//     bottomLine.hidden = !isSelected;

}

-(void)fitGoodsInfoModeC:(BOOL)isMore
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_6);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.y = 10;
     _titleLb.hidden = NO;
     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-100, 15)];
     _titleLb.width = size.width;
     
     
     _detailLb.x = _titleLb.x +_titleLb.width +5;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:15];
     _detailLb.width = __SCREEN_SIZE.width - _detailLb.x -  15;
      _detailLb.y = 10;
     _detailLb.numberOfLines = 1;
//     [_detailLb sizeToFit];
     _detailLb.height = 15;
     
     if (isMore) {
          self.height = 35;//_detailLb.height + _detailLb.y+10;
     }else
          self.height = 25;//_detailLb.height + _detailLb.y ;
}



-(void)fitGoodsInfoModeD
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.y = 10;
     _titleLb.hidden = NO;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     
     _detailLb.width = __SCREEN_SIZE.width-30;
     _detailLb.x = 15;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.y = _titleLb.y + _titleLb.height + 15;
     _detailLb.numberOfLines = 0;
     [_detailLb sizeToFit];
     
     
     
     NSString *htmlString = _dataDic[@"detail"];
     //        if ([htmlString containsString:@"</"] || [htmlString containsString:@"/>"]  ) {
     NSLog(@"img:%@",htmlString);
     //            NSString *style = [NSString stringWithFormat:@"<style  type=\"text/css\">img{width:220px,height:200px}</style>"];
     //            htmlString = [NSString stringWithFormat:@"%@%@",style,htmlString];
     NSInteger www = __SCREEN_SIZE.width - 30;
     htmlString = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><style  type=\"text/css\">img{width:%ldpx; }</style></head><body>%@</body></html>",(long)www,htmlString];
     NSMutableAttributedString  *attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
     _detailLb.attributedText = attrStr;
     [_detailLb sizeToFit];

     
     self.height = _detailLb.y + _detailLb.height +15;

}


-(void)fitHeadMode
{
    self.height = 27;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.textColor = kUIColorFromRGB(color_5);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 15;
    _titleLb.y = 12;
    _titleLb.hidden = NO;
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-100, 15)];
    _titleLb.width = size.width;
    
    _detailLb.width = 70;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
        _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_0xf82D45);
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 15;
     _detailLb.y = 12;//self.height/2.0 - _detailLb.height/2.0;
//    _detailLb.textAlignment = NSTextAlignmentLeft;
    
//    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}



-(void)fitSearchStationMode
{
     self.height = 45;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = self.height;
     _titleLb.y = 0;
     _titleLb.width = __SCREEN_SIZE.width -30;
     
     _detailLb.hidden = YES;
//     _detailLb.width = 200;
//     _detailLb.textAlignment = NSTextAlignmentCenter;
//     _detailLb.textColor = kUIColorFromRGB(color_2);
//     _detailLb.backgroundColor = kUIColorFromRGB(color_3);
//     _detailLb.layer.cornerRadius = 6.0;
//     _detailLb.layer.masksToBounds = YES;
//     _detailLb.font = [UIFont systemFontOfSize:13];
//     [_detailLb sizeToFit];
//     _detailLb.height = 21;
//     _detailLb.y = 13;
//     _detailLb.width = _detailLb.width +10;
}

-(void)fitHeadModeB
{
     self.height = 30;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.y = 15;
     _titleLb.hidden = NO;
//     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-100, 15)];
     _titleLb.width = (__SCREEN_SIZE.width - 30)/2.0;
     
     _detailLb.width = 70;
     _detailLb.x = __SCREEN_SIZE.width - 15 - 28 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.textColor = kUIColorFromRGB(color_1);
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.height = 13;
     _detailLb.y = 15;//self.height/2.0 - _detailLb.height/2.0;
     UIButton *btn = (UIButton *)[self.contentView viewWithTag:313];
     if (btn == nil) {
          btn = [UIButton new];
          btn.tag = 313;
          btn.width = __SCREEN_SIZE.width/2.0;
          btn.height = 30;
          btn.customImgV.image = [UIImage imageContentWithFileName:@"head_more"] ;
          btn.customImgV.height = 16;
          btn.customImgV.width = 16;
          btn.customImgV.x = btn.width - 15 - 16;
          btn.customImgV.y = 14;
//          [btn setImage:[UIImage imageContentWithFileName:@"h_more"] forState:UIControlStateNormal];
          btn.x = __SCREEN_SIZE.width/2.0;
          btn.y = 0;
//          btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
          [btn addTarget:self action:@selector(showMoreAction:) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:btn];
     }
     btn.userInteractionEnabled = YES;
}

-(void)fitHeadModeC
{
     self.height = 30;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.y = 15;
     _titleLb.hidden = NO;
//     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-100, 15)];
     _titleLb.width = 160;//size.width;
     
     _detailLb.width = 100;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.height = 13;
     _detailLb.y = 15;//self.height/2.0 - _detailLb.height/2.0;
     //    _detailLb.textAlignment = NSTextAlignmentLeft;
     
     //    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}


-(void)fitGoodsInfoModeA
{
     self.height = 35;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = self.height;
     _titleLb.y = 0;
     _titleLb.hidden = NO;
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-100, 15)];
     _titleLb.width = 200;
     
     

     _detailLb.x = __SCREEN_SIZE.width - 150 - 200;
     _detailLb.textColor = kUIColorFromRGB(color_1);
     _detailLb.font = [UIFont systemFontOfSize:12];
     _detailLb.height = self.height;
     _detailLb.y = 0;
     _detailLb.hidden = NO;
     //     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-100, 15)];
     _detailLb.width = 200;
     _detailLb.textAlignment = NSTextAlignmentRight;
     
     
     NSArray *arr = [_dataDic[@"time"] componentsSeparatedByString:@":"];
     UILabel *t1 = [self createTimeLbA:14541];
     if(arr.count > 0)
     {
          t1.text = arr[0];
          
     }
     UILabel *t2 = [self createTimeLbA:14542];
     if(arr.count > 1)
     {
          t2.text = arr[1];
     }
     UILabel *t3 = [self createTimeLbA:13543];
     if(arr.count > 2)
     {
          t3.text = arr[2];
     }
     t3.x = __SCREEN_SIZE.width - 15 - t3.width;
     t2.x = t3.x - 8 - t2.width;
     t1.x = t2.x - 8 - t1.width;
}


-(UILabel *)createTimeLbA:(NSInteger)tag
{
     UILabel *lb = [self.contentView viewWithTag:tag];
     if (!lb) {
          lb = [UILabel new];
          lb.height = 16;
          lb.width = 35;
          lb.tag = tag;
     }
     lb.y = self.height/2.0 - lb.height/2.0;
     lb.textAlignment = NSTextAlignmentCenter;
     lb.textColor = kUIColorFromRGB(color_2);
     lb.font =  [UIFont systemFontOfSize:13];
     lb.backgroundColor = kUIColorFromRGB(color_0x646262);
     lb.layer.cornerRadius = 4;
     lb.layer.masksToBounds = YES;
     [self.contentView addSubview:lb];
     return lb;
}


-(void)fitHeadModeD
{
     self.height = 30;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.y = 12;
     _titleLb.hidden = NO;
//     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-100, 15)];
     _titleLb.width = 160;//size.width;
     
     _detailLb.hidden = YES;
     NSArray *arr = [_detailLb.text componentsSeparatedByString:@":"];
     UILabel *t1 = [self createTimeLb:1230];
     if(arr.count > 0)
     {
     t1.text = arr[0];
     
     }
      UILabel *t2 = [self createTimeLb:1231];
     if(arr.count > 1)
     {
      t2.text = arr[1];
     }
      UILabel *t3 = [self createTimeLb:1232];
     if(arr.count > 2)
     {
      t3.text = arr[2];
     }
     t3.x = __SCREEN_SIZE.width - 15 - t3.width;
     t2.x = t3.x - 8 - t2.width;
     t1.x = t2.x - 8 - t1.width;
}

-(UILabel *)createTimeLb:(NSInteger)tag
{
     UILabel *lb = [self.contentView viewWithTag:tag];
     if (!lb) {
          lb = [UILabel new];
          lb.height = 16;
          lb.width = 35;
          lb.tag = tag;
     }
     lb.y = 12;
     lb.textAlignment = NSTextAlignmentCenter;
     lb.textColor = kUIColorFromRGB(color_2);
     lb.font =  [UIFont systemFontOfSize:13];
     lb.backgroundColor = kUIColorFromRGB(color_0x646262);
     lb.layer.cornerRadius = 4;
     lb.layer.masksToBounds = YES;
      [self.contentView addSubview:lb];
     return lb;
}
-(void)fitQuestionMode
{
    
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = 15;
    _titleLb.hidden = NO;
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, __SCREEN_SIZE.height)];
    _titleLb.width = size.width;
    _titleLb.height = size.height;
    
    _detailLb.width = __SCREEN_SIZE.width - 30;
    _detailLb.x = 15;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    size = [_detailLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width-30, __SCREEN_SIZE.height)];
    _detailLb.height = size.height;
    _detailLb.y = _titleLb.y + _titleLb.height +10;
    //    _detailLb.textAlignment = NSTextAlignmentLeft;

    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    self.height = 44;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _detailLb.hidden = YES;
    UIImageView *imgv = [self.contentView viewWithTag:973];
    if (!imgv) {
        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 17)];
        imgv.tag = 973;
        
        imgv.y = 13;
        
        
    }
    imgv.x = __SCREEN_SIZE.width - 10 - 9;
    //    if (upDown) {
    imgv.image = [UIImage imageContentWithFileName:@"icon_arrow_right"];
    imgv.y = self.height/2.0 - imgv.height/2.0;
    [self.contentView addSubview:imgv];
}



-(void)fitQuestionInfoMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.y = 0;
     _titleLb.width = __SCREEN_SIZE.width -30;
     _titleLb.numberOfLines = 0;
     [_titleLb sizeToFit];
     
     
     _detailLb.width = __SCREEN_SIZE.width -30;
     _detailLb.x = 15;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.textColor = kUIColorFromRGB(color_8);
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.height = 13;
     _detailLb.y = _titleLb.y + _titleLb.height + 4;
     _detailLb.numberOfLines = 0;
     [_detailLb sizeToFit];
     
     self.height = _detailLb.y + _detailLb.height +20;
}

-(void)fitMyAccountMode
{
    self.height = 50;
    _titleLb.y = 30;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.width = 140;
    [_titleLb sizeToFit];
    
    _detailLb.textColor = kUIColorFromRGB(color_3);
    _detailLb.font = [UIFont systemFontOfSize:24];
    _detailLb.y = 24;
    _detailLb.width = 80;
    [_detailLb sizeToFit];
    
    _titleLb.x = __SCREEN_SIZE.width/2.0 - (_titleLb.width + 10 + _detailLb.width)/2.0;
    _detailLb.x = _titleLb.x + _titleLb.width + 10;
    self.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitMyOrderMode
{
    self.height = 31;

    _titleLb.font = [UIFont systemFontOfSize:13];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.width = 140;
    [_titleLb sizeToFit];
    _titleLb.x = 15;
        _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.textColor = kUIColorFromRGB(color_0xf82D45);
    _detailLb.font = [UIFont systemFontOfSize:13];
    self.backgroundColor = kUIColorFromRGB(color_2);
    _detailLb.width = 80;
    [_detailLb sizeToFit];
        _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;

     UIButton *btn = [self.contentView viewWithTag:1331];
     if(!btn)
     {
          btn = [UIButton new];
          btn.tag = 1331;
              btn.backgroundColor = [UIColor clearColor];
     }
     if ([_dataDic[@"isShowBtn"] boolValue]) {

          btn.enabled = YES;


     }
     else
     {
          btn.enabled = NO;

     }

     btn.height = self.height;
     btn.width = _titleLb.width;
     btn.x =  14;
     btn.y =  0;
     [self.contentView addSubview:btn];
     [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

}
-(void)fitMyRunMode
{
     self.height = 40;

     _titleLb.font = [UIFont systemFontOfSize:15];
     if (__SCREEN_SIZE.width == 320) {
          _titleLb.font = [UIFont systemFontOfSize:13];
     }
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.width = 140;
     [_titleLb sizeToFit];
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;

     _detailLb.textColor = kUIColorFromRGB(color_3);
     _detailLb.font = [UIFont systemFontOfSize:15];
     if (__SCREEN_SIZE.width == 320) {
          _detailLb.font = [UIFont systemFontOfSize:13];
     }
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 80;
     [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
}
-(void)fitToDoorRecMode
{
     self.height = 45;

     _titleLb.font = [UIFont systemFontOfSize:15];
     if (__SCREEN_SIZE.width == 320) {
          _titleLb.font = [UIFont systemFontOfSize:13];
     }
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 140;
     _titleLb.height = 18;
     [_titleLb sizeToFit];
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;

     _detailLb.textColor = kUIColorFromRGB(color_FF7167);
     _detailLb.font = [UIFont systemFontOfSize:15];
     if (__SCREEN_SIZE.width == 320) {
          _detailLb.font = [UIFont systemFontOfSize:13];
     }
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 80;
     [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
}
-(void)fitReplacementMode
{
     self.height = 28;

     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.width = 140;
     [_titleLb sizeToFit];
     _titleLb.x = 15;
     _titleLb.y = 12;

     _detailLb.textColor = kUIColorFromRGB(color_0xfd7400);
     _detailLb.font = [UIFont systemFontOfSize:15];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 110;
     [_detailLb sizeToFit];
     _detailLb.y = _titleLb.y;// self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
}
-(void)fitSureOrderMode
{
    self.height = 40;
    
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.width = 140;
    [_titleLb sizeToFit];
    _titleLb.x = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    self.backgroundColor = kUIColorFromRGB(color_4);
    _detailLb.width = 160;
    [_detailLb sizeToFit];
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
}
-(void)fitSureOrderModeE
{
    self.height = 40;
    
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.width = 140;
    [_titleLb sizeToFit];
    _titleLb.x = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     _titleLb.attributedText =  [_titleLb richText:[UIFont systemFontOfSize:12] text:@"（提货时出示）" color:kUIColorFromRGB(color_8)];
    
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    self.backgroundColor = kUIColorFromRGB(color_4);
    _detailLb.width = 80;
    [_detailLb sizeToFit];
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
}

-(void)fitSureOrderModeD
{
    self.height = 40;
    
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.width = 140;
    [_titleLb sizeToFit];
    _titleLb.x = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
 _titleLb.attributedText =  [_titleLb richText:[UIFont systemFontOfSize:12] text:@"（商品到达自提点会电话联系您）" color:kUIColorFromRGB(color_8)];
    
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    self.backgroundColor = kUIColorFromRGB(color_4);
    _detailLb.width = 80;
    [_detailLb sizeToFit];
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
}


-(void)fitSureOrderModeC
{
    self.height = 40;
    
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.width = 140;
    [_titleLb sizeToFit];
    _titleLb.x = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.textColor = kUIColorFromRGB(color_6);
    _detailLb.font = [UIFont systemFontOfSize:15];
    self.backgroundColor = kUIColorFromRGB(color_4);
    _detailLb.width = 80;
    [_detailLb sizeToFit];
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    if (![_dataDic[@"price"] isEqualToString:@""]) {
        NSString *p = _dataDic[@"price"];
        [_detailLb strikeout:0 withLength:p.length];
    }
    else
    {
    [_detailLb strikeout:0 withLength:0];
    }
    if (_dataDic[@"tprice"]&&![_dataDic[@"tprice"] isEqualToString:@""]) {
        [_detailLb richMText:_dataDic[@"tprice"] color:kUIColorFromRGB(color_3) withFont:_detailLb.font];
    }
   else
   {
       _detailLb.textColor = kUIColorFromRGB(color_3);
   }
}


-(void)fitGoodsParameterMode
{
     self.height = 40;
     
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = 100;
     _titleLb.x = 15;
     _titleLb.height = self.height;
     _titleLb.y = 0;
     
     _detailLb.textColor = kUIColorFromRGB(color_8);
     _detailLb.font = [UIFont systemFontOfSize:14];
     _detailLb.y = 0;
     _detailLb.x = 125;
     _detailLb.width = __SCREEN_SIZE.width - 15 -_detailLb.width;
     _detailLb.height = self.height;
     _detailLb.textAlignment = NSTextAlignmentLeft;
}

-(void)fitSureOrderModeA
{
    self.height = 30;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.width = 140;
    [_titleLb sizeToFit];
    _titleLb.x = 15;
     _titleLb.y = self.height - 5 - _titleLb.height;
    
    _detailLb.textColor = kUIColorFromRGB(color_3);
    _detailLb.font = [UIFont systemFontOfSize:15];
//    _detailLb.attributedText = [_detailLb richText:@"支付宝" color:kUIColorFromRGB(color_1)];
    self.backgroundColor = kUIColorFromRGB(color_4);
    _detailLb.width = 80;
    [_detailLb sizeToFit];
    _detailLb.y = _titleLb.y;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
}

-(void)fitSureOrderModeB
{
self.height = 30;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.width = 140;
    [_titleLb sizeToFit];
    _titleLb.x = 15;
    _titleLb.y = 5;
    
    
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    self.backgroundColor = kUIColorFromRGB(color_4);
    _detailLb.width = 80;
    [_detailLb sizeToFit];
    _detailLb.y = _titleLb.y;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
}

-(void)fitInfoSettingMode
{
    self.height = 44;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.width = 140;
    [_titleLb sizeToFit];
    _titleLb.x = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    
    _detailLb.textColor = kUIColorFromRGB(color_8);
    _detailLb.font = [UIFont systemFontOfSize:15];
    self.backgroundColor = kUIColorFromRGB(color_4);
    _detailLb.width = 120;
    _detailLb.textAlignment = NSTextAlignmentRight;
    [_detailLb sizeToFit];
    _detailLb.width = 180;
    _detailLb.y = _titleLb.y;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width - 10;
    
    UIImageView *imgv = [self.contentView viewWithTag:973];
    if (!imgv) {
        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 17)];
        imgv.tag = 973;
        
        imgv.y = 13;
        
        
    }
    imgv.x = __SCREEN_SIZE.width - 10 - 9;
    //    if (upDown) {
    imgv.image = [UIImage imageContentWithFileName:@"icon_arrow_right"];
    [self.contentView addSubview:imgv];
    
}
-(void)fitMyPointModeB
{
    self.height = 35;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 156;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.width = 160;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_mainTheme);
    _detailLb.font = [UIFont systemFontOfSize:16];
    _detailLb.height = 20;
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
      self.backgroundColor = kUIColorFromRGB(color_4);
}
-(void)fitMyPointMode
{
    
    self.height = 54;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 290;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.height = 20;
    _titleLb.y = 7;
    [_titleLb sizeToFit];
    
    _detailLb.width = 240;
    _detailLb.x = 15;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.textColor = kUIColorFromRGB(color_8);
    _detailLb.font = [UIFont systemFontOfSize:14];
    _detailLb.height = 20;
    _detailLb.y = _titleLb.y + _titleLb.height + 7;
    [_detailLb sizeToFit];
    
    UILabel *lb = [self.contentView viewWithTag:12113];
    if (!lb) {
        lb = [UILabel new];
        lb.width = 60;
        lb.height = 17;
        lb.tag = 12113;
    }
    lb.textAlignment = NSTextAlignmentRight;
    lb.text = _detail2;
    lb.textColor = kUIColorFromRGB(color_mainTheme);
    lb.font =  [UIFont systemFontOfSize:16];
    lb.x = __SCREEN_SIZE.width - 15 - lb.width;
    lb.y = self.height/2.0 - lb.height/2.0;
    [self.contentView addSubview:lb];
    self.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitMyInviteMode:(UIColor *)color
{
    
    self.height = 54;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 290;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    [_titleLb sizeToFit];
    
    _detailLb.width = 240;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = color;
    _detailLb.font = [UIFont systemFontOfSize:15];
    _detailLb.height = 20;
    _detailLb.y = 7;
    //[_detailLb sizeToFit];
    
    UILabel *lb = [self.contentView viewWithTag:12113];
    if (!lb) {
        lb = [UILabel new];
        lb.width = 220;
        lb.height = 17;
        lb.tag = 12113;
    }
    lb.textAlignment = NSTextAlignmentRight;
    lb.text = _detail2;
    lb.textColor = kUIColorFromRGB(color_8);
    lb.font =  [UIFont systemFontOfSize:14];
    lb.x = __SCREEN_SIZE.width - 15 - lb.width;
    lb.y = _detailLb.y + _detailLb.height + 7;
    [self.contentView addSubview:lb];
    self.backgroundColor = kUIColorFromRGB(color_4);
}
-(void)fitEditAddressMode
{
      self.height = 41;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 105;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _detailLb.hidden = YES;
    _textTf.text = _detailLb.text;
    _textTf.hidden = NO;
    
    _textTf.x = __SCREEN_SIZE.width - 15 - _textTf.width;
    _textTf.textAlignment = NSTextAlignmentLeft;
    _textTf.textColor = kUIColorFromRGB(color_1);
    _textTf.delegate = self;
    _textTf.font = [UIFont systemFontOfSize:15];
    _textTf.height = 20;
    _textTf.y = self.height/2.0 - _textTf.height/2.0;
    _textTf.x = 101;
     _textTf.width = __SCREEN_SIZE.width - _textTf.x - 15;
     _textTf.placeholder = _dataDic[@"placeholder"];
   
}
//
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//    //    _posRange = textView.selectedRange;
//    if (!_tap) {
//        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
//    }
//    [self.window addGestureRecognizer:_tap];
//    return YES;
//}
- (IBAction)editTextBegin:(id)sender {
    //    _posRange = textView.selectedRange;
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    }
    [self.window addGestureRecognizer:_tap];
}
//- (void)textViewDidChangeSelection:(UITextView *)textView
//{
// _posRange = textView.selectedRange;
//}
-(void)tapHandle:(UITapGestureRecognizer *)tap
{
    [tap.view removeGestureRecognizer:tap];
    [self endEditing:YES];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    }
    [self.window addGestureRecognizer:_tap];
    return YES;
}
-(void)fitExamTicketMode:(UIColor *)color
{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 72;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:13];
    _titleLb.height = 20;
    _titleLb.y = 0;
    _detailLb.hidden = NO;
    _textTf.hidden = YES;
    
    _detailLb.width = __SCREEN_SIZE.width/2.0 - 15;
    _detailLb.x = __SCREEN_SIZE.width/2.0;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    _detailLb.textColor = color;
    _detailLb.font = [UIFont systemFontOfSize:13];
    _detailLb.height = 45;
    _detailLb.y = 0;
    _detailLb.numberOfLines = 2;
    [_detailLb sizeToFit];
    self.height = 45;
}

-(void)fitExamTicketMode
{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 72;
    _titleLb.textColor = kUIColorFromRGB(color_3);
  
    _titleLb.font = [UIFont systemFontOfSize:13];
    _titleLb.height = 20;
    _titleLb.y = 0;
     _titleLb.attributedText = [_titleLb richText:@"客服电话:" color:kUIColorFromRGB(color_1)];
    
    _detailLb.hidden = NO;
    _textTf.hidden = YES;
    
    _detailLb.width = __SCREEN_SIZE.width/2.0 - 15;
    _detailLb.textAlignment = NSTextAlignmentRight;
    _detailLb.textColor = kUIColorFromRGB(color_8);
    _detailLb.font = [UIFont systemFontOfSize:13];
    _detailLb.height = 20;
    _detailLb.y = 0;
    _detailLb.numberOfLines = 2;
    [_detailLb sizeToFit];
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
    self.height = 25;
    
    UIButton *btn = [self.contentView viewWithTag:13312];
    if(!btn)
    {
        btn = [UIButton new];
        btn.tag = 13312;
    }
    [btn setImage:nil forState:UIControlStateNormal];
    [btn setTitle:@"" forState:UIControlStateNormal];
  CGSize ss = [_titleLb.text size:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(320, 30)];
    CGSize st = [@"客服电话:"  size:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(320, 30)];
    _titleLb.width = ss.width;
    btn.width = ss.width - st.width + 10;
    btn.height = 25;
    btn.y = 0;
    btn.x = st.width + 15 - 5;
//    btn.layer.cornerRadius = 3;
//    btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
//    btn.layer.masksToBounds = YES;
//    btn.layer.borderWidth = 0.5;
//    btn.x = __SCREEN_SIZE.width - 15 - btn.width;
//    btn.y = self.height/2.0 - btn.height/2.0;
    [self.contentView addSubview:btn];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    //    btn.layer.bo
    btn.hidden = NO;
}

-(void)fitExamTicketModeB:(UIColor *)color
{
    [self fitExamTicketMode:color];
        self.backgroundColor = kUIColorFromRGB(color_9);
     self.contentView.backgroundColor = kUIColorFromRGB(color_9);
}
-(void)fitExamTicketModeB
{
    [self fitExamTicketMode];
    self.backgroundColor = kUIColorFromRGB(color_9);
     self.contentView.backgroundColor = kUIColorFromRGB(color_9);
}
-(void)fitExamTicketModeC
{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 16;
    _titleLb.y = 15;
   
    
    _detailLb.hidden = NO;
    _textTf.hidden = YES;
    
    _detailLb.width = __SCREEN_SIZE.width - 30;
    _detailLb.x = 15;
    _detailLb.textAlignment = NSTextAlignmentCenter;
    _detailLb.textColor = kUIColorFromRGB(color_3);
    _detailLb.font = [UIFont systemFontOfSize:38];
    _detailLb.height = 44;
    _detailLb.y = 56;
    _detailLb.numberOfLines = 1;
    [_detailLb sizeToFit];
    _detailLb.x = __SCREEN_SIZE.width/2.0 - _detailLb.width/2.0;
   _detailLb.attributedText = [_detailLb richText:[UIFont systemFontOfSize:15] text:@"分" color:kUIColorFromRGB(color_3)];
    self.height = 125;
    self.backgroundColor = kUIColorFromRGB(color_4);
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}


-(void)fitShopInfoMode
{
     self.height = 40;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 30;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = self.height;
     _titleLb.y = 0;
     _titleLb.hidden = NO;
     _titleLb.width = 200;
     
     _detailLb.width = 200;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.textColor = kUIColorFromRGB(color_7);
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.height = self.height;
     _detailLb.y = 0;
     
     UIView *view = [self.contentView viewWithTag:1519];
     if (!view) {
          view = [[UIView alloc]initWithFrame:CGRectMake(15, 9, 5, 22)];
          view.tag = 1519;
          view.backgroundColor = kUIColorFromRGB(color_3);
          [self.contentView addSubview:view];
     }
     
}



-(void)fitGoodsInfoMode:(CGFloat)y
{
//     self.height = 40;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.y = y;
     _titleLb.hidden = NO;
     _titleLb.width = 100;
     
     _detailLb.width = __SCREEN_SIZE.width - 126-15;
     _detailLb.x = 126;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.numberOfLines = 0;
     [_detailLb sizeToFit];
     _detailLb.y = y;
     
     self.height = _detailLb.y +_detailLb.height;
     
}

-(void)fitPersonInfoSettingMode
{
       self.height = 40;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = 72;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _detailLb.hidden = NO;
    _textTf.text = _detailLb.text;
    _textTf.hidden = YES;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.x = __SCREEN_SIZE.width - 15 -  _detailLb.width;
//    _textTf.width = 220;
////    _textTf.x = __SCREEN_SIZE.width - 15 - _textTf.width;
//    _textTf.textAlignment = NSTextAlignmentRight;
//    _textTf.textColor =  kUIColorFromRGB(color_1);;
//    _textTf.font = [UIFont systemFontOfSize:15];
//    _textTf.height = 20;
//    _textTf.userInteractionEnabled = NO;
//    _textTf.y = self.height/2.0 - _textTf.height/2.0;
////    _textTf.userInteractionEnabled = NO;
//    _textTf.x = __SCREEN_SIZE.width - 15 -  _textTf.width;
//  _textTf.delegate = self;
   
}
-(void)fitGrowthValueRecordMode
{
     self.height = 56;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     _titleLb.width = 200;
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.y = 11;
     _titleLb.x = 15;
     
     _detailLb.hidden = NO;
     _textTf.hidden = YES;
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:11];
     _detailLb.height = 11;
     _detailLb.width = 200;
     _detailLb.x = 15;
     _detailLb.y = 33;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     
     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 60;
          lb.height = 15;
          lb.tag = 12113;
     }
     lb.textAlignment = NSTextAlignmentRight;
     lb.text = _dataDic[@"detail2"];
     lb.textColor = kUIColorFromRGB(color_3);
     lb.font =  [UIFont systemFontOfSize:15];
     lb.x = __SCREEN_SIZE.width - 15 - lb.width;
     lb.y = self.height/2.0 - lb.height/2.0;
     [self.contentView addSubview:lb];

   
}

-(void)fitTaskCenterModeB:(BOOL)isFinish
{
     self.height = 56;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     _titleLb.width = 200;
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.y = 11;
     _titleLb.x = 15;
     
     _detailLb.hidden = NO;
     _textTf.hidden = YES;
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:11];
     _detailLb.height = 11;
     _detailLb.width = 200;
     _detailLb.x = 15;
     _detailLb.y = 33;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     
     UIButton *btn = [self.contentView viewWithTag:1331];
     if(!btn)
     {
          btn = [UIButton new];
          btn.tag = 1331;
     }
     if (isFinish) {
          btn.layer.borderWidth = 0.5;
          btn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
          btn.enabled = NO;
          btn.backgroundColor = kUIColorFromRGB(color_2);
          [btn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
          [btn setTitle:@"领取" forState:UIControlStateNormal];
     }
     else
     {
          btn.layer.borderWidth = 0;
          btn.enabled = YES;
          btn.backgroundColor = kUIColorFromRGB(color_3);
          [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          [btn setTitle:@"已领取" forState:UIControlStateNormal];
     }
     btn.layer.cornerRadius = 4;
     btn.layer.masksToBounds = YES;
     btn.titleLabel.font = [UIFont systemFontOfSize:13];
     btn.height = 31;
     btn.width = 80;
     btn.x =  __SCREEN_SIZE.width - 15 - btn.width;
     btn.y =  13;
     [self.contentView addSubview:btn];
     [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
     
}

-(void)fitTaskCenterMode:(BOOL)isFinish
{
    self.height = 56;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    
    _titleLb.width = 200;
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.font = [UIFont systemFontOfSize:13];
    _titleLb.height = 13;
    _titleLb.y = 11;
     _titleLb.x = 15;
     
    _detailLb.hidden = NO;
    _textTf.hidden = YES;
    _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
    _detailLb.font = [UIFont systemFontOfSize:11];
     _detailLb.height = 11;
    _detailLb.width = 200;
     _detailLb.x = 15;
    _detailLb.y = 33;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
    
    UIButton *btn = [self.contentView viewWithTag:1331];
    if(!btn)
    {
        btn = [UIButton new];
        btn.tag = 1331;
    }
     if (isFinish) {
          btn.layer.borderWidth = 0.5;
          btn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
          btn.enabled = NO;
          btn.backgroundColor = kUIColorFromRGB(color_2);
          [btn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
          [btn setTitle:@"已完成" forState:UIControlStateNormal];
     }
     else
     {
          btn.layer.borderWidth = 0;
           btn.enabled = YES;
          btn.backgroundColor = kUIColorFromRGB(color_3);
          [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          [btn setTitle:@"做任务" forState:UIControlStateNormal];
     }
     btn.layer.cornerRadius = 4;
     btn.layer.masksToBounds = YES;
     btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.height = 31;
    btn.width = 80;
    btn.x =  __SCREEN_SIZE.width - 15 - btn.width;
    btn.y =  13;
    [self.contentView addSubview:btn];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)dealloc
{
    [_tap.view removeGestureRecognizer:_tap];
    _tap = nil;
}


-(void)fitOrderInfoForteacherMode
{
    self.height = 40;
    
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.width = 130;
//    [_titleLb sizeToFit];
    _titleLb.x = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    self.backgroundColor = kUIColorFromRGB(color_4);
    _detailLb.width = 160;
    _detailLb.hidden = NO;
    _detailLb.height = 17;
//    [_detailLb sizeToFit];
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
}

-(void)fitAppontMentOrderMode
{
    self.height = 40;
    
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.width = 80;
    //    [_titleLb sizeToFit];
    _titleLb.x = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15];
    self.backgroundColor = kUIColorFromRGB(color_4);
    _detailLb.width = 160;
    _detailLb.hidden = NO;
    _detailLb.height = 17;
    //    [_detailLb sizeToFit];
    _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
    _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;

}

-(void)setNull
{
    _titleLb = nil;
    _detail2 = nil;
    _detailLb = nil;
    _textTf = nil;
    _tap = nil;
    _backView = nil;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction
{
    NSString *u = URL.absoluteString;
    return YES;
}

- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<img" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:[NSString stringWithFormat:@"<a href=\"http://www.baidu.com\">%@></a>",text]];
    }
//    MidStrTitle = html;
    return html;
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

-(void)fitYouBiModeA:(UIColor *)color
{
     self.height = 56;
     
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     _titleLb.width = 180;
     _titleLb.height = 13;
     //    [_titleLb sizeToFit];
     _titleLb.x = 15;
     _titleLb.y = 11;
     
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:11];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 180;
     _detailLb.hidden = NO;
     _detailLb.height = 11;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.y = 34;
     _detailLb.x = 15;
     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 60;
          lb.height = 13;
          lb.tag = 12113;
     }
     lb.textAlignment = NSTextAlignmentRight;
     lb.text = _detail2;
     lb.textColor = color;
     lb.font =  [UIFont systemFontOfSize:13];
     lb.x = __SCREEN_SIZE.width - 15 - lb.width;
     lb.y = 23;
     [self.contentView addSubview:lb];
     
}

-(void)fitYouBiModeB
{
     self.height = 48;
     
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 130;
     _titleLb.height = 13;
     _titleLb.x = 43;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 18, 18)];
          imgv.tag = 973;
          
//          imgv.y = 13;
          
          
     }
//     imgv.x = __SCREEN_SIZE.width - 10 - 9;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"calendar"];
     [self.contentView addSubview:imgv];
}

-(void)fitMyYoubiMode
{
     self.height = 32;
     
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 13;
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:12];
     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 12;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
}

-(void)fitPersonCenterMode
{
     
     self.height = 45;
     
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     
     _detailLb.textColor = kUIColorFromRGB(color_7);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 36 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     
     
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 17)];
          imgv.tag = 973;
          
          imgv.y = 15;
          
          
     }
     imgv.x = __SCREEN_SIZE.width - 15 - 10;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     [self.contentView addSubview:imgv];
     imgv.hidden = NO;

}
-(void)fitPersonCenterModeB
{

     self.height = 45;

     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;

     _detailLb.textColor = kUIColorFromRGB(color_7);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;

UIImageView *imgv = [self.contentView viewWithTag:973];
     imgv.hidden =  YES;

}

-(void)fitToDoorRecycleMode
{
     self.height = 45;

     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;

     _detailLb.textColor = kUIColorFromRGB(color_7);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 36 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;


     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 17)];
          imgv.tag = 973;

          imgv.y = 15;


     }
     imgv.x = __SCREEN_SIZE.width - 15 - 9;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     [self.contentView addSubview:imgv];
}

-(void)fitToDoorRecycleModeB
{
     self.height = 61;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = 160;
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.y = 12;

     _detailLb.textColor = kUIColorFromRGB(color_7);
     _detailLb.font = [UIFont systemFontOfSize:12];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 50;
     _detailLb.hidden = NO;
     _detailLb.height = 12;
     //    [_detailLb sizeToFit];
     _detailLb.y = _titleLb.y + _titleLb.height + 10;
     _detailLb.x = 15;
     _detailLb.textAlignment = NSTextAlignmentLeft;

     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 17)];
          imgv.tag = 973;

          imgv.y = 22;


     }
     imgv.x = __SCREEN_SIZE.width - 15 - 9;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     [self.contentView addSubview:imgv];
}

-(void)fitToDoorRecycleModeC
{
     self.height = 61;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = 160;
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;

     _detailLb.textColor = kUIColorFromRGB(color_7);
     _detailLb.font = [UIFont systemFontOfSize:12];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 50;
     _detailLb.hidden = YES;
     _detailLb.height = 12;
     //    [_detailLb sizeToFit];
     _detailLb.y = _titleLb.y + _titleLb.height + 10;
     _detailLb.x = 15;
     _detailLb.textAlignment = NSTextAlignmentLeft;

     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 17)];
          imgv.tag = 973;

          imgv.y = 22;


     }
     imgv.x = __SCREEN_SIZE.width - 15 - 9;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     [self.contentView addSubview:imgv];
     
     UIImageView *imgv2 = [self.contentView viewWithTag:977];
     if (!imgv2) {
          imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 19)];
          imgv2.tag = 977;
          
          imgv2.y = self.height/2.0 - imgv2.height/2.0;
          
          
     }
     imgv2.x = 15;
     //    if (upDown) {
     imgv2.image = [UIImage imageContentWithFileName:@"adr_add"];
     [self.contentView addSubview:imgv2];
       _titleLb.x = imgv2.x + imgv2.width + 15;
     if([_dataDic[@"title" ] isEqualToString:@"请新增服务地址"])
     {
          imgv2.hidden = NO;
     }
     else
     {
             imgv2.hidden = YES;
     }
}
-(void)fitReplacementConfirmMode
{
     self.height = 81;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = 160;
     _titleLb.height = 16;
     _titleLb.x = 15;
     _titleLb.y = 18;

     _detailLb.textColor = kUIColorFromRGB(color_7);
     _detailLb.font = [UIFont systemFontOfSize:12];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 50;
     _detailLb.hidden = NO;
     _detailLb.height = 12;
     //    [_detailLb sizeToFit];
     _detailLb.y = _titleLb.y + _titleLb.height + 13;
     _detailLb.x = 38;
     _detailLb.textAlignment = NSTextAlignmentLeft;


     UIImageView *pimgv = [self.contentView viewWithTag:979];
     if (!pimgv) {
          pimgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 13, 17)];
          pimgv.tag = 979;

          pimgv.y = 42;
     }
     pimgv.x = 15;
     //    if (upDown) {
     pimgv.image = [UIImage imageContentWithFileName:@"nav_pos"];
     [self.contentView addSubview:pimgv];
     pimgv.hidden = NO;

     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 17)];
          imgv.tag = 973;

          imgv.y = 32;
     }
     imgv.x = __SCREEN_SIZE.width - 15 - 10;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     [self.contentView addSubview:imgv];
}

-(void)fitReplacementConfirmModeB
{
     self.height = 81;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = 160;
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;

     _detailLb.textColor = kUIColorFromRGB(color_7);
     _detailLb.font = [UIFont systemFontOfSize:12];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 50;
     _detailLb.hidden = YES;
     _detailLb.height = 12;
     //    [_detailLb sizeToFit];
     _detailLb.y = _titleLb.y + _titleLb.height + 13;
     _detailLb.x = 38;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     UIImageView *pimgv = [self.contentView viewWithTag:979];
     pimgv.hidden = YES;


     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 17)];
          imgv.tag = 973;

          imgv.y = 32;
     }
     imgv.x = __SCREEN_SIZE.width - 15 - 10;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     [self.contentView addSubview:imgv];
     
     UIImageView *imgv2 = [self.contentView viewWithTag:976];
     if (!imgv2) {
          imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 19)];
          imgv2.tag = 976;
          
          imgv2.y = self.height/2.0 - imgv2.height/2.0;
          
          
     }
     imgv2.x = 15;
     //    if (upDown) {
     imgv2.image = [UIImage imageContentWithFileName:@"adr_add"];
     [self.contentView addSubview:imgv2];
     _titleLb.x = imgv2.x + imgv2.width + 15;
     if([_dataDic[@"title" ] isEqualToString:@"请新增服务地址"])
     {
          imgv2.hidden = NO;
     }
     else
     {
          imgv2.hidden = YES;
     }
}

-(void)fitPersonInfoMode
{
     self.height = 44;
     
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     
     _detailLb.textColor = kUIColorFromRGB(color_0x757575);
     _detailLb.font = [UIFont systemFontOfSize:15];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 15;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = 131;//__SCREEN_SIZE.width - 36 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     
     
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 18)];
          imgv.tag = 973;
          
          imgv.y = 13;
     }
     imgv.x = __SCREEN_SIZE.width - 15 - 10;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     [self.contentView addSubview:imgv];
}


-(void)fitPersonInfoModeB
{
     self.height = 44;
     
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     
     _detailLb.textColor = kUIColorFromRGB(color_0x757575);
     _detailLb.font = [UIFont systemFontOfSize:15];
     self.backgroundColor = kUIColorFromRGB(color_2);
     
     _detailLb.hidden = NO;
     _detailLb.height = 15;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = 131;//__SCREEN_SIZE.width - 36 - _detailLb.width;
     _detailLb.width = __SCREEN_SIZE.width - 15 - _detailLb.x;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     
}

-(void)fitOrderInfoModeA
{
     self.height = 41;
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 16)];
          imgv.tag = 973;
          
          imgv.y = 13;
          
          
     }
     imgv.x = 15;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:_dataDic[@"img"]];
     [self.contentView addSubview:imgv];

     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_3);
     _titleLb.width = 160;
     _titleLb.height = 16;
     [_titleLb sizeToFit];
     _titleLb.x = 15 + imgv.width + imgv.x;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     if ([_detailLb.text containsString:@"已到期:"]) {
          _detailLb.textColor = kUIColorFromRGB(color_0xf82D45);
     }
}
-(void)fitOrderInfoModeAA
{
     self.height = 41;
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 16)];
          imgv.tag = 973;
          
          imgv.y = 13;
          
          
     }
     imgv.x = 15;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:_dataDic[@"img"]];
     [self.contentView addSubview:imgv];
     
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_3);
     _titleLb.width = 160;
     _titleLb.height = 13;
     _titleLb.x = 15 + imgv.width + imgv.x;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.textColor = kUIColorFromRGB(color_3);
    _detailLb.attributedText = [_detailLb richText:@"剩余:" color:kUIColorFromRGB(color_0xb0b0b0)];
}
-(void)fitOrderInfoModeB
{
     self.height = 65;
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 15)];
          imgv.tag = 973;
          
          imgv.y = 13;
          
          
     }
     imgv.x = 15;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"fastCar"];
     [self.contentView addSubview:imgv];
     
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - 60;
     _titleLb.height = 13;
     _titleLb.x = 15 + imgv.width + imgv.x;
     _titleLb.y = 15;
     
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = _titleLb.y + _titleLb.height + 11;
     _detailLb.x = _titleLb.x;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     
     UIImageView *imgv2 = [self.contentView viewWithTag:974];
     if (!imgv2) {
          imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 18)];
          imgv2.tag = 974;
          
          imgv2.y = 24;
     }
     imgv2.x = __SCREEN_SIZE.width - 15 - 10;
     //    if (upDown) {
     imgv2.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     [self.contentView addSubview:imgv2];

}

-(void)fitRecycleInfoMode
{
     self.height = 46;
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
          imgv.tag = 973;

          imgv.y = 13;


     }
     imgv.x = 15;
     //    if (upDown) {
     if ([_dataDic[@"img"] isKindOfClass:[BUImageRes class]]) {
          BUImageRes *im = _dataDic[@"img"];
          im.isValid = YES;
          [im displayRemoteImage:imgv imageName:@"default"];
     }
     else
     imgv.image = [UIImage imageContentWithFileName:_dataDic[@"img"]];
     [self.contentView addSubview:imgv];

     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = __SCREEN_SIZE.width - 60;
     _titleLb.height = 15;
     _titleLb.x = 10 + imgv.width + imgv.x;
     _titleLb.y = 17;

     _detailLb.textColor = kUIColorFromRGB(color_3);
     _detailLb.font = [UIFont systemFontOfSize:15];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 200;
     _detailLb.hidden = NO;
     _detailLb.height = 15;
     //    [_detailLb sizeToFit];
     _detailLb.y = 16;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;

//     UIImageView *imgv2 = [self.contentView viewWithTag:974];
//     if (!imgv2) {
//          imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 17)];
//          imgv2.tag = 974;
//
//          imgv2.y = 15;
//     }
//     imgv2.x = __SCREEN_SIZE.width - 15 - 10;
//     //    if (upDown) {
//     imgv2.image = [UIImage imageContentWithFileName:@"rightArrow2"];
//     [self.contentView addSubview:imgv2];
}

-(void)fitOrderInfoModeH
{
     self.height = 46;
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 15)];
          imgv.tag = 973;

          imgv.y = 13;


     }
     imgv.x = 15;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"fastCar"];
     [self.contentView addSubview:imgv];

     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - 60;
     _titleLb.height = 13;
     _titleLb.x = 15 + imgv.width + imgv.x;
     _titleLb.y = 15;

     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 160;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = _titleLb.y + _titleLb.height + 11;
     _detailLb.x = _titleLb.x;
     _detailLb.textAlignment = NSTextAlignmentLeft;

     UIImageView *imgv2 = [self.contentView viewWithTag:974];
     if (!imgv2) {
          imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 17)];
          imgv2.tag = 974;


     }
      imgv2.y = self.height/2.0 - imgv2.height/2.0;
     imgv2.x = __SCREEN_SIZE.width - 15 - 10;
     //    if (upDown) {
     imgv2.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     [self.contentView addSubview:imgv2];

}


-(void)fitOrderInfoModeG
{
     self.height = 45;
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 18, 15)];
          imgv.tag = 973;
          
          
          
          
     }
     imgv.x = 15;
     imgv.y = self.height/2.0 - imgv.height/2.0;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"fastCar"];
     [self.contentView addSubview:imgv];
     
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - 60;
     _titleLb.height = self.height;
     _titleLb.x = 15 + imgv.width + imgv.x;
     _titleLb.y = 0;
     
     _detailLb.hidden = YES;
     
     UIImageView *imgv2 = [self.contentView viewWithTag:974];
     if (!imgv2) {
          imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 18)];
          imgv2.tag = 974;
     }
     imgv2.x = __SCREEN_SIZE.width - 15 - 10;
     imgv2.y = self.height/2.0 - imgv2.height/2.0;
     //    if (upDown) {
     imgv2.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     [self.contentView addSubview:imgv2];
     
}


-(void)fitOrderInfoModeC
{
     self.height = 81;
     
     
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 18;
     _titleLb.x = 14;
     _titleLb.y = 18;
//     [_titleLb sizeToFit];

     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 16)];
          imgv.tag = 973;
          
          imgv.y = _titleLb.y + _titleLb.height + 11;
          
          
     }
     imgv.x = 15;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"icon_location"];
     [self.contentView addSubview:imgv];
     
     
     _detailLb.textColor = kUIColorFromRGB(color_0x757575);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = _titleLb.y + _titleLb.height + 12;
     _detailLb.x = imgv.width + imgv.x + 12;
     _detailLb.width = __SCREEN_SIZE.width - _detailLb.x - 15;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     
}

-(void)fitOrderInfoModeDD
{
     self.height = 26;

     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 12;

     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 14;
     //    [_detailLb sizeToFit];
     _detailLb.y = 12;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = 110;//__SCREEN_SIZE.width - 36 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;

}

-(void)fitBuyoutInfoMode
{
     self.height = 36;

     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 15;

     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 14;
     //    [_detailLb sizeToFit];
     _detailLb.y = 15;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = 110;//__SCREEN_SIZE.width - 36 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;

}
-(void)fitBuyoutInfoModeB
{
     self.height = 36;

     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 10;

     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 14;
     //    [_detailLb sizeToFit];
     _detailLb.y = 10;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = 110;//__SCREEN_SIZE.width - 36 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;

}

-(void)fitOrderInfoModeD
{
     self.height = 26;
     
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 12;
     
     _detailLb.textColor = kUIColorFromRGB(color_0x48a3ff);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 14;
     //    [_detailLb sizeToFit];
     _detailLb.y = 12;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = 110;//__SCREEN_SIZE.width - 36 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     if ([_detailLb.text containsString:@"天"]) {
           _detailLb.attributedText = [_detailLb richText:@"天" color:kUIColorFromRGB(color_0xb0b0b0)];
     }else if ([_detailLb.text containsString:@"月"])
     {
 _detailLb.attributedText = [_detailLb richText:@"月" color:kUIColorFromRGB(color_0xb0b0b0)];
     }
     else if ([_detailLb.text containsString:@"年"])
     {
          _detailLb.attributedText = [_detailLb richText:@"年" color:kUIColorFromRGB(color_0xb0b0b0)];
     }

}
-(void)fitReplacementOrderInfoMode
{
     self.height = 41;

     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_0xfd7400);
     _titleLb.width = 160;
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.y = 15;
    _titleLb.attributedText = [_titleLb richText:@"支付金额" color:kUIColorFromRGB(color_1)];

     _detailLb.textColor = kUIColorFromRGB(color_7);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = 16;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
}
-(void)fitOrderInfoModeE
{
     self.height = 26;
     
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 6;
     
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 14;
     //    [_detailLb sizeToFit];
     _detailLb.y = 6;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     
}
-(void)fitOrderInfoModeE:(NSString *)str
{
     self.height = 26;

     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 6;

     _detailLb.textColor = kUIColorFromRGB(color_0x48a3ff);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 14;
     //    [_detailLb sizeToFit];
     _detailLb.y = 6;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
_detailLb.attributedText = [_detailLb richText:str color:kUIColorFromRGB(color_0xb0b0b0)];
}
-(void)fitSendBackGoodsMode
{
     self.height = 26;

     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 11;

     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 14;
     //    [_detailLb sizeToFit];
     _detailLb.y = 11;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
}
-(void)fitSendBackGoodsModeA
{
     self.height = 36;

     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 22;

     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 14;
     //    [_detailLb sizeToFit];
     _detailLb.y = 22;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
}
-(void)fitSendBackGoodsModeB
{
     self.height = 45;

     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 16;

     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 14;
     //    [_detailLb sizeToFit];
     _detailLb.y = 16;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
}
-(void)fitSendBackGoodsModeO2
{
     [self fitSendBackGoodsModeO:@"" withY:10];
     self.height = 36;
}
-(void)fitSendBackGoodsModeO:(NSString *)str withY:(CGFloat)y
{


     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.y = y;
   self.height = y + _titleLb.height;
     _detailLb.textColor = kUIColorFromRGB(color_0x48a3ff);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 15;
     //    [_detailLb sizeToFit];
     _detailLb.y = y;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     if (![str isEqualToString:@""]) {
          _detailLb.attributedText = [_detailLb richText:str color:kUIColorFromRGB(color_0xb0b0b0)];
     }

}

-(void)fitOrderInfoModeEB
{
     self.height = 26;

     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 6;

     _detailLb.textColor = kUIColorFromRGB(color_0x48a3ff);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 14;
     //    [_detailLb sizeToFit];
     _detailLb.y = 6;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;

}
-(void)fitOrderInfoModeER
{
     self.height = 26;

     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 6;

     _detailLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 14;
     //    [_detailLb sizeToFit];
     _detailLb.y = 6;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;

}
-(void)fitSendBackGoodsModeW
{
     self.height = 46;

     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 16;
     _titleLb.x = 15;
     _titleLb.y = 16;

     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:15];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 16;
     //    [_detailLb sizeToFit];
     _detailLb.y = 16;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
//     self.height = 41;
//     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
//     _detailLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
//     _titleLb.x = 15;
//     _titleLb.width = 105;
//     _titleLb.textColor = kUIColorFromRGB(color_1);
//     _titleLb.font = [UIFont systemFontOfSize:15];
//     _titleLb.height = 20;
//     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     _detailLb.hidden = YES;
     _textTf.text = _detailLb.text;
     _textTf.hidden = NO;
     _textTf.placeholder = _dataDic[@"placeholder"];

     _textTf.textAlignment = NSTextAlignmentRight;
     _textTf.textColor = kUIColorFromRGB(color_0xb0b0b0);;
     _textTf.font = [UIFont systemFontOfSize:15];
     _textTf.height = 16;
     _textTf.y = 16;//self.height/2.0 - _textTf.height/2.0;
     _textTf.userInteractionEnabled = YES;
     _textTf.x = _detailLb.x;
     _textTf.width = __SCREEN_SIZE.width - _textTf.x - 15;

}
-(void)fitOrderInfoModeFF
{
     self.height = 56;

     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 16;
     _titleLb.x = 15;
     _titleLb.y = 20;

     _detailLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _detailLb.font = [UIFont systemFontOfSize:18];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 19;
     //    [_detailLb sizeToFit];
     _detailLb.y = 10;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;

     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 1;
          lb.height = 58;
          lb.tag = 12113;
     }

//     lb.backgroundColor = kUIColorFromRGB(color_0xb0b0b0);
     lb.x = _detailLb.x;
     lb.width = _detailLb.width;
     lb.height = 13;
     lb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     lb.font = [UIFont systemFontOfSize:12];
     lb.text = _dataDic[@"detail2"];
      lb.textAlignment = NSTextAlignmentRight;
     lb.y = _detailLb.y + _detailLb.height + 5;
     [self.contentView addSubview:lb];
   
}

-(void)fitSecondCallMode
{
     self.height = 70;

     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 16;
     _titleLb.x = 15;
     _titleLb.y = 15;
     [_titleLb sizeToFit];

     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 14;
     //    [_detailLb sizeToFit];
     _detailLb.y = _titleLb.y + _titleLb.height + 14;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  _titleLb.x;//__SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentLeft;

     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 1;
          lb.height = 58;
          lb.tag = 12113;
     }

     lb.width = 60;
     lb.height = 16;
     lb.x = __SCREEN_SIZE.width - 15 - lb.width;

     lb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     lb.font = [UIFont systemFontOfSize:15];
     lb.text = _dataDic[@"detail2"];
     lb.textAlignment = NSTextAlignmentRight;
     lb.y = 29;
     [self.contentView addSubview:lb];

     UILabel *lb3 = [self.contentView viewWithTag:2113];
     if (!lb3) {
          lb3 = [UILabel new];
          lb3.width = 1;
          lb3.height = 58;
          lb3.tag = 2113;
     }

     lb3.width = 100;
     lb3.height = 16;
     lb3.x = _titleLb.x + _titleLb.width + 2;

     lb3.textColor = kUIColorFromRGB(color_0xf82D45);
     lb3.font = [UIFont systemFontOfSize:15];
     lb3.text = _dataDic[@"detail3"];
     lb3.textAlignment = NSTextAlignmentLeft;
     lb3.y = 16;
     [self.contentView addSubview:lb3];

}
-(void)fitSecondCallModeB
{
     self.height = 30;

     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 16;

     _detailLb.textColor = kUIColorFromRGB(color_0x48a3ff);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     [_detailLb strikeout];
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 15;
     //    [_detailLb sizeToFit];
     _detailLb.y = 16;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     if ([_detailLb.text containsString:@"天"]) {
          _detailLb.attributedText = [_detailLb richText:@"天" color:kUIColorFromRGB(color_0xb0b0b0)];
     }else if ([_detailLb.text containsString:@"月"])
     {
          _detailLb.attributedText = [_detailLb richText:@"月" color:kUIColorFromRGB(color_0xb0b0b0)];
     }
     else if ([_detailLb.text containsString:@"年"])
     {
          _detailLb.attributedText = [_detailLb richText:@"年" color:kUIColorFromRGB(color_0xb0b0b0)];
     }
}

-(void)fitSecondCallModeBC
{
     self.height = 41;

     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 15;

     _detailLb.textColor = kUIColorFromRGB(color_0x48a3ff);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     [_detailLb strikeout];
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 15;
     //    [_detailLb sizeToFit];
     _detailLb.y = 16;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
     if ([_detailLb.text containsString:@"元/天"]) {
          _detailLb.attributedText = [_detailLb richText:@"/天" color:kUIColorFromRGB(color_0xb0b0b0)];
     }else if ([_detailLb.text containsString:@"月"])
     {
          _detailLb.attributedText = [_detailLb richText:@"月" color:kUIColorFromRGB(color_0xb0b0b0)];
     }
     else if ([_detailLb.text containsString:@"年"])
     {
          _detailLb.attributedText = [_detailLb richText:@"年" color:kUIColorFromRGB(color_0xb0b0b0)];
     }
}

-(void)fitOrderInfoModeF
{
     self.height = 35;
     
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 6;
     
     _detailLb.textColor = kUIColorFromRGB(color_0x48a3ff);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);

     _detailLb.width = 100;//__SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 15;
         [_detailLb sizeToFit];
     _detailLb.y = 6;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
  [_detailLb strikeout];
}

-(void)fitOrderInfoModeFC
{
     self.height = 35;

     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.y = 6;

     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);

     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 15;
     //    [_detailLb sizeToFit];
     _detailLb.y = 6;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x =  __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;

}

-(void)fitVipCenterMode
{
     self.height = 35;
     
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.y = 11;
     
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:12];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 110 - 15;;
     _detailLb.hidden = NO;
     _detailLb.height = 12;
     //    [_detailLb sizeToFit];
     _detailLb.y = 12;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
}

-(void)fitTraceOrderModeA
{
     self.height = 84;
     
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - 70;
     _titleLb.height = 13;
     _titleLb.x = 61;
     _titleLb.y = 16;
     
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 70;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = _titleLb.y + _titleLb.height + 10;
     _detailLb.x = _titleLb.x;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
          imgv.tag = 973;
          
          imgv.y = 16;
          
          
     }
     imgv.x = 29;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"traceB"];
     imgv.highlightedImage = [UIImage imageContentWithFileName:@"traceA"];
     imgv.highlighted = [_dataDic[@"isCheck"] boolValue];
     [self.contentView addSubview:imgv];
     
     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 1;
          lb.height = 58;
          lb.tag = 12113;
     }

     lb.backgroundColor = kUIColorFromRGB(color_0xb0b0b0);
     lb.x = 35;
     lb.y = imgv.y + imgv.height;
     [self.contentView addSubview:lb];

}

-(void)fitTraceOrderModeB
{
     self.height = 67;
     
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - 70;
     _titleLb.height = 13;
     _titleLb.x = 61;
     _titleLb.y = 0;
     
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 70;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = _titleLb.y + _titleLb.height + 10;
     _detailLb.x = _titleLb.x;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
          imgv.tag = 973;
          
          imgv.y = 0;
          
          
     }
     imgv.x = 29;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"traceB"];
     imgv.highlightedImage = [UIImage imageContentWithFileName:@"traceA"];
     imgv.highlighted = [_dataDic[@"isCheck"] boolValue];
     [self.contentView addSubview:imgv];
     
     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 1;
          lb.height = 55;
          lb.tag = 12113;
     }
     
     lb.backgroundColor = kUIColorFromRGB(color_0xb0b0b0);
     lb.x = 35;
     lb.y = imgv.y + imgv.height;
     [self.contentView addSubview:lb];

}

-(void)fitSignMode
{
     self.height = 60;
     
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 12;
     //    [_titleLb sizeToFit];
     _titleLb.x = 15;
     _titleLb.y = 16;
     
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:12];
     self.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _detailLb.width =__SCREEN_SIZE.width - 30;
     _detailLb.numberOfLines = 2;
     _detailLb.hidden = NO;
     _detailLb.height = 34;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.y = 34;
     _detailLb.x = 15;
}


-(void)fitCartMode:(BOOL)isSelected
{
     self.height = 45;
     
     
     
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = __SCREEN_SIZE.width - 60;
     _titleLb.height = self.height;
     //    [_titleLb sizeToFit];
     _titleLb.x = 45;
     _titleLb.y = 0;
     
     _detailLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _detailLb.font = [UIFont systemFontOfSize:15];
     _detailLb.width =__SCREEN_SIZE.width - 30;
     _detailLb.numberOfLines = 1;
     _detailLb.width = __SCREEN_SIZE.width - 30;
     _detailLb.height = self.height;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.y = 0;
     _detailLb.x = 15;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     
     
     UIButton *btn = [self.contentView viewWithTag:1113];
     if(!btn)
     {
          btn = [UIButton new];
          btn.tag = 13312;
          btn.layer.borderWidth = 0;
          [btn setTitle:nil forState:UIControlStateNormal];
          
          btn.height = 45;
          btn.width = 45;
          btn.x = 0;
          btn.y = 0;
     }
    
     [self.contentView addSubview:btn];
     [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
     
     if (isSelected) {
          [btn setImage:[UIImage imageContentWithFileName:@"icon_selected"] forState:UIControlStateNormal];
     }else{
          [btn setImage:[UIImage imageContentWithFileName:@"icon_unselected"] forState:UIControlStateNormal];
     }
     
}

-(void)fitAuditProgressModeA
{
     self.height = 84;
     
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - 70;
     _titleLb.height = 13;
     _titleLb.x = 60;
     _titleLb.y = 16;
     
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 70;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = _titleLb.y + _titleLb.height + 9;
     _detailLb.x = _titleLb.x;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
          imgv.tag = 973;
          
          imgv.y = 16;
          
          
     }
     imgv.x = 29;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"traceB"];
     imgv.highlightedImage = [UIImage imageContentWithFileName:@"traceA"];
     imgv.highlighted = [_dataDic[@"isCheck"] boolValue];
     [self.contentView addSubview:imgv];
     
     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 1;
          lb.height = 58;
          lb.tag = 12113;
     }
     
     lb.backgroundColor = kUIColorFromRGB(color_0xb0b0b0);
     lb.x = 35;
     lb.y = imgv.y + imgv.height;
     [self.contentView addSubview:lb];
     
     UILabel *lb2 = [self.contentView viewWithTag:12123];
     if (!lb2) {
          lb2 = [UILabel new];
          lb2.width = 200;
          lb2.height = 13;
          lb2.tag = 12123;
     }
     lb2.text = _dataDic[@"detail2"];
     lb2.textColor = kUIColorFromRGB(color_0xb0b0b0);
     lb2.font = [UIFont systemFontOfSize:13];
     lb2.x = 60;
     lb2.y = _detailLb.y + _detailLb.height + 10;
     [self.contentView addSubview:lb2];
     
}

-(void)fitAuditProgressModeB
{
     self.height = 68;
     
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - 70;
     _titleLb.height = 13;
     _titleLb.x = 60;
     _titleLb.y = 0;
     
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width - 70;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     //    [_detailLb sizeToFit];
     _detailLb.y = _titleLb.y + _titleLb.height + 9;
     _detailLb.x = _titleLb.x;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
          imgv.tag = 973;
          
          imgv.y = 0;
          
          
     }
     imgv.x = 29;
     //    if (upDown) {
     imgv.image = [UIImage imageContentWithFileName:@"traceB"];
     imgv.highlightedImage = [UIImage imageContentWithFileName:@"traceA"];
     imgv.highlighted = [_dataDic[@"isCheck"] boolValue];
     [self.contentView addSubview:imgv];
     
     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 1;
          lb.height = 55;
          lb.tag = 12113;
     }
     
     lb.backgroundColor = kUIColorFromRGB(color_0xb0b0b0);
     lb.x = 35;
     lb.y = imgv.y + imgv.height;
     [self.contentView addSubview:lb];
     
     UILabel *lb2 = [self.contentView viewWithTag:12123];
     if (!lb2) {
          lb2 = [UILabel new];
          lb2.width = 200;
          lb2.height = 13;
          lb2.tag = 12123;
     }
     lb2.text = _dataDic[@"detail2"];
     lb2.textColor = kUIColorFromRGB(color_0xb0b0b0);
     lb2.font = [UIFont systemFontOfSize:13];
     lb2.x = 60;
     lb2.y = _detailLb.y + _detailLb.height + 10;
     [self.contentView addSubview:lb2];
     
}

-(void)fitAuditProgressModeC
{
     self.height = 59;
     
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 15;
     //    [_titleLb sizeToFit];
     _titleLb.x = 15;
     _titleLb.y = 16;
     
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:15];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width =__SCREEN_SIZE.width - 30;
     _detailLb.numberOfLines = 1;
     _detailLb.hidden = NO;
     _detailLb.height = 15;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.y = 34;
     _detailLb.x = 15;
}
-(void)fitSelledSeverModeB
{
     [self fitSelledSeverMode];
      _detailLb.textColor = kUIColorFromRGB(color_5);
}
-(void)fitSelledSeverMode
{
     self.height = 35;
     
     _titleLb.font = [UIFont systemFontOfSize:13];
        _detailLb.font = [UIFont systemFontOfSize:13];
       _detailLb.height = 15;
       _titleLb.height = 15;
//     if (__SCREEN_SIZE.width == 320) {
//          _titleLb.font = [UIFont systemFontOfSize:11];
//          _detailLb.font = [UIFont systemFontOfSize:11];
//     }
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;

     _titleLb.x = 15;
     _titleLb.y = 9;
       [_titleLb sizeToFit];
     _detailLb.textColor = kUIColorFromRGB(color_0xf82D45);

     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = __SCREEN_SIZE.width/2.0 ;
     _detailLb.hidden = NO;

     _detailLb.y = 9;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentRight;
}

-(void)fitRecordInfoMode
{
     self.height = 112;
     
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 15;
     //    [_titleLb sizeToFit];
     _titleLb.x = 15;
     _titleLb.y = 11;
     
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:15];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width =__SCREEN_SIZE.width - 30;
     _detailLb.numberOfLines = 1;
     _detailLb.hidden = NO;
     _detailLb.height = 15;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.y = 35;
     _detailLb.x = 15;
}

-(void)fitSeverMsgMode
{
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 13;
     //    [_titleLb sizeToFit];
     _titleLb.x = 15;
     _titleLb.y = 11;
     
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width =__SCREEN_SIZE.width - 30;
     _detailLb.numberOfLines = 0;
     _detailLb.hidden = NO;
     _detailLb.height = 34;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.y = 35;
     _detailLb.x = 15;
     [_detailLb sizeToFit];
     self.height = 80;
}

-(void)fitSysMsgMode
{
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 13;
     //    [_titleLb sizeToFit];
     _titleLb.x = 15;
     _titleLb.y = 11;
     
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width =__SCREEN_SIZE.width - 30;
     _detailLb.numberOfLines = 2;
     _detailLb.hidden = NO;
     _detailLb.height = 29;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.y = 34;
     _detailLb.x = 15;
     [_detailLb sizeToFit];
     self.height = 80;
     UIImageView *imgv = [self.contentView viewWithTag:9322];
     if (!imgv) {
          imgv = [UIImageView new];
          imgv.width = 7;
          imgv.height = 7;
          imgv.y = 15;
          imgv.x = __SCREEN_SIZE.width - 15 - imgv.width;
          imgv.tag = 9322;
          imgv.backgroundColor = kUIColorFromRGB(color_0xf82D45);
          imgv.layer.cornerRadius = imgv.height/2.0;
          imgv.layer.masksToBounds = YES;

     }
     [self.contentView addSubview:imgv];
     if (![_dataDic[@"isR"] boolValue]) {
          imgv.hidden = NO;
     }
     else
     {
          imgv.hidden =YES;
     }
}
-(void)fitMsgMode
{
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.width = __SCREEN_SIZE.width - 60;
     _titleLb.height = 50;
     _titleLb.numberOfLines = 0;
         [_titleLb sizeToFit];
     _titleLb.x = 15;
     _titleLb.y = 10;

     _detailLb.textColor = kUIColorFromRGB(color_7);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width =__SCREEN_SIZE.width - 60;
     _detailLb.numberOfLines = 1;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.y = 77;
     _detailLb.x = __SCREEN_SIZE.width - 30 - 15 - _detailLb.width;

     UIImageView *topLine = [self.contentView viewWithTag:1002];
     if (!topLine) {
          topLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width - 30, 2)];
          topLine.backgroundColor = kUIColorFromRGB(color_3);
          topLine.tag = 1002;

     }


     UIImageView *leftLine = [self.contentView viewWithTag:1001];
     if (!leftLine) {
          leftLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 65, __SCREEN_SIZE.width - 30, 0.5)];
          leftLine.backgroundColor = kUIColorFromRGB(color_lineColor);
          leftLine.tag = 1001;

     }
     self.height = 100;

     UIView *containerView = [self.contentView viewWithTag:10000];
     if (!containerView) {
          containerView = [UIView new];
          containerView.height = 100;
          containerView.width = __SCREEN_SIZE.width - 30;
          containerView.tag = 10000;
          containerView.x = 15;
          containerView.backgroundColor = kUIColorFromRGB(color_2);
     }
     [containerView addSubview:_titleLb];
     [containerView addSubview:_detailLb];
     [self.contentView addSubview:containerView];
       [containerView addSubview:topLine];
       [containerView addSubview:leftLine];
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf5f5f5);
}
-(void)fitActMsgMode
{
     self.height = 32;
     
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 160;
     _titleLb.height = 13;
     _titleLb.x = 15;
     _titleLb.y = 10;
     
     _detailLb.textColor = kUIColorFromRGB(color_2);
     if ([_detailLb.text isEqualToString: @"进行中" ]) {
             _detailLb.backgroundColor = kUIColorFromRGB(color_3);
     }
       else if([_detailLb.text isEqualToString: @"已结束" ])
       {
         _detailLb.backgroundColor = kUIColorFromRGB(color_5);
       }
     _detailLb.layer.cornerRadius = 6;
     _detailLb.layer.masksToBounds = YES;
     _detailLb.font = [UIFont systemFontOfSize:12];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 50;
     _detailLb.hidden = NO;
     _detailLb.height = 20;
     //    [_detailLb sizeToFit];
     _detailLb.y = 7;//self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentCenter;
}

- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
     NSInteger num = newScorePercent * 5;
     if (self.handleAction) {
          self.handleAction(@{@"score":@(num)});
     }
}


-(void)fitPublishEvaMode
{
     self.height = 46;
     
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 120;
     _titleLb.height = 15;
     _titleLb.x = 30;
     _titleLb.y = 21;
     if (!_starView) {
          _starView = [[CWStarRateView alloc]initWithFrame:CGRectMake(111, 21, 112, 16) numberOfStars:5 withImg:@"eva_unLove" withHimg:@"eva_love"];
          _starView.scorePercent = 1.0;
          _starView.delegate = self;
          [self.contentView addSubview:_starView];
     }
     _detailLb.width = 128;
     _detailLb.height = 15;
     _detailLb.font = [UIFont systemFontOfSize:15];
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.x = __SCREEN_SIZE.width - 30 - _detailLb.width;
     _detailLb.y = 21;
     
     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = __SCREEN_SIZE.width - 30;
          lb.height = 36;
          lb.tag = 12113;
     }
     
     lb.backgroundColor = kUIColorFromRGB(color_2);
     lb.x = 15;
     lb.y = 10;
     lb.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     lb.layer.borderWidth = 0.5;
     [self.contentView insertSubview:lb atIndex:0];
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(void)fitAwardRecordMode
{
     self.height = 40;
     
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     _titleLb.width = 150;
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     
     
     _detailLb.font = [UIFont systemFontOfSize:15];
      _detailLb.textColor = kUIColorFromRGB(color_0x757575);
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = 150;
     _detailLb.hidden = NO;
     _detailLb.height = 15;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width - 15 - _detailLb.width;
     _detailLb.textAlignment = NSTextAlignmentCenter;
}

-(void)fitAwardRecordModeB
{
     self.height = 30;
     
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     _titleLb.width = __SCREEN_SIZE.width/2.0;
     _titleLb.height = 15;
     _titleLb.x = 0;
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     
     _detailLb.font = [UIFont systemFontOfSize:15];
     _detailLb.textColor = kUIColorFromRGB(color_0x757575);
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width = _titleLb.width;
     _detailLb.hidden = NO;
     _detailLb.height = 15;
     //    [_detailLb sizeToFit];
     _detailLb.y = self.height/2.0 - _detailLb.height/2.0;
     _detailLb.x = __SCREEN_SIZE.width/2.0;
     _detailLb.textAlignment = NSTextAlignmentCenter;
}

-(void)fitSysMsgInfoMode
{
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 15;
     //    [_titleLb sizeToFit];
     _titleLb.x = 15;
     _titleLb.y = 10;
         _titleLb.textAlignment = NSTextAlignmentCenter;
     
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:13];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width =__SCREEN_SIZE.width - 30;
     _detailLb.numberOfLines = 1;
     _detailLb.hidden = NO;
     _detailLb.height = 13;
     _detailLb.textAlignment = NSTextAlignmentCenter;
     _detailLb.y = 33;
     _detailLb.x = 15;
     self.height = 55;
}

-(void)fitVipHelpMode:(CGFloat)height withDetailHeight:(CGFloat)dh
{
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = __SCREEN_SIZE.width - 15 - 49;
     _titleLb.height = 13;
     //    [_titleLb sizeToFit];
     _titleLb.x = 49;
     _titleLb.y = 10;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:12];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width =__SCREEN_SIZE.width - 15 - 49;
     _detailLb.numberOfLines = 0;
     _detailLb.hidden = NO;
     _detailLb.height = dh;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.y = 31;
     _detailLb.x = 49;
     self.height = height;
     
     UIImageView *imgv = [self.contentView viewWithTag:9222];
     if (!imgv) {
          imgv = [UIImageView new];
          imgv.width = 20;
          imgv.height = 23;
          imgv.y = 10;
          imgv.x = 15;
          imgv.tag = 9222;
          
     
     }
     imgv.image = [UIImage imageContentWithFileName:_dataDic[@"img"]];
     imgv.contentMode = UIViewContentModeTopLeft;
     [self.contentView addSubview:imgv];
}

-(void)fitTopicMode
{
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.textColor = kUIColorFromRGB(color_3);
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 12;
         [_titleLb sizeToFit];
     _titleLb.x = 15;
     _titleLb.y = 5;
     _titleLb.attributedText = [_titleLb richText:@"分类：" color:kUIColorFromRGB(color_5)];
     
     _detailLb.textColor = kUIColorFromRGB(color_3);
     _detailLb.font = [UIFont systemFontOfSize:12];
     self.backgroundColor = kUIColorFromRGB(color_2);
     _detailLb.width =__SCREEN_SIZE.width - 30;
     _detailLb.numberOfLines = 1;
     _detailLb.hidden = NO;
     _detailLb.height = 12;
     _detailLb.textAlignment = NSTextAlignmentLeft;
   _detailLb.attributedText = [_detailLb richText:@"标签：" color:kUIColorFromRGB(color_5)];
     [_detailLb sizeToFit];
     _detailLb.y = 5;
     _detailLb.x = _titleLb.x + _titleLb.width + 15;
     self.height = 28;
}
@end
