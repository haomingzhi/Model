//
//  SeckillView.m
//  oranllcshoping
//
//  Created by air on 2017/7/19.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SeckillView.h"

@implementation SeckillView
{


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(SeckillView *)createView
{
    return (SeckillView *)[[NSBundle mainBundle] loadNibNamed:@"SeckillView" owner:nil options:nil].lastObject;
}

-(void)fitSecKillMode
{
     self.height = 180;
      self.width = MIN(MAX((__SCREEN_SIZE.width - 90 - 50)/2.0, 120), (375 - 90 - 50)/2.0);
     _imgV.y = 7;
     _imgV.width = 101;
     _imgV.height = 95;
     
     _titleLb.x = _imgV.x - 6;
     _titleLb.y = _imgV.y + _imgV.height + 10;
     _titleLb.width = _imgV.width + 12;
     _titleLb.height = 13;
     _titleLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textAlignment = NSTextAlignmentCenter;
     
     _detailLb.x = _titleLb.x;
     _detailLb.y = _titleLb.y + _titleLb.height + 11;
     _detailLb.width = _titleLb.width;
     _detailLb.height = 13;
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.textAlignment = NSTextAlignmentCenter;
     
     _contentLb.x = _titleLb.x;
     _contentLb.y = _detailLb.y + _detailLb.height + 10;
     _contentLb.width = _titleLb.width;
     _contentLb.height = 11;
     _contentLb.font = [UIFont systemFontOfSize:11];
     _contentLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _contentLb.textAlignment = NSTextAlignmentCenter;
     
     _markLb.y = 0;
     _markLb.width = 25;
     _markLb.height = 25;
      _markLb.x = _imgV.x + _imgV.width - _markLb.width/2.0;
     _markLb.layer.cornerRadius = _markLb.width/2.0;
     _markLb.layer.masksToBounds = YES;
     _markLb.textColor = kUIColorFromRGB(color_2);
     _markLb.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     _markLb.textAlignment = NSTextAlignmentCenter;
     _markLb.font = [UIFont systemFontOfSize:9];
     [_markLb strikeout];
     _markImgV.hidden = YES;
     _markLb.hidden = NO;
    _btn.height = self.height;
    _btn.width = self.width;
}
-(void)fitYouLikeMode
{
     self.height = 176;
     self.width = MIN(MAX((__SCREEN_SIZE.width - 90 - 50)/2.0, 120), (375 - 90 - 50)/2.0);
     _imgV.y = 0;
     _imgV.width = 101;
     _imgV.height = 95;
     
     _titleLb.x = _imgV.x - 6;
     _titleLb.y = _imgV.y + _imgV.height + 10;
     _titleLb.width = _imgV.width + 12;
     _titleLb.height = 13;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textAlignment = NSTextAlignmentCenter;
     
     _detailLb.x = _titleLb.x;
     _detailLb.y = _titleLb.y + _titleLb.height + 11;
     _detailLb.width = _titleLb.width;
     _detailLb.height = 11;
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.font = [UIFont systemFontOfSize:11];
     _detailLb.textAlignment = NSTextAlignmentCenter;
     
     _contentLb.x = _titleLb.x;
     _contentLb.y = _detailLb.y + _detailLb.height + 10;
     _contentLb.width = _titleLb.width;
     _contentLb.height = 13;
     _contentLb.font = [UIFont systemFontOfSize:13];
     _contentLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _contentLb.textAlignment = NSTextAlignmentCenter;
     
     _markLb.hidden = YES;
     _markImgV.hidden = YES;
//     _markLb.y = 0;
//     _markLb.width = 25;
//     _markLb.height = 25;
//     _markLb.x = _imgV.x + _imgV.width - _markLb.width/2.0;
//     _markLb.layer.cornerRadius = _markLb.width/2.0;
//     _markLb.layer.masksToBounds = YES;
//     _markLb.textColor = kUIColorFromRGB(color_2);
//     _markLb.backgroundColor = kUIColorFromRGB(color_0xf82D45);
//     _markLb.textAlignment = NSTextAlignmentCenter;
//     _markLb.font = [UIFont systemFontOfSize:8];
//     [_markLb strikeout];
     _btn.height = self.height;
     _btn.width = self.width;
}
-(void)fitHeadMode
{
     self.height = 174;
     self.width = (__SCREEN_SIZE.width - 30 - 12)/2.0;
     
     _imgV.y = 24;
     _imgV.width = 90;
     _imgV.height = 90;
     _imgV.x = self.width/2.0 - _imgV.width/2.0;

     _titleLb.x = 10;
     _titleLb.y = 128;
     _titleLb.width = self.width-20;
     _titleLb.height = 14;
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textAlignment = NSTextAlignmentCenter;

     _detailLb.x = 10;
     _detailLb.y = 150;
     _detailLb.width = _titleLb.width;
     _detailLb.height = 13;
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.textAlignment = NSTextAlignmentCenter;

//     _contentLb.x = _titleLb.x;
//     _contentLb.y = _detailLb.y + _detailLb.height + 10;
//     _contentLb.width = 60;
//     _contentLb.height = 15;
//     _contentLb.font = [UIFont systemFontOfSize:15];
//     _contentLb.textColor = kUIColorFromRGB(color_3);
//     _contentLb.textAlignment = NSTextAlignmentCenter;

     _contentLb.hidden = YES;
     _markImgV.hidden = YES;
     
     _markLb.y = 15;
     _markLb.width = 55;
     _markLb.height = 20;
     _markLb.x = 15;
//     _markLb.layer.cornerRadius = _markLb.width/2.0;
//     _markLb.layer.masksToBounds = YES;
     _markLb.textColor = kUIColorFromRGB(color_2);
     _markLb.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     _markLb.textAlignment = NSTextAlignmentCenter;
     _markLb.font = [UIFont systemFontOfSize:13];
     _markLb.text = @"热门";
//     [_markLb strikeout];

//     UILabel *nwprLb = [self viewWithTag:9020];
//     if (!nwprLb) {
//          nwprLb = [UILabel new];
//          nwprLb.tag = 9020;
//          nwprLb.height = 12;
//          nwprLb.width = 50;
//          nwprLb.y = 160;
//          nwprLb.x = _contentLb.x + _contentLb.width + 10;
//     }
//     nwprLb.text = _dataDic[@"nwPrice"];
//     nwprLb.font = [UIFont systemFontOfSize:12];
//     nwprLb.textColor = kUIColorFromRGB(color_0xeb7f00);
//
//
//     [self addSubview:nwprLb];

//     UIButton *btn = [self viewWithTag:9030];
//     if (!btn) {
//          btn = [UIButton new];
//          btn.tag = 9030;
//          btn.width = 40;
//          btn.height = 40;
//          btn.y = 139;
//          btn.x = 78;
////          btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//     }
//     [btn setImage:[UIImage imageContentWithFileName:@"cart_blue"] forState:UIControlStateNormal];
//     [btn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
//     [self addSubview:btn];
//     
//     _btn.height = self.height;
//     _btn.width = self.width;
//     _btn.hidden = YES;
}

-(void)fitFreshMode
{
     self.height = 180;
       self.width = MIN(MAX((__SCREEN_SIZE.width - 90 - 50)/2.0, 120), (375 - 90 - 50)/2.0);
     _imgV.y = 7;
     _imgV.width = 101;
     _imgV.height = 95;
     
     _titleLb.x = _imgV.x - 6;
     _titleLb.y = _imgV.y + _imgV.height + 10;
     _titleLb.width = _imgV.width + 12;
     _titleLb.height = 13;
     _titleLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textAlignment = NSTextAlignmentCenter;
     
     _detailLb.x = _titleLb.x;
     _detailLb.y = _titleLb.y + _titleLb.height + 11;
     _detailLb.width = _titleLb.width;
     _detailLb.height = 13;
     _detailLb.textColor = kUIColorFromRGB(color_5);
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.textAlignment = NSTextAlignmentCenter;
     
     _contentLb.x = _titleLb.x;
     _contentLb.y = _detailLb.y + _detailLb.height + 10;
     _contentLb.width = _titleLb.width;
     _contentLb.height = 11;
     _contentLb.font = [UIFont systemFontOfSize:11];
     _contentLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _contentLb.textAlignment = NSTextAlignmentCenter;
     
     _markLb.hidden = YES;
     _markImgV.hidden = NO;
     _markImgV.width = 31;
     _markImgV.height = 18;
     _markImgV.image = [UIImage imageContentWithFileName:@"new"];
     _markImgV.x = self.width - _markImgV.width;
     _markImgV.y = _imgV.y;
    _btn.height = self.height;
    _btn.width = self.width;
}
- (IBAction)handleAction:(id)sender {
    if (self.handleAction) {
        self.handleAction(sender);
    }
}


@end
