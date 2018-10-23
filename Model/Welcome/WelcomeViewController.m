//
//  MiniWelcomeViewController.m
//  MiniClient
//
//  Created by longgong on 14-8-11.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "WelcomeViewController.h"
#import "AppDelegate.h"
#import "BUSystem.h"
#import "TabViewControllerManager.h"
#import "AdvertiseViewController.h"
//#import "AdvertiseViewController.h"
@interface WelcomeViewController ()

@end

@implementation WelcomeViewController{
     NSArray *imgArr ;
     NSMutableArray * imageViews;
     UIPageControl *_pageCl;
     NSInteger _pageCount;
     UIButton *_skipBtn;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
     self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
     if (self) {
          // Custom initialization
          _pageCl = [UIPageControl new];
          _pageCl.width = 60;
          _pageCl.height = 30;
          _pageCl.pageIndicatorTintColor = kUIColorFromRGB(color_lineColor);
          _pageCl.currentPageIndicatorTintColor = kUIColorFromRGB(color_0xff5d5b);
          _pageCl.x = __SCREEN_SIZE.width/2.0 - _pageCl.width/2.0;
          _pageCl.y = __SCREEN_SIZE.height - 50;
          _pageCl.numberOfPages = 3;
          _pageCount = 4;
          //         _pageCl.hidden = YES;
          [self.view addSubview:_pageCl];
     }
     return self;
}


-(void)loadView
{
     self.pageView =  [[MyPageView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height)];
     //    [self.pageView showPageController];
     self.pageView.pageController.numberOfPages = 4;
     self.pageView.delegate = self;
     //     self.pageView.showPageController = NO;
     //     self.pageView.pageController.hidden = YES;
     self.view = self.pageView;

}

- (void)viewDidLoad
{
     [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
     self.pageView.delegate = self;
     self.pageView.cycle = FALSE;
     busiSystem.agent.canPush = YES;
     //if (!__IOS7)
     //    [self wantsFullScreenLayout];

     imageViews = [[NSMutableArray alloc]init];

     //     [self getData];
     [self addView];


}


-(void)getData{
     [busiSystem.agent getSliGuide:self callback:@selector(getSliGuideNotification:)];
}


-(void)getSliGuideNotification:(BSNotification *)noti{

     if (busiSystem.agent.adImgList.count != 0) {
          imgArr = [NSArray arrayWithArray:busiSystem.agent.adImgList];

     }
     [self addView];
}


-(void)addView{
     if(imgArr.count == 0){
          if(__IPHONEX)
          {
               imgArr=@[@"引导页1-1125x2436",@"引导页2-1125x2436",@"引导页3-1125x2436"];
          }
          else
               if (__IPHONE6PLUS) {
                    imgArr=@[@"引导页1-1242x2208",@"引导页2-1242x2208",@"引导页3-1242x2208"];
               }
               else if (__IPHONE6)
               {
                    imgArr= @[@"引导页1-750x1334",@"引导页2-750x1334",@"引导页3-750x1334"];
               }
               else if (__IPHONE5)
               {
                    imgArr= @[@"引导页1-640x1136",@"引导页2-640x1136",@"引导页3-640x1136"];
               }
               else{
                    imgArr= @[@"引导页1-640x960",@"引导页2-640x960",@"引导页3-640x960"];
               }
     }
     _pageCl.numberOfPages = imgArr.count;
     for (int i =0; i < imgArr.count; i++) {

          UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.frame];
          //imgView.backgroundColor = [UIColor redColor];
          imgView.contentMode = UIViewContentModeScaleToFill;
          UIEdgeInsets ed = {385, 0, 565, 0};
          id img = [imgArr objectAtIndex:i];
          if ([img isKindOfClass:[NSString class]]) {
               [imgView setImage:[[UIImage imageNamed:[imgArr objectAtIndex:i]] resizableImageWithCapInsets:ed]];
               [imgView setImage:[UIImage imageNamed:[imgArr objectAtIndex:i]]];
          }else if([img isKindOfClass:[BUImageRes class]]){
               [(BUImageRes *)img download:self callback:@selector(getImgNotification:) extraInfo:@{@"imageView":imgView}];
          }

          [imageViews addObject:imgView];
          if(imgArr.count - 1 == i)
          {
               [self addEnterBtn:imgView];
          }
     }
     //     [self.pageView setScrollEnabled:NO];
     [self.pageView reloadData];
     //         self.pageView.pageController.hidden = YES;
     [self addSkipBtn];
}


-(void)getImgNotification:(BSNotification *)noti
{
     //    ISTOLOGIN;

     if(noti.error.code ==0)
     {
          BUImageRes *res =(BUImageRes *) noti.target;
          UIImageView * imageView =noti.extraInfo[@"imageView"];
          if (res.isCached) {
               UIEdgeInsets ed = {385, 0, 565, 0};
               UIImage *image =  [UIImage imageNamed:res.cacheFile];
               [imageView setImage:[image resizableImageWithCapInsets:ed]];
               [imageView setImage:image];
          }
     }
}



-(void)addSkipBtn
{
     _skipBtn = [UIButton new];
     _skipBtn.width = 45;
     _skipBtn.height = 20;
     _skipBtn.layer.cornerRadius = 6;
     _skipBtn.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _skipBtn.layer.borderWidth = 0.5;
     [_skipBtn setTitleColor:kUIColorFromRGB(color_7) forState:UIControlStateNormal];
     [_skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
     _skipBtn.titleLabel.font = [UIFont systemFontOfSize:13];
     _skipBtn.x = __SCREEN_SIZE.width - 15 - _skipBtn.width;
     _skipBtn.y = 25;
     [_skipBtn addTarget:self action:@selector(enterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:_skipBtn];
     if(__IPHONEX)
     {
          _skipBtn.y = 55;
     }
}

-(void)addEnterBtn:(UIView *)v
{
     UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     enterBtn.frame = CGRectMake(25, 0, 136, 40);
     enterBtn.x = __SCREEN_SIZE.width - enterBtn.width;
     enterBtn.y = __SCREEN_SIZE.height - enterBtn.height - 68;
     [enterBtn setTitle:@"开启租赁之旅 >" forState:UIControlStateNormal];
     [enterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     enterBtn.backgroundColor= kUIColorFromRGB(color_0x46556d);
     [enterBtn addTarget:self action:@selector(enterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [v addSubview:enterBtn];
     //    enterBtn.layer.cornerRadius = 4;
     //    enterBtn.layer.masksToBounds = YES;

}
-(void)enterBtnClick:(UIButton *)btn

{

     [self goToTabViewControlller];




}
- (void)didReceiveMemoryWarning
{
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
     return YES;
}


#pragma mark
//里面视图的数量。
-(NSInteger)countOfPageView:(MyPageView*)pageView{
     return imageViews.count;
}
//从获取某个位置的视图
-(UIView*)pageView:(MyPageView*)pageView pageFromIndex:(NSInteger)index{

     return [imageViews objectAtIndex:index];

}
//-(void)pageView:(MyPageView *)pageView willDismissAtIndex:(NSInteger)from  wilDisplayAtIndex:(NSInteger)index
//{
//   _pageCl.currentPage= index;
//}
-(void)pageView:(MyPageView *)pageView fromDisplayAtIndex:(NSInteger) from  didDisplayAtIndex:(NSInteger)index {
     // 得到每页宽度
     CGFloat pageWidth = pageView.frame.size.width;
     //    // 根据当前的x坐标和页宽度计算出当前页数
     int currentPage = floor((pageView.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
     //    if(currentPage == _pageCount)
     //    {
     //        currentPage = 0;
     //    }
     _pageCl.currentPage= currentPage;
     if(currentPage == 2)
     {
          _skipBtn.hidden = YES;
     }
     else
     {
          _skipBtn.hidden = NO;
     }
}
-(void)goToTabViewControlller
{
     [[UIApplication sharedApplication] setStatusBarHidden:NO];

     //  self.view.window.rootViewController = ((AppDelegate *)[UIApplication sharedApplication].delegate).slidMenu;

     NSString *welcomeKey = [NSString stringWithFormat:@"welcome%@", busiSystem.appVer];
     [[NSUserDefaults standardUserDefaults]setObject:@"true" forKey:welcomeKey];
     [[NSUserDefaults standardUserDefaults]  synchronize];
     UIWindow *window = [UIApplication sharedApplication].delegate.window;
     window.rootViewController = [TabViewControllerManager mainUI];
     [UIView transitionWithView:window duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:nil ];

     //     [self toAd];

}
-(void)toAd
{
     AdvertiseViewController *advc = [AdvertiseViewController new];
     advc.view.height = __SCREEN_SIZE.height;
     advc.view.width = __SCREEN_SIZE.width;
     advc.view.tag = 55550;
     UIWindow *window = [UIApplication sharedApplication].delegate.window;
     [window.rootViewController.view addSubview:advc.view];
     [self performSelector:@selector(hiddenAdvc) withObject:nil afterDelay:3];
}
-(void)hiddenAdvc
{
     UIWindow *window = [UIApplication sharedApplication].delegate.window;
     UIView *vv = [window.rootViewController.view viewWithTag:55550];
     [UIView animateWithDuration:1 animations:^{

          vv.alpha = 0;
     } completion:^(BOOL finished) {
          vv.hidden = YES;
     }];
}
//单击了某页面视图
-(void)pageView:(MyPageView*)pageView didSelected:(NSInteger)index{
     if (imageViews.count - 1 == index)
     {
          [self goToTabViewControlller];


     }else
     {
          [pageView nextPage:NO];
     }
}
@end
