//
//  AdvertiseViewController.m
//  chenxiaoerSv
//
//  Created by orange on 16/4/7.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "AdvertiseViewController.h"
#import "TabViewControllerManager.h"
//#import "OrderViewController.h"
#import "BUSystem.h"
#import "LoginViewController.h"
//#import "BUGetAd.h"
//#import "CommonWebViewViewController.h"
@interface AdvertiseViewController ()<UIScrollViewDelegate,UINavigationControllerDelegate>
{
     int timeCount;
     BOOL isClick;
     BUImageRes *_curImgRes;
     UIImageView *_bgImgV;
}

@end

@implementation AdvertiseViewController

-(void)viewDidAppear:(BOOL)animated{
     [super viewDidAppear:animated];
     _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerHandle) userInfo:nil repeats:YES];


}
- (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view from its nib.

     [self addAdvertise];
     [self addBgImg];

}

-(void)addBgImg
{
     _bgImgV = [UIImageView new];
     NSString *bgImgName = @"";
     //    if (!_bgImg) {
     //        if (__IPHONE6PLUS) {
     //            bgImgName= @"启动页1242x2208";
     //        }
     //        else if (__IPHONE6)
     //        {
     //            bgImgName= @"启动页750x1334";
     //        }
     //        else if (__IPHONE5)
     //        {
     //            bgImgName= @"启动页640x1136";
     //        }
     //        else{
     //            bgImgName= @"启动页640x960";
     //        }
     //    }
     //    else
     //    {
     //        bgImgName = _bgImg;
     //    }

     _bgImgV.image = [UIImage imageNamed:bgImgName];
     _bgImgV.width = __SCREEN_SIZE.width;
     _bgImgV.height = 518/360.0 * __SCREEN_SIZE.width;
     [self.view addSubview:_bgImgV];
     UIImageView *markImgV = [UIImageView new];
     markImgV.width = 156;//__SCREEN_SIZE.width;
     markImgV.height = 57;
     markImgV.x = __SCREEN_SIZE.width/2.0 - markImgV.width/2.0;
     markImgV.y = __SCREEN_SIZE.height - markImgV.height - 31;
     markImgV.image = [UIImage imageContentWithFileName:@"adMark"];
     [self.view addSubview:markImgV];
}
-(void)addAdvertise
{
     [busiSystem.agent geTadvertising:@"" withUserid:@"" observer:self callback:@selector(getAdNotification:)];
     //     [busiSystem.headManager getAdInfo:[NSString stringWithFormat:@"%.0f",__SCREEN_SIZE.width] withHeight:[NSString stringWithFormat:@"%.0f",__SCREEN_SIZE.height] observer :self callback:@selector(getAdNotification:) extraInfo:nil];
}
-(void)getAdNotification:(BSNotification *)notice
{

     //    BASENOTIFICATION(notice);
     _bgImgV.hidden = YES;
     //    if(busiSystem.headManager.addata.count == 0)
     //    {
     //        [self goToManinUi];
     //    }
     //    else
     //    {
     //NSLog(@"addatacount-=-=-=%lu",(unsigned long)busiSystem.outUserManager.addata.count);
     [self addScroll];
     [self addPageControl];
     [self getImageView];
     [_pageBtn setTitle:@"跳过广告" forState:UIControlStateNormal];
     _pageBtn.backgroundColor = kUIColorFromRGBWithAlpha(color_15, 0.3);
     _pageBtn.width = 66;
     _pageBtn.height = 21;
     [_pageBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     _pageBtn.layer.cornerRadius = _pageBtn.height/2.0;
     _pageBtn.layer.masksToBounds = YES;
     _pageBtn.x = __SCREEN_SIZE.width - 15 - _pageBtn.width;
     //    [_pageBtn setBackgroundImage:[UIImage imageNamed:@"跳过.png"] forState:UIControlStateNormal];
     [self performSelector:@selector(delayToMain) withObject:nil afterDelay: 3];
     //    }


}
-(void)getImageView
{
     //    for (int i = 0; i<busiSystem.headManager.addata.count; i++) {
     UIImageView *imageView = [_adverScroll viewWithTag:1];

     //        if (busiSystem.agent.addata.count<3) {
     //            imageView.image = [UIImage imageNamed:@"广告页1"];
     //        }else{
     //            BUGetAd *adModel = busiSystem.headManager.addata;
     //             NSLog(@"admodelimageurl====%@",adModel.adimage);
     //
     //        _curImgRes = adModel.adImgPath ;
     BUImageRes *img = busiSystem.agent.adImg;
     if (img.isCached) {
          imageView.image =  [UIImage imageWithContentsOfFile:img.cacheFile];
          imageView.alpha = 0;
               [UIView animateWithDuration:0.3 animations:^{
                    imageView.alpha = 1;
               }];
     }
     else {
          [img download:self callback:@selector(getImgNotification:) extraInfo:@{@"imageView":imageView}];
     }
     //            [adModel.adimage displayRemoteImage:imageView imageName:@"广告页1"];
     //        }
     //    }
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
     isClick = YES;
     [_timer invalidate];
     _timer = nil;
     //    UIWindow *window = [UIApplication sharedApplication].delegate.window;
     //    window.rootViewController = [TabViewControllerManager mainUI];
     ////    [UIView transitionWithView:window duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:nil ];
     //    int page = floor((_adverScroll.contentOffset.x - __SCREEN_SIZE.width/2)/__SCREEN_SIZE.width)+1;
     //    NSLog(@"%d",page);
     //    BUGetAd *rec = busiSystem.headManager.addata[page];
     //    [CommonWebViewViewController setPushWebViewController:rec withTitle:rec.rectitle withBlock:nil];
}


-(void)getImgNotification:(BSNotification *)noti
{
     //    ISTOLOGIN;
     UIImageView * imageView =noti.extraInfo[@"imageView"];
     if(noti.error.code ==0)
     {
          BUImageRes *res =(BUImageRes *) noti.target;
          if (_curImgRes != res) {
               return;
          }
          if (res.isCached) {
               imageView.image =  [UIImage imageWithContentsOfFile:res.cacheFile];
               //             self.height = [self heightOfCellWithImg:_imgV.image];
               imageView.alpha = 0;
               [UIView animateWithDuration:0.3 animations:^{
                    imageView.alpha = 1;
               }];
          }
     }
}

-(void)addScroll
{
     [_adverScroll setScrollEnabled:NO];
     _adverScroll.delegate = self;
     _adverScroll.bounces = NO;
     _adverScroll.frame = CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height);
     _adverScroll.contentSize = CGSizeMake(__SCREEN_SIZE.width  ,__SCREEN_SIZE.height);
     [_adverScroll setContentOffset:CGPointMake(0, 0) animated:YES];
     _adverScroll.pagingEnabled = YES;
     _adverScroll.showsHorizontalScrollIndicator = NO;
     //    for (int i = 0; i<busiSystem.headManager.addata.count; i++) {
     UIImageView *imageView = [UIImageView new];
     imageView.tag =  1;
     UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
     imageView.userInteractionEnabled = YES;
     [imageView addGestureRecognizer:singleTap];
     //imageView.image = [UIImage imageNamed:@"广告页1.png"];
     imageView.frame = CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height - 122);
     [_adverScroll addSubview:imageView];
     //    }
}


-(void)addPageControl
{
     _pageControl.y = __SCREEN_SIZE.height-80;
     //    _pageControl.bounds = CGRectMake(0, 0, 55, 20);
     //    _pageControl.center=CGPointMake(__SCREEN_SIZE.width/2, __SCREEN_SIZE.height-60);
     _pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
     _pageControl.currentPageIndicatorTintColor=[UIColor grayColor];
     _pageControl.currentPage = 0;
     _pageControl.numberOfPages = 1;//busiSystem.headManager.addata.count;
     if (_pageControl.numberOfPages > 1) {
          [self.view addSubview:_pageControl];
     }
     else
     {
          [_pageControl removeFromSuperview];
     }

}

-(void)timerHandle
{
     //    timeCount = timeCount+1;
     //    if ( !busiSystem.headManager.addata ) {
     //        return;
     //    }
     [_adverScroll setContentOffset:CGPointMake(__SCREEN_SIZE.width*timeCount, 0) animated:YES];

     _pageControl.currentPage =timeCount;
}
-(void)delayToMain
{
     if (isClick==YES) {
          [_timer invalidate];
          _timer = nil;
     }
     else{
          [self goToManinUi];
     }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     _pageControl.currentPage = _adverScroll.contentOffset.x/__SCREEN_SIZE.width;



}
- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}




/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)goToManinUi
{
     UIWindow *window = [UIApplication sharedApplication].delegate.window;
     //    window.rootViewController = [TabViewControllerManager mainUI];
     //
     //    [UIView transitionWithView:window duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:nil ];
     UIView *vv = [window.rootViewController.view viewWithTag:55550];
     [UIView animateWithDuration:1 animations:^{

          vv.alpha = 0;
     } completion:^(BOOL finished) {
          vv.hidden = YES;
          [vv removeFromSuperview];
     }];

}

- (IBAction)pageBtnClick:(id)sender {
     isClick = YES;
     [_timer invalidate];
     _timer = nil;
     [self goToManinUi];

}

+(void)hiddenAdvc:(CGFloat)deleyTime
{
     [AdvertiseViewController performSelector:@selector(hiddenAdvc) withObject:nil afterDelay:deleyTime];
}

+(void)hiddenAdvc
{
     UIWindow *window = [UIApplication sharedApplication].delegate.window;
     UIView *vv = [window.rootViewController.view viewWithTag:55550];
     [UIView animateWithDuration:1 animations:^{

          vv.alpha = 0;
     } completion:^(BOOL finished) {
          if (finished) {
               vv.hidden = YES;
               [vv removeFromSuperview];
//              [[(UINavigationController *)window.rootViewController viewControllers].firstObject view].hidden  = NO;
               [[NSNotificationCenter defaultCenter] postNotificationName:@"loadTip" object:nil];
          }

          //          HUDSHOW(@"加载中");
     }];
}

+(void)showView:(UIViewController *)vc
{
//     UIWindow *window = [UIApplication sharedApplication].delegate.window;
     AdvertiseViewController *advc = [AdvertiseViewController new];
     advc.view.height = __SCREEN_SIZE.height;
     advc.view.width = __SCREEN_SIZE.width;
     advc.view.tag = 55550;
//     advc.view.alpha = 0;
     [vc.view addSubview:advc.view];
//     [UIView animateWithDuration:0.3 animations:^{
//          advc.view.alpha = 1;
//     }];
}
@end
