//
//  SignCouponView.m
//  rentingshop
//
//  Created by Steve on 2018/3/22.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "SignCouponView.h"

@implementation SignCouponView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//-(void)awakeFromNib {
//     [[NSBundlemainBundle]loadNibNamed:@"SignCouponView"owner:selfoptions:nil];
//     [selfaddSubview:self.testView];
//}
//
//-(instancetype)initWithFrame:(CGRect)frame
//{
//     self = [super initWithFrame:frame];
//     if (self) {
//          [[NSBundle mainBundle]loadNibNamed:@"SignCouponView"owner:selfoptions:nil];
//          [self addSubview:self.testView];
//     }
//     return self;
//}
//
//-(instancetype)ini
//{
//     self = [superinitWithFrame:frame];
//     if (self) {
//          [[NSBundle mainBundle]loadNibNamed:@"SignCouponView"owner:selfoptions:nil];
//          [selfaddSubview:self.testView];
//     }
//     return self;
//}


-(void)setCellData:(NSDictionary *)dataDic{
     _titleLb.text = dataDic[@"title"];
     _detailLb.text = dataDic[@"detail"];
     _stateLb.text = dataDic[@"state"];
     if ([dataDic[@"isGet"] boolValue]) {
          self.backgroundColor = kUIColorFromRGB(color_0xff5c72);
     }
}

-(void)fitMode{
     self.layer.cornerRadius =6.0;
     self.layer.masksToBounds = YES;
}

@end
