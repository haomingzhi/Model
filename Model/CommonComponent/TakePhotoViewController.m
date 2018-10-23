//
//  ViewController.m
//  photographDemo
//
//  Created by liguohuai on 16/4/3.
//  Copyright © 2015年 Renford. All rights reserved.
//
#define kScreenBounds  __SCREEN_SIZE// [UIScreen mainScreen].bounds
//#define kScreenWidth  kScreenBounds.size.width*1.0
//#define kScreenHeight kScreenBounds.size.height*1.0
#import "TakePhotoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface TakePhotoViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property(nonatomic)AVCaptureDevice *device;
@property (weak, nonatomic) IBOutlet UIView *takePhotoView;

//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property(nonatomic)AVCaptureDeviceInput *input;

//当启动摄像头开始捕获输入
@property(nonatomic)AVCaptureMetadataOutput *output;

@property (nonatomic)AVCaptureStillImageOutput *ImageOutPut;

//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property(nonatomic)AVCaptureSession *session;

//图像预览层，实时显示捕获的图像
@property(nonatomic)AVCaptureVideoPreviewLayer *previewLayer;
@property(nonatomic)ZLPhotoPickerViewController *photoVC;
@property (nonatomic)UIButton *PhotoButton;
@property (nonatomic)UIButton *goOnPhotoButton;
@property (nonatomic)UIButton *curImgBtn;
@property (nonatomic)UIButton *doneBtn;
@property (nonatomic)UIButton *leftButton;
@property (nonatomic)UIButton *rightButton;
@property (nonatomic)UIButton *bliBtn;
@property (nonatomic)UILabel *goOnTipLb;
@property (nonatomic)UIButton *flashButton;
@property (nonatomic)UIImageView *imageView;
@property (nonatomic)UIView *focusView;
@property (nonatomic)BOOL isflashOn;
@property (nonatomic)UIImage *image;
@property (nonatomic)UIView *menuView;
@property (nonatomic)UIView *toolBarView;
@property (nonatomic)UIView *photoView;
@property (nonatomic)UIScrollView *checkPhotosView;
@property (nonatomic)NSMutableArray *imgsArr;
@property (nonatomic)BOOL canCa;
@property (weak, nonatomic) IBOutlet UIScrollView *scroView;
@property (nonatomic)NSInteger bliMode;
@end

@implementation TakePhotoViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     if (@available(iOS 11.0, *)) {
          self.scroView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
          self.checkPhotosView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
     } else {
          self.automaticallyAdjustsScrollViewInsets = NO;
     }
     _imgsArr = [NSMutableArray new];
     _bliMode = 0;
     _canCa = [self canUserCamear];
     if (_canCa) {
          [self customCamera];
          [self customUI];

     }else{
          return;
     }
     _photoVC = [ZLPhotoPickerViewController new];
     _photoVC.status = PickerViewShowStatusCameraRoll;
     [_photoVC setCallBack:^(id obj) {
          [self dismissViewControllerAnimated:YES completion:nil];
     }];
     _photoVC.topShowPhotoPicker = YES;
     _photoVC.isShowTakePhoto = NO;
     _photoVC.delegate = _photoVCdelgate;
     _photoVC.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
     _photoVC.view.height = __SCREEN_SIZE.height - 70;
     _photoVC.view.width = __SCREEN_SIZE.width;
     [(UIScrollView *)self.scroView addSubview:_photoVC.view];
     //     _photoVC.view.userInteractionEnabled = NO;
     self.takePhotoView.backgroundColor = [UIColor blackColor];
     [(UIScrollView*)self.scroView setContentSize:CGSizeMake(__SCREEN_SIZE.width*2, __SCREEN_SIZE.height)];
     [(UIScrollView*)self.scroView setFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height)];
     self.scroView.delegate = self;
     self.scroView.bounces = NO;
     // Do any additional setup after loading the view, typically from a nib.
     if(_mode == 1){
          [self.scroView setContentOffset:CGPointMake(__SCREEN_SIZE.width, 0) animated:YES];
     }
     if (_imgsCount == 0) {
          _imgsCount = 1;
          self.photoVC.maxCount = _imgsCount;
     }
     else
     {
          self.photoVC.maxCount = _imgsCount;
     }
}

-(void)viewWillDisappear:(BOOL)animated
{
     self.panGesture.enabled = YES;
     _photoVC.delegate = nil;
     [_photoVC.view removeFromSuperview];
     _photoVC = nil;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     if (scrollView.contentOffset.x > __SCREEN_SIZE.width/2.0 ) {
          _mode = 1;
     }
     else
     {
          _mode = 0;
     }

     if (_mode == 0) {
          UIButton *bb = [_toolBarView viewWithTag:2000];
          UIButton *aa = [_toolBarView viewWithTag:1000];
          [aa setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          [bb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
          _toolBarView.backgroundColor = [UIColor whiteColor];
     }
     else
     {
          UIButton *bb = [_toolBarView viewWithTag:2000];
          UIButton *aa = [_toolBarView viewWithTag:1000];
          if(_bliMode == 0)
          {
               [aa setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
               [bb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
               _toolBarView.backgroundColor = [UIColor clearColor];
          }
          else
          {
               [aa setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
               [bb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
               _toolBarView.backgroundColor = [UIColor clearColor];
          }

     }
}
-(void)viewDidLayoutSubviews
{
     self.takePhotoView.frame = CGRectMake(__SCREEN_SIZE.width, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height);
}

-(void)viewWillAppear:(BOOL)animated
{
     self.panGesture.enabled = NO;
}

//-(void)viewWillDisappear:(BOOL)animated
//{
//
//}
- (void)customUI{
     _menuView = [UIView new];
     _menuView.frame = CGRectMake(0, __SCREEN_SIZE.height-170 - TABBARNONEHEIGHT, __SCREEN_SIZE.width, 170 + TABBARNONEHEIGHT);
     _menuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
     [self.takePhotoView addSubview:_menuView];

     UILabel *titleLb = [UILabel new];
     titleLb.frame = CGRectMake(0, 20, __SCREEN_SIZE.width, 14);
     titleLb.font = [UIFont systemFontOfSize:13];
     titleLb.text = @"轻触拍摄";
     titleLb.textAlignment = NSTextAlignmentCenter;
     titleLb.textColor = [UIColor whiteColor];
     titleLb.tag = 1230;
     [_menuView addSubview:titleLb];

     _doneBtn = [UIButton new];
     _doneBtn.frame = CGRectMake(__SCREEN_SIZE.width - 50 - 50, 55, 50, 50);
     [_doneBtn addTarget:self action:@selector(doneHandle:) forControlEvents:UIControlEventTouchUpInside];
     [_doneBtn setImage:[UIImage imageContentWithFileName:@"checkDone"] forState:UIControlStateNormal];
     [_menuView addSubview:_doneBtn];
     _doneBtn.hidden = YES;
     _toolBarView = [UIView new];
     _toolBarView.frame = CGRectMake(0, __SCREEN_SIZE.height-70 - TABBARNONEHEIGHT, __SCREEN_SIZE.width, 70);
     if (_mode == 0) {
          _toolBarView.backgroundColor = [UIColor whiteColor];
     }
     else
          _toolBarView.backgroundColor = [UIColor clearColor];

     UIButton *photoABtn = [UIButton buttonWithType:UIButtonTypeCustom];
     photoABtn.frame = CGRectMake(__SCREEN_SIZE.width/2.0 - 90, 0, 80, 70);
     [photoABtn setTitle:@"相册" forState: UIControlStateNormal];
     photoABtn.tag = 1000;
     photoABtn.titleLabel.font = [UIFont systemFontOfSize:13];
     if (_mode == 0) {
          [photoABtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     }
     else
          [photoABtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [photoABtn addTarget:self action:@selector(photoABtn:) forControlEvents:UIControlEventTouchUpInside];
     [self.toolBarView addSubview:photoABtn];

     UIButton *photoBBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     photoBBtn.frame = CGRectMake(__SCREEN_SIZE.width/2.0 + 10, 0, 80, 70);
     [photoBBtn setTitle:@"拍摄" forState: UIControlStateNormal];
     photoBBtn.titleLabel.font = [UIFont systemFontOfSize:13];
     photoBBtn.tag = 2000;
     if (_mode == 0) {
          [photoBBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     }
     else
          [photoBBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [photoBBtn addTarget:self action:@selector(photoBBtn:) forControlEvents:UIControlEventTouchUpInside];
     [self.toolBarView addSubview:photoBBtn];
     UILabel *checkLineLb = [UILabel new];
     checkLineLb.frame = CGRectMake(__SCREEN_SIZE.width/2.0 + 40, _menuView.frame.size.height - 4 - TABBARNONEHEIGHT, 20, 4);
     checkLineLb.backgroundColor = [UIColor clearColor];
     [_menuView addSubview:checkLineLb];
     checkLineLb.tag = 1099;
     _PhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
     _PhotoButton.frame = CGRectMake(__SCREEN_SIZE.width*1/2.0-30, __SCREEN_SIZE.height-120 - TABBARNONEHEIGHT, 60, 60);
     [_PhotoButton setImage:[UIImage imageNamed:@"photograph"] forState: UIControlStateHighlighted];
     [_PhotoButton setImage:[UIImage imageNamed:@"photograph_Select"] forState:UIControlStateNormal];
     [_PhotoButton addTarget:self action:@selector(shutterCamera) forControlEvents:UIControlEventTouchUpInside];
     [self.takePhotoView addSubview:_PhotoButton];
     _PhotoButton.customTitleLb.text = [NSString stringWithFormat:@"%ld",_imgsCount];
     _PhotoButton.customTitleLb.font = [UIFont systemFontOfSize:18];
     _PhotoButton.customTitleLb.x = 0;
     _PhotoButton.customTitleLb.y = 0;
     _PhotoButton.customTitleLb.width = 60;
     _PhotoButton.customTitleLb.height = 60;
     _PhotoButton.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _PhotoButton.customTitleLb.textColor = kUIColorFromRGB(color_1);
     _focusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
     _focusView.layer.borderWidth = 1.0;
     _focusView.layer.borderColor =[UIColor greenColor].CGColor;
     _focusView.backgroundColor = [UIColor clearColor];
     [self.takePhotoView addSubview:_focusView];
     _focusView.hidden = YES;

     _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
     _leftButton.frame = CGRectMake(0, 10 + NAVNONEHEIGHT, 40, 40);
     [_leftButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
     //    [leftButton setTitle:@"x" forState:UIControlStateNormal];
     //    leftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
     //    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [_leftButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
     [self.takePhotoView addSubview:_leftButton];

     _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
     _rightButton.frame = CGRectMake(__SCREEN_SIZE.width - 50, 10 + NAVNONEHEIGHT, 40, 40);
     //    [rightButton setTitle:@"切换" forState:UIControlStateNormal];
     //    rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
     //     [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [_rightButton setImage:[UIImage imageNamed:@"fanzhuan"] forState:UIControlStateNormal];
     [_rightButton addTarget:self action:@selector(changeCamera) forControlEvents:UIControlEventTouchUpInside];
     [self.takePhotoView addSubview:_rightButton];


     _bliBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     _bliBtn.frame = CGRectMake(__SCREEN_SIZE.width - 148, 10 + NAVNONEHEIGHT, 40, 40);
     //    [rightButton setTitle:@"切换" forState:UIControlStateNormal];
     //    rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
     //     [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [_bliBtn setImage:[UIImage imageNamed:@"bliF"] forState:UIControlStateNormal];
     [_bliBtn addTarget:self action:@selector(changeBli:) forControlEvents:UIControlEventTouchUpInside];
     [self.takePhotoView addSubview:_bliBtn];

     _flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
     _flashButton.frame = CGRectMake(__SCREEN_SIZE.width- 100, 10 + NAVNONEHEIGHT, 40, 40);
     [_flashButton setImage:[UIImage imageNamed:@"shandian"] forState:UIControlStateNormal];
     //    [_flashButton setTitle:@"闪光灯关" forState:UIControlStateNormal];
     [_flashButton addTarget:self action:@selector(FlashOn) forControlEvents:UIControlEventTouchUpInside];
     [self.takePhotoView addSubview:_flashButton];
     [_flashButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(focusGesture:)];
     [self.photoView addGestureRecognizer:tapGesture];
     [self.view addSubview:_toolBarView];

     UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
     [self.view addGestureRecognizer:pan];
}

-(void)doneHandle:(UIButton *)btn
{
     if (self.photoVCdelgate) {
          if ([self.photoVCdelgate respondsToSelector:@selector(pickerViewControllerDoneAsstes:)]) {
               [self.photoVCdelgate pickerViewControllerDoneAsstes:_imgsArr];
          }
     }
}
-(void)panGesture:(UIPanGestureRecognizer *)pan
{
     //     if(pan.state !=UIGestureRecognizerStateBegan &&pan.state != UIGestureRecognizerStateEnded)
     //     {
     //        CGPoint p =  [pan translationInView:self.photoVC.view];
     //          CGPoint pp = self.scroView.contentOffset;
     //          [self.scroView setContentOffset:CGPointMake(-pp.x - p.x, 0)];
     //     }
     //     else if(pan.state !=UIGestureRecognizerStateEnded)
     //     {
     // CGPoint p =  [pan translationInView:self.photoVC.view];
     //          CGPoint pp = self.scroView.contentOffset;
     //          if (-pp.x - p.x > __SCREEN_SIZE.width/2.0) {
     //                [self.scroView setContentOffset:CGPointMake(__SCREEN_SIZE.width, 0)];
     //          }
     //          else
     //          {
     // [self.scroView setContentOffset:CGPointMake(0, 0)];
     //          }
     //     }
}
-(void)photoBBtn:(UIButton *)btn
{
     _mode = 1;
     [self.scroView setContentOffset:CGPointMake(__SCREEN_SIZE.width, 0) animated:YES];
     //     if (_mode == 0) {
     //          UIButton *bb = [_toolBarView viewWithTag:2000];
     //          UIButton *aa = [_toolBarView viewWithTag:1000];
     //          [aa setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     //          [bb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     //           _toolBarView.backgroundColor = [UIColor whiteColor];
     //     }
     //     else
     //     {
     //          UIButton *bb = [_toolBarView viewWithTag:2000];
     //          UIButton *aa = [_toolBarView viewWithTag:1000];
     //          if(_bliMode == 0)
     //          {
     //          [aa setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     //          [bb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     //               _toolBarView.backgroundColor = [UIColor clearColor];
     //          }
     //          else
     //          {
     //               [aa setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     //               [bb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     //               _toolBarView.backgroundColor = [UIColor clearColor];
     //          }
     //
     //     }
}

-(void)photoABtn:(UIButton *)btn
{
     _mode = 0;
     [self.scroView setContentOffset:CGPointMake(0, 0) animated:YES];
     //     if (_mode == 0) {
     //              UIButton *bb = [_toolBarView viewWithTag:2000];
     //              UIButton *aa = [_toolBarView viewWithTag:1000];
     //          [aa setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     //           [bb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     //           _toolBarView.backgroundColor = [UIColor whiteColor];
     //     }
     //     else
     //     {
     //          UIButton *bb = [_toolBarView viewWithTag:2000];
     //          UIButton *aa = [_toolBarView viewWithTag:1000];
     //          if(_bliMode == 0)
     //          {
     //               [aa setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     //               [bb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     //               _toolBarView.backgroundColor = [UIColor clearColor];
     //          }
     //          else
     //          {
     //               [aa setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     //               [bb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     //               _toolBarView.backgroundColor = [UIColor clearColor];
     //          }
     //     }
}

-(BOOL)prefersStatusBarHidden
{
     return YES;
}

-(void)changeBli:(UIButton *)btn
{
     _bliMode = (_bliMode + 1)%3;
     if (_bliMode == 1) {//1:1
          [btn setImage:[UIImage imageNamed:@"bli1"] forState:UIControlStateNormal];
          self.photoView.frame = CGRectMake(0, 55, __SCREEN_SIZE.width, __SCREEN_SIZE.width);
          _menuView.backgroundColor = [UIColor whiteColor];
          UILabel *clb = [_menuView viewWithTag:1099];
          clb.backgroundColor = [UIColor yellowColor];
          UILabel *tlb = [_menuView viewWithTag:1230];
          UIButton *ab = [_toolBarView viewWithTag:1000];
          [ab setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
          UIButton *bb = [_toolBarView viewWithTag:2000];
          [bb setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];

          tlb.textColor = [UIColor blackColor];
          self.previewLayer.frame = CGRectMake(0, 0, self.photoView.bounds.size.width, self.photoView.bounds.size.height);
     }
     else if (_bliMode == 2)
     {//3:4
          [btn setImage:[UIImage imageNamed:@"bli2"] forState:UIControlStateNormal];
          self.photoView.frame = CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.width/3.0*4.0);
          _menuView.backgroundColor = [UIColor whiteColor];
          UILabel *clb = [_menuView viewWithTag:1099];
          clb.backgroundColor = [UIColor yellowColor];
          UILabel *tlb = [_menuView viewWithTag:1230];
          UIButton *ab = [_toolBarView viewWithTag:1000];
          [ab setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
          UIButton *bb = [_toolBarView viewWithTag:2000];
          [bb setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];

          tlb.textColor = [UIColor blackColor];
          self.previewLayer.frame = CGRectMake(0, 0, self.photoView.bounds.size.width, self.photoView.bounds.size.height);
     }
     else//全屏
     {
          [btn setImage:[UIImage imageNamed:@"bliF"] forState:UIControlStateNormal];
          self.photoView.frame = CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height);
          _menuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
          UILabel *clb = [_menuView viewWithTag:1099];
          clb.backgroundColor = [UIColor clearColor];
          UILabel *tlb = [_menuView viewWithTag:1230];
          UIButton *ab = [_toolBarView viewWithTag:1000];
          [ab setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
          UIButton *bb = [_toolBarView viewWithTag:2000];
          [bb setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
          tlb.textColor = [UIColor whiteColor];
          self.previewLayer.frame = CGRectMake(0, 0, self.photoView.bounds.size.width, self.photoView.bounds.size.height);
     }
     [self.scroView setContentOffset:CGPointMake(__SCREEN_SIZE.width, 0) animated:NO];
}
- (void)customCamera{
     self.view.backgroundColor = [UIColor whiteColor];

     //使用AVMediaTypeVideo 指明self.device代表视频，默认使用后置摄像头进行初始化
     self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

     //使用设备初始化输入
     self.input = [[AVCaptureDeviceInput alloc]initWithDevice:self.device error:nil];

     //生成输出对象
     self.output = [[AVCaptureMetadataOutput alloc]init];
     self.ImageOutPut = [[AVCaptureStillImageOutput alloc] init];

     //生成会话，用来结合输入输出
     self.session = [[AVCaptureSession alloc]init];
     if ([self.session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {

          self.session.sessionPreset = AVCaptureSessionPreset1280x720;

     }
     if ([self.session canAddInput:self.input]) {
          [self.session addInput:self.input];
     }

     if ([self.session canAddOutput:self.ImageOutPut]) {
          [self.session addOutput:self.ImageOutPut];
     }
     self.photoView = [UIView new];
     self.photoView.frame = CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height - 0);
     [self.takePhotoView addSubview:self.photoView];
     //使用self.session，初始化预览层，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
     self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
     self.previewLayer.frame = CGRectMake(0, 0, self.photoView.bounds.size.width, self.photoView.bounds.size.height);
     self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
     [self.photoView.layer addSublayer:self.previewLayer];
     NSLog(@"photoView height:%f",self.photoView.bounds.size.height);
     //开始启动
     [self.session startRunning];
     if ([_device lockForConfiguration:nil]) {
          if ([_device isFlashModeSupported:AVCaptureFlashModeAuto]) {
               [_device setFlashMode:AVCaptureFlashModeAuto];
          }
          //自动白平衡
          if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
               [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
          }
          [_device unlockForConfiguration];
     }
}
- (void)FlashOn{
     if ([_device lockForConfiguration:nil]) {
          if (_isflashOn) {
               if ([_device isFlashModeSupported:AVCaptureFlashModeOff]) {
                    [_device setFlashMode:AVCaptureFlashModeOff];
                    _isflashOn = NO;
                    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
                    if ([device hasTorch]) {
                         [device lockForConfiguration:nil];
                         [device setTorchMode: AVCaptureTorchModeOff];
                         [device unlockForConfiguration];
                    }
                    [_flashButton setImage:[UIImage imageNamed:@"shandian"] forState:UIControlStateNormal];
                    //                [_flashButton setTitle:@"闪光灯关" forState:UIControlStateNormal];
               }
          }else{
               if ([_device isFlashModeSupported:AVCaptureFlashModeOn]) {
                    [_device setFlashMode:AVCaptureFlashModeOn];
                    _isflashOn = YES;

                    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
                    NSError *error = nil;

                    if ([captureDevice hasTorch]) {
                         BOOL locked = [captureDevice lockForConfiguration:&error];
                         if (locked) {
                              captureDevice.torchMode = AVCaptureTorchModeOn;
                              [captureDevice unlockForConfiguration];
                         }
                    }
                    [_flashButton setImage:[UIImage imageNamed:@"shandianSel"] forState:UIControlStateNormal];
                    //                [_flashButton setTitle:@"闪光灯开" forState:UIControlStateNormal];
               }
          }


          [_device unlockForConfiguration];
     }
     [self.scroView setContentOffset:CGPointMake(__SCREEN_SIZE.width, 0) animated:NO];
}
- (void)changeCamera{
     NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
     if (cameraCount > 1) {
          NSError *error;

          CATransition *animation = [CATransition animation];

          animation.duration = .5f;

          animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

          animation.type = @"oglFlip";
          AVCaptureDevice *newCamera = nil;
          AVCaptureDeviceInput *newInput = nil;
          AVCaptureDevicePosition position = [[_input device] position];
          if (position == AVCaptureDevicePositionFront){
               newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
               animation.subtype = kCATransitionFromLeft;
          }
          else {
               newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
               animation.subtype = kCATransitionFromRight;
          }

          newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
          [self.previewLayer addAnimation:animation forKey:nil];
          if (newInput != nil) {
               [self.session beginConfiguration];
               [self.session removeInput:_input];
               if ([self.session canAddInput:newInput]) {
                    [self.session addInput:newInput];
                    self.input = newInput;

               } else {
                    [self.session addInput:self.input];
               }

               [self.session commitConfiguration];

          } else if (error) {
               NSLog(@"toggle carema failed, error = %@", error);
          }

     }
     [self.scroView setContentOffset:CGPointMake(__SCREEN_SIZE.width, 0) animated:NO];
}
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
     NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
     for ( AVCaptureDevice *device in devices )
          if ( device.position == position ) return device;
     return nil;
}
- (void)focusGesture:(UITapGestureRecognizer*)gesture{
     CGPoint point = [gesture locationInView:self.photoView];
     [self focusAtPoint:point];
}
- (void)focusAtPoint:(CGPoint)point{
     CGSize size = self.photoView.bounds.size;
     CGPoint focusPoint = CGPointMake( point.y /size.height ,1-point.x/size.width );
     NSError *error;
     if (!CGRectContainsPoint(CGRectMake(0, 0, self.photoView.bounds.size.width, self.photoView.bounds.size.height),focusPoint)) {
          return;
     }
     if ([self.device lockForConfiguration:&error]) {

          if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
               [self.device setFocusPointOfInterest:focusPoint];
               [self.device setFocusMode:AVCaptureFocusModeAutoFocus];
          }

          if ([self.device isExposureModeSupported:AVCaptureExposureModeAutoExpose ]) {
               [self.device setExposurePointOfInterest:focusPoint];
               [self.device setExposureMode:AVCaptureExposureModeAutoExpose];
          }

          [self.device unlockForConfiguration];
          _focusView.center = point;
          _focusView.hidden = NO;
          [UIView animateWithDuration:0.3 animations:^{
               _focusView.transform = CGAffineTransformMakeScale(1.25, 1.25);
          }completion:^(BOOL finished) {
               [UIView animateWithDuration:0.5 animations:^{
                    _focusView.transform = CGAffineTransformIdentity;
               } completion:^(BOOL finished) {
                    _focusView.hidden = YES;
               }];
          }];
     }

}
#pragma mark - 截取照片
- (void) shutterCamera
{
     if(_imgsCount - self.imgsArr.count == 0)
          return;
     AVCaptureConnection * videoConnection = [self.ImageOutPut connectionWithMediaType:AVMediaTypeVideo];
     if (!videoConnection) {
          NSLog(@"take photo failed!");
          return;
     }
     _PhotoButton.enabled = NO;
     [self.ImageOutPut captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
          if (imageDataSampleBuffer == NULL) {
               return;
          }
          NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
          self.image = [UIImage imageWithData:imageData scale:[UIScreen mainScreen].scale];
          self.imageView = [[UIImageView alloc]initWithFrame:self.takePhotoView.frame];
          [self.takePhotoView insertSubview:_imageView belowSubview:_menuView];
          self.imageView.image = _image;
          UIGraphicsBeginImageContextWithOptions(self.takePhotoView.bounds.size, NO,  [UIScreen mainScreen].scale);
          [self.imageView.layer renderInContext:UIGraphicsGetCurrentContext()];

          _image = UIGraphicsGetImageFromCurrentImageContext();

          UIGraphicsEndImageContext();
          //          self.image = [UIImage ct_imageFromImage: self.image inRect:CGRectMake(0,0 , __SCREEN_SIZE.height, __SCREEN_SIZE.width)];
          if (_bliMode == 0) {//这里根据不同的比例截取不同的图片大小

          }
          else if (_bliMode == 1)
          {
               //             self.image = [self.image getSubImage:CGRectMake(0,0 , kScreenWidth, kScreenWidth) centerBool:NO canScale:YES];//
               self.image = [UIImage ct_imageFromImage: self.image inRect:CGRectMake(0,150 , __SCREEN_SIZE.width, __SCREEN_SIZE.width)];
          }
          else
          {
               //            self.image = [self.image getSubImage:CGRectMake(0, 0, kScreenWidth, kScreenWidth/3.0 * 4.0) centerBool:NO canScale:YES];//
               self.image = [UIImage ct_imageFromImage: self.image inRect:CGRectMake(0, 80, __SCREEN_SIZE.width, __SCREEN_SIZE.width/3.0 * 4.0)];
          }
          //        [self.session stopRunning];
          //        [self saveImageToPhotoAlbum:self.image];
          [self.imgsArr addObject:_image];
          _PhotoButton.customTitleLb.text = [NSString stringWithFormat:@"%ld",_imgsCount - self.imgsArr.count];
          [self showImgsView];
          self.imageView.frame = self.photoView.frame;
          self.imageView.layer.masksToBounds = YES;
          self.imageView.image = _image;
          self.imageView.hidden = YES;
          NSLog(@"image size = %@",NSStringFromCGSize(self.image.size));
          _PhotoButton.enabled = YES;
     }];
     [self.scroView setContentOffset:CGPointMake(__SCREEN_SIZE.width, 0) animated:NO];
}
-(void)showImgsView
{
     if (!self.checkPhotosView) {
          self.checkPhotosView = [UIScrollView new];
          self.checkPhotosView.showsHorizontalScrollIndicator = NO;
          self.checkPhotosView.height = 80;
          self.checkPhotosView.width = __SCREEN_SIZE.width;
          self.checkPhotosView.y = __SCREEN_SIZE.height - 250.5 - TABBARNONEHEIGHT;
          self.checkPhotosView.backgroundColor = kUIColorFromRGBWithAlpha(color_black, 0.2);
          [self.takePhotoView addSubview:self.checkPhotosView];
     }
     self.checkPhotosView.hidden = NO;
     self.doneBtn.hidden = NO;
     [self.imgsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          UIButton *iv = [self.checkPhotosView viewWithTag:8000 + idx];
          if (!iv) {
               iv = [UIButton new];
          }
          [iv setImage:obj forState:UIControlStateNormal];
          iv.tag = 8000 + idx;
          iv.width = 50;
          iv.height = 50;
          iv.x = 15 + idx * 65;
          iv.y = 15;
          [self.checkPhotosView addSubview:iv];
          [iv addTarget:self action:@selector(imgBtnHandle:) forControlEvents:UIControlEventTouchUpInside];
          UIButton *bt = [self.checkPhotosView viewWithTag:8100 + idx];
          if (!bt) {
               bt = [UIButton new];
          }
          [bt setImage:[UIImage imageContentWithFileName:@"delImg"] forState:UIControlStateNormal];
          bt.tag = 8100 + idx;
          bt.width = 20;
          bt.height = 20;
          bt.x = 6 + idx * 65;
          bt.y = 6;
          [bt addTarget:self action:@selector(delImg:) forControlEvents:UIControlEventTouchUpInside];
          [self.checkPhotosView addSubview:bt];

     }];
     self.scroView.scrollEnabled = NO;
     [self.checkPhotosView setContentSize:CGSizeMake(MAX(self.checkPhotosView.width, (self.imgsArr.count ) * 80 + 20) , 80)];
     //     [self.checkPhotosView  setContentOffset:CGPointMake(self.checkPhotosView.contentSize.width - self.checkPhotosView.width, 0) animated:NO];
}
-(void)imgBtnHandle:(UIButton *)btn
{
     _curImgBtn.layer.borderWidth = 0;
     NSInteger index = btn.tag - 8000;
     UIImage *img = self.imgsArr[index];
     self.imageView.image = img;
     self.imageView.hidden = NO;
     self.doneBtn.hidden = NO;
     btn.layer.borderColor = [UIColor yellowColor].CGColor;//kUIColorFromRGB(color_)
     btn.layer.borderWidth = 2;
     _curImgBtn = btn;
     [self showGoOnBtn];
}
-(void)delImg:(UIButton *)btn
{
     NSInteger index = btn.tag - 8100;
     [self removeImgsView:index];
     _PhotoButton.customTitleLb.text = [NSString stringWithFormat:@"%ld",_imgsCount - self.imgsArr.count];
     if (self.imgsArr.count == 0) {
          self.checkPhotosView.hidden = YES;
          self.scroView.scrollEnabled = YES;
          self.imageView.hidden = YES;
          self.doneBtn.hidden = YES;
          [self goOnHandle:_goOnPhotoButton];
     }
}

-(void)showGoOnBtn
{
     if (!self.goOnPhotoButton) {
          self.goOnPhotoButton = [UIButton new];
          [self.takePhotoView addSubview:self.goOnPhotoButton];
          _goOnPhotoButton.frame = CGRectMake(__SCREEN_SIZE.width*1/2.0-30, __SCREEN_SIZE.height-120 - TABBARNONEHEIGHT, 60, 60);
          [_goOnPhotoButton setImage:[UIImage imageNamed:@"photograph"] forState: UIControlStateNormal];
          [_goOnPhotoButton setImage:[UIImage imageNamed:@"photograph_Select"] forState:UIControlStateNormal];
          //          [_goOnPhotoButton setTitle:@"继续" forState:UIControlStateNormal];
          [_goOnPhotoButton setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
          [_goOnPhotoButton addTarget:self action:@selector(goOnHandle:) forControlEvents:UIControlEventTouchUpInside];
          //          _goOnTipLb = [UILabel new];
          //          _goOnTipLb.height = 16;
          //          _goOnTipLb.width = __SCREEN_SIZE.width;
          //          _goOnTipLb.textAlignment = NSTextAlignmentCenter;
          //          _goOnTipLb.y = 15;
          //          if (_bliMode == 0) {
          //     _goOnTipLb.textColor = kUIColorFromRGB(color_2);
          //          }
          //          else
          //          _goOnTipLb.textColor = kUIColorFromRGB(color_1);
          //          _goOnTipLb.font = [UIFont systemFontOfSize:14];
          //          [_menuView addSubview:_goOnTipLb];
     }
     UILabel *tlb = [_menuView viewWithTag:1230];
     tlb.text = @"点击继续拍照";
     tlb.textColor = kUIColorFromRGB(color_1);
     _goOnPhotoButton.hidden = NO;
     _goOnTipLb.hidden = NO;
     UIButton *bb = [_toolBarView viewWithTag:2000];
     UIButton *aa = [_toolBarView viewWithTag:1000];
     UILabel *clb = [_menuView viewWithTag:1099];
     clb.hidden = YES;
     aa.hidden = YES;
     bb.hidden = YES;
     _leftButton.hidden = YES;
     _rightButton.hidden = YES;
     _flashButton.hidden = YES;
     _bliBtn.hidden = YES;
     _menuView.backgroundColor = kUIColorFromRGB(color_2);
}

-(void)goOnHandle:(UIButton *)btn
{
     self.imageView.hidden = YES;
     btn.hidden = YES;
     _curImgBtn.layer.borderWidth = 0;
     _goOnTipLb.hidden = YES;
     UILabel *tlb = [_menuView viewWithTag:1230];
     tlb.text = @"轻触拍摄";
     UIButton *bb = [_toolBarView viewWithTag:2000];
     UIButton *aa = [_toolBarView viewWithTag:1000];
     UILabel *clb = [_menuView viewWithTag:1099];
     aa.hidden = NO;
     bb.hidden = NO;
     _leftButton.hidden = NO;
     _rightButton.hidden = NO;
     _flashButton.hidden = NO;
     _bliBtn.hidden = NO;
     if (_bliMode == 0) {
          tlb.textColor = [UIColor whiteColor];
          _menuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
     }
     else
     {
          clb.hidden = NO;
          tlb.textColor = kUIColorFromRGB(color_1);
          _menuView.backgroundColor = kUIColorFromRGB(color_2);
     }
}
//-(void)addImgsView:(NSInteger)index
//{
//     [self showImgsView];
//}
-(void)removeImgsView:(NSInteger)index
{
     [self.imgsArr removeObjectAtIndex:index];
     [self showImgsView];
     UIImageView *iv = [self.checkPhotosView viewWithTag:8000 + self.imgsArr.count];
     [iv removeFromSuperview];
     UIButton *bt = [self.checkPhotosView viewWithTag:8100 + self.imgsArr.count];
     [bt removeFromSuperview];
}

#pragma - 保存至相册
- (void)saveImageToPhotoAlbum:(UIImage*)savedImage
{

     UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

}
// 指定回调方法

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
     NSString *msg = nil ;
     if(error != NULL){
          msg = @"保存图片失败" ;
     }else{
          msg = @"保存图片成功" ;
     }
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                     message:msg
                                                    delegate:self
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil];
     [alert show];
}
-(void)cancle{
     [self.imageView removeFromSuperview];
     //    [self.session startRunning];
     [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 检查相机权限
- (BOOL)canUserCamear{
     AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
     if (authStatus == AVAuthorizationStatusDenied) {
          UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请打开相机权限" message:@"设置-隐私-相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
          alertView.tag = 100;
          [alertView show];
          return NO;
     }
     else{
          return YES;
     }
     return YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
     if (buttonIndex == 0 && alertView.tag == 100) {

          NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];

          if([[UIApplication sharedApplication] canOpenURL:url]) {

               [[UIApplication sharedApplication] openURL:url];

          }
     }
}


- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

@end
