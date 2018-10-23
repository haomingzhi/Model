//
//  PinpaiTableViewCell.m
//  oranllcshoping
//
//  Created by air on 2017/7/20.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "PinpaiTableViewCell.h"

@implementation PinpaiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     self.aView = (PinpaiView *)[[NSBundle mainBundle] loadNibNamed:@"PinpaiView" owner:nil options:nil].lastObject;
     self.aView.x = 15;
     [self.contentView addSubview:self.aView];
     
     self.bView = (PinpaiView *)[[NSBundle mainBundle] loadNibNamed:@"PinpaiView" owner:nil options:nil].lastObject;
     self.bView.x = (__SCREEN_SIZE.width - 15) - self.bView.width;
     [self.contentView addSubview:self.bView];
     
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
     self.aView.titleLb.text = dataDic[@"aTitle"];
     self.aView.detailLb.text = dataDic[@"aDetail"];
     self.aView.markLb.text = dataDic[@"aMark"];
     
     self.bView.titleLb.text = dataDic[@"bTitle"];
     self.bView.detailLb.text = dataDic[@"bDetail"];
     self.bView.markLb.text = dataDic[@"bMark"];
     
     self.aView.imgV.image = [UIImage imageContentWithFileName:dataDic[@"aimg"]];
     
       self.bView.imgV.image = [UIImage imageContentWithFileName:dataDic[@"bimg"]];
   
}

-(void)fitPinpaiMode
{
     __weak PinpaiTableViewCell *weakSelf = self;
     self.height = 138;
     [self.aView fitPinpaiMode];
     [self.bView fitPinpaiMode];
     self.bView.x = (__SCREEN_SIZE.width - 15) - self.bView.width;
     self.height = self.aView.height;
     [self.aView setHandleAction:^(id o){
          if (weakSelf.handleAction) {
               weakSelf.handleAction(@{@"row":weakSelf.dataDic[@"row"]?:@"",@"index":@0});
          }
     }];
     [self.bView setHandleAction:^(id o){
          if (weakSelf.handleAction) {
               weakSelf.handleAction(@{@"row":weakSelf.dataDic[@"row"]?:@"",@"index":@1});
          }
     }];
}

@end
