//
//  TitleCollectionReusableView.m
//  oranllcshoping
//
//  Created by Steve on 2017/8/9.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "TitleCollectionReusableView.h"

@implementation TitleCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellData:(NSDictionary *)dataDic{
     _titleLb.text = dataDic[@"title"];
}

-(void)fitCellMode{
     self.height = 45;
     
     if (!_titleLb) {
          _titleLb = [UILabel new];
          _titleLb.x = 15;
          _titleLb.width = __SCREEN_SIZE.width - 30;
          _titleLb.height = self.height;
          _titleLb.y = 0;
          _titleLb.font = [UIFont systemFontOfSize:14];
          _titleLb.textColor = kUIColorFromRGB(color_1);
          [self addSubview:_titleLb];
     }
     
}

@end
