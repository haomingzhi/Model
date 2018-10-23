//
//  SignTableViewCell.m
//  rentingshop
//
//  Created by Steve on 2018/3/22.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "SignTableViewCell.h"

@implementation SignTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     [self fitCellMode];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)fitCellMode{
     self.contentView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     _backView.width = __SCREEN_SIZE.width - 30;
     _backView.layer.cornerRadius = 6.0;
     _backView.layer.shadowColor = kUIColorFromRGB(color_0x0a0204).CGColor;
     _backView.layer.shadowRadius = 8;
     _backView.layer.shadowOpacity = 0.23;
     _backView.layer.shadowOffset = CGSizeMake(0,0);
     
     _imgV.x = _backView.width/2.0 - _imgV.width/2.0;
     
     _title.x = _backView.width/2.0 - _title.width/2.0;
     _couponView.x= 32;
     _couponView.width = _backView.width - 64;
     _couponView.layer.cornerRadius = 6.0;
     _couponView.layer.masksToBounds = YES;
//     _couponView.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     
     _circleAImgV.x= _couponView.width - _circleAImgV.width;
     
     _signWarnLb.x= 0;
     _signDayLb.x = 0;
     _signDayLb.width = _couponView.width;
     _signWarnLb.width=_couponView.width;
     
     
//     //画虚线
//
//     CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//     [shapeLayer setBounds:_couponView.bounds];
//     [shapeLayer setPosition:CGPointMake(_couponView.width-20, 0)];
//     [shapeLayer setFillColor:[UIColor clearColor].CGColor];
//     //  设置虚线颜色为blackColor
//     [shapeLayer setStrokeColor:kUIColorFromRGB(color_2).CGColor];
//     //  设置虚线宽度
//     [shapeLayer setLineWidth:1];
//     [shapeLayer setLineJoin:kCALineJoinRound];
//     //  设置线宽，线间距
//     [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:1], nil]];
//     //  设置路径
//     CGMutablePathRef path = CGPathCreateMutable();
//     CGPathMoveToPoint(path, NULL, _couponView.width-20, 0);
//     CGPathAddLineToPoint(path, NULL,_couponView.width-20, 60);
//     [shapeLayer setPath:path];
//     CGPathRelease(path);
//     //  把绘制好的虚线添加上来
//     [_couponView.layer addSublayer:shapeLayer];
}

-(void)setData:(NSDictionary *)dataDic{
     _signDayLb.text = dataDic[@"title"];
}


@end
