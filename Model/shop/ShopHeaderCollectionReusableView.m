//
//  ShopHeaderCollectionReusableView.m
//  compassionpark
//
//  Created by Steve on 2017/1/22.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ShopHeaderCollectionReusableView.h"

@implementation ShopHeaderCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [self addGestureRecognizer:tap];
}

-(void)tapGesture:(UITapGestureRecognizer *)gesture{
    NSLog(@"tap gesture");
    if (self.handleAction) {
        self.handleAction(@{});
    }
}

-(void)setCellData:(NSDictionary *)dataDic{
    _titleLb.text = dataDic[@"title"];
    _detailLb.text = dataDic[@"detail"];
    
}

-(void)fitCellMode{
    self.backgroundColor = kUIColorFromRGB(color_4);
    _titleLb.x = 15;
    _titleLb.y = 0;
    _titleLb.height = 35;
    _titleLb.textColor = kUIColorFromRGB(color_5);
    
    _detailLb.y=0;
    _detailLb.height = 35;
    _detailLb.x = __SCREEN_SIZE.width -15-_detailLb.width;
    _detailLb.textColor = kUIColorFromRGB(color_5);
    
    _lineImage.x = __SCREEN_SIZE.width - 50;
}

-(void)fitExamMode{
    self.backgroundColor = kUIColorFromRGB(color_4);
    _titleLb.x = 15;
    _titleLb.y = 0;
    _titleLb.height = 35;
    _titleLb.textColor = kUIColorFromRGB(color_1);
    _titleLb.font = [UIFont systemFontOfSize:13.0];
    
    _detailLb.y=0;
    _detailLb.height = 35;
    _detailLb.x = __SCREEN_SIZE.width -15-_detailLb.width;
    _detailLb.textColor = kUIColorFromRGB(color_5);
    
    _lineImage.x = __SCREEN_SIZE.width - 50;
}
@end
