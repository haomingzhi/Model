//
//  SeckillView.h
//  oranllcshoping
//
//  Created by air on 2017/7/19.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeckillView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *imgV;
@property (strong, nonatomic) IBOutlet UIImageView *markImgV;
@property (strong, nonatomic) IBOutlet UILabel *titleLb;
@property (strong, nonatomic) IBOutlet UILabel *detailLb;
@property (strong, nonatomic) IBOutlet UILabel *markLb;
@property (strong, nonatomic) IBOutlet UILabel *contentLb;
@property (strong, nonatomic)  UILabel *extrLb;
@property (strong, nonatomic)UIButton *cartBtn;
@property (strong, nonatomic)IBOutlet UIButton *btn;
@property (strong, nonatomic)NSDictionary *dataDic;
@property(nonatomic,strong) void (^handleAction)(id sender);
-(void)fitSecKillMode;
+(SeckillView *)createView;
-(void)fitFreshMode;
-(void)fitYouLikeMode;
-(void)fitHeadMode;
@end
