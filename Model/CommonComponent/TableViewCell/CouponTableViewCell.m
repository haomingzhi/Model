//
//  CouponTableViewCell.m
//  oranllcshoping
//
//  Created by air on 2017/7/28.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "CouponTableViewCell.h"

@implementation CouponTableViewCell
{
    IBOutlet UIView *_containerView;

    IBOutlet UIImageView *_bgImgV;
    IBOutlet UILabel *_aTitleLb;
    IBOutlet UILabel *_bTitleLb;
    IBOutlet UILabel *_cTitleLb;
    IBOutlet UILabel *_dTitleLb;
    IBOutlet UILabel *_eTitleLb;
    IBOutlet UIImageView *_markImgV;
    IBOutlet UIImageView *_rImgV;
    NSDictionary *_dataDic;
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
    _bgImgV.image = [UIImage imageContentWithFileName:_dataDic[@"bgImg"]];
    _aTitleLb.text = _dataDic[@"aTitle"];
    _bTitleLb.text = _dataDic[@"bTitle"];
    _cTitleLb.text = _dataDic[@"cTitle"];
    _dTitleLb.text = _dataDic[@"dTitle"];
    _eTitleLb.text = _dataDic[@"eTitle"];
    
    _markImgV.image = [UIImage imageContentWithFileName:dataDic[@"markImg"]];
    _rImgV.image = [UIImage imageContentWithFileName:@"rightArrow2"];
}
-(void)fitGetCouponCenterMode
{
     self.height = 85;
     _containerView.width = __SCREEN_SIZE.width - 30;
     _containerView.height = 75;
     _containerView.y = 10;
     _containerView.x = 15;

     _bgImgV.width = 115;
     _bgImgV.height = 75;
     _bgImgV.x = 0;
     _bgImgV.image = [UIImage imageContentWithFileName:_dataDic[@"bgImg"]];
     UIView *vv = [self.contentView viewWithTag:7433];
     if (!vv) {
          vv = [UIView new];
          vv.tag = 7433;
          vv.width = 20;
          vv.height = _bgImgV.height;
          vv.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     }
     [_containerView insertSubview:vv atIndex:0];
     _aTitleLb.font = [UIFont systemFontOfSize:30];
     _aTitleLb.height = 30;
     _aTitleLb.x = 0;
     _aTitleLb.y = 15;
     _aTitleLb.width = 115;
     _aTitleLb.textColor = kUIColorFromRGB(color_2);
     _aTitleLb.textAlignment = NSTextAlignmentCenter;

     _bTitleLb.font = [UIFont systemFontOfSize:12];
     _bTitleLb.height = 12;
     _bTitleLb.x = 0;
     _bTitleLb.y = _aTitleLb.y + _aTitleLb.height + 8;
     _bTitleLb.width = 115;
     _bTitleLb.textColor = kUIColorFromRGB(color_2);
     _bTitleLb.textAlignment = NSTextAlignmentCenter;

     _cTitleLb.x = 115 + 20;
     _cTitleLb.y = 16;
     _cTitleLb.width = _containerView.width - _cTitleLb.x  - 20;
     _cTitleLb.font = [UIFont systemFontOfSize:12];
     _cTitleLb.height = 12;
     _cTitleLb.textColor = kUIColorFromRGB(color_0x757575);

     _dTitleLb.x = 115 + 20;
     _dTitleLb.y = _cTitleLb.y + _cTitleLb.height + 10;
     _dTitleLb.width = _containerView.width - _dTitleLb.x  - 20;
     _dTitleLb.font = [UIFont systemFontOfSize:12];
     _dTitleLb.height = 12;
     _dTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);

     _eTitleLb.x = 115 + 20;
     _eTitleLb.y = _dTitleLb.y + _dTitleLb.height + 10;
     _eTitleLb.width = _containerView.width - _eTitleLb.x  - 20;
     _eTitleLb.font = [UIFont systemFontOfSize:12];
     _eTitleLb.height = 12;
     _eTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _eTitleLb.hidden = YES;
     _markImgV.height = 30;
     _markImgV.width = 30;
     _markImgV.x = _containerView.width - _markImgV.width;
     _markImgV.y = 0;

     _markImgV.hidden = YES;

     _rImgV.width = 5;
     _rImgV.height = 9;
     _rImgV.y = 33;
     _rImgV.hidden = YES;
     _rImgV.x = _containerView.width - 15 - _rImgV.width;
     _containerView.backgroundColor = kUIColorFromRGB(color_2);
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     UIButton *aBtn = [self.contentView viewWithTag:2999];
     if(!aBtn)
     {
          aBtn = [UIButton new];
          aBtn.width = 80;
          aBtn.height = 31;
          aBtn.x = __SCREEN_SIZE.width - 30 - aBtn.width;
          aBtn.y = 33;
          aBtn.tag = 2999;
          aBtn.layer.cornerRadius = 6;
          aBtn.layer.masksToBounds = YES;
          [aBtn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
          aBtn.titleLabel.font = [UIFont systemFontOfSize:13];
     }

     [aBtn setTitle:_dataDic[@"btn"] forState:UIControlStateNormal];
     if(![_dataDic[@"btn"] isEqualToString:@"领取"])
     {
          aBtn.backgroundColor = kUIColorFromRGB(color_2);
          aBtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
          aBtn.layer.borderWidth = 0.5;
           [aBtn setTitleColor:kUIColorFromRGB(color_0xb0b0b0) forState:UIControlStateNormal];
          aBtn.userInteractionEnabled = NO;
     }
     else
     {
          aBtn.layer.borderWidth = 0;
          aBtn.backgroundColor = kUIColorFromRGB(color_0xf82D45);
          [aBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          aBtn.userInteractionEnabled = YES;
     }
     [self.contentView addSubview:aBtn];

}

-(void)handleAction:(UIButton *)btn
{
     if (self.handleAction) {
          self.handleAction(@{@"row":_dataDic[@"row"]});
     }
}
-(void)fitMode
{
     self.height = 85;
     _containerView.width = __SCREEN_SIZE.width - 30;
     _containerView.height = 75;
     _containerView.y = 10;
     _containerView.x = 15;
     
     _bgImgV.width = 115;
     _bgImgV.height = 75;
     _bgImgV.x = 0;
     _bgImgV.image = [UIImage imageContentWithFileName:_dataDic[@"bgImg"]];
     UIView *vv = [self.contentView viewWithTag:7433];
     if (!vv) {
          vv = [UIView new];
          vv.tag = 7433;
          vv.width = 20;
          vv.height = _bgImgV.height;
          vv.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     }
     [_containerView insertSubview:vv atIndex:0];
     _aTitleLb.font = [UIFont systemFontOfSize:30];
     _aTitleLb.height = 30;
     _aTitleLb.x = 0;
     _aTitleLb.y = 15;
     _aTitleLb.width = 115;
     _aTitleLb.textColor = kUIColorFromRGB(color_2);
     _aTitleLb.textAlignment = NSTextAlignmentCenter;
     
     _bTitleLb.font = [UIFont systemFontOfSize:12];
     _bTitleLb.height = 12;
     _bTitleLb.x = 0;
     _bTitleLb.y = _aTitleLb.y + _aTitleLb.height + 8;
     _bTitleLb.width = 115;
     _bTitleLb.textColor = kUIColorFromRGB(color_2);
     _bTitleLb.textAlignment = NSTextAlignmentCenter;
     
     _cTitleLb.x = 115 + 20;
     _cTitleLb.y = 11;
     _cTitleLb.width = _containerView.width - _cTitleLb.x  - 20;
     _cTitleLb.font = [UIFont systemFontOfSize:12];
     _cTitleLb.height = 12;
     _cTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     
     _dTitleLb.x = 115 + 20;
     _dTitleLb.y = _cTitleLb.y + _cTitleLb.height + 10;
     _dTitleLb.width = _containerView.width - _dTitleLb.x  - 20;
     _dTitleLb.font = [UIFont systemFontOfSize:12];
     _dTitleLb.height = 12;
     _dTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     
     _eTitleLb.x = 115 + 20;
     _eTitleLb.y = _dTitleLb.y + _dTitleLb.height + 10;
     _eTitleLb.width = _containerView.width - _eTitleLb.x  - 20;
     _eTitleLb.font = [UIFont systemFontOfSize:12];
     _eTitleLb.height = 12;
     _eTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     
     _markImgV.height = 30;
     _markImgV.width = 30;
     _markImgV.x = _containerView.width - _markImgV.width;
     _markImgV.y = 0;
     if (_dataDic[@"markImg"] == nil) {
           _markImgV.hidden = YES;
     }
 else
 {
   _markImgV.hidden = NO;
 }
     _rImgV.width = 5;
     _rImgV.height = 9;
     _rImgV.y = 33;
     _rImgV.hidden = YES;
     _rImgV.x = _containerView.width - 15 - _rImgV.width;
     _containerView.backgroundColor = kUIColorFromRGB(color_2);
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}


-(void)fitSelectCouponMode:(BOOL)isSelected
{
     self.height = 85;
     _containerView.width = __SCREEN_SIZE.width - 30;
     _containerView.height = 75;
     _containerView.y = 10;
     _containerView.x = 15;
     
     
     _bgImgV.width = 115;
     _bgImgV.height = 75;
     _bgImgV.x = 0;
     _bgImgV.image = [UIImage imageNamed:@"coupon_bg"];
     
     _aTitleLb.font = [UIFont systemFontOfSize:30];
     _aTitleLb.height = 30;
     _aTitleLb.x = 0;
     _aTitleLb.y = 15;
     _aTitleLb.width = 115;
     _aTitleLb.textColor = kUIColorFromRGB(color_2);
     _aTitleLb.textAlignment = NSTextAlignmentCenter;
     
     _bTitleLb.font = [UIFont systemFontOfSize:12];
     _bTitleLb.height = 12;
     _bTitleLb.x = 0;
     _bTitleLb.y = _aTitleLb.y + _aTitleLb.height + 8;
     _bTitleLb.width = 115;
     _bTitleLb.textColor = kUIColorFromRGB(color_2);
     _bTitleLb.textAlignment = NSTextAlignmentCenter;
     
     _cTitleLb.x = 115 + 20;
     _cTitleLb.y = 16;
     _cTitleLb.width = _containerView.width - _cTitleLb.x  - 30;
     _cTitleLb.font = [UIFont systemFontOfSize:12];
     _cTitleLb.height = 12;
     _cTitleLb.textColor = kUIColorFromRGB(color_0x757575);
     
     _dTitleLb.x = 115 + 20;
     _dTitleLb.y = _cTitleLb.y + _cTitleLb.height + 10;
     _dTitleLb.width = _containerView.width - _dTitleLb.x  - 30;
     _dTitleLb.font = [UIFont systemFontOfSize:12];
     _dTitleLb.height = 12;
     _dTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     
     _eTitleLb.x = 115 + 20;
     _eTitleLb.y = _dTitleLb.y + _dTitleLb.height + 4;
     _eTitleLb.width = _containerView.width - _eTitleLb.x  - 30;
     _eTitleLb.font = [UIFont systemFontOfSize:12];
     _eTitleLb.height = 12;
     _eTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     
     _markImgV.height = 15;
     _markImgV.width = 15;
     _markImgV.x = _containerView.width - _markImgV.width-15;
     _markImgV.y = self.height/2.0 - _markImgV.height/2.0;
     
     if (isSelected) {
          _markImgV.image = [UIImage imageNamed:@"icon_selected"];
     }else{
          _markImgV.image = [UIImage imageNamed:@"icon_unselected"];
     }
     
     _rImgV.hidden = YES;
     
     _containerView.backgroundColor = kUIColorFromRGB(color_2);
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(void)fitModeB
{
     [self fitMode];
     
     _markImgV.height = 47;
     _markImgV.width = 47;
     _markImgV.x = _containerView.width - _markImgV.width - 15;
     _markImgV.y = 14;
     _rImgV.image = nil;
}
-(void)fitModeC
{
    [self fitMode];
     _markImgV.height = 47;
     _markImgV.width = 47;
     _markImgV.x = _containerView.width - _markImgV.width - 15;
     _markImgV.y = 14;
     _rImgV.image = nil;
}


-(void)fitModeD
{
     [self fitMode];
     
     _markImgV.hidden = YES;
}

-(void)fitSelectCouponMode{
     [self fitMode];
     _bgImgV.image = [UIImage imageNamed:@"coupon_bg2"];
     _markImgV.hidden = YES;
}

@end
