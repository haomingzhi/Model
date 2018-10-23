//
//  CommonVideoViewController.m
//  compassionpark
//
//  Created by Steve on 2017/4/12.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "CommonVideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "KRVideoPlayerController.h"

@interface CommonVideoViewController ()
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic,strong) KRVideoPlayerController *videoController;
@end

@implementation CommonVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigateLeftButton:@"" image:[UIImage imageNamed:@"nav_back"] font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_5)];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [self playVideoWithURL:[NSURL URLWithString:_url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleReturnBack:(id)sender{
    [_videoController dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)playVideoWithURL:(NSURL *)url
{
    
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, __SCREEN_SIZE.height/2.0 -  width*(9.0/16.0)/2.0, width, width*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        [self.videoController showInWindow];
    }
    self.videoController.contentURL = url;
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}

-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSURL *url = [NSURL URLWithString:_url];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame=self.view.bounds;
//        _moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
        _moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _moviePlayer.shouldAutoplay = YES;
//        _moviePlayer.repeatMode = MPMovieRepeatModeOne;
        [_moviePlayer setFullscreen:YES animated:YES];
        [_moviePlayer prepareToPlay];
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}



+(CommonVideoViewController *)setVideoViewController:(NSString *)url
{
    
//    url = @"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    CommonVideoViewController *vc;
    vc = [[CommonVideoViewController alloc]init];
    vc.url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [vc playVideoWithURL:[NSURL URLWithString:vc.url]];
//    [vc.moviePlayer play];
    return vc;
    
}

-(void)setVideoViewController:(NSString *)url
{
    self.url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self playVideoWithURL:[NSURL URLWithString:self.url]];
    
}
@end
