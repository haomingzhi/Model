//
//  JYWaitingLoadDataViewController.m
//  ChaoLiu
//
//  Created by air on 15/12/2.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "JYWaitingLoadDataViewController.h"

@interface JYWaitingLoadDataViewController ()
{
    IBOutlet UILabel *_textLb;
    float _tran;
    IBOutlet UIImageView *_imgV;
}
@end

@implementation JYWaitingLoadDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self xuanzhuang];
   }

-(void)xuanzhuang
{
//    if (_tran == M_PI *2)
//    {
//        _tran = 0;
//    }
//    _imgV.transform = CGAffineTransformMakeRotation(_tran);
////    if (_tran == M_PI) {
//        _tran =  M_PI*2;
////    }
////    else
////    {
////        _tran =  M_PI;
////    }
//    [UIView  animateWithDuration:0.5 animations:^{
//        
//        
//        _imgV.transform = CGAffineTransformMakeRotation(_tran);
//    } ];
//      [self performSelector:@selector(xuanzhuang) withObject:nil afterDelay:0.5];
//    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
//        _imgV.transform = CGAffineTransformMakeRotation(M_PI);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
//            _imgV.transform = CGAffineTransformMakeRotation(M_PI*2);
//        } completion:^(BOOL finished) {
//            [self xuanzhuang];
//        }];
//    }];
    [self rotation:M_PI * 2.0 animationDuration:2.0 repeatCount:MAXFLOAT];
}

//-(void)loadView
//{
//    [super loadView];
//    _tran = M_PI * 1;
//    [UIView  animateWithDuration:0.5 animations:^{
//        
//        _imgV.transform = CGAffineTransformMakeRotation(_tran);
//    } ];
//    [self performSelector:@selector(xuanzhuang) withObject:nil afterDelay:0.5];
//}

-(UIImageView *)getImgV
{
    return _imgV;
}

-(UILabel*)getTextLb
{
    return _textLb;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
static JYWaitingLoadDataViewController *waitingDataVC;
static UIViewController *pVC;
static UIViewController *oVC;
+(void)WaitingDataView:(UIViewController *)waitVC withOldVC:(UIViewController *)ovc
{
    [JYWaitingLoadDataViewController WaitingDataView:waitVC withOldVC:ovc withTargetView:nil];
//    if (!waitingDataVC) {
//        JYWaitingLoadDataViewController *vc = [[JYWaitingLoadDataViewController alloc] initWithNibName:@"JYWaitingLoadDataViewController" bundle:nil];
//        waitingDataVC = vc;
////        [waitingVC addChildViewController:vc];
//    }
//    pVC = waitingVC;
//    oVC = ovc;
//    waitingDataVC.view.autoresizingMask = UIViewAutoresizingNone;
//    waitingDataVC.view.width = __SCREEN_SIZE.width;
//    if([pVC isKindOfClass:[UINavigationController class]])
//    {
//    waitingDataVC.view.height = __SCREEN_SIZE.height;
//        waitingDataVC.view.y = 0;
//    }
//    else
//    {
//        if (!oVC.navigationController.navigationBar.translucent) {
//            waitingDataVC.view.height = __SCREEN_SIZE.height;
//            waitingDataVC.view.y = -32;
//        }
//        else
//        {
//            waitingDataVC.view.y = 0;
//     waitingDataVC.view.height = __SCREEN_SIZE.height;
//        }
//    }
//
//    [waitingDataVC getImgV].center = waitingDataVC.view.center;
//    [waitingDataVC getTextLb].center = waitingDataVC.view.center;
//    [waitingDataVC getTextLb].y = [waitingDataVC getTextLb].y + 40;
////   [waitingDataVC didMoveToParentViewController:waitingVC];
//    [pVC.view addSubview:waitingDataVC.view];
//    [waitingDataVC.view setHidden:NO];
//    waitingDataVC.view.alpha = 1;
//    return waitingVC.view;
}
+(void)WaitingDataViewNotOne:(UIViewController *)waitingVC withOldVC:(UIViewController *)ovc
{
    [JYWaitingLoadDataViewController WaitingDataViewNotOne:waitingVC withOldVC:ovc withTargetView:nil];
}

+(void)WaitingDataViewNotOne:(UIViewController *)waitingVC withOldVC:(UIViewController *)ovc withTargetView:(UIView *)targetView
{
    JYWaitingLoadDataViewController *waitingDataVC;// = ovc;
    UIView *waitV ;
    if (targetView) {
        waitV = [targetView viewWithTag:7990];
    }
    else
    {
    waitV = [waitingVC.view viewWithTag:7990];
    }
    if (!waitV) {
        JYWaitingLoadDataViewController *vc = [[JYWaitingLoadDataViewController alloc] initWithNibName:@"JYWaitingLoadDataViewController" bundle:nil];
        waitingDataVC = vc;
        vc.view.tag = 7990;
        waitV = vc.view;
                [waitingVC addChildViewController:vc];
    }
    pVC = waitingVC;
    oVC = ovc;
    waitingDataVC.view.autoresizingMask = UIViewAutoresizingNone;
    waitingDataVC.view.width = __SCREEN_SIZE.width;
    if([pVC isKindOfClass:[UINavigationController class]])
    {
        waitingDataVC.view.height = __SCREEN_SIZE.height;
        waitingDataVC.view.y = 0;
    }
    else
    {
        if (!oVC.navigationController.navigationBar.translucent) {
            waitingDataVC.view.height = __SCREEN_SIZE.height;
            waitingDataVC.view.y = -32;
        }
        else
        {
            waitingDataVC.view.y = 0;
            waitingDataVC.view.height = __SCREEN_SIZE.height;
        }
    }
  
    [waitingDataVC getImgV].center = waitingDataVC.view.center;
    [waitingDataVC getTextLb].center = waitingDataVC.view.center;
    [waitingDataVC getTextLb].y = [waitingDataVC getTextLb].y + 40;
    [waitingDataVC.view setHidden:NO];
    waitingDataVC.view.alpha = 1;
    CGPoint p =  [waitV convertPoint:waitV.frame.origin fromView:[UIApplication sharedApplication].windows[0]];
    //   [waitingDataVC didMoveToParentViewController:waitingVC];
    if (targetView) {
        waitingDataVC.view.y = 0;
        [waitingDataVC getImgV].y -= 32;
        [targetView addSubview:waitingDataVC.view];
    }
    else
    {
        [pVC.view addSubview:waitingDataVC.view];
    }
   
}

+(void)WaitingDataView:(UIViewController *)waitingVC withOldVC:(UIViewController *)ovc withTargetView:(UIView *)targetView
{
    if (!waitingDataVC) {
        JYWaitingLoadDataViewController *vc = [[JYWaitingLoadDataViewController alloc] initWithNibName:@"JYWaitingLoadDataViewController" bundle:nil];
        waitingDataVC = vc;
        //        [waitingVC addChildViewController:vc];
    }
    pVC = waitingVC;
    oVC = ovc;
    waitingDataVC.view.autoresizingMask = UIViewAutoresizingNone;
    waitingDataVC.view.width = __SCREEN_SIZE.width;
    if([pVC isKindOfClass:[UINavigationController class]])
    {
        waitingDataVC.view.height = __SCREEN_SIZE.height;
        waitingDataVC.view.y = 0;
    }
    else
    {
        if (!oVC.navigationController.navigationBar.translucent) {
            waitingDataVC.view.height = __SCREEN_SIZE.height;
            waitingDataVC.view.y = -32;
        }
        else
        {
            waitingDataVC.view.y = 0;
            waitingDataVC.view.height = __SCREEN_SIZE.height;
        }
    }
    
    [waitingDataVC getImgV].center = waitingDataVC.view.center;
    [waitingDataVC getTextLb].center = waitingDataVC.view.center;
    [waitingDataVC getTextLb].y = [waitingDataVC getTextLb].y + 40;
    //   [waitingDataVC didMoveToParentViewController:waitingVC];
    if (targetView) {
         waitingDataVC.view.y = 0;
        [targetView addSubview:waitingDataVC.view];
    }
    else
    {
    [pVC.view addSubview:waitingDataVC.view];
    }
    [waitingDataVC.view setHidden:NO];
    waitingDataVC.view.alpha = 1;
    //    return waitingVC.view;
}

+(void)completeWaitingNotOne:(UIView *)tab
{
    UIView *waitingV = [tab viewWithTag:7990];
    [UIView animateWithDuration:0.3 animations:^{
       waitingV.alpha = 0;
    } completion:^(BOOL finished) {
        [waitingV setHidden:YES];
    }];
}

+(void)completeWaiting
{
//    [waitingDataVC.view removeFromSuperview];
//    [pVC transitionFromViewController:waitingDataVC toViewController:oVC duration:4 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//    }  completion:^(BOOL finished) {
//        //......
//    }];
//    [waitingDataVC willMoveToParentViewController:nil];
    [UIView animateWithDuration:0.3 animations:^{
        waitingDataVC.view.alpha = 0;
    } completion:^(BOOL finished) {
         [waitingDataVC.view setHidden:YES];
    }];
   
//    [waitingDataVC removeFromParentViewController];
//    [pVC.view addSubview:oVC.view];
}

//旋转
-(void)rotation:(CGFloat)angle animationDuration:(NSTimeInterval)duration repeatCount:(CGFloat)count
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: angle ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = count;//你可以设置到最大的整数值
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [_imgV.layer addAnimation:rotationAnimation forKey:@"Rotation"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
