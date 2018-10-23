//
//  MyPageViewController.m
//  ChaoLiu
//
//  Created by ORANLLC_IOS1 on 15/8/27.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ImageExplorerViewController.h"
#import "BUImageRes.h"

@interface ImageExplorerViewController ()<MyPageViewDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet MyPageView *pageView;

@property (weak, nonatomic) IBOutlet StyledPageControl *pageControl;

@property (nonatomic) NSInteger showStyle;

@property (nonatomic) CGRect preFrame;


@end

@implementation ImageExplorerViewController
{
    NSArray *_dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //建立一个自己的返回视图。。
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 29, 29);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    self.pageControl.pageControlStyle = PageControlStyleThumb;
    self.pageControl.gapWidth = 5;//点之间间隔
    self.pageControl.thumbImage =  [UIImage imageNamed:@"dot_nor"] ;
    self.pageControl.selectedThumbImage = [UIImage imageNamed:@"dot_sel"];
    self.pageView.pageController = self.pageControl;
    self.pageView.showPageController = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id) initWithDatasource:(NSArray *) datasource
{
    self = [super init];
    if (self) {
        _dataSource = datasource;
        self.view.backgroundColor = [UIColor blackColor];
        _pageView.delegate = self;
        [_pageView layoutIfNeeded];
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    _pageView.cycle = NO;
    [_pageView reloadData];
    self.pageView.currentPageIndex = self.pageView.currentPageIndex;
}


-(void) viewDidAppear:(BOOL)animated
{
    
    
}

//里面视图的数量。
-(NSInteger)countOfPageView:(MyPageView*)pageView
{
    return _dataSource.count;
}

//从获取某个位置的视图
-(UIView*)pageView:(MyPageView*)pageView pageFromIndex:(NSInteger)index
{
    UIScrollView *scrollview =[[UIScrollView alloc]initWithFrame:self.view.frame];
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.bounces = NO;
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    BUImageRes *res = _dataSource[index];
    if (res.isCached) {
        imgView.image = [[UIImage imageWithContentsOfFile:res.cacheFile] imageByScalingToSize:__SCREEN_SIZE];
        imgView.frame = CGRectMake(0, (__SCREEN_SIZE.height - imgView.image.size.height) /2, imgView.image.size.width, imgView.image.size.height);

    }
    else {
        imgView.image = [[UIImage imageNamed:@"DefaultChart1"] imageByScalingToSize:__SCREEN_SIZE];
        imgView.frame = CGRectMake(0, (__SCREEN_SIZE.height - imgView.image.size.height) /2, imgView.image.size.width, imgView.image.size.height);
        [res download:self callback:@selector(downloadNotification:) extraInfo:@{@"img":imgView}];
    }
    [scrollview addSubview:imgView];
    //设置UIScrollView的滚动范围和图片的真实尺寸一致
    scrollview.contentSize=imgView.frame.size;
    scrollview.delegate = self;
    scrollview.maximumZoomScale = 2.5;
    scrollview.minimumZoomScale = 1;
    
    
    return scrollview;
    
    
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.frame];
//    [imgView setContentMode:UIViewContentModeScaleAspectFit];
//    BUImageRes *res = _dataSource[index];
//    [res displayRemoteImage:imgView imageName:@"defaultImg" thumb:NO];
//    return imgView;
}

-(void)pageView:(MyPageView*)pageView didDoubleClick:(NSInteger)index;
{
    UIScrollView *scrollView = (UIScrollView *)[pageView pageFromIndex:index];
    scrollView.zoomScale =scrollView.zoomScale * 1.5;
}

-(void)pageView:(MyPageView *)pageView fromDisplayAtIndex:(NSInteger) from  didDisplayAtIndex:(NSInteger)index;
{
    if (from >=0 && from < pageView.count) {
        UIScrollView *scrollView = (UIScrollView *)[pageView pageFromIndex:from];
        scrollView.zoomScale =1.0;
    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView.subviews.lastObject;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    if(scrollView.zoomScale <=1) scrollView.zoomScale = 1.0f;
    
    CGFloat xcenter = __SCREEN_SIZE.width/2 , ycenter = scrollView.center.y;
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    UIImageView *img = scrollView.subviews.lastObject;
    
    [img setCenter:CGPointMake(xcenter, ycenter)];
}

-(void) downloadNotification:(BSNotification *) noti
{
    BUImageRes *res = (BUImageRes *) noti.target;
    if (res.isCached) {
        UIImageView *imgView = [noti.extraInfo objectForKey:@"img"];
        imgView.image = [[UIImage imageWithContentsOfFile:res.cacheFile] imageByScalingToSize:__SCREEN_SIZE];
        imgView.frame = CGRectMake(0, (__SCREEN_SIZE.height - imgView.image.size.height) /2, imgView.image.size.width, imgView.image.size.height);
        UIScrollView *scrollView = (UIScrollView *)imgView.superview;
        scrollView.contentSize=imgView.frame.size;
    }
}


//showStyle 显示样式，1--push 2--pop
+(void)showImageList:(NSArray *) images index:(NSInteger) index context:(JYBaseViewController *)context frame:(CGRect) frame style:(NSInteger) showStyle
{
    ImageExplorerViewController * vc;
    if (showStyle ==1) {
        vc = [ImageExplorerViewController showImageListPush:images context:context frame:frame];
        vc.showStyle = showStyle;
    }
    else {
        vc = [ImageExplorerViewController showImageListPop:images context:context frame:frame];
        vc.showStyle = showStyle;
    }
    [vc.pageView setCurrentPageIndex:index];
    
}

-(void) pageView:(MyPageView *)pageView didSelected:(NSInteger)index
{
    if (self.showStyle == 1) {
        [self pageViewPush:pageView didSelected:index];
    }
    else [self pageViewPop:pageView didSelected:index];
}



//单击了某页面视图
-(void)pageViewPop:(MyPageView*)pageView didSelected:(NSInteger)index
{
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.navigationBarHidden = NO;
        self.view.alpha = 0;
        self.view.frame = self.preFrame;
    } completion:^(BOOL finished) {
        
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}



+(ImageExplorerViewController *)showImageListPop:(NSArray *) images context:(JYBaseViewController *)context frame:(CGRect) frame;
{
    ImageExplorerViewController *vc = [[ImageExplorerViewController alloc] initWithDatasource:images];
    [context addChildViewController:vc];
    vc.preFrame = frame;
    vc.view.frame = frame;
    vc.view.alpha =0;
    [context.view addSubview:vc.view];
    [vc.view layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        vc.navigationController.navigationBarHidden = YES;
        vc.view.alpha = 1;
        vc.view.frame = CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height);
    } completion:^(BOOL finished) {
        [vc.pageView reloadData];
    }];
    return vc;
}


// push

//单击了某页面视图
-(void)pageViewPush:(MyPageView*)pageView didSelected:(NSInteger)index
{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}



+(ImageExplorerViewController *)showImageListPush:(NSArray *) images context:(JYBaseViewController *)context frame:(CGRect) frame;
{
    ImageExplorerViewController *vc = [[ImageExplorerViewController alloc] initWithDatasource:images];
    vc.hidesBottomBarWhenPushed = YES;
    [context.navigationController pushViewController:vc animated:YES];
    vc.navigationController.navigationBarHidden = YES;
    return vc;
}



@end
