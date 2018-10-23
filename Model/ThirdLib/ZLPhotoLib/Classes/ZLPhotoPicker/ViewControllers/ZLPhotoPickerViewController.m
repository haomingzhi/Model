//
//  PickerViewController.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "ZLPhotoPickerViewController.h"
#import "ZLNavigationController.h"
#import "ZLPhoto.h"

@interface ZLPhotoPickerViewController ()
@property (nonatomic , weak) ZLPhotoPickerGroupViewController *groupVc;
@end

@implementation ZLPhotoPickerViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addNotification];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - init Action
- (void) createNavigationController{
    ZLPhotoPickerGroupViewController *groupVc = [[ZLPhotoPickerGroupViewController alloc] init];
    ZLNavigationController *nav = [[ZLNavigationController alloc] initWithRootViewController:groupVc];
    nav.view.frame = self.view.bounds;
    [self addChildViewController:nav];
    [self.view addSubview:nav.view];
    self.groupVc = groupVc;
    
}

-(void)popView
{
   self.groupVc.status = PickerViewShowStatusGroup;
    [self.groupVc getImgs];
    [self.groupVc.navigationController popViewControllerAnimated:YES];

}

-(void)getImgs
{
    [self.groupVc reloadPhotos];
}

-(void)pushViewController:(UIViewController *)vc
{
    [self.groupVc.navigationController pushViewController:vc animated:YES];
    
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self createNavigationController];
    }
    return self;
}

- (void)setSelectPickers:(NSArray *)selectPickers{
    _selectPickers = selectPickers;
    self.groupVc.selectAsstes = selectPickers;
}

- (void)setStatus:(PickerViewShowStatus)status{
    _status = status;
    self.groupVc.status = status;
}

- (void)setMaxCount:(NSInteger)maxCount{
    if (maxCount <= 0) return;
    _maxCount = maxCount;
    self.groupVc.maxCount = maxCount;
}

- (void)setTopShowPhotoPicker:(BOOL)topShowPhotoPicker{
    _topShowPhotoPicker = topShowPhotoPicker;
    self.groupVc.topShowPhotoPicker = topShowPhotoPicker;
}
-(void)setIsShowTakePhoto:(BOOL)isShowTakePhoto
{
     _isShowTakePhoto = isShowTakePhoto;
      self.groupVc.isShowTakePhoto = isShowTakePhoto;
}
- (void)setIsHeadPortraitScreenshot:(BOOL)isHeadPortraitScreenshot
{
    _isHeadPortraitScreenshot = isHeadPortraitScreenshot;
    self.groupVc.isHeadPortraitScreenshot = isHeadPortraitScreenshot;
}

- (void)setIsCanAutoChangeCheck:(BOOL)isCanAutoChangeCheck{
    _isCanAutoChangeCheck = isCanAutoChangeCheck;
    self.groupVc.isCanAutoChangeCheck = isCanAutoChangeCheck;
}

#pragma mark - 展示控制器
- (void)showPickerVc:(UIViewController *)vc{
//    __weak typeof(vc)weakVc = vc;
//    if (weakVc != nil) {
//        [weakVc presentViewController:self animated:YES completion:nil];
//    }
     ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
     if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied) {
          CGFloat kSystemMainVersion = [UIDevice currentDevice].systemVersion.floatValue;
          NSString *title = nil;
          NSString *msg = @"还没有开启相册权限~请在系统设置中开启";
          NSString *cancelTitle = @"暂不";
          NSString *otherButtonTitles = @"去设置";

          if (kSystemMainVersion < 8.0) {
               title = @"相册权限未开启";
               msg = @"请在系统设置中开启相机服务\n(设置>隐私>相册>开启)";
               cancelTitle = @"知道了";
               otherButtonTitles = nil;
          }

          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:otherButtonTitles, nil];
          [alertView show];
     }
     __weak typeof(vc)weakVc = vc;
     if (weakVc != nil) {
          [weakVc presentViewController:self animated:YES completion:nil];
     }
}

- (void) addNotification{
    // 监听异步done通知
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(done:) name:PICKER_TAKE_DONE object:nil];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancel:) name:@"cancelTakePhoto" object:nil];
    });
    
    // 监听异步点击第一个Cell的拍照通知
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectCamera:) name:PICKER_TAKE_PHOTO object:nil];
    });
}

#pragma mark - 监听点击第一个Cell进行拍照
- (void)selectCamera:(NSNotification *)noti{
    dispatch_async(dispatch_get_main_queue(), ^{
        if([self.delegate respondsToSelector:@selector(pickerCollectionViewSelectCamera:withImage:)]){
            [self.delegate pickerCollectionViewSelectCamera:self withImage:noti.userInfo[@"image"]];
        }
    });
}

#pragma mark - 监听点击Done按钮
- (void)done:(NSNotification *)note{
    NSArray *selectArray =  note.userInfo[@"selectAssets"];
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(pickerViewControllerDoneAsstes:)]) {
            [self.delegate pickerViewControllerDoneAsstes:selectArray];
        }else if (self.callBack){
            self.callBack(selectArray);
        }
//        [self dismissViewControllerAnimated:YES completion:nil];
    });
}
- (void)cancel:(NSNotification *)note{
//     NSArray *selectArray =  note.userInfo[@"cancelTakePhoto"];
     dispatch_async(dispatch_get_main_queue(), ^{
//          if ([self.delegate respondsToSelector:@selector(pickerViewControllerDoneAsstes:)]) {
//               [self.delegate pickerViewControllerDoneAsstes:selectArray];
//          }else
               if (self.callBack){
               self.callBack(nil);
          }
          //        [self dismissViewControllerAnimated:YES completion:nil];
     });
}

- (void)setDelegate:(id<ZLPhotoPickerViewControllerDelegate>)delegate{
    _delegate = delegate;
    self.groupVc.delegate = delegate;
}
@end
