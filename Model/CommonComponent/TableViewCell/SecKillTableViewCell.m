//
//  SecKillTableViewCell.m
//  oranllcshoping
//
//  Created by air on 2017/7/20.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SecKillTableViewCell.h"

@implementation SecKillTableViewCell
{
     
}
- (void)awakeFromNib {
     [super awakeFromNib];
     // Initialization code
     self.aView = (SeckillView *)[[NSBundle mainBundle] loadNibNamed:@"SeckillView" owner:nil options:nil].lastObject;
     self.aView.x = 47;
     [self.contentView addSubview:self.aView];
     
     self.bView = (SeckillView *)[[NSBundle mainBundle] loadNibNamed:@"SeckillView" owner:nil options:nil].lastObject;
     self.bView.x = (__SCREEN_SIZE.width - 47 - self.bView.width)  ;
     [self.contentView addSubview:self.bView];
     self.aView.imgV.contentMode =UIViewContentModeCenter;
     self.bView.imgV.contentMode = UIViewContentModeCenter;
//     self.aView.imgV.backgroundColor = kUIColorFromRGB(color_f8f8f8);
//     self.bView.imgV.backgroundColor = kUIColorFromRGB(color_f8f8f8);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
     [super setSelected:selected animated:animated];
     
     // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)dataDic
{
     _dataDic = dataDic;
     self.aView.titleLb.text = dataDic[@"aTitle"];
     self.aView.detailLb.text = dataDic[@"aDetail"];
     self.aView.contentLb.text = dataDic[@"aContent"];
     self.aView.markLb.text = dataDic[@"aMark"];
     
     self.bView.titleLb.text = dataDic[@"bTitle"];
     self.bView.detailLb.text = dataDic[@"bDetail"];
     self.bView.contentLb.text = dataDic[@"bContent"];
     self.bView.markLb.text = dataDic[@"bMark"];
     self.aView.imgV.image = [UIImage imageNamed:dataDic[@"default"]];
     self.bView.imgV.image = [UIImage imageNamed:dataDic[@"default"]];
     self.bView.imgV.contentMode = UIViewContentModeCenter;
     self.aView.imgV.contentMode = UIViewContentModeCenter;
     if ([dataDic[@"aimg"] isKindOfClass:[NSString class]]) {
           self.bView.imgV.contentMode = UIViewContentModeCenter;
           self.aView.imgV.image = [UIImage imageContentWithFileName:dataDic[@"aimg"]];
     }
     else if ([dataDic[@"aimg"] isKindOfClass:[BUImageRes class]])
     {
          BUImageRes *im = dataDic[@"aimg"];
          [im download:self callback:@selector(getImgNotification:) extraInfo:@{@"img":self.aView.imgV}];
     }

     if ([dataDic[@"bimg"] isKindOfClass:[NSString class]]) {
           self.bView.imgV.contentMode = UIViewContentModeCenter;
          self.bView.imgV.image = [UIImage imageContentWithFileName:dataDic[@"bimg"]];
     
       }else if ([dataDic[@"bimg"] isKindOfClass:[BUImageRes class]])
       {
            BUImageRes *im = dataDic[@"bimg"];
            [im download:self callback:@selector(getImgNotification:) extraInfo:@{@"img":self.bView.imgV}];
       }
}

-(void)getImgNotification:(BSNotification *) noti
{
     if(noti.error.code ==0)
     {
          BUImageRes *res =(BUImageRes *) noti.target;
          if (res.isCached) {
               UIImageView *imgv = noti.extraInfo[@"img"];
               UIImage *im =  [UIImage imageWithContentsOfFile:res.cacheFile];//[[UIImage imageWithContentsOfFile:res.cacheFile] getSubImage:CGRectMake(0, 0, __SCREEN_SIZE.width, 400/720.0 * __SCREEN_SIZE.width) centerBool:YES];
               if (im) {
                    imgv.image = im;
                    imgv.contentMode = UIViewContentModeScaleToFill;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"imgChange" object:self];
               }
               
          }
     }
}

-(void)fitSecKillMode
{
     __weak SecKillTableViewCell *weakSelf = self;
     self.height = 180;
     [self.aView fitSecKillMode];
     [self.aView setHandleAction:^(id o){
          if (weakSelf.handleAction) {
               weakSelf.handleAction(@{@"row":weakSelf.dataDic[@"row"]?:@"",@"index":@0});
          }
     }];
     [self.bView fitSecKillMode];
     [self.bView setHandleAction:^(id o){
          if (weakSelf.handleAction) {
               weakSelf.handleAction(@{@"row":weakSelf.dataDic[@"row"]?:@"",@"index":@1});
          }
     }];
     if (__SCREEN_SIZE.width == 320) {
          self.aView.x = 30;
          self.bView.x = (__SCREEN_SIZE.width - 40 - self.bView.width)  ;
     }
     else
     {
          self.aView.x = 47;
          self.bView.x = (__SCREEN_SIZE.width - 47 - self.bView.width)  ;
     }
}

-(void)fitYouLikeMode
{
     self.height = 176;
     [self.aView fitYouLikeMode];
     [self.bView fitYouLikeMode];
     if (__SCREEN_SIZE.width == 320) {
          self.aView.x = 40;
          self.bView.x = (__SCREEN_SIZE.width - 40 - self.bView.width)  ;
     }
     else
     {
          self.aView.x = 47;
          self.bView.x = (__SCREEN_SIZE.width - 47 - self.bView.width)  ;
     }
     __weak SecKillTableViewCell *weakSelf = self;
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
-(void)fitHeadMode
{
     self.height = 184;
     [self.aView fitHeadMode];
     [self.bView fitHeadMode];
     
     if ([_dataDic[@"aHot"] boolValue]) {
          self.aView.markLb.hidden = NO;
     }else{
          self.aView.markLb.hidden = YES;
     }
     
     if ([_dataDic[@"bHot"] boolValue]) {
          self.bView.markLb.hidden = NO;
     }else{
          self.bView.markLb.hidden = YES;
     }
     
     if (!_dataDic[@"bTitle"]) {
          self.bView.hidden = YES;
     }
     else
     {
          self.bView.hidden = NO;
     }
     
     self.aView.backgroundColor = kUIColorFromRGB(color_2);
     self.aView.layer.cornerRadius = 6.0;
     self.aView.layer.masksToBounds = YES;
     self.bView.backgroundColor = kUIColorFromRGB(color_2);
     self.bView.layer.cornerRadius = 6.0;
     self.bView.layer.masksToBounds = YES;
     
     self.aView.y = 0;
     self.bView.y = 0;
     if (__SCREEN_SIZE.width == 320) {
          self.aView.x = 10;
          self.bView.x = (__SCREEN_SIZE.width - 10 - self.bView.width)  ;
     }
     else
     {
          self.aView.x = 15;
          self.bView.x = (__SCREEN_SIZE.width - 15 - self.bView.width)  ;
     }
     __weak SecKillTableViewCell *weakSelf = self;
     [self.aView setHandleAction:^(id o){
          if (weakSelf.handleAction) {
               weakSelf.handleAction(@{@"row":weakSelf.dataDic[@"row"]?:@"",@"index":@0,@"obj":o});
          }
     }];
     [self.bView setHandleAction:^(id o){
          if (weakSelf.handleAction) {
               weakSelf.handleAction(@{@"row":weakSelf.dataDic[@"row"]?:@"",@"index":@1,@"obj":o});
          }
     }];

}
-(void)fitPopularityRecModeA
{
     self.height = 176;
     [self.aView fitYouLikeMode];
     [self.bView fitYouLikeMode];
     if (__SCREEN_SIZE.width == 320) {
          self.aView.x = 40;
          self.bView.x = (__SCREEN_SIZE.width - 40 - self.bView.width)  ;
     }
     else
     {
          self.aView.x = 47;
          self.bView.x = (__SCREEN_SIZE.width - 47 - self.bView.width)  ;
     }
     __weak SecKillTableViewCell *weakSelf = self;
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
-(void)fitPopularityRecModeB
{
     self.height = 192;
     self.aView.y = 16;
     self.bView.y = 16;
     [self.aView fitYouLikeMode];
     [self.bView fitYouLikeMode];
     if (__SCREEN_SIZE.width == 320) {
          self.aView.x = 30;
          self.bView.x = (__SCREEN_SIZE.width - 40 - self.bView.width)  ;
     }
     else
     {
          self.aView.x = 47;
          self.bView.x = (__SCREEN_SIZE.width - 47 - self.bView.width)  ;
     }
     __weak SecKillTableViewCell *weakSelf = self;
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
