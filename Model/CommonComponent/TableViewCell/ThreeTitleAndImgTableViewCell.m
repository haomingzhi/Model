//
//  TwoTitleAndImgTableViewCell.m
//  deliciousfood
//
//  Created by Steve on 2017/2/23.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ThreeTitleAndImgTableViewCell.h"

@implementation ThreeTitleAndImgTableViewCell{
     NSMutableDictionary *_dataDic;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic{
     _dataDic = dataDic;
    if (dataDic[@"titleA"]) {
        _titleA.text = dataDic[@"titleA"];
    }
    if (dataDic[@"titleB"]) {
        _titleB.text = dataDic[@"titleB"];
    }
     
     if (dataDic[@"titleC"]) {
          _titleC.text = dataDic[@"titleC"];
     }
}


-(void)fitCellMode{
     self.height = 30;
     
     _imgVA.x = 15;
     _imgVA.y = self.height/2.0 - _imgVA.height/2.0;
     _titleA.x = _imgVA.x +_imgVA.width +12;
     _titleA.y = self.height/2.0 - _titleA.height/2.0;
     
     _imgVB.width = 14;
     _imgVB.height = 9;
    _imgVB.x = 80;
    _imgVB.y = self.height/2.0 - _imgVB.height/2.0;
    _titleB.x = _imgVB.x +_imgVB.width +10;
    _titleB.y = _imgVB.y;
    _titleB.height = _imgVB.height;

     [_titleC sizeToFit];
     _titleC.x = __SCREEN_SIZE.width - 15 - _titleC.width;
     _titleC.y = self.height/2.0 - _titleC.height/2.0;
     
     _imgVC.x = _titleC.x - 10 - _imgVC.width;
     _imgVC.y =  self.height/2.0 - _imgVC.height/2.0;
    
}


-(void)fitEvaMode{
     self.height = 30;
     
     _imgVA.x = __SCREEN_SIZE.width-126-_imgVA.width;
     _imgVA.y = self.height/2.0 - _imgVA.height/2.0;
     _titleA.x = _imgVA.x +_imgVA.width +10;
     _titleA.y = self.height/2.0 - _titleA.height/2.0;
     
     _imgVB.hidden = YES;

     _titleB.x = 15;
     _titleB.y = 0;
     _titleB.height = 30;
     _titleB.width = 200;
     
     [_titleC sizeToFit];
     _titleC.x = __SCREEN_SIZE.width - 15 - _titleC.width;
     _titleC.y = self.height/2.0 - _titleC.height/2.0;
     
     _imgVC.x = _titleC.x - 10 - _imgVC.width;
     _imgVC.y =  self.height/2.0 - _imgVC.height/2.0;
     
     _titleA.textColor = kUIColorFromRGB(color_8);
     _titleB.textColor = kUIColorFromRGB(color_8);
     _titleC.textColor = kUIColorFromRGB(color_8);
     
}

-(void)fitNoCashApproveMode
{
     
}
-(void)fitTopicHomeMode{
     self.height = 30;
     
     _imgVA.x = __SCREEN_SIZE.width-126-_imgVA.width;
     _imgVA.y = self.height/2.0 - _imgVA.height/2.0;
     _titleA.x = _imgVA.x +_imgVA.width +10;
     _titleA.y = self.height/2.0 - _titleA.height/2.0;
     
     _imgVB.x = __SCREEN_SIZE.width-196-_imgVB.width;
     _imgVB.y = self.height/2.0 - _imgVB.height/2.0;
     

     _titleB.x = _imgVB.x +_imgVB.width +10;
     _titleB.y = self.height/2.0 - _titleC.height/2.0;
     
     [_titleC sizeToFit];
     _titleC.x = __SCREEN_SIZE.width - 15 - _titleC.width;
     _titleC.y = self.height/2.0 - _titleC.height/2.0;
     
     _imgVC.x = _titleC.x - 10 - _imgVC.width;
     _imgVC.y =  self.height/2.0 - _imgVC.height/2.0;
     
     _titleA.textColor = kUIColorFromRGB(color_8);
     _titleB.textColor = kUIColorFromRGB(color_8);
     _titleC.textColor = kUIColorFromRGB(color_8);
     
     UILabel *label = [self.contentView viewWithTag:1017];
     if (!label) {
          label = [UILabel new];
          label.tag = 1017;
          label.x = 15;
          label.y = 0;
          label.height = 30;
          label.width = 200;
          label.font = [UIFont systemFontOfSize:13];
          label.textColor = kUIColorFromRGB(color_8);
          [self.contentView addSubview:label];
     }
     label.text = _dataDic[@"time"];
}

-(void)fitTopicMode
{
     self.height = 31;
     
     _imgVA.x = __SCREEN_SIZE.width-126-_imgVA.width;
     _imgVA.y = self.height/2.0 - _imgVA.height/2.0;
     _titleA.x = _imgVA.x +_imgVA.width +10;
     _titleA.y = self.height/2.0 - _titleA.height/2.0;
     
     _imgVB.hidden = YES;
     
     _titleB.x = 15;
     _titleB.y = 0;
     _titleB.height = 30;
     _titleB.width = 200;
     
     [_titleC sizeToFit];
     _titleC.x = __SCREEN_SIZE.width - 15 - _titleC.width;
     _titleC.y = self.height/2.0 - _titleC.height/2.0;
     
     _imgVC.x = _titleC.x - 10 - _imgVC.width;
     _imgVC.y =  self.height/2.0 - _imgVC.height/2.0;
     
     _titleA.textColor = kUIColorFromRGB(color_8);
     _titleB.textColor = kUIColorFromRGB(color_8);
     _titleC.textColor = kUIColorFromRGB(color_8);
     
     UIButton *aBtn = [self.contentView viewWithTag:3000];
     if(!aBtn)
     {
          aBtn = [UIButton new];
          aBtn.width = _titleB.width + 20;
          aBtn.height = _titleB.height;
          aBtn.x = _titleB.x - 20;
          aBtn.y = _titleB.y;
          aBtn.tag = 3000;
          [aBtn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
     }
     [self.contentView addSubview:aBtn];
     
     
     UIButton *bBtn = [self.contentView viewWithTag:3001];
     if(!bBtn)
     {
          bBtn = [UIButton new];
          bBtn.width = _titleC.width + 20;
          bBtn.height = _titleC.height;
          bBtn.x = _titleC.x - 20;
          bBtn.y = _titleC.y;
          bBtn.tag = 3001;
           [bBtn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
     }
     [self.contentView addSubview:bBtn];
     
}

-(void)handleAction:(UIButton *)btn
{
  if(self.handleAction)
  {
       self.handleAction(@{@"obj":btn});
  }
}
@end
