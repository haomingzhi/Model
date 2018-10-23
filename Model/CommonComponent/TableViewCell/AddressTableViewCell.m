//
//  AddressTableViewCell.m
//  chenxiaoer
//
//  Created by air on 16/3/10.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell
{
    IBOutlet UILabel *_phoneLb;
    NSIndexPath *_curIndexPath;
    IBOutlet UILabel *_markLb;
    IBOutlet UILabel *_nameLb;
    IBOutlet UILabel *_addressLb;
    IBOutlet UIButton *_btn;
    IBOutlet UILabel *_lineLb;
     NSDictionary *_dataDic;
}

- (void)awakeFromNib {
    // Initialization code
    _markLb.layer.cornerRadius = 6;
    _markLb.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
     _dataDic = dataDic;
    _curIndexPath = dataDic[@"row"];
     if (!_curIndexPath) {
          _curIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
     }
    _addressLb.text = dataDic[@"address"];
    _phoneLb.text = dataDic[@"phone"];
    _nameLb.text = dataDic[@"name"];
    _markLb.hidden = ![dataDic[@"mark"] boolValue];
    _btn.hidden = ![dataDic[@"selected"] boolValue];
}
- (IBAction)btnHandle:(id)sender {
    if (self.handleAction) {
        self.handleAction(@{@"row":_curIndexPath});
    }
}

-(void)fitCellMode{
    _lineLb.hidden = YES;
    _phoneLb.x = __SCREEN_SIZE.width - _phoneLb.width - 45;
    _phoneLb.textAlignment = NSTextAlignmentRight;
}

-(void)fitConfirmOrderMode{
    _lineLb.hidden = YES;
    
    self.height =  75;
    
    _markLb.x = 15;
    _markLb.y = 7;
    _markLb.width = 50;
    _markLb.height = 21;
    _markLb.backgroundColor = kUIColorFromRGB(color_3);
    _markLb.textColor = kUIColorFromRGB(color_5);
    _markLb.layer.cornerRadius = 6.0;
    _markLb.layer.masksToBounds = YES;
    
    if (_markLb.hidden) {
        _nameLb.x = 15;
    }else{
        _nameLb.x = _markLb.x + _markLb.width +10;
    }
    
    
    _nameLb.y = 10;
    _nameLb.width = 200;
    _nameLb.height = 15;
    _nameLb.font = [UIFont systemFontOfSize:13];
    _nameLb.textColor = kUIColorFromRGB(color_1);
    
    _phoneLb.x = __SCREEN_SIZE.width - 215;
    _phoneLb.y = 10;
    _phoneLb.width = 200;
    _phoneLb.height = 15;
    _phoneLb.font = [UIFont systemFontOfSize:13];
    _phoneLb.textColor = kUIColorFromRGB(color_1);
    _phoneLb.textAlignment = NSTextAlignmentRight;
    
    _btn.width = _btn.height = 20;
    _btn.x = __SCREEN_SIZE.width -_btn.width -15;
    _btn.y = self.height/2.0 - _btn.height/2.0;
    [_btn setBackgroundImage:[UIImage imageNamed:@"icon_round_selected"] forState:UIControlStateNormal];
    _btn.userInteractionEnabled = NO;
    
    _addressLb.x= 15;
    _addressLb.y = _nameLb.y + _nameLb.height +8;
    _addressLb.width = _btn.x -30;
    _addressLb.numberOfLines = 2;
    _addressLb.font = [UIFont systemFontOfSize:12];
    _addressLb.textColor = kUIColorFromRGB(color_8);
}

-(void)fitCheckAddressMode:(BOOL)isCheck
{
    _lineLb.hidden = YES;
    _markLb.hidden = YES;
    _btn.hidden = YES;
    self.height =  81;
    
    

    
    _nameLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _nameLb.y = 18;
    _nameLb.x = 15;
    _nameLb.width = 150;
    _nameLb.height = 15;
    _nameLb.font = [UIFont systemFontOfSize:13];
    _nameLb.textColor = kUIColorFromRGB(color_5);
     [_nameLb sizeToFit];
     _phoneLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _phoneLb.x = _nameLb.x + _nameLb.width + 10;
    _phoneLb.y = 18;
    _phoneLb.width = 140;
    _phoneLb.height = 15;
    _phoneLb.font = [UIFont systemFontOfSize:13];
    _phoneLb.textColor = kUIColorFromRGB(color_5);
    _phoneLb.textAlignment = NSTextAlignmentLeft;
     [_phoneLb sizeToFit];
    
     _addressLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _addressLb.x = 15;
    _addressLb.y = _nameLb.y + _nameLb.height + 12;
    _addressLb.width = __SCREEN_SIZE.width - 50;
    _addressLb.numberOfLines = 2;
    _addressLb.height = 30;
    _addressLb.font = [UIFont systemFontOfSize:13];
    _addressLb.textColor = kUIColorFromRGB(color_0x757575);
//    self.backgroundColor = kUIColorFromRGB(color_4);
     
     UIImageView *imgv = [self.contentView viewWithTag:9222];
     if (!imgv) {
          imgv = [UIImageView new];
          imgv.width = 18;
          imgv.height = 17;
          imgv.y = 32;
          imgv.x = __SCREEN_SIZE.width - 15 - imgv.width;
          imgv.tag = 9222;
          imgv.image = [UIImage imageContentWithFileName:@"icon_edit"];
     }
     [self.contentView addSubview:imgv];
     UILabel *lb = [self.contentView viewWithTag:12113];
     if (!lb) {
          lb = [UILabel new];
          lb.width = 46;
          lb.height = 19;
          lb.tag = 12113;
     }
     lb.textAlignment = NSTextAlignmentCenter;
     lb.text = @"默认";
     lb.textColor = kUIColorFromRGB(color_3);
     lb.font =  [UIFont systemFontOfSize:13];
     lb.layer.cornerRadius = 5;
     lb.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
     lb.layer.borderWidth = 0.5;
     lb.x = _phoneLb.x + _phoneLb.width + 7;
     lb.y = 15;
     if (isCheck) {
           [self.contentView addSubview:lb];
     }
    
     else
     {
          [lb removeFromSuperview];
     }
}


-(void)fitAddressMode:(BOOL)isCheck
{
    
     self.height =  81;
     
     
     
     
     _nameLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _nameLb.y = 18;
     _nameLb.x = 16;
     _nameLb.width = 150;
     _nameLb.height = 15;
     _nameLb.font = [UIFont systemFontOfSize:15];
     _nameLb.textColor = kUIColorFromRGB(color_1);
     [_nameLb sizeToFit];
     _phoneLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     
     _phoneLb.x = 180;
     _phoneLb.y = 43;
     _phoneLb.width = 140;
     _phoneLb.height = 15;
     _phoneLb.font = [UIFont systemFontOfSize:15];
     _phoneLb.textColor = kUIColorFromRGB(color_1);
     _phoneLb.textAlignment = NSTextAlignmentLeft;
     [_phoneLb sizeToFit];
     
     _addressLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _addressLb.x = 16;
     _addressLb.y = _nameLb.y + _nameLb.height + 12;
     _addressLb.width = __SCREEN_SIZE.width - 30;
     _addressLb.numberOfLines = 2;
//     _addressLb.height = 30;
     _addressLb.font = [UIFont systemFontOfSize:12];
     [_addressLb sizeToFit];
     
     _addressLb.textColor = kUIColorFromRGB(color_0x757575);
     //    self.backgroundColor = kUIColorFromRGB(color_4);
     
     _lineLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _lineLb.height = 0.5;
     _lineLb.y = 60;
     _lineLb.width = __SCREEN_SIZE.width;
     _lineLb.x= 0;
     _lineLb.backgroundColor = kUIColorFromRGB(color_lineColor);
     _lineLb.hidden = YES;
     UILabel *markLb = [self.contentView viewWithTag:9334];
     if (!markLb) {
          markLb = [UILabel new];
          markLb.tag = 9334;
     }
     markLb.x = MIN(_nameLb.x + _nameLb.width + 10, __SCREEN_SIZE.width - 100);
     markLb.y = 16;
     markLb.width = 46;
     markLb.height = 19;
     markLb.font = [UIFont systemFontOfSize:13];
     markLb.text = @"默认";
     markLb.textAlignment = NSTextAlignmentCenter;
     markLb.layer.cornerRadius = 4;
     markLb.layer.borderColor = kUIColorFromRGB(color_0xf82D45).CGColor;
     markLb.layer.borderWidth = 0.5;
     markLb.textColor = kUIColorFromRGB(color_0xf82D45);
     [self.contentView addSubview:markLb];
     [_btn fitImgAndTitleMode];
     _btn.x = 10;
     _btn.width = 30;
     _btn.height = 30;
     _btn.y = self.height/2.0 - _btn.height/2.0;
 if (isCheck) {
      markLb.hidden = NO;
 }
     else
     {
 markLb.hidden = YES;
     }
//     if (isCheck) {
////          _btn.customImgV.image = [UIImage imageNamed:@"icon_radio_selected"];
//          [_btn setImage:[UIImage imageContentWithFileName:@"icon_radio_selected"] forState:UIControlStateNormal];
//     }else{
////         _btn.customImgV.image = [UIImage imageNamed:@"icon_unselected"];
//             [_btn setImage:[UIImage imageContentWithFileName:@"icon_unselected"] forState:UIControlStateNormal];
//     }


     _btn.hidden = YES;
     
     UIButton *btnA = [self.contentView viewWithTag:1433];
     if (!btnA) {
          btnA = [UIButton new];
          btnA.tag = 1433;
          btnA.height = 50;
          btnA.width = 50;
          btnA.x = __SCREEN_SIZE.width - 15 - btnA.width;
          btnA.y = self.height/2.0 - btnA.height/2.0;

     }
     [btnA setImage:[UIImage imageContentWithFileName:@"editAdr"] forState:UIControlStateNormal];
//     btnA.titleLabel.font = [UIFont systemFontOfSize:15];
//     [btnA setTitle:@"编辑地址" forState:UIControlStateNormal];
//     [btnA setTitleColor:kUIColorFromRGB(color_7) forState:UIControlStateNormal];
     [btnA addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
     [self.contentView addSubview:btnA];
     

}


-(void)btnAction{
     if (self.handleAction) {
          self.handleAction(@{@"row":_curIndexPath,@"index":@(2)});
     }
}


@end
