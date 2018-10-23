//
//  FiveTitleTableViewCell.m
//  taihe
//
//  Created by LinFeng on 2016/11/22.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "FiveTitleTableViewCell.h"

@implementation FiveTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//
-(void)setCellData:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    _titleLb.text = dataDic[@"title"];
    _addressTitleLb.text = dataDic[@"priceTitle"];
    _addressLb.text = dataDic[@"price"];
    _tellTitleLb.text = dataDic[@"saleNum"];
    _tellLb.text = dataDic[@"stock"];
}

-(void)fitCellMode{
    
    _titleLb.x = 15;
    _titleLb.y = 10;
    _titleLb.width = __SCREEN_SIZE.width -30;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 100)];
    _titleLb.height = size.height;
    _titleLb.numberOfLines = 2;
    
    
    _addressTitleLb.x = 15;
    _addressTitleLb.y = _titleLb.y +_titleLb.height +10;
    _addressTitleLb.text = @"售价";
    _addressTitleLb.font = [UIFont systemFontOfSize:13];
    [_addressTitleLb sizeToFit];
    _addressTitleLb.textColor = kUIColorFromRGB(color_1);
    
    
    //金额
    _addressLb.x = _addressTitleLb.x +_addressTitleLb.width + 3;
    _addressLb.y = _addressTitleLb.y;
    _addressLb.font = [UIFont systemFontOfSize:13];
    _addressLb.textColor = kUIColorFromRGB(color_1);
    [_addressLb sizeToFit];
    _addressLb.numberOfLines = 1;
    
    _tellTitleLb.x = 15;
    _tellTitleLb.y = _addressLb.y +_addressLb.height +10;
//    _tellTitleLb.text = @"";
    _tellTitleLb.font = [UIFont systemFontOfSize:13];
    _tellTitleLb.textColor = kUIColorFromRGB(color_8);
    [_tellTitleLb sizeToFit];
    
    
    _tellLb.y = _tellTitleLb.y;
    _tellLb.font = [UIFont systemFontOfSize:13];
    _tellLb.textColor = kUIColorFromRGB(color_8);
    [_tellLb sizeToFit];
    _tellLb.x = __SCREEN_SIZE.width - 15 - _tellLb.width;
    _tellLb.numberOfLines = 1;
    
    if (_starBtn == nil) {
        _starBtn = [UIButton new];
        _starBtn.width = _starBtn.height = 15;
        _starBtn.y = _addressLb.y;
        [_starBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_starBtn];
        
        _collectionBtn = [UIButton new];
        _collectionBtn.height = 15;
        _collectionBtn.y = _starBtn.y;
        [_collectionBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _collectionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_collectionBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
        [self.contentView addSubview:_collectionBtn];
    }
    
    
}


-(void)changeCollectionBtnState:(BOOL)isCollection{
    if (isCollection) {//已收藏
        _collectionBtn.tag = 0;
        _starBtn.tag = 0;
        [_collectionBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
        [_collectionBtn sizeToFit];
        _collectionBtn.height = 15;
        _collectionBtn.x = __SCREEN_SIZE.width -15 -_collectionBtn.width;
        [_starBtn setBackgroundImage:[UIImage imageNamed:@"icon_star_selected"] forState:UIControlStateNormal];
        _starBtn.x = _collectionBtn.x -7 - _starBtn.width;
        
    }else{
        _collectionBtn.tag = 1;
        _starBtn.tag = 1;
        [_collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectionBtn sizeToFit];
        _collectionBtn.height = 15;
        _collectionBtn.x = __SCREEN_SIZE.width -15 -_collectionBtn.width;
        [_starBtn setBackgroundImage:[UIImage imageNamed:@"icon_star_normal"] forState:UIControlStateNormal];
        _starBtn.x = _collectionBtn.x -7 - _starBtn.width;
    }
}


-(void)fitTeacherMode{
    
    _titleLb.x = 15;
    _titleLb.y = 10;
    _titleLb.width = __SCREEN_SIZE.width -30;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    CGSize size = [_titleLb.text size:_titleLb.font constrainedToSize:CGSizeMake(_titleLb.width, 30)];
    _titleLb.height = size.height;
    _titleLb.numberOfLines = 1;
    
    
    _addressTitleLb.x = 15;
    _addressTitleLb.y = _titleLb.y +_titleLb.height +8;
//    _addressTitleLb.text = @"服务价格";
    _addressTitleLb.font = [UIFont systemFontOfSize:13];
    [_addressTitleLb sizeToFit];
    _addressTitleLb.textColor = kUIColorFromRGB(color_1);
    
    
    //金额
    _addressLb.x = _addressTitleLb.x +_addressTitleLb.width + 3;
    _addressLb.y = _addressTitleLb.y;
    _addressLb.font = [UIFont systemFontOfSize:13];
    _addressLb.textColor = kUIColorFromRGB(color_3);
    [_addressLb sizeToFit];
    _addressLb.numberOfLines = 1;
    
    
    //所在地
    
    _tellTitleLb.y = _addressTitleLb.y;
    _tellTitleLb.font = [UIFont systemFontOfSize:13];
    _tellTitleLb.textColor = kUIColorFromRGB(color_8);
    [_tellTitleLb sizeToFit];
    _tellTitleLb.x = __SCREEN_SIZE.width - _tellTitleLb.width -15;
    
    _tellLb.hidden = YES;
    
//    _tellLb.y = _tellTitleLb.y;
//    _tellLb.font = [UIFont systemFontOfSize:13];
//    _tellLb.textColor = kUIColorFromRGB(color_8);
//    [_tellLb sizeToFit];
//    _tellLb.x = __SCREEN_SIZE.width - 15 - _tellLb.width;
//    _tellLb.numberOfLines = 1;
    
//    if (_starBtn == nil) {
//        _starBtn = [UIButton new];
//        _starBtn.width = _starBtn.height = 15;
//        _starBtn.y = _addressLb.y;
//        [_starBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_starBtn];
//        
//        _collectionBtn = [UIButton new];
//        _collectionBtn.height = 15;
//        _collectionBtn.y = _starBtn.y;
//        [_collectionBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
//        _collectionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//        [_collectionBtn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
//        [self.contentView addSubview:_collectionBtn];
//    }
//    
//    if ([_dataDic[@"isCollect"] boolValue]) {
//        [_collectionBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
//        [_collectionBtn sizeToFit];
//        _collectionBtn.height = 15;
//        _collectionBtn.x = __SCREEN_SIZE.width -15 -_collectionBtn.width;
//        [_starBtn setBackgroundImage:[UIImage imageNamed:@"icon_star_selected"] forState:UIControlStateNormal];
//        _starBtn.x = _collectionBtn.x -7 - _starBtn.width;
//        
//    }else{
//        [_collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
//        [_collectionBtn sizeToFit];
//        _collectionBtn.height = 15;
//        _collectionBtn.x = __SCREEN_SIZE.width -15 -_collectionBtn.width;
//        [_starBtn setBackgroundImage:[UIImage imageNamed:@"icon_star_normal"] forState:UIControlStateNormal];
//        _starBtn.x = _collectionBtn.x -7 - _starBtn.width;
//    }
    
    
}

-(void)btnAction:(UIButton *)sender{
    if (self.handleAction) {
        self.handleAction(@{@"state":@(sender.tag)});//0:收藏 1:未收藏
    }
}


-(void)fitConfirmOrderMode{
    
    self.height = 40;
    
    _titleLb.x = 15;
    _titleLb.y = 0;
    _titleLb.font = [UIFont systemFontOfSize:15];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.text = @"礼品卡";
    [_titleLb sizeToFit];
    _titleLb.height = self.height;
    _titleLb.numberOfLines = 1;
    
    //余额
    _addressTitleLb.x = _titleLb.x + _titleLb.width +4;
    _addressTitleLb.y = 0;
    _addressTitleLb.font = [UIFont systemFontOfSize:15];
    [_addressTitleLb sizeToFit];
    _addressTitleLb.height = self.height;
    _addressTitleLb.textColor = kUIColorFromRGB(color_8);
    
    
    //本次使用金额
    
    _addressLb.y = 0;
    _addressLb.font = [UIFont systemFontOfSize:15];
    _addressLb.textColor = kUIColorFromRGB(color_1);
    [_addressLb sizeToFit];
    _addressLb.x = __SCREEN_SIZE.width - 15-_addressLb.width;
    _addressLb.height = self.height;
    _addressLb.numberOfLines = 1;
    
    
    //
    _tellTitleLb.text = @"本次使用";
    _tellTitleLb.y = 0;
    _tellTitleLb.font = [UIFont systemFontOfSize:15];
    _tellTitleLb.textColor = kUIColorFromRGB(color_8);
    [_tellTitleLb sizeToFit];
    _tellTitleLb.x = _addressLb.x -10 - _tellTitleLb.width;
    _tellTitleLb.height = self.height;
    
    _tellLb.hidden = YES;
    
    
    
}

-(void)fitLawMode{
    _titleLb.x = 15;
    _titleLb.y = 15;
    _titleLb.width = __SCREEN_SIZE.width -30;
    _titleLb.height = 16;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    
    _addressTitleLb.x = 15;
    _addressTitleLb.y = _titleLb.y +_titleLb.height +15;
    _addressTitleLb.text = @"地址";
    [_addressTitleLb sizeToFit];
    _addressTitleLb.textColor = kUIColorFromRGB(color_6);
    
    _addressLb.x = _addressTitleLb.x +_addressTitleLb.width +45;
    _addressLb.y = _addressTitleLb.y;
    _addressLb.width = __SCREEN_SIZE.width - _addressLb.x -15;
    CGSize size = [_addressLb.text size:_addressLb.font  constrainedToSize:CGSizeMake(_addressLb.width, __SCREEN_SIZE.height*2)];
    _addressLb.height = size.height;
    _addressLb.numberOfLines = 0;
    _addressLb.textColor = kUIColorFromRGB(color_1);
    
    _tellTitleLb.x = 15;
    _tellTitleLb.y = _addressLb.y +_addressLb.height +15;
    _tellTitleLb.text = @"联系电话";
    [_tellTitleLb sizeToFit];
    _tellTitleLb.textColor = kUIColorFromRGB(color_6);
    
    
    _tellLb.x = _addressLb.x;
    _tellLb.y = _tellTitleLb.y;
    _tellLb.width = __SCREEN_SIZE.width - _addressLb.x -15;
    size = [_tellLb.text size:_titleLb.font  constrainedToSize:CGSizeMake(_tellLb.width, 100)];
    _tellLb.height = size.height;
    _tellLb.numberOfLines = 0;
    _tellLb.textColor = kUIColorFromRGB(color_1);
    
}


-(void)fitMoneyUserMode{
    _titleLb.x = 15;
    _titleLb.y = 15;
    _titleLb.width = __SCREEN_SIZE.width -30;
    _titleLb.height = 16;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    
    _addressTitleLb.x = 15;
    _addressTitleLb.y = _titleLb.y +_titleLb.height +15;
    _addressTitleLb.text = @"联系电话";
    [_addressTitleLb sizeToFit];
    _addressTitleLb.textColor = kUIColorFromRGB(color_6);
    
    _addressLb.x = _addressTitleLb.x +_addressTitleLb.width +45;
    _addressLb.y = _addressTitleLb.y;
    _addressLb.width = __SCREEN_SIZE.width - _addressLb.x -15;
    CGSize size = [_addressLb.text size:_addressLb.font  constrainedToSize:CGSizeMake(_addressLb.width, __SCREEN_SIZE.height*2)];
    _addressLb.height = size.height;
    _addressLb.numberOfLines = 0;
    _addressLb.textColor = kUIColorFromRGB(color_1);
    
//    _tellTitleLb.x = 15;
//    _tellTitleLb.y = _addressLb.y +_addressLb.height +15;
//    _tellTitleLb.text = @"联系电话";
//    [_tellTitleLb sizeToFit];
//    _tellTitleLb.textColor = kUIColorFromRGB(color_6);
//    
//    
//    _tellLb.x = _addressLb.x;
//    _tellLb.y = _tellTitleLb.y;
//    _tellLb.width = __SCREEN_SIZE.width - _addressLb.x -15;
//    size = [_tellLb.text size:_titleLb.font  constrainedToSize:CGSizeMake(_tellLb.width, 100)];
//    _tellLb.height = size.height;
//    _tellLb.numberOfLines = 0;
//    _tellLb.textColor = kUIColorFromRGB(color_1);
    
    _tellLb.hidden = YES;
    _tellTitleLb.hidden = YES;
    
    self.height = _addressLb.y +_addressLb.height+15;
}

//-(void)setCellData:(NSDictionary *)dataDic{
//    _titleLb.text = dataDic[@"title"];
//    _addressLb.text = dataDic[@"address"];
//    _tellLb.text = dataDic[@"tell"];
//    
//    _titleLb.text = dataDic[@"aTitle"];
//    _addressTitleLb.text = dataDic[@"bTitle"];
//    _addressLb.text = dataDic[@"cTitle"];
//    _tellTitleLb.text = dataDic[@"dTitle"];
//    _tellLb.text = dataDic[@"eTitle"];
//}

-(void)fitGiftMode
{
    _titleLb.x = 15;
    _titleLb.y = 10;
    
    _addressTitleLb.x = __SCREEN_SIZE.width/2.0 + 15;
    _addressTitleLb.y = 10;
    
    _addressLb.x = 15;
    _addressLb.y = 35;
    
    _tellTitleLb.x = __SCREEN_SIZE.width/2.0 + 15;
    _tellTitleLb.y = 35;
    
    _tellLb.x = __SCREEN_SIZE.width - 100;
    _tellLb.y = 35;
    _tellLb.width = 85;
    _tellLb.textAlignment = NSTextAlignmentRight;
    
}

-(void)fitOrderMode
{
    self.height = 40;
    _titleLb.text = _dataDic[@"aTitle"];
    _titleLb.x = 15;
    _titleLb.y = 10;
    _titleLb.width = 30;
    _titleLb.font = [UIFont systemFontOfSize:13];
    
    _addressTitleLb.text = _dataDic[@"bTitle"];
    _addressTitleLb.x = 43;
    _addressTitleLb.y =  self.height/2.0 - _addressTitleLb.height/2.0;
    _addressTitleLb.width = 165;
    _addressTitleLb.font = [UIFont systemFontOfSize:13];
    _addressTitleLb.textColor = kUIColorFromRGB(color_3);
    
    _addressLb.text = _dataDic[@"cTitle"];
    _addressLb.x = _addressTitleLb.width + _addressTitleLb.x + 10;
    _addressLb.y =  self.height/2.0 - _addressLb.height/2.0;
    _addressLb.width = 30;
    _addressLb.font = [UIFont systemFontOfSize:13];
    _addressLb.textColor = kUIColorFromRGB(color_1);
    
    _tellTitleLb.text = _dataDic[@"dTitle"];
    _tellTitleLb.x = _addressLb.x + _addressLb.width + 3;
    _tellTitleLb.y =  self.height/2.0 - _tellTitleLb.height/2.0;
    _tellTitleLb.width = 60;
    _tellTitleLb.font = [UIFont systemFontOfSize:13];
    _tellTitleLb.textColor = kUIColorFromRGB(color_3);
    
    _tellLb.text = _dataDic[@"eTitle"];
    _tellLb.x = __SCREEN_SIZE.width - 85;
    _tellLb.y = self.height/2.0 - _tellLb.height/2.0;
    _tellLb.width = 70;
    _tellLb.textAlignment = NSTextAlignmentRight;
    _tellLb.font = [UIFont systemFontOfSize:13];
    _tellLb.textColor = kUIColorFromRGB(color_8);
    self.backgroundColor = kUIColorFromRGB(color_4);
    
}

-(void)fitMyAccountMode
{
    self.height = 54;
   
    _titleLb.width = 110;//卡片名称
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    [_titleLb sizeToFit];
    _titleLb.x = 15;
  _titleLb.y = 10;
    
    
    _addressLb.width = 126;//密码
    _addressLb.font = [UIFont systemFontOfSize:14];
    _addressLb.textColor = kUIColorFromRGB(color_3);
   _addressLb.attributedText = [_addressLb richText:@"密码" color:kUIColorFromRGB(color_1)];
    [_addressLb sizeToFit];
    _addressLb.x = 15;
    _titleLb.y = self.height/2.0 - (_titleLb.height + 6 + _addressLb.height)/2.0 ;
    _addressLb.y = _titleLb.y + _titleLb.height + 6;
    
    
    _addressTitleLb.width = 180;//卡号
    _addressTitleLb.font = [UIFont systemFontOfSize:14];
    _addressTitleLb.textColor = kUIColorFromRGB(color_3);
    _addressTitleLb.attributedText = [_addressTitleLb richText:@"卡号" color:kUIColorFromRGB(color_1)];
    [_addressTitleLb sizeToFit];
    _addressTitleLb.x = __SCREEN_SIZE.width - 15 - _addressTitleLb.width;
    
    _tellLb.width = 90;//是否绑定充值
    _tellLb.textAlignment = NSTextAlignmentRight;
    _tellLb.font = [UIFont systemFontOfSize:14];
    
    [_tellLb sizeToFit];
    _tellLb.x = __SCREEN_SIZE.width - 15 - _tellLb.width;
    _addressTitleLb.y = self.height/2.0 - (_addressTitleLb.height + 6 + _tellLb.height)/2.0;
    _tellLb.y = _addressTitleLb.y + _addressTitleLb.height + 6;
    if ([_tellLb.text isEqualToString:@"未使用"]) {
        _tellLb.textColor = kUIColorFromRGB(color_1);
    }else{
        _tellLb.textColor = kUIColorFromRGB(color_8);
    }
    
    
    
    _tellTitleLb.width = 94;//日期
    _tellTitleLb.font = [UIFont systemFontOfSize:14];
     _tellTitleLb.textColor = kUIColorFromRGB(color_8);
    [_tellTitleLb sizeToFit];
     _tellTitleLb.x = _tellLb.x - 10 - _tellTitleLb.width;
     _tellTitleLb.y = _tellLb.y;
    

    
   
    self.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitOrderInfoMode
{
    self.height = 68;
    _titleLb.text = _dataDic[@"aTitle"];
    _titleLb.x = 15;
    _titleLb.y = 6;
    _titleLb.width = 30;
    _titleLb.font = [UIFont systemFontOfSize:13];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    [_titleLb sizeToFit];
    
      _addressTitleLb.width = 120;
    _addressTitleLb.text = _dataDic[@"bTitle"];
    _addressTitleLb.x = __SCREEN_SIZE.width - 15 - _addressTitleLb.width;
    _addressTitleLb.y =  _titleLb.y;
    _addressTitleLb.textAlignment = NSTextAlignmentRight;
    _addressTitleLb.font = [UIFont systemFontOfSize:13];
    _addressTitleLb.textColor = kUIColorFromRGB(color_1);
    
    _addressLb.text = _dataDic[@"cTitle"];
    _addressLb.x = 15;
    _addressLb.y =  _titleLb.y + _titleLb.height + 7;
    _addressLb.width = __SCREEN_SIZE.width - _addressLb.x - 40;
    _addressLb.height = 40;
    _addressLb.numberOfLines = 2;
    _addressLb.font = [UIFont systemFontOfSize:13];
    _addressLb.textColor = kUIColorFromRGB(color_1);
    [_addressLb sizeToFit];
    self.backgroundColor = kUIColorFromRGB(color_4);
    self.height = _addressLb.y +_addressLb.height + 5;
}

-(void)fitMyGiftMode
{
    self.height = 54;
    
    _titleLb.width = 110;//卡片名称
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    [_titleLb sizeToFit];
    _titleLb.x = 15;
    _titleLb.y = 10;
    
    
    _addressLb.width = 126;//密码
    _addressLb.font = [UIFont systemFontOfSize:14];
    _addressLb.textColor = kUIColorFromRGB(color_3);
    _addressLb.attributedText = [_addressLb richText:@"密码" color:kUIColorFromRGB(color_1)];
    [_addressLb sizeToFit];
    _addressLb.x = 15;
    _titleLb.y = self.height/2.0 - (_titleLb.height + 6 + _addressLb.height)/2.0 ;
    _addressLb.y = _titleLb.y + _titleLb.height + 6;
    
    
    _addressTitleLb.width = 180;//卡号
    _addressTitleLb.font = [UIFont systemFontOfSize:14];
    _addressTitleLb.textColor = kUIColorFromRGB(color_3);
    _addressTitleLb.attributedText = [_addressTitleLb richText:@"卡号" color:kUIColorFromRGB(color_1)];
    [_addressTitleLb sizeToFit];
    _addressTitleLb.x = __SCREEN_SIZE.width - 15 - _addressTitleLb.width;
    
    _tellLb.width = 90;//是否绑定充值
    _tellLb.textAlignment = NSTextAlignmentRight;
    _tellLb.font = [UIFont systemFontOfSize:14];
    
    [_tellLb sizeToFit];
    _tellLb.x = __SCREEN_SIZE.width - 15 - _tellLb.width;
    _addressTitleLb.y = self.height/2.0 - (_addressTitleLb.height + 6 + _tellLb.height)/2.0;
    _tellLb.y = _addressTitleLb.y + _addressTitleLb.height + 6;
    if ([_tellLb.text isEqualToString:@"未使用"]) {
        _tellLb.textColor = kUIColorFromRGB(color_1);
    }else{
        _tellLb.textColor = kUIColorFromRGB(color_8);
    }
    
    _tellTitleLb.width = 94;//日期
    _tellTitleLb.font = [UIFont systemFontOfSize:14];
    _tellTitleLb.textColor = kUIColorFromRGB(color_8);
    [_tellTitleLb sizeToFit];
    _tellTitleLb.x = _tellLb.x - 10 - _tellTitleLb.width;
    _tellTitleLb.y = _tellLb.y;
    
    
    
    
    self.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)fitWithdrawMode:(UIColor *)color
{
    self.height = 55;
    
    _titleLb.width = 110;//账号
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = kUIColorFromRGB(color_1);
    [_titleLb sizeToFit];
    _titleLb.x = 15;
    _titleLb.y = 10;
    
    
    _addressLb.width = 126;//密码
    _addressLb.font = [UIFont systemFontOfSize:14];
    _addressLb.textColor = kUIColorFromRGB(color_8);
//    _addressLb.attributedText = [_addressLb richText:@"密码" color:kUIColorFromRGB(color_1)];
    [_addressLb sizeToFit];
    _addressLb.x = 15;
    _titleLb.y = self.height/2.0 - (_titleLb.height + 6 + _addressLb.height)/2.0 ;
    _addressLb.y = _titleLb.y + _titleLb.height + 6;
    
    
    _addressTitleLb.width = 180;//卡号
    _addressTitleLb.font = [UIFont systemFontOfSize:16];
    _addressTitleLb.textColor = kUIColorFromRGB(color_1);
//    _addressTitleLb.attributedText = [_addressTitleLb richText:@"卡号" color:kUIColorFromRGB(color_1)];
    [_addressTitleLb sizeToFit];
    _addressTitleLb.x = __SCREEN_SIZE.width - 15 - _addressTitleLb.width;
    
    _tellLb.width = 90;//是否绑定充值
    _tellLb.textAlignment = NSTextAlignmentRight;
    _tellLb.font = [UIFont systemFontOfSize:14];
    _tellLb.textColor = color;
    [_tellLb sizeToFit];
    _tellLb.x = __SCREEN_SIZE.width - 15 - _tellLb.width;
    _addressTitleLb.y = self.height/2.0 - (_addressTitleLb.height + 6 + _tellLb.height)/2.0;
    _tellLb.y = _addressTitleLb.y + _addressTitleLb.height + 6;
    
    _tellTitleLb.hidden = YES;
//    _tellTitleLb.width = 94;//日期
//    _tellTitleLb.font = [UIFont systemFontOfSize:14];
//    _tellTitleLb.textColor = kUIColorFromRGB(color_8);
//    [_tellTitleLb sizeToFit];
//    _tellTitleLb.x = _tellLb.x - 10 - _tellTitleLb.width;
//    _tellTitleLb.y = _tellLb.y;
    self.contentView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self modifiDeleteBtn];
}

-(void)setNull
{
    _addressLb = nil;
    _titleLb = nil;
    _addressTitleLb = nil;
    _tellLb = nil;
    _tellTitleLb = nil;
    _dataDic = nil;
    _starBtn = nil;
    _collectionBtn = nil;
}

-(void)dealloc
{
    _collectionBtn = nil;
}
@end
