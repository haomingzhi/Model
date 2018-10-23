//
//  PinpaiView.m
//  oranllcshoping
//
//  Created by air on 2017/7/19.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "PinpaiView.h"

@implementation PinpaiView
{
  IBOutlet UIButton *_btn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)fitPinpaiMode
{
     self.height = 138;
     
     _titleLb.height = 14;
     _titleLb.y = 10;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.width = 120;
     
      _detailLb.height = 14;
     _detailLb.x = 0;
     _detailLb.y = _titleLb.y + _titleLb.height + 10;
     _detailLb.font = [UIFont systemFontOfSize:14];
       _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.width = 120;
     
     
     _imgV.y = _detailLb.y + _detailLb.height + 15;
     _imgV.width = 155;
     _imgV.height = 75;
     if (__SCREEN_SIZE.width == 320) {
          _imgV.width = (__SCREEN_SIZE.width - 50)/2.0;
          _imgV.height = 75/155.0 * _imgV.width;
     }
     self.height = _imgV.y + _imgV.height;
     self.width = _imgV.width;
     _markLb.hidden = YES;
     _markImgV.y = 10;
     _markImgV.image = [UIImage imageContentWithFileName:@"new"];
     _markImgV.x =_imgV.width - _markImgV.width;
//     _markLb.textColor = kUIColorFromRGB(color_2);
//     _markLb.font = [UIFont systemFontOfSize:12];
//     _markLb.width = 31;
//     _markLb.height = 18;
//     _markLb.layer.cornerRadius = 3;
//     _markLb.layer.masksToBounds = YES;
//     _markLb.backgroundColor = kUIColorFromRGB(color_mainTheme);
     _btn.height = self.height;
     _btn.width = self.width;
}

- (IBAction)handleAction:(id)sender {
     if (self.handleAction) {
          self.handleAction(nil);
     }
}
@end
