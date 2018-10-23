//
//  AdvertiseViewController.h
//  chenxiaoerSv
//
//  Created by orange on 16/4/7.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface AdvertiseViewController : JYBaseViewController
@property (strong, nonatomic) IBOutlet UIScrollView *adverScroll;
@property (weak, nonatomic) IBOutlet UIButton *pageBtn;
- (IBAction)pageBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)NSString *bgImg;
+(void)hiddenAdvc:(CGFloat)deleyTime;
+(void)showView:(UIViewController *)vc;
@end
