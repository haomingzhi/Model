//
//  SignATableViewCell.m
//  rentingshop
//
//  Created by Steve on 2018/3/22.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "SignATableViewCell.h"
#import "SignCouponView.h"

@implementation SignATableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     [self fitCellMode];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic{
     _dataDic = dataDic;
}


-(void)fitCellMode{
     self.contentView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     _backView.width = __SCREEN_SIZE.width - 30;
     _backView.x= 15;
     _backView.layer.cornerRadius = 6.0;
     _backView.layer.shadowColor = kUIColorFromRGB(color_0x0a0204).CGColor;
     _backView.layer.shadowRadius = 8;
     _backView.layer.shadowOpacity = 0.23;
     _backView.layer.shadowOffset = CGSizeMake(0,0);
     
     _titleLb.x = _backView.width/2.0 - _titleLb.width/2.0;
     
     
     NSArray *arr = _dataDic[@"arr"];
     
     [_viewsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          UIView *v = obj;
          [v removeFromSuperview];
     }];
     
     _viewsArr = [NSMutableArray new];
     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          NSDictionary *dic = obj;
          NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SignCouponView" owner:self options:nil];
          SignCouponView *view = [[[NSBundle mainBundle] loadNibNamed:@"SignCouponView" owner:self options:nil] firstObject];
          view.x= 32;
          view.y = 40+66*idx;
          view.height = 54;
          view.width = _backView.width - 64;
          [view setCellData:dic];
          view.layer.cornerRadius = 6.0;
          view.layer.masksToBounds = YES;
          [_backView addSubview:view];
          [_viewsArr addObject:view];
     }];
     
     
     _warnView.x= 32;
     _warnView.y = 40+66*arr.count;
     _warnView.width = _backView.width - 64;
     _warnView.layer.cornerRadius = 6.0;
     _warnView.layer.masksToBounds = YES;
     //     _couponView.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     
     NSString *htmlString = _dataDic[@"signRule"];
     //        if ([htmlString containsString:@"</"] || [htmlString containsString:@"/>"]  ) {
     NSLog(@"img:%@",htmlString);
     //            NSString *style = [NSString stringWithFormat:@"<style  type=\"text/css\">img{width:220px,height:200px}</style>"];
     //            htmlString = [NSString stringWithFormat:@"%@%@",style,htmlString];
     NSInteger www = __SCREEN_SIZE.width - 64-20;
     htmlString = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta charset=\"utf-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><style  type=\"text/css\">img{width:%ldpx; }</style></head><body>%@</body></html>",(long)www,htmlString];
     NSMutableAttributedString  *attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
     _warnLbA.width = www;
     _warnLbA.x = 10;
     _warnLbA.attributedText = attrStr;
     [_warnLbA sizeToFit];
   
     _warnView.height = _warnLbA.y + _warnView.height +12;
     
     
     _backView.height = _warnView.y + _warnView.height +15;
     self.height = _backView.height;
 
}

@end
