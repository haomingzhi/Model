//
//  TitleAndDetailAndImageTableViewCell.m
//  taihe
//
//  Created by LinFeng on 2016/11/23.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleAndDetailAndImageTableViewCell.h"
#import "BUSystem.h"


@implementation TitleAndDetailAndImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fitCellMode{
     _titleLb.x = 15;
     _titleLb.height = 44;
     _titleLb.y = 0;
     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
     _titleLb.width = size.width;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     
     _imgV.width = 7.5;
     _imgV.height = 14;
     _imgV.x = __SCREEN_SIZE.width - _imgV.width -15;
     _imgV.y = (self.height - _imgV.height)/2.0;
     
     _detailLb.x = _titleLb.x +_titleLb.width +15 ;
     _detailLb.height = 44;
     _detailLb.y = 0;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
     _detailLb.width = _imgV.x -_detailLb.x - 8;
     _detailLb.textColor = kUIColorFromRGB(color_7);
     
     _imgV.hidden = NO;
     
}


-(void)fitHiddenMode{
     _detailLb.hidden = YES;
     _imgV.hidden = YES;
     _titleLb.hidden = YES;
}


-(void)fitSpecialInfoModeA{
     self.height = 35;
     
     _titleLb.x = 15;
     _titleLb.height = self.height;
     _titleLb.y = 0;
     _titleLb.width = 200;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     
     _imgV.width = 18;
     _imgV.height = 18;
     _imgV.x = __SCREEN_SIZE.width - _imgV.width - 66;
     _imgV.y = (self.height - _imgV.height)/2.0;
     
     _detailLb.y = 0;
     _detailLb.width = 100;
     _detailLb.x = __SCREEN_SIZE.width - _detailLb.width -15 ;
     _detailLb.height = self.height;
     _detailLb.textColor = kUIColorFromRGB(color_8);
     _detailLb.font = [UIFont systemFontOfSize:14];
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.hidden = NO;

     
}


-(void)fitEvaInfoModeA{
     self.height = 30;
     
     _titleLb.x = 15;
     _titleLb.height = self.height;
     _titleLb.y = 0;
     _titleLb.width = 200;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_8);
     
     _imgV.hidden = YES;
     
     _detailLb.y = 0;
     _detailLb.width = 100;
     _detailLb.x = 128 ;
     _detailLb.height = self.height;
     _detailLb.textColor = kUIColorFromRGB(color_8);
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.hidden = NO;
     
     CWStarRateView *startView = [self.contentView viewWithTag:1055];
     if (!startView ) {
          startView = [[CWStarRateView alloc]initWithFrame:CGRectMake(172, 7.5, 100, 15) numberOfStars:5];
          startView.tag = 1055;
//          startView.x = 172;
//          startView.y = 10;
//          startView.width = 100;
//          startView.height  = 15;
          [self.contentView addSubview:startView];
     }
     startView.scorePercent = [_dataDic[@"starNumber"] floatValue];
     
}

-(void)fitEvaInfoMode{
     self.height = 30;
     
     _titleLb.x = 42;
     _titleLb.height = self.height;
     _titleLb.y = 0;
     _titleLb.width = 200;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_8);
     
     _imgV.width = 17;
     _imgV.height = 15;
     _imgV.x = 15;
     _imgV.y = (self.height - _imgV.height)/2.0;
     
     _detailLb.hidden = YES;
     
     
}

-(void)fitAppointentMode{
    _titleLb.x = 15;
    _titleLb.height = 40;
    _titleLb.y = 0;
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
    _titleLb.width = size.width;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    
    _imgV.width = 7.5;
    _imgV.height = 14;
    _imgV.x = __SCREEN_SIZE.width - _imgV.width -15;
    _imgV.y = (self.height - _imgV.height)/2.0;
    
    
    _detailLb.x = _titleLb.x +_titleLb.width +15 ;
    _detailLb.height = 40;
    _detailLb.y = 0;
    //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
    _detailLb.width = _imgV.x -_detailLb.x - 8;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    
    _imgV.hidden = NO;
    
}

-(void)fitSpecialMode{
     self.height = 30;
     
     _titleLb.x = 50;
     _titleLb.height = 30;
     _titleLb.y = 0;
     _titleLb.width = 200;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     
     _imgV.width = 20;
     _imgV.height = 20;
     _imgV.x = 15;
     _imgV.y = (self.height - _imgV.height)/2.0;
     
     
     _detailLb.hidden = YES;
     
}


-(void)fitServerMode{
    
     
     _titleLb.x = 36;
     _titleLb.height = 13;
     _titleLb.y = 15;
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x - 15;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     
     _imgV.width = 13;
     _imgV.height = 13;
     _imgV.x = 15;
     _imgV.y = 13;
     
     
     _detailLb.width = __SCREEN_SIZE.width-30;
     _detailLb.x = 15;
     _detailLb.y = 35;
     _detailLb.textAlignment = NSTextAlignmentLeft;
     _detailLb.font = [UIFont systemFontOfSize:12];
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _detailLb.numberOfLines = 0;
     [_detailLb sizeToFit];
     
      self.height = _detailLb.y +_detailLb.height;
     
}



-(void)fitSpecialInfoMode{
     self.height = 30;
     
     _titleLb.x = 50;
     _titleLb.height = 30;
     _titleLb.y = 0;
     _titleLb.width = 200;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     
     _imgV.width = 20;
     _imgV.height = 20;
     _imgV.x = 15;
     _imgV.y = (self.height - _imgV.height)/2.0;
     
     
     _detailLb.width = 200;
     _detailLb.height = self.height;
     _detailLb.x = __SCREEN_SIZE.width - _detailLb.width -15;
     _detailLb.y = 0;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.font = [UIFont systemFontOfSize:12];
     _detailLb.textColor = kUIColorFromRGB(color_8);
     
}

-(void)fitUpPersonInfoMode{
    _titleLb.x = 15;
    _titleLb.height = 44;
    _titleLb.y = 0;
    _titleLb.font = [UIFont systemFontOfSize:14.0];
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
    _titleLb.width = size.width;
    _titleLb.textColor = kUIColorFromRGB(color_6);
    
    _imgV.x = __SCREEN_SIZE.width - _imgV.width -15;
    _imgV.y = (self.height - _imgV.height)/2.0;
    
    _detailLb.x = _titleLb.x +_titleLb.width +15 ;
    _detailLb.height = 44;
    _detailLb.y = 0;
    //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
    _detailLb.width = _imgV.x -_detailLb.x - 8;
    _detailLb.textColor = kUIColorFromRGB(color_7);
    _detailLb.font = [UIFont systemFontOfSize:14.0];
    _imgV.hidden = NO;
    
}


-(void)fitConfirmGoodsInfoMode{
    self.height = 40;
    _titleLb.x = 15;
    _titleLb.height = self.height;
    _titleLb.y = 0;
    _titleLb.font = [UIFont systemFontOfSize:15.0];
    _titleLb.width = 200;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    
    _imgV.width = 7.5;
    _imgV.height = 14;
    _imgV.x = __SCREEN_SIZE.width - _imgV.width -15;
    _imgV.y = (self.height - _imgV.height)/2.0;
    
    _detailLb.width = 200;
    _detailLb.x = _imgV.x - _detailLb.width -10 ;
    _detailLb.height = self.height;
    _detailLb.y = 0;
    _detailLb.textColor = kUIColorFromRGB(color_1);
    _detailLb.font = [UIFont systemFontOfSize:15.0];
    _imgV.hidden = NO;
    
}




-(void)fitClasstifyInfoMode{
     self.height = 40;
     _titleLb.x = 15;
     _titleLb.height = 15;
     _titleLb.y = 15;
     _titleLb.font = [UIFont systemFontOfSize:13.0];
     _titleLb.width = 200;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     
     _imgV.width = 15;
     _imgV.height = 15;
     _imgV.x = __SCREEN_SIZE.width - _imgV.width -15;
     _imgV.y = 15;
     
     _detailLb.width = 200;
     _detailLb.x = _imgV.x - _detailLb.width -10 ;
     _detailLb.height = 15;
     _detailLb.y = 15;
     _detailLb.textColor = kUIColorFromRGB(color_8);
     _detailLb.font = [UIFont systemFontOfSize:13.0];
     _detailLb.textAlignment = NSTextAlignmentRight;
     
}





-(void)fitNoImageMode{
     _titleLb.x = 15;
     _titleLb.height = 44;
     _titleLb.y = 0;
     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
     _titleLb.width = size.width;
     _titleLb.textColor = kUIColorFromRGB(color_6);
     
     _imgV.hidden = YES;
     
     _detailLb.x = _titleLb.x +_titleLb.width +15 ;
     _detailLb.height = 44;
     _detailLb.y = 0;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
     _detailLb.width = __SCREEN_SIZE.width -_detailLb.x - 15;
     _detailLb.textColor = kUIColorFromRGB(color_7);
     
     
     
}


-(void)fitInvoicerMode{
     self.height = 40;
     _titleLb.x = 15;
     _titleLb.height = 44;
     _titleLb.y = 0;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
     _titleLb.width = 200;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     
     _imgV.width = 10;
     _imgV.height = 18;
     _imgV.x = __SCREEN_SIZE.width - _imgV.width -15;
     _imgV.y = self.height/2.0 - _imgV.height/2.0;
     _imgV.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     
     
     _detailLb.height = 44;
     _detailLb.y = 0;
     _detailLb.x = 117 ;
     _detailLb.width = _imgV.x - 15 - _detailLb.x;
     _detailLb.textColor = kUIColorFromRGB(color_7);
     _detailLb.textAlignment = NSTextAlignmentLeft;
     
     
}


-(void)fitPayOrderMode{
     self.height = 40;
     
     _titleLb.x = 60;
     _titleLb.height = self.height;
     _titleLb.y = 0;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
     _titleLb.width = 200;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     
     _imgV.width = 30;
     _imgV.height = 30;
     _imgV.x = 15;
     _imgV.y = self.height/2.0 - _imgV.height/2.0;
     
     
     
     _detailLb.hidden = YES;
     
     UIImageView *arrowImgv = [self.contentView viewWithTag:1047];
     if (!arrowImgv) {
          arrowImgv = [UIImageView new];
          arrowImgv.width = 10;
          arrowImgv.height = 18;
          arrowImgv.x= __SCREEN_SIZE.width - 25;
          arrowImgv.y = self.height/2.0 - arrowImgv.height/2.0;
          arrowImgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
          arrowImgv.tag = 1047;
          [self.contentView addSubview:arrowImgv];
     }
     
}

-(void)fitGoodsInfoMode{
     self.height = 35;
     _titleLb.x = 15;
     _titleLb.height = self.height;
     _titleLb.y = 0;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
     _titleLb.width = 200;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:15];
     
//     _imgV.width = 10;
//     _imgV.height = 18;
//     _imgV.x = __SCREEN_SIZE.width - _imgV.width -15;
//     _imgV.y = self.height/2.0 - _imgV.height/2.0;
//     _imgV.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     
     _imgV.hidden = YES;
     
     
     _detailLb.height = self.height;
     _detailLb.y = 0;
     _detailLb.font = [UIFont systemFontOfSize:15];
     CGSize size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width, self.height)];
     _detailLb.width = size.width;
     _detailLb.textColor = kUIColorFromRGB(color_8);
     
     _detailLb.x = __SCREEN_SIZE.width  -15 -_detailLb.width ;
     
     
}



-(void)fitGoodsInfoModeC{
     self.height = 45;
     
     _titleLb.x = 15;
     _titleLb.height = self.height;
     _titleLb.y = 0;
     _titleLb.width = 200;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     
     _imgV.width = 7;
     _imgV.height = 13;
     _imgV.x = __SCREEN_SIZE.width-15-_imgV.width;
     _imgV.y = (self.height - _imgV.height)/2.0;
     
     
     _detailLb.width = 300;
     _detailLb.height = self.height;
     _detailLb.x = __SCREEN_SIZE.width - _detailLb.width -32;
     _detailLb.y = 0;
     _detailLb.textAlignment = NSTextAlignmentRight;
     _detailLb.font = [UIFont systemFontOfSize:13];
     _detailLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf7f7f7);
     
}


-(void)fitGoodsInfoModeB{
     self.height = 30;
     _titleLb.hidden = YES;
     _detailLb.hidden = YES;
     
     
     
     UIImageView *headerA = [self.contentView viewWithTag:16001];
     if (!headerA) {
          headerA = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width/2.0 - 150/2.0, 0, 30, 30)];
          headerA.image = [UIImage imageNamed:@"icon_header"];
          headerA.tag = 16001;
          [self.contentView addSubview:headerA];
     }
     
     UIImageView *headerB = [self.contentView viewWithTag:16002];
     if (!headerB) {
          headerB = [[UIImageView alloc]initWithFrame:CGRectMake(headerA.x +headerA.width +15.0, 0, 30, 30)];
          headerB.image = [UIImage imageNamed:@"icon_header"];
          headerB.tag = 16002;
          [self.contentView addSubview:headerB];
     }
     
     UIImageView *headerC = [self.contentView viewWithTag:16003];
     if (!headerC) {
          headerC = [[UIImageView alloc]initWithFrame:CGRectMake(headerB.x +headerB.width +15.0, 0, 30, 30)];
          headerC.image = [UIImage imageNamed:@"icon_header"];
          headerC.tag = 16003;
          [self.contentView addSubview:headerC];
     }
     
     _imgV.width = 10;
     _imgV.height = 18;
     _imgV.x = headerC.x + headerC.width +15;
     _imgV.y = self.height/2.0 - _imgV.height/2.0;
     _imgV.image = [UIImage imageContentWithFileName:@"rightArrow2"];
}

-(void)fitGoodsInfoModeA{
     self.height = 80;

     _detailLb.hidden = YES;
     
     
     _titleLb.x = 0;
     _titleLb.height = 56;
     _titleLb.y = 12;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
     _titleLb.width = __SCREEN_SIZE.width;
     _titleLb.text = @"";
     _titleLb.backgroundColor = kUIColorFromRGB(color_0xf6fbff);
     
     NSArray *arr = _dataDic[@"arr"];
     [_viewsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          UIView *v = obj;
          [v removeFromSuperview];
     }];
     _viewsArr = [NSMutableArray new];
     
     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          NSString *str = obj;
          if (str.length >4) {
               str = [str substringToIndex:4];
          }
          UIImageView *imgB = [self.contentView viewWithTag:2000+idx];
          if (!imgB) {
               imgB = [UIImageView new];
               imgB.height = 15;
               imgB.width =15;
               
               imgB.y = _titleLb.height/2.0 - imgB.height/2.0;
               imgB.tag = 2000+idx;
               imgB.image = [UIImage imageNamed:@"goods_selected"];
               [self.titleLb addSubview:imgB];
          }
          imgB.x = 15+80*idx;
          
          UILabel *titleBLb = [self.contentView viewWithTag:1000+idx];
          if (!titleBLb) {
               titleBLb = [UILabel new];
               titleBLb.textColor = kUIColorFromRGB(color_1);
               titleBLb.tag = 1000+idx;
               titleBLb.textAlignment = NSTextAlignmentCenter;
               titleBLb.height = 13;
               titleBLb.width = 55;
               titleBLb.font = [UIFont systemFontOfSize:13];
               titleBLb.y = _titleLb.height/2.0 - titleBLb.height/2.0;
               [self.titleLb addSubview:titleBLb];
          }
          titleBLb.text = str;
          titleBLb.x = imgB.x+imgB.width+6;
          [_viewsArr addObject:titleBLb];
          [_viewsArr addObject:imgB];
     }];
     
     
     //是否还有更多
//     if ([_dataDic[@"hasMore"] boolValue]) {
          _imgV.hidden = NO;
          _imgV.x = __SCREEN_SIZE.width - 13-15;
          _imgV.width = 13;
          _imgV.height = 3;
          _imgV.y = self.height/2.0 - _imgV.height/2.0;
          _imgV.image = [UIImage imageNamed:@"icon_more"];
//     }else{
//          _imgV.hidden = YES;
//     }

}





-(void)fitFillInOrderMode{
     self.height = 45;
     _titleLb.x = 15;
     _titleLb.height = self.height;
     _titleLb.y = 0;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
     _titleLb.width = 200;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:15];
     
     _imgV.width = 7;
     _imgV.height = 13;
     _imgV.x = __SCREEN_SIZE.width - _imgV.width -15;
     _imgV.y = self.height/2.0 - _imgV.height/2.0;
     _imgV.image = [UIImage imageContentWithFileName:@"arrow_right_goods"];
     
     
     _detailLb.height = self.height;
     _detailLb.y = 0;
     _detailLb.font = [UIFont systemFontOfSize:13];
     CGSize size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width, self.height)];
     _detailLb.width = size.width;
//     if ([_detailLb.text containsString:@"¥"]) {
//          _detailLb.textColor = kUIColorFromRGB(color_);
//     }else
         _detailLb.textColor = kUIColorFromRGB(color_8);
     
     
     _detailLb.x = _imgV.x  -15 -_detailLb.width ;
     
     
}

-(void)fitFillInOrderModeA:(BOOL)isOpen{
     self.height = 40;
     _titleLb.x = 15;
     _titleLb.height = self.height;
     _titleLb.y = 0;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
     _titleLb.width = 200;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     
     _imgV.width = 33;
     _imgV.height = 15;
     _imgV.x = __SCREEN_SIZE.width - _imgV.width -10;
     _imgV.y = self.height/2.0 - _imgV.height/2.0;
     if (isOpen) {
          _imgV.image = [UIImage imageContentWithFileName:@"icon_switch_open"];
     }else{
          _imgV.image = [UIImage imageContentWithFileName:@"icon_switch_close"];
     }
     
     
     _detailLb.height = self.height;
     _detailLb.y = 0;
     _detailLb.font = [UIFont systemFontOfSize:13];
     CGSize size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width, 44)];
     _detailLb.width = size.width;
     _detailLb.textColor = kUIColorFromRGB(color_8);
     
     
     _detailLb.x = _imgV.x  -15 -_detailLb.width ;
     
     
}


-(void)fitWriteEvaluationMode:(BOOL)isOpen{
     self.height = 40;
     _titleLb.x = 15;
     _titleLb.height = self.height;
     _titleLb.y = 0;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
     _titleLb.width = 200;
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     _titleLb.font = [UIFont systemFontOfSize:13];
     
     _imgV.width = 33;
     _imgV.height = 15;
     _imgV.x = __SCREEN_SIZE.width - _imgV.width -10;
     _imgV.y = self.height/2.0 - _imgV.height/2.0;
     if (isOpen) {
          _imgV.image = [UIImage imageContentWithFileName:@"icon_switch_open"];
     }else{
          _imgV.image = [UIImage imageContentWithFileName:@"icon_switch_close"];
     }
     
     
     _detailLb.height = self.height;
     _detailLb.y = 0;
     _detailLb.font = [UIFont systemFontOfSize:13];
     CGSize size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width, 44)];
     _detailLb.width = size.width;
     _detailLb.textColor = kUIColorFromRGB(color_0x757575);
     
     
     _detailLb.x = _imgV.x  -15 -_detailLb.width ;
     
     
}

-(void)fitFillInOrderModeC:(BOOL)isSelected{
     self.height = 40;
     _titleLb.x = 52;
     _titleLb.height = 44;
     _titleLb.y = 0;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
     _titleLb.width = 200;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     
     _imgV.width = 15;
     _imgV.height = 15;
     _imgV.x = 15;
     _imgV.y = 13;
     if (isSelected) {
          _imgV.image = [UIImage imageContentWithFileName:@"icon_selected"];
     }else{
          _imgV.image = [UIImage imageContentWithFileName:@"icon_unselected"];
     }
     
     
     _detailLb.x = 114;
     _detailLb.height = 44;
     _detailLb.y = 0;
     _detailLb.font = [UIFont systemFontOfSize:12];
     _detailLb.width = __SCREEN_SIZE.width - _detailLb.x -15;
     _detailLb.textColor = kUIColorFromRGB(color_8);
     _detailLb.textAlignment = NSTextAlignmentCenter;
     
     
     
     
}


-(void)fitFillInOrderModeD{
     self.height = 45;
     
     
     _imgV.width = 20;
     _imgV.height = 20;
     _imgV.x = 15;
     _imgV.y = self.height/2.0 - _imgV.height/2.0;
     
     
     _titleLb.x = _imgV.x + _imgV.width +10;
     _titleLb.height = self.height;
     _titleLb.y = 0;
     _titleLb.width = 200;
     _titleLb.textColor = kUIColorFromRGB(color_3);
     _titleLb.font = [UIFont systemFontOfSize:15];
     
     _detailLb.height = YES;
     
     
     
     
     
}

-(void)fitFillInOrderModeE{
     self.height = 45;
     
     
     _imgV.hidden = YES;
     
     
     _titleLb.x = _imgV.x + _imgV.width +10;
     _titleLb.height = self.height;
     _titleLb.y = 0;
     _titleLb.width = 200;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.font = [UIFont systemFontOfSize:15];
     
     _detailLb.height = YES;
     
     
     UILabel *numLb = [self.contentView viewWithTag:1341];
     if (!numLb) {
          numLb = [UILabel new];
          numLb.textColor = kUIColorFromRGB(color_8);
          numLb.font = [UIFont systemFontOfSize:15];
          numLb.tag = 1341;
          numLb.textAlignment = NSTextAlignmentCenter;
          [self.contentView addSubview:numLb];
     }
     numLb.text = _dataDic[@"integral"];
     [numLb sizeToFit];
     numLb.height = 21;
     numLb.width +=10;
     numLb.x = _detailLb.x - 15 - numLb.width;
     numLb.y = self.height/2.0 - numLb.height/2.0;
     numLb.hidden = NO;
     
     
//     UIButton *addBtn = [self.contentView viewWithTag:1055];
//     if (!addBtn) {
//          addBtn = [UIButton new];
//          addBtn.width = 36;
//          addBtn.height = self.height;
//          addBtn.x = __SCREEN_SIZE.width - addBtn.width - 5;
//          addBtn setImage:[UIImage im] forState:<#(UIControlState)#>
//     }
//     
//     
//     UIButton *reduceBtn = [self.contentView viewWithTag:1056];
//     if (!reduceBtn) {
//          reduceBtn = [UIButton new];
//          
//     }
//   
     _detailLb.x = 114;
     _detailLb.height = 44;
     _detailLb.y = 0;
     _detailLb.font = [UIFont systemFontOfSize:12];
     _detailLb.width = __SCREEN_SIZE.width - _detailLb.x -15;
     _detailLb.textColor = kUIColorFromRGB(color_8);
     _detailLb.textAlignment = NSTextAlignmentCenter;
     
}

-(void)fitFillInOrderModeB{
     self.height = 40;
     _titleLb.x = 15;
     _titleLb.height = 44;
     _titleLb.y = 0;
     //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
     _titleLb.width = 200;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     
     _imgV.hidden = YES;
     
     _detailLb.height = 44;
     _detailLb.y = 0;
     _detailLb.font = [UIFont systemFontOfSize:13];
     CGSize size = [_detailLb.text size:_detailLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width, 44)];
     _detailLb.width = size.width;
     _detailLb.textColor = kUIColorFromRGB(color_8);
     _detailLb.x = __SCREEN_SIZE.width  -15 -_detailLb.width ;
     
     UILabel *warnLb = [self.contentView viewWithTag:1341];
     if (_dataDic[@"warn"]) {
          if (!warnLb) {
               warnLb = [UILabel new];
               warnLb.textColor = kUIColorFromRGB(color_3);
               warnLb.layer.cornerRadius = 6.0;
               warnLb.layer.masksToBounds = YES;
               warnLb.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
               warnLb.layer.borderWidth = 0.5;
               warnLb.font = [UIFont systemFontOfSize:13];
               warnLb.tag = 1341;
               warnLb.textAlignment = NSTextAlignmentCenter;
               [self.contentView addSubview:warnLb];
          }
          warnLb.text = _dataDic[@"warn"];
          [warnLb sizeToFit];
          warnLb.height = 21;
          warnLb.width +=10;
          warnLb.x = _detailLb.x - 15 - warnLb.width;
          warnLb.y = self.height/2.0 - warnLb.height/2.0;
          warnLb.hidden = NO;
     }else{
          warnLb.hidden = YES;
     }
     
     
}


-(void)fitWarnMode{
    _titleLb.x = 15;
    _titleLb.height = 44;
    _titleLb.y = 0;
    _titleLb.text = @"提示:请确认您此次发起是针对";
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width, 44)];
    _titleLb.width = size.width;
    _titleLb.textColor = kUIColorFromRGB(color_6);
    
    _detailLb.x = _titleLb.x +_titleLb.width + 2 ;
    _detailLb.height = 44;
    _detailLb.y = 0;
    //    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(200, 44)];
    _detailLb.width = __SCREEN_SIZE.width -_detailLb.x - 15;
    _detailLb.textColor = kUIColorFromRGB(color_3);
//    _detailLb.text = busiSystem.agent.sap;
    _detailLb.textAlignment = NSTextAlignmentLeft;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    _imgV.hidden = YES;
    
    self.height = 44;
}


-(void)fitEvaluationShowMoreMode:(BOOL)isShowMore{
     self.height = 35;
     if (isShowMore) {
          _titleLb.text = @"收起全部";
          _imgV.image = [UIImage imageNamed:@"icon_up_arrow"];
     }else{
          _titleLb.text = @"展开全部";
          _imgV.image = [UIImage imageNamed:@"icon_down_arrow"];
     }
     
     _titleLb.x = __SCREEN_SIZE.width/2.0 - 75/2.0;
     _titleLb.height = self.height;
     _titleLb.y = 0;
     _titleLb.font = [UIFont systemFontOfSize:14.0];
     CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width, 44)];
     _titleLb.width = size.width;
     _titleLb.textColor = kUIColorFromRGB(color_8);
     
     _detailLb.hidden = YES;
     _imgV.width = 15;
     _imgV.height = 8;
     _imgV.x  = _titleLb.x+_titleLb.width+8;
     _imgV.y = self.height/2.0 - _imgV.height/2.0;
     
}


-(void)fitBrandShowMoreMode:(BOOL)isShowMore{
     self.height = 40;
     if (isShowMore) {
          _imgV.image = [UIImage imageNamed:@"icon_up_arrow"];
     }else{
          _imgV.image = [UIImage imageNamed:@"icon_down_arrow"];
     }
     
     _titleLb.height = YES;
     _detailLb.hidden = YES;
     
     _imgV.width = 15;
     _imgV.height = 8;
     _imgV.x  = __SCREEN_SIZE.width/2.0 - _imgV.width/2.0;
     _imgV.y = self.height/2.0 - _imgV.height/2.0;
     
}

-(void)setCellData:(NSDictionary *)dataDic{
     _dataDic = dataDic;
    if (dataDic[@"title"]) {
        _titleLb.text = dataDic[@"title"];
    }
    
    if (dataDic[@"detail"]) {
        _detailLb.text = dataDic[@"detail"];
//        _imgV.hidden = YES;
//        _detailLb.hidden = NO;
    }else{
//        _detailLb.hidden = YES;
//        _imgV.hidden = NO;
        _detailLb.text = @"";
    }
    
    
    if (dataDic[@"titleColor"]) {
        _titleLb.textColor = dataDic[@"titleColor"];
    }
    
    if (dataDic[@"detailColor"]) {
        _detailLb.textColor = dataDic[@"detailColor"];
    }
    
    if (dataDic[@"img"]) {
        _imgV.image = [UIImage imageNamed:dataDic[@"img"]];
    }
}

-(NSString *)getData:(NSString *)title{
    if ([title isEqualToString:@"title"]) {
        return _titleLb.text;
    }else{
        return _detailLb.text;
    }
}

@end
