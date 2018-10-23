//
//  AddPhotoManager.m
//  compassionpark
//
//  Created by air on 2017/4/5.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "AddPhotoManager.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhotoAssets.h"
#import "BUImageRes.h"

@implementation AddPhotoManager
{
     NSMutableArray *_imgArr;
     JYAbstractTableViewCell *_imgsCell;
     __weak id  weakSelf;
     UITableView *_tableView;
     ZLPhotoPickerBrowserViewController *_pickerBrowser;
}

-(id)initWith:(id)obj withImgArr:(NSMutableArray *)imgArr withCell:(JYAbstractTableViewCell *)cell withTableView:(UITableView *)tableView
{
     self = [super init];
     if (self) {
          self->_imgArr = imgArr;
          self->_imgsCell = cell;
          self->weakSelf = obj;
          self->_tableView = tableView;
          self.count = 3;
     }
     return self;
}
-(void)toCheckOption:(id)userInfo
{
     [[CommonAPI managerWithVC:weakSelf] showPhotoOption:nil withTarget:self withUserInfo:userInfo];
}

#pragma mark --相册的选取照片
-(void)toPhoto
{
     [[CommonAPI managerWithVC:weakSelf] showPhotoOption:nil withTarget:self withUserInfo:@{@"count":@(1)}];//限定只能选取一张照片
}



#pragma mark -- 选取照片确定
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
     NSMutableArray *timgArr = [NSMutableArray array];
     [assets enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
          if ([obj isKindOfClass:[UIImage class]]) {
               UIImage *img = obj;
               [_imgArr addObject:img];
               [timgArr addObject:img];
          }
          else
          {
               ZLPhotoAssets *asset = (ZLPhotoAssets *)obj;
               UIImage *img = [asset originImage];
               //        UIImage *image =  [img getSubImage:CGRectMake(0, 0, __SCREEN_SIZE.width, 108*2) centerBool:YES];
               [_imgArr addObject:img];
               [timgArr addObject:img];
          }
     }];
     if(_imgArr.count > _count)
     {
          [_imgArr removeObjectsInRange:NSMakeRange(_count, _imgArr.count - _count)];
     }
     [_imgsCell setCellData:@{@"limitCount":@(_count),@"arr":_imgArr,@"colCount":@(_count)}];
     if (_checkDoneCallBack) {
          _checkDoneCallBack(@{@"arr":timgArr});
     }
     else
          [_tableView reloadData];
     [weakSelf dismissViewControllerAnimated:YES completion:nil];
}

//拍照:
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
     NSMutableArray *timgArr = [NSMutableArray array];
     UIImage *img = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
     //    UIImage *image = [img getSubImage:CGRectMake(0, 0,img.size.width, img.size.width * (106/320.0)*2) centerBool:YES];
     [_imgArr addObject:img];
     [timgArr addObject:img];
     [_imgsCell setCellData:@{@"limitCount":@(_count),@"arr":_imgArr,@"colCount":@(_count)}];
     if (_checkDoneCallBack) {
          _checkDoneCallBack(@{@"arr":timgArr});
     }
     else
          [_tableView reloadData];
     [picker dismissViewControllerAnimated:YES completion:nil];
}

//点击cancel 调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
     if (_cancelCheckCallBack) {
          _cancelCheckCallBack();
     } else
          [_tableView reloadData];
     [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void) setupPhotoBrowser:(NSDictionary *)dic{
     // 图片游览器
     //     if(!_pickerBrowser)
     //     {
     //     if (_pickerBrowser) {
     //          [_pickerBrowser.photos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     //               ZLPhotoPickerBrowserPhoto *photo = obj;
     //               [photo.toView removeObserver:self forKeyPath:@"Image"];
     //          }];
     //     }
     _pickerBrowser  = [[ZLPhotoPickerBrowserViewController alloc] init];
     //     }
     // 数据源/delegate
     //    pickerBrowser.delegate = self;
     // 数据源可以不传，传photos数组 photos<里面是ZLPhotoPickerBrowserPhoto>
     _pickerBrowser.photos = [self addZLPhotoPickerBrowserPhotoArr:dic[@"arr"] withImgVArr:dic[@"imgArr"]];
     // 是否可以删除照片
     //    pickerBrowser.editing = YES;
     // 当前选中的值
     _pickerBrowser.currentIndexPath = [NSIndexPath indexPathForRow:[dic[@"row"] integerValue] inSection:0];
     // 展示控制器
     [_pickerBrowser showPickerVc:weakSelf];
     //    [self.navigationController pushViewController:pickerBrowser animated:NO ];
}

- (NSMutableArray *)addZLPhotoPickerBrowserPhotoArr:(NSArray *)arr withImgVArr:(NSArray *)imgArr;
{
     NSMutableArray * mArr =[NSMutableArray new];
     for (int i=0; i<MIN(arr.count, imgArr.count); i++)
     {
          ZLPhotoPickerBrowserPhoto *photo =[ZLPhotoPickerBrowserPhoto new];
          BUImageRes *im = arr[i];
          UIImage *d;
          UIImage *ii;
          photo.toView = imgArr[i];
          if ([im isKindOfClass:[UIImage class]]) {
               d = (UIImage *)im;
               ii = (UIImage *)im;
               photo.thumbImage = d;
               photo.photoImage = ii;
          }
          else if([im isKindOfClass:[BUImageRes class]])
          {
               if(im.isCached)
               {
                    d= [UIImage imageWithContentsOfFile:im.cacheThumbFile];
                    ii = [UIImage imageWithContentsOfFile:im.cacheFile];
                    photo.thumbImage = d;
                    photo.photoImage = ii;
               }
               else
               {
                    im.isValid = YES;
                    photo.thumbImage = [UIImage imageContentWithFileName:@"default"];
                    photo.photoImage = [UIImage imageContentWithFileName:@"default"];
                    [im displayRemoteImage:photo.toView imageName:@"default" thumb:NO isFitImgV:NO];
                    //                    [photo.toView addObserver:self forKeyPath:@"Image" options:0 context:(__bridge void *)photo];
                    //                 [im displayRemoteImage:photo. imageName:@"default"];
               }
          }
          else
          {
               photo.thumbImage = [UIImage imageContentWithFileName:(NSString *)im];
               photo.photoImage = [UIImage imageContentWithFileName:(NSString *)im];
          }
          photo.aspectRatioImage = ii;

          [mArr addObject:photo];
     }
     return mArr;
}


//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//     if ([keyPath isEqualToString:@"Image"]) {
//          NSLog(@"cccc:sss");
//          ZLPhotoPickerBrowserPhoto *photo = (__bridge ZLPhotoPickerBrowserPhoto *)context;
//            photo.aspectRatioImage = [(UIImageView *)object image];
//           photo.photoImage = [(UIImageView *)object image];
//           photo.thumbImage = [(UIImageView *)object image];
//     }
//}

-(void)delImg:(NSInteger)indexPath
{
     [self delImg:indexPath withImgArr:nil];
}

-(void)delImg:(NSInteger )indexPath withImgArr:(NSArray *)arr
{
     [_imgArr removeObjectAtIndex:indexPath];
     [_imgsCell setCellData:@{@"limitCount":@(_count),@"arr":_imgArr,@"colCount":@(_count)}];
     if (_delImgCallBack) {
          _delImgCallBack(@{@"row":@(indexPath),@"arr":arr?:@[]});
     }
     else
          [_tableView reloadData];
}
@end
