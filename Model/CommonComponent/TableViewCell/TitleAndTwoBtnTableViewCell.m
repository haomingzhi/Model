//
//  TitleAndTwoBtnTableViewCell.m
//  compassionpark
//
//  Created by air on 2017/4/10.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleAndTwoBtnTableViewCell.h"

@implementation TitleAndTwoBtnTableViewCell
{
    IBOutlet UIButton *_btnA;
    IBOutlet UILabel *_titleLb;
     NSDictionary *_dataDic;
    IBOutlet UIButton *_btnB;
     UIButton *_curBtn;
     UIImageView *_lineImgV;
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
    _titleLb.text = dataDic[@"title"];
    [_btnA setTitle:dataDic[@"btnA"] forState:UIControlStateNormal];
     [_btnB setTitle:dataDic[@"btnB"] forState:UIControlStateNormal];
     _dataDic = dataDic;
}
- (IBAction)btnHandle:(id)sender {
    if (self.handleAction) {
        self.handleAction(@{@"obj":sender});
    }
}

-(void)fitOrderInfoMode
{
     self.height = 40;
     self.contentView.backgroundColor = kUIColorFromRGB(color_4);
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.y = 0;
     _titleLb.width = 157;
     _titleLb.height = 40;
     _btnA.y = 5;
     _btnB.y = 5;
     _btnA.width = 80;
     _btnB.width = 80;
     _btnA.height = 30;
     _btnB.height = 30;
     _btnA.layer.cornerRadius = 4;
     _btnA.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
     _btnA.layer.borderWidth = 0.5;
     
     _btnB.layer.cornerRadius = 4;
     _btnB.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
     _btnB.layer.borderWidth = 0.5;
     
     [_btnA setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
     [_btnB setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
     
     _btnA.titleLabel.font = [UIFont systemFontOfSize:14];
     _btnB.titleLabel.font = [UIFont systemFontOfSize:14];
     _btnB.x = __SCREEN_SIZE.width - 15 - _btnB.width;
     _btnA.hidden = NO;
     _btnA.x = _btnB.x - 20 - _btnA.width;
     _btnB.backgroundColor = [UIColor clearColor];
     _btnA.tag = 100;
     _btnB.tag = 101;
}


-(void)fitInvoiceModeA
{
     self.height = 40;
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.y = 0;
     _titleLb.width = 150;
     _titleLb.height = self.height;
     
     _btnA.y = 0;
     _btnB.y = 0;
     _btnA.width = 85;
     _btnB.width = 145;
     _btnA.height = self.height;
     _btnB.height = self.height;
     _btnA.x = 120;
     _btnB.x = _btnA.x + _btnA.width +10;
     
//     [_btnA setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
//     [_btnB setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
//
//     _btnA.titleLabel.font = [UIFont systemFontOfSize:14];
//     _btnB.titleLabel.font = [UIFont systemFontOfSize:14];
//     _btnB.x = __SCREEN_SIZE.width - 15 - _btnB.width;
//     _btnA.hidden = NO;
//     _btnA.x = _btnB.x - 20 - _btnA.width;
//     _btnB.backgroundColor = [UIColor clearColor];
     _btnA.customImgV.x = 0;
     _btnA.customImgV.y = 12.5;
     _btnA.customImgV.width = 15;
     _btnA.customImgV.height = 15;
     _btnA.customTitleLb.x = 25;
     _btnA.customTitleLb.y = 0;
     _btnA.customTitleLb.width = _btnA.width - 25;
     _btnA.customTitleLb.height = _btnA.height;
     _btnA.customTitleLb.font = [UIFont systemFontOfSize:14];
     [_btnA setTitle:@"" forState:UIControlStateNormal];
      [_btnB setTitle:@"" forState:UIControlStateNormal];
      _btnA.customTitleLb.text = _dataDic[@"btnA"];
     
     _btnB.customImgV.x = 0;
     _btnB.customImgV.y = 12.5;
     _btnB.customImgV.width = 15;
     _btnB.customImgV.height = 15;
     _btnB.customTitleLb.x = 25;
     _btnB.customTitleLb.y = 0;
     _btnB.customTitleLb.width = _btnB.width - 25;
     _btnB.customTitleLb.height = _btnB.height;
     _btnB.customTitleLb.textAlignment = NSTextAlignmentLeft;
     _btnB.customTitleLb.font = [UIFont systemFontOfSize:14];
     _btnB.customTitleLb.text = _dataDic[@"btnB"];
     if ([_dataDic[@"isPerson"] boolValue]) {
          _btnB.customImgV.image = [UIImage imageNamed:@"icon_selected"];
          _btnA.customImgV.image = [UIImage imageNamed:@"icon_unselected"];
     }else{
          _btnA.customImgV.image = [UIImage imageNamed:@"icon_selected"];
          _btnB.customImgV.image = [UIImage imageNamed:@"icon_unselected"];
     }

     
     
}

-(void)fitOrderInfoModeA
{
    [self fitOrderInfoMode];
    _btnB.backgroundColor = kUIColorFromRGB(color_3);
}




-(void)fitOrderInfoModeB
{
    [self fitOrderInfoMode];
    _btnA.hidden = YES;

}

-(void)fitPersonInfoMode
{
     self.height = 44;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.y = 15;
     _titleLb.width = 60;
     _titleLb.height = 15;
     
     
     _btnA.y = 0;
     _btnB.y = 0;
     _btnA.width = 40;
     _btnB.width = 40;
     _btnA.height = 40;
     _btnB.height = 40;

     [_btnA fitImgAndTitleMode];
     [_btnB fitImgAndTitleMode];

     [self setBtnFitMode:_btnA];
      [self setBtnFitMode:_btnB];
     _btnB.x = 180;
     _btnA.hidden = NO;
     _btnA.x = 130;
     if ([_dataDic[@"sex"] integerValue] == 0) {
          _btnA.customImgV.highlighted = YES;
              _btnB.customImgV.highlighted = NO;
     }
     else
          {
               _btnA.customImgV.highlighted = NO;
                _btnB.customImgV.highlighted = YES;
          }
}


-(void)setBtnFitMode:(UIButton *)btn
{
     btn.customTitleLb.x = 24;
     btn.customTitleLb.y = 16;
     btn.customTitleLb.width = 15;
     btn.customTitleLb.height = 14;
       btn.customTitleLb.font = [UIFont systemFontOfSize:15];
     
     btn.customImgV.y = 14;
     btn.customImgV.x = 0;
     btn.customImgV.width = 15;
     btn.customImgV.height = 15;
     btn.customImgV.image = [UIImage imageContentWithFileName:@"unCheck"];
     btn.customImgV.highlightedImage = [UIImage imageContentWithFileName:@"check"];
}


-(void)fitInvoiceMode
{
     
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.y = 15;
     _titleLb.width = 200;
     _titleLb.height = 15;
     
     _btnA.y = 38;
     _btnB.y = 38;
     _btnA.width = 136;
     _btnB.width = 136;
     _btnA.height = 30;
     _btnB.height = 30;
     _btnA.layer.cornerRadius = 4;
     _btnA.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _btnA.layer.borderWidth = 0.0;
     _btnA.backgroundColor = kUIColorFromRGB(color_3);
     [_btnA setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     
     _btnB.layer.cornerRadius = 4;
     _btnB.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _btnB.layer.borderWidth = 0.5;
     [_btnB setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
     
     _btnA.titleLabel.font = [UIFont systemFontOfSize:15];
     _btnB.titleLabel.font = [UIFont systemFontOfSize:15];
     _btnB.x = __SCREEN_SIZE.width - 15 - _btnB.width;
     _btnA.x = 15;
     
     [_btnA addTarget:self action:@selector(btnAAction:) forControlEvents:UIControlEventTouchUpInside];
     [_btnB addTarget:self action:@selector(btnBAction:) forControlEvents:UIControlEventTouchUpInside];
     
     
     UILabel *warnLb = [self.contentView viewWithTag:1724];
     if (!warnLb) {
          warnLb = [UILabel new];
          warnLb.font = [UIFont systemFontOfSize:12];
          warnLb.tag = 1724;
          warnLb.textAlignment = NSTextAlignmentLeft;
          warnLb.textColor = kUIColorFromRGB(color_7);
          [self.contentView addSubview:warnLb];
          warnLb.text = @"电子发票即电子增值税发票，是税局认可的有效凭证，其法律效力、基本用途及使用规定同纸质发票";
          warnLb.numberOfLines = 0;
          warnLb.height = 21;
          warnLb.width = __SCREEN_SIZE.width -30;
          warnLb.x = 15;
          warnLb.y = 80;
          [warnLb sizeToFit];
     }
     
     
     if ([_dataDic[@"type"] integerValue] == 0) {
          _btnB.layer.borderWidth = 0.5;
          _btnB.backgroundColor = kUIColorFromRGB(color_2);
          [_btnB setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
          
          _btnA.layer.borderWidth = 0.0;
          _btnA.backgroundColor = kUIColorFromRGB(color_3);
          [_btnA setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          _curBtn = _btnA;
          warnLb.hidden = NO;
          self.height = 120;
     }else{
          _btnA.layer.borderWidth = 0.5;
          _btnA.backgroundColor = kUIColorFromRGB(color_2);
          [_btnA setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
          
          _btnB.layer.borderWidth = 0.0;
          _btnB.backgroundColor = kUIColorFromRGB(color_3);
          [_btnB setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          _curBtn = _btnB;
          warnLb.hidden = YES;
          self.height = 85;
     }
}

-(void)btnAAction:(UIButton *)sender{
     if (_curBtn != sender) {
          _curBtn.layer.borderWidth = 0.5;
          _curBtn.backgroundColor = kUIColorFromRGB(color_2);
          [_curBtn setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
          
          sender.layer.borderWidth = 0.0;
          sender.backgroundColor = kUIColorFromRGB(color_3);
          [sender setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          
          _curBtn = sender;
           UILabel *warnLb = [self.contentView viewWithTag:1724];
          warnLb.hidden = NO;
          if (self.handleAction) {
               self.handleAction(@{@"index":@"0"});
          }
     }
}

-(void)btnBAction:(UIButton *)sender{
     if (_curBtn != sender) {
          _curBtn.layer.borderWidth = 0.5;
          _curBtn.backgroundColor = kUIColorFromRGB(color_2);
          [_curBtn setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
          
          sender.layer.borderWidth = 0.0;
          sender.backgroundColor = kUIColorFromRGB(color_3);
          [sender setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          
          _curBtn = sender;
          UILabel *warnLb = [self.contentView viewWithTag:1724];
          warnLb.hidden = YES;
          if (self.handleAction) {
               self.handleAction(@{@"index":@"1"});
          }
     }
}


-(void)fitEvaMode
{
     self.height = 70;
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.y = 15;
     _titleLb.width = __SCREEN_SIZE.width -30;
     _titleLb.height = 13;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     
     _btnA.y = 35;
     _btnB.y = 35;
     _btnA.width = __SCREEN_SIZE.width/2.0;
     _btnB.width =  __SCREEN_SIZE.width/2.0;
     _btnA.height = 35;
     _btnB.height = 35;
    
     [_btnA setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     [_btnB setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
     
     _btnA.titleLabel.font = [UIFont systemFontOfSize:13];
     _btnB.titleLabel.font = [UIFont systemFontOfSize:13];
     _btnB.x = __SCREEN_SIZE.width/2.0;
     _btnA.x = 0;
     
     [_btnA addTarget:self action:@selector(btnAEvaAction:) forControlEvents:UIControlEventTouchUpInside];
     [_btnB addTarget:self action:@selector(btnBevaAction:) forControlEvents:UIControlEventTouchUpInside];
     _curBtn = _btnA;
     
     
     if (!_lineImgV) {
          _lineImgV = [UIImageView new];
          _lineImgV.height = 2;
          _lineImgV.width = __SCREEN_SIZE.width/2.0;
          _lineImgV.x = 0;
          _lineImgV.y = 68;
          _lineImgV.backgroundColor = kUIColorFromRGB(color_3);
          [self.contentView addSubview:_lineImgV];
     }
     
}


-(void)btnAEvaAction:(UIButton *)sender{
     if (_curBtn != sender) {
          [_curBtn setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];

          [sender setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
          _lineImgV.x = 0;
          _curBtn = sender;
          if (self.handleAction) {
               self.handleAction(@{@"index":@"0"});
          }
     }
}

-(void)btnBevaAction:(UIButton *)sender{
     if (_curBtn != sender) {
          [_curBtn setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
          [sender setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
          _curBtn = sender;
           _lineImgV.x = __SCREEN_SIZE.width/2.0;
          if (self.handleAction) {
               self.handleAction(@{@"index":@"1"});
          }
     }
}


@end
