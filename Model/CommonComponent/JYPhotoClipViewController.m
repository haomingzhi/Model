//
//  JYPhotoClipViewController.m
//  TestYiHui
//
//  Created by wujiayuan on 15/10/29.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import "JYPhotoClipViewController.h"

@interface JYPhotoClipViewController ()<UIScrollViewDelegate>
{
     IBOutlet UIView *_topView;
     IBOutlet UIView *_bottomView;
     IBOutlet UIButton *_backBtn;
     IBOutlet UIButton *_useBtn;
     UIScrollView *_scrollview;
     UIImageView *_imageview;
     IBOutlet UIView *_clipView;
     NSInteger _curIndex;
     NSMutableArray *_selectDataArr;
     //    IBOutlet UIImageView *_imgV;

}
@end

@implementation JYPhotoClipViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view from its nib.
     //    self.title = @"test";
     _selectDataArr = [NSMutableArray array];
     self.navigationController.navigationBar.translucent = NO;
     self.navigationController.navigationBarHidden = YES;
     self.navigationController.navigationBar.alpha = 1;
     _clipView.layer.borderColor = [UIColor lightGrayColor].CGColor;
     _clipView.layer.borderWidth = 1;
     if (_clipRect.size.width > 0) {
          _clipView.frame = _clipRect;
     }
     if (_dataArr.count > 0) {
          //        _imageview.image = _dataArr[0];
          _curIndex = 0;
          [self setScrollView:_dataArr[_curIndex]];
          [self.view bringSubviewToFront:_clipView];
          [self.view bringSubviewToFront:_useBtn];
          [self.view bringSubviewToFront:_backBtn];
          [self.view insertSubview:_topView aboveSubview:_scrollview];
          [self.view insertSubview:_bottomView aboveSubview:_scrollview];
     }

}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}
- (IBAction)userHandle:(UIButton *)btn {
     btn.enabled = NO;
     _backBtn.enabled = NO;
     //    UIGraphicsBeginImageContext(self.view.bounds.size);
     UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO,  [UIScreen mainScreen].scale);
     [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];

     UIImage *image=UIGraphicsGetImageFromCurrentImageContext();

     UIGraphicsEndImageContext();
     CGRect rect = [self.view convertRect:_clipView.frame fromView:_scrollview];
     //    UIImage *srcimg = _imageview.image;

     //    NSLog(@"image width = %f,height = %f",srcimg.size.width,srcimg.size.height);
     NSInteger cc = 0;//长方形有误差
     if (_clipRect.size.width > 0) {
          cc = 0;
     }
     rect.size.width = MIN((_clipView.width - _clipView.borderWidth * 2)* [UIScreen mainScreen].scale, _imageview.width*[UIScreen mainScreen].scale-4) ;
     rect.size.height = MIN((_clipView.height - _clipView.borderWidth * 2 - cc * 2)* [UIScreen mainScreen].scale, MIN(rect.size.width*(_clipRect.size.width > 0?2/3.0:1),_imageview.height*[UIScreen mainScreen].scale-4)) ;

     rect.origin.x = (_clipView.x + _clipView.borderWidth)* [UIScreen mainScreen].scale;
     rect.origin.y = (_clipView.y +  _clipView.borderWidth + cc)* [UIScreen mainScreen].scale;
     UIImageView *imgview = [[UIImageView alloc] init];

     CGImageRef cgimg = CGImageCreateWithImageInRect([image CGImage], rect);
     imgview.image = [UIImage imageWithCGImage:cgimg];
     _imageview.image = nil;
     imgview.frame = _clipView.frame;
     imgview.x = 0;
     imgview.y = 0;
     [_clipView addSubview:imgview];
     CGImageRelease(cgimg);//／／用完一定要释放，否则内存泄露
     [_selectDataArr addObject:imgview.image];
     _curIndex ++;
     if (_dataArr.count > _curIndex) {
          [UIView animateWithDuration:1 animations:^{
               imgview.alpha = 0;
          } completion:^(BOOL finished) {
               btn.enabled = YES;
               _backBtn.enabled = YES;
               UIImage *img = _dataArr[_curIndex];
               [imgview removeFromSuperview];
               [_imageview removeFromSuperview];
               _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0)];
               _imageview.image = img;
               //调用initWithImage:方法，它创建出来的imageview的宽高和图片的宽高一样
               [_scrollview addSubview:_imageview];
               [_imageview autoSize];
               //            if (image.size.width >= __SCREEN_SIZE.width*2) {
               //                _scrollview.zoomScale = 0.5;//__SCREEN_SIZE.width/image.size.width;
               //                _scrollview.minimumZoomScale=0.1;
               //            }
               //            else if(image.size.width >= __SCREEN_SIZE.width)
               //            {
               //                _scrollview.zoomScale = 0.8;
               //                _scrollview.minimumZoomScale=0.5;
               //            }
               //            else
               //            {
               //                _scrollview.zoomScale = 1;
               //                _scrollview.minimumZoomScale = 0.6;
               //            }

               [self updateScrollviewContentOffset];
               //            [_imageview sizeToFit];
               //            [_scrollview sizeToFit];
               //             _scrollview.zoomScale = __SCREEN_SIZE.width/image.size.width;
               //            [_scrollview setZoomScale:__SCREEN_SIZE.width/(image.size.width*1.0) animated:NO];
               //            _imageview.x = 0;
               //            _imageview.y = 0;
               //            _scrollview.zoomScale = __SCREEN_SIZE.width/image.size.width;
               //            CGPoint point = CGRectMake(0, 0, _scrollview.width, _scrollview.height);
               //            center.y = center.y - 200;

          }];
     }
     else
     {
          if (_callBack) {
               _callBack(_selectDataArr);
          }
          //       [self.navigationController popViewControllerAnimated:YES];
     }


}

-(void)viewDidLayoutSubviews
{
     [super viewDidLayoutSubviews];

     if (_clipRect.size.width > 0) {
          _clipView.frame = _clipRect;
     }
     else
     {
          _clipView.width = __SCREEN_SIZE.width;
          _clipView.height = __SCREEN_SIZE.width/3.0*3;
     }
     _clipView.center = self.view.center;
     _bottomView.alpha = 0.8;
     _topView.alpha = 0.8;
     _topView.height = _clipView.y;
     _bottomView.y = _clipView.y +_clipView.height;
     _bottomView.height = __SCREEN_SIZE.height - _clipView.height - _topView.height;
     _useBtn.y = _bottomView.y + 40;
     _backBtn.y = _bottomView.y + 40;
     _scrollview.contentInset = UIEdgeInsetsMake(_topView.height, 0/320.0*__SCREEN_SIZE.width, _bottomView.height, 0/320.0*__SCREEN_SIZE.width);
}

//- (void)cutMapView:(UIView *)theView
//{
//    //************** 得到图片 *******************
//    CGRect rect = theView.frame;  //截取图片大小
//
//    //开始取图，参数：截图图片大小
//    UIGraphicsBeginImageContext(rect.size);
//    //截图层放入上下文中
//    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    //从上下文中获得图片
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    //结束截图
//    UIGraphicsEndImageContext();
//
//
//    //************** 存图片 *******************
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"jietu"]];   // 保存文件的名称
//    NSLog(@"filePath = %@",filePath);
//    //UIImagePNGRepresentation方法将image对象转为NSData对象
//    //写入文件中
//    BOOL result = [UIImagePNGRepresentation(image)writeToFile: filePath atomically:YES];
//    NSLog(@"result = %d",result);
//
//
//    //*************** 截取小图 ******************
//    CGRect rect1 = CGRectMake(90, 0, 82, 82);//创建矩形框
//    //对图片进行截取
//    UIImage * image2 = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect1)];
//    NSString *filePath2 = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"jietu2"]];   // 保存文件的名称
//    NSLog(@"filePath = %@",filePath);
//    BOOL result2 = [UIImagePNGRepresentation(image2)writeToFile:filePath2 atomically:YES];
//    NSLog(@"result2 = %d",result2);
//
//    //存入相册
//    //UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
//}

-(void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
     [scrollView setContentOffset:scrollView.contentOffset animated:NO];
     //    if(scrollView.contentOffset.x <= 0)
     //    {
     //        [scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y)];
     //    }else if(scrollView.contentOffset.y <= 0)
     //    {
     //        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
     //    }
     //    else if(scrollView.contentOffset.x >= scrollView.contentSize.width)
     //    {
     //        [scrollView setContentOffset:CGPointMake(scrollView.contentSize.width, scrollView.contentOffset.y)];
     //    }
     //    else if(scrollView.contentOffset.y >= scrollView.contentSize.height)
     //    {
     //        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height)];
     //    }else
     //    {
     //
     //    }
}

-(void)setScrollView:(UIImage *)image
{
     _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height)];
     _scrollview.clipsToBounds = NO;
     [self.view addSubview:_scrollview];
     //    _scrollview.borderColor = [UIColor redColor];
     //    _scrollview.borderWidth = 3;
     _scrollview.showsHorizontalScrollIndicator = NO;
     _scrollview.showsVerticalScrollIndicator = NO;
     _scrollview.bounces = NO;

     _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0)];
     _imageview.image = image;

     //调用initWithImage:方法，它创建出来的imageview的宽高和图片的宽高一样
     [_scrollview addSubview:_imageview];
     //     _imageview.center = self.view.center;
     //    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, __SCREEN_SIZE.height - _bottomView.height, __SCREEN_SIZE.width, _bottomView.height)];
     //    v.backgroundColor = [UIColor whiteColor];
     //    [_scrollview addSubview:v];

     //设置UIScrollView的滚动范围和图片的真实尺寸一致

     //设置实现缩放
     //设置代理scrollview的代理对象
     _scrollview.delegate = self;
     //设置最大伸缩比例
     _scrollview.maximumZoomScale = 2.0;
     //设置最小伸缩比例
     [_imageview autoSize];
     //    _imageview.center = _scrollview.center;

     if (image.size.width >= __SCREEN_SIZE.width*2) {
          //        _scrollview.zoomScale = [UIScreen mainScreen].scale;//__SCREEN_SIZE.width/image.size.width;
          [_scrollview setZoomScale:0.8 animated:NO];
          _scrollview.minimumZoomScale=0.8;
     }
     else if(image.size.width >= __SCREEN_SIZE.width)
     {
          _scrollview.zoomScale = 0.8;
          _scrollview.minimumZoomScale=0.8;
     }
     else
     {
          _scrollview.zoomScale = 0.8;
          _scrollview.minimumZoomScale = 0.8;
     }
     [self updateScrollviewContentOffset];
     //    CGSize size = _scrollview.contentSize;
     //    size.height = size.height*2;
     //    _scrollview.contentSize = size;


}

-(void)updateScrollviewContentOffset
{
     CGFloat y = __SCREEN_SIZE.height/2.0;
     y = y - _imageview.height/2.0;
     //    if (_clipRect.size.width > 0) {
     _scrollview.contentOffset = CGPointMake(0, 21 - y);
     //    }
     //    else
     //    {
     //        _scrollview.contentOffset = CGPointMake(0, -y);
     //    }
}

//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale
//{
//    CGSize size = _scrollview.contentSize;
//    size.height = size.height*2;
//    _scrollview.contentSize = size;
//}

//告诉scrollview要缩放的是哪个子控件
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
     return _imageview;
}
/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)tett:(id)sender {

}
- (IBAction)backHandle:(id)sender {
     [_scrollview removeFromSuperview];
     if(!_isPresent)
     {
          [(NSMutableArray *)_dataArr removeAllObjects];
          [self.navigationController popViewControllerAnimated:YES];
          if (_callBack) {
               _callBack(nil);
          }
     }
     else
     {

          [(NSMutableArray *)_dataArr removeAllObjects];
          [self dismissViewControllerAnimated:YES completion:nil];
          if (_callBack) {
               _callBack(_selectDataArr);
          }

     }
}
- (void)showPickerVc:(UIViewController *)vc{
     __weak typeof(vc)weakVc = vc;
     if (weakVc != nil) {
          _isPresent = YES;
          [weakVc presentViewController:self animated:YES completion:nil];
     }
}

-(void)viewWillDisappear:(BOOL)animated
{
     [super viewWillDisappear:animated];
     self.navigationController.navigationBarHidden = NO;
}
@end
