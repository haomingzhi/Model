//
//  PayWayTitleTableViewCell.m
//  ChaoLiu
//
//  Created by air on 15/7/21.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "OnlyTitleTableViewCell.h"

@implementation OnlyTitleTableViewCell
{
    NSDictionary *_dataDic;
    IBOutlet UILabel *_titleLb;
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
    _titleLb.text = dataDic[@"title"];
    if (dataDic[@"textColor"]) {
       _titleLb.textColor = dataDic[@"textColor"];
    }
    if (dataDic[@"textFont"]) {
        _titleLb.font = dataDic[@"textFont"];
    }
    if (dataDic[@"backgroundColor"]) {
        self.backgroundColor = dataDic[@"backgroundColor"];
    }
    [super setCellData:dataDic];
}
-(void)fitDiscoveMode
{
     if(__SCREEN_SIZE.width == 320)
     {
_titleLb.font = [UIFont boldSystemFontOfSize:16];
     }
     else
     _titleLb.font = [UIFont boldSystemFontOfSize:17];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 15;
     _titleLb.y = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     self.height = 34;
}
-(void)fitZhiMaAuthMode
{
     _titleLb.font = [UIFont boldSystemFontOfSize:13];
   
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 34;
     _titleLb.y = 0;
     _titleLb.height = 15;
     _titleLb.textColor = kUIColorFromRGB(color_0xEEB74E);
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x;
     self.height = 28;
     self.contentView.backgroundColor = kUIColorFromRGB(color_F2F2F2);
}
-(void)fitZhiMaAuthModeB
{
     _titleLb.font = [UIFont boldSystemFontOfSize:10];
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.x = 34;
     _titleLb.y = 40;
     _titleLb.height = 100;
     _titleLb.numberOfLines = 0;
     _titleLb.textColor = kUIColorFromRGB(color_0xA7A7A7);
     _titleLb.width = __SCREEN_SIZE.width - _titleLb.x * 2;
     [_titleLb sizeToFit];
     self.height = 140;
     self.contentView.backgroundColor = kUIColorFromRGB(color_F2F2F2);
}
-(void)fitDiscoveModeB
{

     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.numberOfLines = 0;
     _titleLb.x = 15;
     _titleLb.y = 13;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     [_titleLb sizeToFit];
     self.height = _titleLb.y + _titleLb.height + 10;
}

-(void)fitMyActivityMode
{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_3);
    _titleLb.y = 10;
    self.height = 35;
}
-(void)fitShareMode
{
     [self fitSheetMode];
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf7f7f7);
}
-(void)fitSheetMode
{
    self.height = 40;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 18;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
//    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitSheetModeB
{
    self.height = 45;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 18;
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
//    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitMyActivityModeB
{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 13;
    _titleLb.font = [UIFont systemFontOfSize:13];
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.y = 0;
    self.height = 18;
}

-(void)fitCodeMode
{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 40;
    _titleLb.numberOfLines = 2;
    _titleLb.font = [UIFont systemFontOfSize:12];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.y = 10;
     self.contentView.backgroundColor = kUIColorFromRGB(color_9);
    self.height = 50;
}


-(void)setCenterMode:(CGFloat)height withY:(CGFloat)y
{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    if (y == -1) {
        _titleLb.y = height/2.0 - _titleLb.height/2.0;
    }
    else
    {
        _titleLb.y = y;
    }
    _titleLb.height = 30;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    self.height = height;
}
-(void)fitMyRantInfoMode
{
 _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 17;
    _titleLb.y = 15;
    self.height = 42;
}

-(void)fitMyRantInfoModeB
{
 _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_3);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.y = 8;
    self.height = 32;
}

-(void)fitServerInfoStateMode
{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.y = 8;
    self.height = 34;
}

-(void)fitServerInfoStateModeB
{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.y = 10;
    self.height = 36;
}


-(void)fitServerInfoMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 13;
     _titleLb.y = 12;
     _titleLb.font = [UIFont systemFontOfSize:13];
     
     NSArray *arr = _dataDic[@"arr"];
     __block CGFloat height = _titleLb.height + _titleLb.y +9;
     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          NSString *title = obj;
          CGFloat y = height + 21*(idx/2);
          UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(15, y, 13, 13)];
          if (idx %2 == 1) {
               img.x = __SCREEN_SIZE.width/2.0;
          }
          img.image = [UIImage imageNamed:@"icon_radio_selected"];
          [self.contentView addSubview:img];
          
          UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(img.x+img.width +10, y, __SCREEN_SIZE.width/2.0-45, 13)];
          lable.font = [UIFont systemFontOfSize:12];
          lable.text = title;
          lable.textColor = kUIColorFromRGB(color_7);
          [self.contentView addSubview:lable];
          
     }];
     
     self.height = height+ 21*((arr.count+1)/2.0);
}

-(void)fitImgTipMode
{
       self.height = 35;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
 
}

-(void)fitSendInfoMode
{
      self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
  
}

-(void)fitSendInfoModeB
{
    self.height = 110;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.numberOfLines = 0;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.y = 15;
    CGSize sz = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 10000)];
    _titleLb.height = sz.height;
    
}

-(void)fitSendInfoModeC
{
    self.height = 110;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.numberOfLines = 0;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.y = 15;
    CGSize sz = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 10000)];
    _titleLb.height = sz.height;
    if ([_dataDic[@"title"] isEqualToString:@""]) {
        _titleLb.text = @"客服暂未回复";
         _titleLb.textColor = kUIColorFromRGB(color_6);
          self.height = MAX(_titleLb.x + _titleLb.height + 15, 50);
    }
   else
   {
    self.height = MAX(_titleLb.x + _titleLb.height + 15, 150);
   }
}

-(void)fitRantInfoMode
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;

}

-(void)fitUserCerMode
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}
-(void)fitCerModeB
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_3);
    _titleLb.x = 80;
    _titleLb.width = __SCREEN_SIZE.width - 28 - _titleLb.x;
    _titleLb.height = 16;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    UILabel *txtLb = [self.contentView viewWithTag:10332];
    if (!txtLb) {
        txtLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
        txtLb.tag = 10332;
        txtLb.x = 15;
        txtLb.y = 13;
        txtLb.text = @"园区";
        txtLb.numberOfLines = 1;
        txtLb.textColor = kUIColorFromRGB(color_6);
        txtLb.font = [UIFont systemFontOfSize:15];
    }
    [txtLb sizeToFit];
    txtLb.hidden = NO;
    txtLb.y = self.height/2.0 - txtLb.height/2.0;
    [self.contentView addSubview:txtLb];
    UIImageView *imgv = [self.contentView viewWithTag:973];
    if (!imgv) {
        imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 5)];
        imgv.tag = 973;
        
        imgv.y = 19;
        
        
    }
    imgv.x = __SCREEN_SIZE.width - 15 - 9;
    //    if (upDown) {
    imgv.image = [UIImage imageContentWithFileName:@"p_down"];
    //    }
    //    else
    //    {
    //        imgv.image = [UIImage imageContentWithFileName:@"down"];
    //    }
    [self.contentView addSubview:imgv];
    imgv.hidden = NO;
    _titleLb.textAlignment = NSTextAlignmentRight;
}

-(void)fitPersonInfoMode
{
    self.height = 25;
    UILabel *txtLb = [self.contentView viewWithTag:10332];
    txtLb.hidden = YES;
      UIImageView *imgv = [self.contentView viewWithTag:973];
    imgv.hidden = YES;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:13];
    _titleLb.textColor = kUIColorFromRGB(color_5);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 13;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}

-(void)fitCerCompanyMode
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}

-(void)fitEvaModeB
{
     
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.numberOfLines = 0;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 16;
     _titleLb.y = 15;
     CGSize sz = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 10000)];
     _titleLb.height = sz.height;
     self.height = _titleLb.y + _titleLb.height +8;
     
}


-(void)fitEvaInfoMode
{
     
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.numberOfLines = 0;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 16;
     _titleLb.y = 15;
     CGSize sz = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 10000)];
     _titleLb.height = sz.height;
     self.height = _titleLb.y + _titleLb.height +15;
     
}


-(void)fitHtmlMode{
     
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_6);
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.y = 15;
     _titleLb.numberOfLines = 0;

     NSString *htmlString = _dataDic[@"title"];

     NSLog(@"img:%@",htmlString);
     NSInteger www = __SCREEN_SIZE.width - 30;
     htmlString = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><style  type=\"text/css\">img{width:%ldpx; }</style></head><body>%@</body></html>",(long)www,htmlString];
     NSMutableAttributedString  *attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
     //            _detailLb.attributedText = attrStr;
     //            [_detailLb sizeToFit];
     _titleLb.attributedText = attrStr;
     [_titleLb sizeToFit];

    

    self.height = _titleLb.height+_titleLb.y+15;
}

-(void)fitRepairMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.y = 15;
    _titleLb.numberOfLines = 0;
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, __SCREEN_SIZE.height*2)];
    _titleLb.height = size.height;
    if (_titleLb.text.length == 0) {
        self.height = 0.001;
    }else{
        self.height = size.height + 25;
    }
    
}

-(void)fitLiveMode{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.y = 0;
    _titleLb.numberOfLines = 0;
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, __SCREEN_SIZE.height*2)];
    _titleLb.height = size.height;
    if (_titleLb.text.length == 0) {
        self.height = 0.50;
    }else{
        self.height = size.height + 15;
    }
    
}

-(void)fitRepairModeB
{
        _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
        _titleLb.font = [UIFont systemFontOfSize:15];
        _titleLb.textColor = kUIColorFromRGB(color_1);
        _titleLb.x = 15;
        _titleLb.width = __SCREEN_SIZE.width - 30;
        _titleLb.y = 2;
        _titleLb.numberOfLines = 0;
        CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, __SCREEN_SIZE.height*2)];
        _titleLb.height = size.height;
        self.height = size.height + 25;
}

-(void)fitUpPersonInfoMode
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}

-(void)fitUpPersonInfoModeB
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
}

-(void)fitUpPersonInfoModeC
{
   // self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.numberOfLines = 0;
    _titleLb.height = 170;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.y = 0;
    [_titleLb sizeToFit];
    
    self.height = _titleLb.height;
    
}

-(void)fitCompanyCerMode
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = __SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    
    _titleLb.height = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
}
-(void)fitPersonCerInfoMode
{
    self.height = 44;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.x = 15;
    _titleLb.textAlignment = NSTextAlignmentLeft;
    
    _titleLb.height = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}
-(void)fitCompanyInfoMode{
    self.height = 30;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_3);
    _titleLb.x = 15;
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.height = 15;
    _titleLb.y = 15;
}

-(void)fitDesignTitleMode{
    self.height = 35;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}



-(void)fitHasSeeClassMode{
    self.height = 35;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = kUIColorFromRGB(color_8);
    _titleLb.x = 15;
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    self.contentView.backgroundColor = kUIColorFromRGB(color_9);
}

-(void)fitClassMode{
    self.height = 35;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.height = 20;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitGoodsInfoMode{
    self.height = 35;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.height = 17;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}

-(void)fitCerInfoMode
{
        self.height = 44;
        _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
        _titleLb.width = __SCREEN_SIZE.width - 30;
        _titleLb.font = [UIFont systemFontOfSize:15];
        _titleLb.textColor = kUIColorFromRGB(color_6);
        _titleLb.x = 15;
        _titleLb.textAlignment = NSTextAlignmentLeft;
    
        _titleLb.height = 15;
        _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}

-(void)fitMeetingInfoMode{
    self.height = 40;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.height = 16;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _titleLb.numberOfLines = 0;
}

-(void)fitMenuSelectionMode
{
    self.height = 40;
    UILabel *txtLb = [self.contentView viewWithTag:10332];
    txtLb.hidden = YES;
    UIImageView *imgv = [self.contentView viewWithTag:973];
    imgv.hidden = YES;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    //    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = self.height;
    _titleLb.y = 0;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitPublishActMode
{
        self.height = 44;
       _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
        _titleLb.width = __SCREEN_SIZE.width - 30;
        _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_6);
        _titleLb.x = 15;
        _titleLb.textAlignment = NSTextAlignmentLeft;
    
        _titleLb.height = 15;
       _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}

-(void)fitPublishMode
{
    self.height = 35;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.x = 15;
    _titleLb.textAlignment = NSTextAlignmentLeft;
    
    _titleLb.height = 15;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}


-(void)fitFuctionListMode
{
     self.height = 35;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_3);
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
   

}

-(void)fitActInfoMode
{
    self.height = 50;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_3);
    _titleLb.y = 15;
    _titleLb.numberOfLines = 2;
    CGSize s = [_titleLb.text size:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 10000)];
    _titleLb.height = s.height;
    self.height = MAX(50, _titleLb.height + _titleLb.y + 10);
}

-(void)fitActInfoModeB
{
    self.height = 50;
    _titleLb.numberOfLines = 0;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 1000;
   CGSize s = [_titleLb.text size:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 10000)];
    _titleLb.height = s.height;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.y = 2;
    self.height = _titleLb.height + _titleLb.y + 15;
}

-(void)fitNoticeInfoMode
{
    self.height = 50;
    _titleLb.numberOfLines = 0;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 1000;
    CGSize s = [_titleLb.text size:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 10000)];
    _titleLb.height = s.height;
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.y = 14;
    self.height = _titleLb.height + _titleLb.y + 10;
    self.backgroundColor = kUIColorFromRGB(color_9);
    self.contentView.backgroundColor = kUIColorFromRGB(color_9);
}

-(void)fitNoticeInfoModeB
{
    self.height = 50;
    _titleLb.numberOfLines = 0;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 1000;
    CGSize s = [_titleLb.text size:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 10000)];
    _titleLb.height = s.height;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.y = 10;
    self.height = _titleLb.height + _titleLb.y + 18;
     self.backgroundColor = kUIColorFromRGB(color_9);
       self.contentView.backgroundColor = kUIColorFromRGB(color_9);
}

-(void)fitUserCerTipMode
{
    self.height = 100;
    _titleLb.numberOfLines = 0;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 100;
    CGSize s = [_titleLb.text size:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 10000)];
    _titleLb.height = s.height;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_6);
    _titleLb.y = 15;
    self.width = __SCREEN_SIZE.width;
    self.height = MAX(_titleLb.height + _titleLb.y + 10, 100);
}

-(void)fitCerFailTipMode
{
    self.height = 110;
    _titleLb.numberOfLines = 0;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 100;
    CGSize s = [_titleLb.text size:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 10000)];
    _titleLb.height = s.height;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_3);
    _titleLb.y = 42;
    [_titleLb sizeToFit];
    self.width = __SCREEN_SIZE.width;
    
    UILabel *lb = [self.contentView viewWithTag:6663];
    if (!lb) {
        lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, __SCREEN_SIZE.width - 30, 16)];
        lb.tag = 6663;
    }
    lb.text = @"失败原因";
    lb.font = [UIFont systemFontOfSize:15];
    lb.textColor = kUIColorFromRGB(color_3);
    [self.contentView addSubview:lb];
    self.height = MAX(110, _titleLb.y + _titleLb.height + 10);
}

-(void)fitCerFailTipModeB
{
    self.height = 110;
    _titleLb.numberOfLines = 0;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 100;
    CGSize s = [_titleLb.text size:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 10000)];
    _titleLb.height = s.height;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_3);
    _titleLb.y = 42;
    [_titleLb sizeToFit];
    self.width = __SCREEN_SIZE.width;
    
    UILabel *lb = [self.contentView viewWithTag:6663];
    if (!lb) {
        lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, __SCREEN_SIZE.width - 30, 16)];
        lb.tag = 6663;
    }
    lb.text = @"提示";
    lb.font = [UIFont systemFontOfSize:15];
    lb.textColor = kUIColorFromRGB(color_3);
    [self.contentView addSubview:lb];
}


-(void)fitTipMode
{
    self.height = 44;
    _titleLb.numberOfLines = 0;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    CGSize s = [_titleLb.text size:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 10000)];
    _titleLb.height = s.height;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_3);
     [_titleLb sizeToFit];
    _titleLb.y =  self.height/2.0 - _titleLb.height/2.0;
    [_titleLb richText:@"提示：请确认您此次发起是针对" color:kUIColorFromRGB(color_6)];
    self.width = __SCREEN_SIZE.width;
}

-(void)fitTipModeB
{
    self.height = 80;
    _titleLb.numberOfLines = 0;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    CGSize s = [_titleLb.text size:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 10000)];
    _titleLb.height = s.height;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_3);
    [_titleLb sizeToFit];
    _titleLb.y = 10; //self.height/2.0 - _titleLb.height/2.0;
    [_titleLb richText:@"提示：请确认您此次发起是针对" color:kUIColorFromRGB(color_6)];
    self.width = __SCREEN_SIZE.width;
    
    UILabel *lb = [self.contentView viewWithTag:6663];
    if (!lb) {
        lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, __SCREEN_SIZE.width - 30, 16)];
        lb.tag = 6663;
    }
    lb.text = _dataDic[@"detail"];
    lb.font = [UIFont systemFontOfSize:15];
    lb.textColor = kUIColorFromRGB(color_6);
     lb.numberOfLines = 0;
    CGSize ss = [lb.text size:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, 10000)];
    lb.height = ss.height;
    [self.contentView addSubview:lb];

}
-(void)fitSecondCallMode
{
     self.height = 46;
     self.backgroundColor = kUIColorFromRGB(color_2);
     _titleLb.x = 15;//__SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
     _titleLb.textColor = kUIColorFromRGB(color_0x4F5B70);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}
-(void)fitSecondCallModeB
{
     self.height = 32;
     self.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     _titleLb.x = 39;//__SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.y = 12;
     UIImageView *imgv = [self.contentView viewWithTag:973];
     if (!imgv) {
          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14, 14)];
          imgv.tag = 973;

          imgv.y = 15;


     }
     imgv.x = 15;

     imgv.image = [UIImage imageContentWithFileName:@"icon_warn"];

     [self.contentView addSubview:imgv];
}
-(void)fitSecondCallModeC
{
     self.height = 44;
     self.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     _titleLb.x = 15;//__SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.y = 15;
     _titleLb.numberOfLines = 0;
     _titleLb.height = 40;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     [_titleLb sizeToFit];
}
-(void)fitMyAccountMode
{
    self.height = 46;
    self.backgroundColor = kUIColorFromRGB( color_4);
    _titleLb.x = 15;//__SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}

-(void)fitMyAccountModeB
{
    self.height = 47;
    self.backgroundColor = kUIColorFromRGB( color_4);
    _titleLb.x = __SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
    _titleLb.textColor = kUIColorFromRGB(color_8);
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.y = 11;
}

-(void)fitOrderInfoMode
{
    self.height = 40;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    
}

-(void)fitInfoSettingMode
{
    self.height = 45;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}

-(void)fitSignModeA
{
    self.height = 40;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 16;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
}

-(void)fitSignModeB
{
  
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = __SCREEN_SIZE.height * 4;
    _titleLb.y = 0;
    _titleLb.numberOfLines = 0;
    [_titleLb sizeToFit];
    self.height = _titleLb.height + 10;
}

-(void)fitSignModeC
{
    self.height = 125;
    self.backgroundColor = kUIColorFromRGB(color_4);
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.numberOfLines = 2;
    _titleLb.width = 260;
    _titleLb.height = 40;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _titleLb.x = __SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
}

-(void)fitPayPwdMode
{
    self.height = 70;
    self.backgroundColor = kUIColorFromRGB(color_9);
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:12];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.numberOfLines = 1;
    _titleLb.width = 260;
    _titleLb.height = 14;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.y = 44;
    _titleLb.x = __SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
    self.contentView.backgroundColor = kUIColorFromRGB(color_9);
}

-(void)fitPayPwdModeB
{
    self.height = 30;
    self.backgroundColor = kUIColorFromRGB(color_9);
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:12];
    _titleLb.textColor = kUIColorFromRGB(color_8);
    _titleLb.numberOfLines = 1;
    _titleLb.width = 260;
    _titleLb.height = 14;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.y = 10;
    _titleLb.x = __SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
    self.contentView.backgroundColor = kUIColorFromRGB(color_9);
}

-(void)fitPersonMode
{
    self.height = 44;
    self.backgroundColor = kUIColorFromRGB(color_9);
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.numberOfLines = 1;
    _titleLb.width = 260;
    _titleLb.height = 17;
    _titleLb.textAlignment = NSTextAlignmentLeft;
   _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _titleLb.x = 15;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitExamTicketMode
{
     self.height = 45;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     _titleLb.width = 300;
     _titleLb.height = self.height;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.y = 0;
     _titleLb.x = 15;
}

-(void)fitClassifyTitleMode
{
     self.height = 45;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     _titleLb.width = __SCREEN_SIZE.width -30;
     _titleLb.height = 15;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.y = 15;
     _titleLb.x = 15;
}

-(void)fitSpecialInfoMode
{
     self.height = 30;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     _titleLb.width = 260;
     _titleLb.height = 30;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.y = 0;
     _titleLb.x = 15;
}

-(void)fitEvaMode
{
     self.height = 35;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = self.height;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.y = 0;
     _titleLb.x = 15;
}


-(void)fitSelectAddressMode
{
     self.height = 22;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.textColor = kUIColorFromRGB(color_8);
     _titleLb.numberOfLines = 1;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 12;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.y = 10;
     _titleLb.x = 12;
}

-(void)fitCartMode
{
     self.height = 25;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.numberOfLines = 1;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = self.height;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.y = 0;
     _titleLb.x = 15;
     UIButton *btn = [self.contentView viewWithTag:1707];
     btn.hidden = YES;
     self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitCartModeA
{
     self.height = 45;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = self.height;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.y = 0;
     _titleLb.x = 15;
     
     UIButton *btn = [self.contentView viewWithTag:1707];
     if (!btn) {
          btn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width-55, 0, 55, self.height)];
          [btn setTitle:@"清空" forState:UIControlStateNormal];
          btn.titleLabel.font = [UIFont systemFontOfSize:13];
          [btn setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
          [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:btn];
     }
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}


-(void)fitBrandMode:(BOOL)isShowMore
{
     if (isShowMore) {
          _titleLb.numberOfLines = 0;
     }else{
          _titleLb.numberOfLines = 3;
     }
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.y = 15;
     _titleLb.x = 15;
     [_titleLb sizeToFit];
      self.height = _titleLb.y + _titleLb.height;
}

-(void)fitEvaModeA
{
     self.height = 35;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_8);
     _titleLb.numberOfLines = 1;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = self.height;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.y = 0;
     _titleLb.x = 15;
}


-(void)fitEvaModeD
{
   
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.numberOfLines = 2;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 30;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.y = 10;
     _titleLb.x = 15;
     [_titleLb sizeToFit];
       self.height = _titleLb.height + 10 + _titleLb.y;
}

-(void)fitSpecialInfoModeB
{
     self.height = 35;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = self.height;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.y = 0;
     _titleLb.x = 15;
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf6f6f6);
}


-(void)fitSpecialInfoModeC
{
     self.height = 35;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.numberOfLines = 1;
     _titleLb.width = 260;
     _titleLb.height = self.height;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.y = 0;
     _titleLb.x = 15;
}

-(void)fitSpecialInfoModeD
{
     self.height = 35;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_8);
     _titleLb.numberOfLines = 1;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = self.height;
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.y = 0;
     _titleLb.x = 15;
}


-(void)fitSpecialInfoModeA
{
     
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.numberOfLines = 0;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.y = 5;
     _titleLb.x = 15;
     [_titleLb sizeToFit];
     self.height = _titleLb.height + _titleLb.y +15;
}

-(void)dealloc
{
    _titleLb = nil;
}

-(void)fitExamTicketModeB
{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = __SCREEN_SIZE.height * 4;
    _titleLb.y = 0;
    _titleLb.numberOfLines = 0;
    [_titleLb sizeToFit];
    self.height = _titleLb.height + 20;
}

-(void)fitCommentMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 20;
     _titleLb.y = 10;
     _titleLb.numberOfLines = 1;
     [_titleLb sizeToFit];
     self.height = 50;
     self.backgroundColor = kUIColorFromRGB(color_4);
}


-(void)fitClasstifyMode
{
     self.height = 44;
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 20;
     _titleLb.y = 10;
     _titleLb.numberOfLines = 1;
     _titleLb.textAlignment = NSTextAlignmentCenter;
}


-(void)fitPersonInfoSettingMode
{
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 20;
    _titleLb.y = 10;
    _titleLb.numberOfLines = 1;
    [_titleLb sizeToFit];
    self.height = 40;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    self.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitPersonInfoSettingModeB
{
    self.height = 25;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_8);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 20;
    _titleLb.y = 10;
    _titleLb.textAlignment = NSTextAlignmentRight;
    _titleLb.numberOfLines = 1;
//    [_titleLb sizeToFit];
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    self.backgroundColor = kUIColorFromRGB(color_9);
      self.contentView.backgroundColor = kUIColorFromRGB(color_9);
}

-(void)fitWithdrawMode
{
    self.height = 28;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:12];
    _titleLb.textColor = kUIColorFromRGB(color_7);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 14;
    _titleLb.y = 15;
    _titleLb.textAlignment = NSTextAlignmentCenter;
     self.contentView.backgroundColor = kUIColorFromRGB(color_9);
}

-(void)fitWithdrawModeB
{
    self.height = 34;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:13];
    _titleLb.textColor = kUIColorFromRGB(color_8);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 15;
    _titleLb.y = 20;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    self.contentView.backgroundColor = kUIColorFromRGB(color_9);
}

-(void)fitUserCardRechargeMode
{
    self.height = 40;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 17;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _titleLb.textAlignment = NSTextAlignmentLeft;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitUserCardRechargeModeB
{
    self.height = 40;
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 17;
    _titleLb.y = self.height/2.0 - _titleLb.height/2.0;
    _titleLb.textAlignment = NSTextAlignmentLeft;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    _titleLb.attributedText = [_titleLb richText:[UIFont systemFontOfSize:14] text:@"(可输入或选中我购买的礼品卡）" color:kUIColorFromRGB(color_8)];
}

-(void)fitMyInviteMode
{
  
    _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.x = 15;
    _titleLb.width = __SCREEN_SIZE.width - 30;
    _titleLb.height = 17;
    _titleLb.y = 10;
    _titleLb.textAlignment = NSTextAlignmentLeft;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
    _titleLb.height = 900;
    _titleLb.numberOfLines = 0;
    [_titleLb sizeToFit];
      self.height = MAX(__SCREEN_SIZE.height - 64 - 290, _titleLb.height + 20);
}

 
-(void)setNull
{
    _titleLb = nil;
    _dataDic = nil;
}

-(void)fitHeadMode
{
     _titleLb.y = 9;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.height = 12;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     self.height = 35;
     
}

-(void)fitHeadModeB
{
     _titleLb.y = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _titleLb.textAlignment = NSTextAlignmentCenter;
     self.height = 35;
     
}
-(void)fitApplySalesReturnMode
{
     _titleLb.y = 11;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 32;
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}
-(void)fitApplySalesReturnModeC
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 36;
     UIView *v = [self.contentView viewWithTag:9111];
     if (!v) {
          v = [UIView new];
          v.tag = 9111;
          v.height = 36;
          v.width = __SCREEN_SIZE.width - 30;
          v.x = 15;
          v.y = 0;
          v.backgroundColor = kUIColorFromRGB(color_2);
          v.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
          v.layer.borderWidth = 0.5;
          //          v.layer.cornerRadius =

     }
     [self.contentView addSubview:v];

     _titleLb.x = 15;
     _titleLb.height = 15;
     _titleLb.width = 200;
     _titleLb.y = v.height/2.0 - _titleLb.height/2.0;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     [v addSubview:_titleLb];

     UIImageView *imgv = [self.contentView viewWithTag:9222];
     if (!imgv) {
          imgv = [UIImageView new];
          imgv.width = 10;
          imgv.height = 18;
          imgv.y = 9;
          imgv.x = v.width - 15 - imgv.width;
          imgv.tag = 9222;
          imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     }
     [v addSubview:imgv];
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(void)fitFeedbackMode
{
         _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
 self.height = 46;
     UIView *v = [self.contentView viewWithTag:9111];
     if (!v) {
          v = [UIView new];
          v.tag = 9111;
          v.height = 36;
          v.width = __SCREEN_SIZE.width - 30;
          v.x = 15;
          v.y = 10;
          v.backgroundColor = kUIColorFromRGB(color_2);
          v.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
          v.layer.borderWidth = 0.5;
//          v.layer.cornerRadius = 
          
     }
     [self.contentView addSubview:v];
     
     _titleLb.x = 15;
     _titleLb.height = 15;
     _titleLb.width = 200;
     _titleLb.y = v.height/2.0 - _titleLb.height/2.0;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     [v addSubview:_titleLb];
     
     UIImageView *imgv = [self.contentView viewWithTag:9222];
     if (!imgv) {
          imgv = [UIImageView new];
          imgv.width = 10;
          imgv.height = 18;
          imgv.y = 9;
          imgv.x = v.width - 15 - imgv.width;
          imgv.tag = 9222;
          imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     }
     [v addSubview:imgv];
      self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(void)fitPublishEvaMode
{
     [self fitFeedbackModeB];
      _titleLb.textColor = kUIColorFromRGB(color_1);
}

-(void)fitToDoorRecMode
{
     [self fitMyRunMode];
         _titleLb.textColor = kUIColorFromRGB(color_5);
}

-(void)fitToDoorRecModeB
{
     [self fitMyRunMode];
     _titleLb.textColor = kUIColorFromRGB(color_7);
}

-(void)fitToDoorRecModeC
{
     UIImageView *pimgv = [self.contentView viewWithTag:979];
     if (!pimgv) {
          pimgv = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 13, 17)];
          pimgv.tag = 979;

          pimgv.y = 6;
     }
     pimgv.x = 15;
     //    if (upDown) {
     pimgv.image = [UIImage imageContentWithFileName:@"nav_pos"];
     [self.contentView addSubview:pimgv];

     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;

     _titleLb.x = 39;
     _titleLb.y = 11;
     _titleLb.height = 40;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_7);
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     _titleLb.width = __SCREEN_SIZE.width - 39 - 15;
     _titleLb.numberOfLines = 0;
     [_titleLb sizeToFit];
      self.height = _titleLb.y + _titleLb.height + 2;
}


-(void)fitMyRunMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 27;
     _titleLb.x = 15;
     _titleLb.y = 10;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     _titleLb.width = __SCREEN_SIZE.width - 30;
}
-(void)fitMyRunModeB
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;

     _titleLb.x = 15;
     _titleLb.y = 1;
     _titleLb.height = 60;
     _titleLb.numberOfLines = 0;
      _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     [_titleLb sizeToFit];
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);

       self.height = _titleLb.y + _titleLb.height + 1;
}
-(void)fitMyRunModeC
{
     [self fitMyRunMode];
     _titleLb.y = 1;
}

-(void)fitMyRunModeD
{
     [self fitMyRunMode];
     _titleLb.textColor = kUIColorFromRGB(color_3);
     self.height = 17;
     _titleLb.y = 1;
     _titleLb.attributedText = [_titleLb richText:[UIFont systemFontOfSize:15] text:@"联系电话:" color:kUIColorFromRGB(color_1)];
     UIButton *aBtn = [self.contentView viewWithTag:2999];
     if(!aBtn)
     {
          aBtn = [UIButton new];
          aBtn.width = 110;
          aBtn.height = 17;
          CGSize s = [@"联系电话:" size:[UIFont systemFontOfSize:15] constrainedToSize: CGSizeMake(200, 16)];
          aBtn.x = 15 + s.width;
          aBtn.y = 0;
          aBtn.tag = 2999;
//          [aBtn setImage:[UIImage imageContentWithFileName:@"nav_close"] forState:UIControlStateNormal];
          [aBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
     }
     [self.contentView addSubview:aBtn];
}
-(void)fitReplacementMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 26;
     _titleLb.x = 15;
     _titleLb.y = 11;
     _titleLb.height = 14;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.textColor = kUIColorFromRGB(color_5);
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     _titleLb.width = __SCREEN_SIZE.width - 30 - 110;
     
     UIButton *aBtn = [self.contentView viewWithTag:2999];
     if(!aBtn)
     {
          aBtn = [UIButton new];
          aBtn.width = 110;
          aBtn.height = 17;
          aBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//          CGSize s = [@"联系电话:" size:[UIFont systemFontOfSize:15] constrainedToSize: CGSizeMake(200, 16)];
          aBtn.x = __SCREEN_SIZE.width - 15 - aBtn.width;
          aBtn.y = 9;
          aBtn.tag = 2999;
          //          [aBtn setImage:[UIImage imageContentWithFileName:@"nav_close"] forState:UIControlStateNormal];
//          [aBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
     }
     aBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     [aBtn setTitle:_dataDic[@"detail"] forState:UIControlStateNormal];
     [aBtn setTitleColor:kUIColorFromRGB(color_0x757575) forState:UIControlStateNormal];
     [self.contentView addSubview:aBtn];
     
}
-(void)fitReplacementModeB
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;

     _titleLb.x = 15;
     _titleLb.y = 12;
     _titleLb.height = 60;
     _titleLb.numberOfLines = 0;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     [_titleLb sizeToFit];
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);

     self.height = _titleLb.y + _titleLb.height + 1;
}

-(void)fitReplacementConfirmMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 41;
     _titleLb.x = 30;
     _titleLb.y = 14;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     _titleLb.width = __SCREEN_SIZE.width - 30;

     UILabel *gx = [self.contentView viewWithTag:2846];
     if (!gx) {
          gx = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 5, 23)];
          gx.backgroundColor = kUIColorFromRGB(color_3);
          gx.y = self.height/2.0 - gx.height/2.0;
          gx.x = 15;
          gx.tag = 2846;
     }

     [self.contentView addSubview:gx];
}

-(void)fitReplacementOrderInfoMode
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 33;
     _titleLb.x = 15;
     _titleLb.y = 13;
          _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);

}
-(void)fitReplacementOrderInfoModeB
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 41;
     _titleLb.x = 30;
     _titleLb.y = 14;
     _titleLb.height = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     _titleLb.width = __SCREEN_SIZE.width - 30;

     UILabel *gx = [self.contentView viewWithTag:2846];
     if (!gx) {
          gx = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 5, 23)];
          gx.backgroundColor = kUIColorFromRGB(color_3);
          gx.y = self.height/2.0 - gx.height/2.0;
          gx.x = 15;
          gx.tag = 2846;
     }

     [self.contentView addSubview:gx];

     UILabel *lb = [self.contentView viewWithTag:6663];
     if (!lb) {
          lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 120, 18)];
          lb.tag = 6663;
     }
     lb.text = _dataDic[@"detail"];
     lb.font = [UIFont systemFontOfSize:15];
     lb.textColor = kUIColorFromRGB(color_0xf82D45);
     lb.numberOfLines = 1;
     lb.textAlignment = NSTextAlignmentRight;
     lb.x = __SCREEN_SIZE.width - 15 - lb.width;
     lb.y = self.height/2.0 - lb.height/2.0;
     [self.contentView addSubview:lb];
     
}
-(void)fitRecycleInfoMode
{
     self.height = 46;
     _titleLb.x = 15;
     _titleLb.y = 16;
     _titleLb.font = [UIFont systemFontOfSize:16];
     _titleLb.height = 16;

     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 1;
}

-(void)fitPublishAnswerMode
{
     [self fitFeedbackModeB];
        _titleLb.y = 16;
     self.height = 37;
        self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}
-(void)fitFeedbackModeB
{
         _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 33;
     _titleLb.x = 15;
     _titleLb.y = 11;
     _titleLb.height = 12;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
           self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _titleLb.width = 200;
}
-(void)fitApplySalesReturnModeB
{
     _titleLb.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
     self.height = 33;
     _titleLb.x = 15;
     _titleLb.y = 11;
     _titleLb.height = 12;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.textColor = kUIColorFromRGB(color_1);
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     _titleLb.width = 200;
}
-(void)fitTaskCenterMode
{
     _titleLb.y = 10;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 35;
}

-(void)fitOrderInfoModeA
{
     _titleLb.y = 9;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 31;
}
-(void)fitOrderInfoModeB
{
     _titleLb.y = 14;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 41;
}
-(void)fitSendBackGoodsMode
{
     _titleLb.y = 16;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 16;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 46;
}

-(void)fitSendBackGoodsModeB
{
     _titleLb.y = 16;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 16;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.contentView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     self.height = 46;
}
-(void)fitVipCenterModeA
{
     _titleLb.y = 11;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 41;
}

-(void)fitVipCenterModeB
{
     _titleLb.y = 14;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.height = 12;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 41;
}

-(void)fitTraceOrderMode
{
     _titleLb.y = 11;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 35;
}

-(void)fitAuditProgressMode
{
     _titleLb.y = 11;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 36;
}

-(void)fitSeverCenterMode
{
     _titleLb.y = 12;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 35;
}

-(void)fitApplyReturnMode
{
     _titleLb.y = 0;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.height = 120;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.numberOfLines = 0;
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 120;
         self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(void)fitApplyReturnModeB
{
     _titleLb.y = 14;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     self.height = 43;
}

-(void)fitSubmitSuccessMode
{
     _titleLb.y = 15;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.height = 98;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.numberOfLines = 0;
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 105;
     self.contentView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
}

-(void)fitRecordInfoModeA
{
     _titleLb.y = 11;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 50;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 36;
     
//     UIImageView *imgv = [self.contentView viewWithTag:973];
//     if (!imgv) {
//          imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, 13)];
//          imgv.tag = 973;
//
//          imgv.y = 12;
//
//
//     }
//     imgv.x = __SCREEN_SIZE.width - 15 - imgv.width;
//     //    if (upDown) {
//     imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
//     [self.contentView addSubview:imgv];
}
-(void)fitRecordInfoModeB
{
     _titleLb.y = 11;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 36;
}
-(void)fitRecordInfoModeC
{
     _titleLb.y = 11;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 313;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 0;
     [_titleLb sizeToFit];
     self.height = _titleLb.y + _titleLb.height + 12;
}


-(void)fitInvGetGiftMode
{
     _titleLb.y = 15;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 44;
}
-(void)fitQusetionMode
{
     _titleLb.y = 15;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 44;
}
-(void)fitCouponInfoModeA
{
     _titleLb.y = 26;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentCenter;
     self.height = 41;
        self.contentView.backgroundColor = [UIColor clearColor];
     self.backgroundColor = [UIColor clearColor];
}
-(void)fitCouponInfoModeB
{
     _titleLb.y = 10;
     _titleLb.font = [UIFont systemFontOfSize:30];
     _titleLb.height = 30;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _titleLb.textAlignment = NSTextAlignmentCenter;
     self.height = 40;
        self.contentView.backgroundColor = [UIColor clearColor];
       self.backgroundColor = [UIColor clearColor];
}

-(void)fitCouponInfoModeC
{
     _titleLb.y = 10;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.height = 12;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     _titleLb.textAlignment = NSTextAlignmentCenter;
     self.height = 59;
        self.contentView.backgroundColor = [UIColor clearColor];
       self.backgroundColor = [UIColor clearColor];
}

-(void)fitCouponInfoModeD
{
     _titleLb.y = 21;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 48;
     _titleLb.x = 31;
     _titleLb.width = __SCREEN_SIZE.width - 31 * 2;
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 0;
     self.height = 66;
        self.contentView.backgroundColor = [UIColor clearColor];
       self.backgroundColor = [UIColor clearColor];
}

-(void)fitSeverMsgModeB
{
     _titleLb.y = 8;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 32;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 72;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 2;
     self.height = 45;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     UIImageView *imgv = [self.contentView viewWithTag:9222];
     if (!imgv) {
          imgv = [UIImageView new];
          imgv.width = 10;
          imgv.height = 18;
          imgv.y = 14;
          imgv.x = __SCREEN_SIZE.width - 15 - imgv.width;
          imgv.tag = 9222;
          imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     }
     [self.contentView addSubview:imgv];
}

-(void)fitSeverMsgModeA
{
     _titleLb.y = 10;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = 12;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _titleLb.textAlignment = NSTextAlignmentCenter;
     self.height = 30;
    
          self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(void)fitSeverMsgMode
{
     _titleLb.y = 12;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 35;
     
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     
     UIImageView *imgv = [self.contentView viewWithTag:9222];
     if (!imgv) {
          imgv = [UIImageView new];
          imgv.width = 6;
          imgv.height = 6;
          imgv.y = 15;
          imgv.x = __SCREEN_SIZE.width - 15 - imgv.width;
          imgv.tag = 9222;
          imgv.layer.cornerRadius = 3;
          imgv.layer.masksToBounds = YES;
          imgv.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     }
     [self.contentView addSubview:imgv];
     if ([_dataDic[@"isShowDot"] boolValue]) {
          imgv.hidden = NO;
     }
     else
     {
          imgv.hidden = YES;
     }
}

-(void)fitSysMsgModeA
{
     _titleLb.y = 10;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.height = 12;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _titleLb.textAlignment = NSTextAlignmentCenter;
     self.height = 30;
    
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}
-(void)fitSysMsgModeB
{
     _titleLb.y = 8;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 50;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     self.height = 30;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     UIImageView *imgv = [self.contentView viewWithTag:9222];
     if (!imgv) {
          imgv = [UIImageView new];
          imgv.width = 10;
          imgv.height = 18;
          imgv.y = 6;
          imgv.x = __SCREEN_SIZE.width - 15 - imgv.width;
          imgv.tag = 9222;
          imgv.image = [UIImage imageContentWithFileName:@"rightArrow2"];
     }
     [self.contentView addSubview:imgv];
}

-(void)fitActMsgModeA
{
     [self fitSysMsgModeA];
}
-(void)fitActMsgModeB
{
     [self fitSysMsgModeB];
}
-(void)fitActMsgMode
{
     _titleLb.y = 10;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.height = 30;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 2;
     self.height = 45;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)fitSearchMode
{
     _titleLb.y = 15;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 1;
     self.height = 28;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)fitSearchModeB
{
     self.height = 44;
     _titleLb.y = 0;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = self.height;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 1;
//     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     
     UIButton *btn = [self.contentView viewWithTag:1044];
     if (!btn) {
          btn = [UIButton new];
          btn.tag = 1044;
          btn.width = 95;
          btn.height = 25;
          btn.x = __SCREEN_SIZE.width - 15- btn.width;
          btn.y = self.height/2.0 - btn.height/2.0;
          btn.layer.cornerRadius = btn.height/2.0;
          btn.layer.masksToBounds = YES;
          btn.layer.borderColor = kUIColorFromRGB(color_0xb0b0b0).CGColor;
          btn.layer.borderWidth = 0.5;
          
          [btn fitImgAndTitleMode];
          btn.customImgV.image = [UIImage imageNamed:@"icon_delete"];
          btn.customImgV.frame = CGRectMake(15, 5, 12, 14);
          
          btn.customTitleLb.text = @"删除记录";
          btn.customTitleLb.font = [UIFont systemFontOfSize:12];
          btn.customTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
          btn.customTitleLb.frame = CGRectMake(35, 0, 60, 25);
          
          [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
          [self.contentView addSubview:btn];
     }
}

-(void)fitOddsRecMode
{
     _titleLb.y = 16;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 1;
     self.height = 35;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)fitAwardDetailMode
{
     _titleLb.y = 16;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 72;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 1;
     self.height = 44;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
    }

-(void)fitSimilarityGoodsMode
{
     _titleLb.y = 11;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.numberOfLines = 1;
     self.height = 39;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);

}

-(void)fitSysMsgInfoMode
{
     _titleLb.y = 15;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 1750;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 0;
     [_titleLb sizeToFit];
     self.height = _titleLb.height + 20;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)fitVipHelpMode:(CGFloat)y withTitleHeight:(CGFloat)height withH:(CGFloat)h withTitleColor:(UIColor *)color
{
     _titleLb.y = y;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = height;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = color;
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 0;
     self.height = h;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)fitQuestionMode
{
     _titleLb.y = 15;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = __SCREEN_SIZE.height - 64;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 0;
     [_titleLb sizeToFit];
     self.height = __SCREEN_SIZE.height - 64;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)fitEvaRuleMode
{
     _titleLb.y = 15;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 99999;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 0;
     [_titleLb sizeToFit];
     self.height = _titleLb.height + _titleLb.y + 10;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}
-(void)fitSecKillMode
{
     _titleLb.y = 6;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     _titleLb.attributedText = [_titleLb richText:@"距本场结束剩余" color:kUIColorFromRGB(color_5)];
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.numberOfLines = 1;
     self.height = 29;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)fitAboutUsModeA
{
     self.height = 187;
     _titleLb.y = 133;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = 54;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     //     _titleLb.attributedText = [_titleLb richText:@"距本场结束剩余" color:kUIColorFromRGB(color_5)];
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.numberOfLines = 0;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}
-(void)fitAboutUsModeB
{
     self.height = 100;
     _titleLb.y = 60;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 34;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_0x757575);
     _titleLb.attributedText = [_titleLb richText:[UIFont systemFontOfSize:15] text:@"《桔用户协议》" color:kUIColorFromRGB(color_3)];
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.numberOfLines = 0;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}


-(void)fitTopicMode
{
     _titleLb.y = 10;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
//     _titleLb.attributedText = [_titleLb richText:@"距本场结束剩余" color:kUIColorFromRGB(color_5)];
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 1;
     self.height = 24;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);

}
-(void)fitPublishSecHandMode
{
     _titleLb.y = 10;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_7);
     //     _titleLb.attributedText = [_titleLb richText:@"距本场结束剩余" color:kUIColorFromRGB(color_5)];
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 1;
     self.height = 34;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}
-(void)fitPublishSecHandModeB
{
     _titleLb.y = 11;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_8);
     //     _titleLb.attributedText = [_titleLb richText:@"距本场结束剩余" color:kUIColorFromRGB(color_5)];
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 1;
     self.height = 27;
     self.contentView.backgroundColor = [UIColor clearColor];
     self.backgroundColor = [UIColor clearColor];
}
-(void)fitTopicModeB
{
     _titleLb.y = 15;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = 10000;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_7);
     //     _titleLb.attributedText = [_titleLb richText:@"距本场结束剩余" color:kUIColorFromRGB(color_5)];
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 0;
     [_titleLb sizeToFit];
     self.height = _titleLb.y + _titleLb.height;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     
}

-(void)fitTopicModeC
{
     _titleLb.y = 9;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     //     _titleLb.attributedText = [_titleLb richText:@"距本场结束剩余" color:kUIColorFromRGB(color_5)];
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 1;
     self.height = 23;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     
}

-(void)fitTopicModeD
{
     _titleLb.y = 0;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = 36;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     //     _titleLb.attributedText = [_titleLb richText:@"距本场结束剩余" color:kUIColorFromRGB(color_5)];
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 0;
     self.height = 43;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     
}

-(void)fitTopicModeE
{
     _titleLb.y = 12;
     _titleLb.font = [UIFont systemFontOfSize:14];
     _titleLb.height = 14;
     _titleLb.x = 15;
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_3);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 1;
     self.height = 35;
     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
     
}

-(void)fitCancelOrderModeA
{
     _titleLb.y = 14;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 15;
   
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.x = __SCREEN_SIZE.width/2.0 - _titleLb.width/2.0;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.numberOfLines = 1;
     self.height = 41;
     UIButton *aBtn = [self.contentView viewWithTag:2999];
     if(!aBtn)
     {
          aBtn = [UIButton new];
          aBtn.width = 43;
          aBtn.height = 41;
          aBtn.x = __SCREEN_SIZE.width - aBtn.width;
          aBtn.y = 0;
          aBtn.tag = 2999;
          [aBtn setImage:[UIImage imageContentWithFileName:@"nav_close"] forState:UIControlStateNormal];
          [aBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
     }
     [self.contentView addSubview:aBtn];

     self.contentView.backgroundColor = kUIColorFromRGB(color_2);
}
-(void)btnAction:(UIButton *)btn
{
     if (self.handleAction) {
          self.handleAction(@{});
     }
}
-(void)fitCancelOrderModeB
{
     _titleLb.y = 12;
     _titleLb.font = [UIFont systemFontOfSize:15];
     _titleLb.height = 36;
     
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_5);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 2;
     self.height = 48;
}
-(void)fitRegMode
{
     _titleLb.y = 10;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.height = 30;

     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_8);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 2;
     self.height = 45;
}
-(void)fitPointRankMode
{
     self.height = 46;
     _titleLb.x = 15;
     _titleLb.y = 16;
     _titleLb.font = [UIFont systemFontOfSize:16];
     _titleLb.height = 16;

     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 1;
}

-(void)fitRecycleRecMode
{
     self.height = 25;
     _titleLb.x = 15;
     _titleLb.y = 9;
     _titleLb.font = [UIFont systemFontOfSize:12];
     _titleLb.height = 12;

     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.textAlignment = NSTextAlignmentCenter;
     _titleLb.numberOfLines = 1;
     self.contentView.backgroundColor = kUIColorFromRGB(color_0xf5f5f5);
     UILabel *line = [self.contentView viewWithTag:2322];
     if (!line) {
         line = [UILabel new];
          line.tag = 2322;
          line.width = __SCREEN_SIZE.width;
          line.height = 2;
          line.backgroundColor = kUIColorFromRGB(color_3);
          line.y = 23;
     }
     [self.contentView addSubview:line];

}
-(void)fitCancelOrderModeC
{
     _titleLb.y = 15;
     _titleLb.font = [UIFont systemFontOfSize:13];
     _titleLb.height = 13;
     
     _titleLb.width = __SCREEN_SIZE.width - 30;
     _titleLb.x = 15;
     _titleLb.textColor = kUIColorFromRGB(color_7);
     _titleLb.textAlignment = NSTextAlignmentLeft;
     _titleLb.numberOfLines = 2;
     self.height = 28;
}

@end
