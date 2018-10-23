//
//  PickerCollectionView.m
//  相机
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "ZLPhotoPickerCollectionView.h"
#import "ZLPhotoPickerCollectionViewCell.h"
#import "ZLPhotoPickerImageView.h"
#import "ZLPhotoPickerFooterCollectionReusableView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZLPhotoAssets.h"
#import "ZLPhoto.h"
#import "UIImage+ZLPhotoLib.h"
#import "BUImageRes.h"
#import "VPImageCropperViewController.h"
#import "BUSystem.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@interface ZLPhotoPickerCollectionView () <UICollectionViewDataSource,UICollectionViewDelegate,ZLPhotoPickerBrowserViewControllerDelegate,VPImageCropperDelegate>

@property (nonatomic , strong) ZLPhotoPickerFooterCollectionReusableView *footerView;

// 判断是否是第一次加载
@property (nonatomic , assign , getter=isFirstLoadding) BOOL firstLoadding;

@end

@implementation ZLPhotoPickerCollectionView

#pragma mark -getter
- (NSMutableArray *)selectsIndexPath{
    if (!_selectsIndexPath) {
        _selectsIndexPath = [NSMutableArray array];
    }
    
    if (_selectsIndexPath) {
        NSSet *set = [NSSet setWithArray:_selectsIndexPath];
        _selectsIndexPath = [NSMutableArray arrayWithArray:[set allObjects]];
    }
    return _selectsIndexPath;
}

#pragma mark -setter
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    // 需要记录选中的值的数据
    if (self.isRecoderSelectPicker){
        NSMutableArray *selectAssets = [NSMutableArray array];
        for (ZLPhotoAssets *asset in self.selectAssets) {
            NSLog(@"awwww");
            for (ZLPhotoAssets *asset2 in self.dataArray) {
                
                if ([asset isKindOfClass:[UIImage class]] || [asset2 isKindOfClass:[UIImage class]]) {
                    continue;
                }
                if([asset isKindOfClass:[NSURL class]])
                {
                    if ([asset isEqual:asset2.asset.defaultRepresentation.url]&&![selectAssets containsObject:asset2]) {
                        NSLog(@"asssll");
                            
                        [selectAssets addObject:asset2];
                        break;
                    }
                } else
                if ([asset.asset.defaultRepresentation.url isEqual:asset2.asset.defaultRepresentation.url]&&![selectAssets containsObject:asset2]) {
                    [selectAssets addObject:asset2];
                    break;
                }
               
            }
        }
        _selectAssets = selectAssets;
    }
    
    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
        _selectAssets = [NSMutableArray array];
    }
    return self;
}

#pragma mark -<UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZLPhotoPickerCollectionViewCell *cell = [ZLPhotoPickerCollectionViewCell cellWithCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    if(indexPath.item == 0 && self.topShowPhotoPicker &&self.isShowTakePhoto){
        UIImageView *imageView = [[cell.contentView subviews] lastObject];
        // 判断真实类型
        if (![imageView isKindOfClass:[UIImageView class]]) {
            imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.clipsToBounds = YES;
            [cell.contentView addSubview:imageView];
        }
        imageView.tag = indexPath.item;
        imageView.image = [UIImage ml_imageFromBundleNamed:@"camera"];
    }else{
        ZLPhotoPickerImageView *cellImgView = [[ZLPhotoPickerImageView alloc] initWithFrame:cell.bounds];
        cellImgView.isHeadPortraitScreenshot =_isHeadPortraitScreenshot;
        cellImgView.Action =^{
            [self selectCell:collectionView IndexPath:indexPath];
        };
        cellImgView.maskViewFlag = YES;
        // 需要记录选中的值的数据
        if (self.isRecoderSelectPicker) {
            for (ZLPhotoAssets *asset in self.selectAssets) {
                if ([asset isKindOfClass:[ZLPhotoAssets class]] && [asset.asset.defaultRepresentation.url isEqual:[(ZLPhotoAssets *)self.dataArray[indexPath.item] asset].defaultRepresentation.url]) {
                    [self.selectsIndexPath addObject:@(indexPath.row)];
                }
            }
        }
        [cell.contentView addSubview:cellImgView];
        cellImgView.tag = 380;
        cellImgView.maskViewFlag = ([self.selectsIndexPath containsObject:@(indexPath.row)]);
        
        ZLPhotoAssets *asset = self.dataArray[indexPath.item];
        cellImgView.isVideoType = asset.isVideoType;
        if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
            cellImgView.image = asset.aspectRatioImage;
        }
        cell.cellImgView =cellImgView;
    }
    return cell;
}


- (BOOL)validatePhotoCount:(NSInteger)maxCount{
    if (self.isCanAutoChangeCheck) {
//        [self reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:[[self.selectsIndexPath lastObject] integerValue] inSection:0]]];
        if (self.selectsIndexPath.count == 0) {
            return YES;
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[[self.selectsIndexPath lastObject] integerValue] inSection:0];
        
        [self.selectAssets removeLastObject];
        [self.lastDataArray removeLastObject];
         [self.selectsIndexPath removeLastObject];
     ZLPhotoPickerCollectionViewCell   *cell = (ZLPhotoPickerCollectionViewCell   *)[self cellForItemAtIndexPath:indexPath];
        ZLPhotoPickerImageView * cellImgView = ( ZLPhotoPickerImageView *)[cell viewWithTag:380];
       cellImgView.maskViewFlag = ([self.selectsIndexPath containsObject:@(indexPath.row)]);
        return YES;
    }
    else
    if (self.selectAssets.count >= maxCount) {
        NSString *format = [NSString stringWithFormat:@"最多只能选择%zd张图片",maxCount];
        if (maxCount == 0) {
            format = [NSString stringWithFormat:@"您已经选满了图片了."];
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:format delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
        [alertView show];
        return NO;
    }
    return YES;
}

#pragma mark - <UICollectionViewDelegate>

- (void)selectCell:(UICollectionView *)collectionView IndexPath:(NSIndexPath *)indexPath
{
    if (self.topShowPhotoPicker && indexPath.item == 0 && self.isShowTakePhoto) {
        NSUInteger maxCount = (self.maxCount < 0) ? KPhotoShowMaxCount :  self.maxCount;
        if (![self validatePhotoCount:maxCount]){
            return ;
        }
        if ([self.collectionViewDelegate respondsToSelector:@selector(pickerCollectionViewDidCameraSelect:)]) {
            [self.collectionViewDelegate pickerCollectionViewDidCameraSelect:self];
        }
        return ;
    }
    
    if (!self.lastDataArray) {
        self.lastDataArray = [NSMutableArray array];
    }
    
    ZLPhotoPickerCollectionViewCell *cell = (ZLPhotoPickerCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    ZLPhotoAssets *zlps =[ZLPhotoAssets new];
    ZLPhotoAssets *asset = self.dataArray[indexPath.row];
    ZLPhotoPickerImageView *pickerImageView = [cell.contentView.subviews lastObject];
    // 如果没有就添加到数组里面，存在就移除
    if (pickerImageView.isMaskViewFlag) {
        [self.selectsIndexPath removeObject:@(indexPath.row)];
        [self.selectAssets removeObject:asset];
        [self.lastDataArray removeObject:asset];
    }else{
        if (self.maxCount==1) {
            if (self.selectAssets.count !=0) {
                zlps =self.selectAssets[0];
            }
            
            [self.selectsIndexPath removeAllObjects];
            [self.selectAssets removeAllObjects];
            [self.lastDataArray removeAllObjects];
            
            [self.selectsIndexPath addObject:@(indexPath.row)];
            [self.selectAssets addObject:asset];
            [self.lastDataArray addObject:asset];
        }
        else
        {
            NSUInteger maxCount = (self.maxCount < 0) ? KPhotoShowMaxCount :  self.maxCount;
            // 1 判断图片数超过最大数或者小于0
            if (![self validatePhotoCount:maxCount]){
                return ;
            }
            [self.selectsIndexPath addObject:@(indexPath.row)];
            [self.selectAssets addObject:asset];
            [self.lastDataArray addObject:asset];
        }
        
    }
    // 告诉代理现在被点击了!
    if ([self.collectionViewDelegate respondsToSelector:@selector(pickerCollectionViewDidSelected: deleteAsset:)]) {
        if (pickerImageView.isMaskViewFlag) {
            // 删除的情况下
            [self.collectionViewDelegate pickerCollectionViewDidSelected:self deleteAsset:asset];
        }else{
            if (self.maxCount ==1) {
                [self.collectionViewDelegate pickerCollectionViewDidSelected:self deleteAsset:zlps];
                [self.collectionViewDelegate pickerCollectionViewDidSelected:self deleteAsset:nil];
            }
            else{
                [self.collectionViewDelegate pickerCollectionViewDidSelected:self deleteAsset:nil];
            }
        }
    }
    
    pickerImageView.maskViewFlag = ([pickerImageView isKindOfClass:[ZLPhotoPickerImageView class]]) && !pickerImageView.isMaskViewFlag;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //图片浏览
//    _push(self.selectsIndexPath,indexPath);
    if (self.topShowPhotoPicker && indexPath.item == 0 &&self.isShowTakePhoto) {
        NSUInteger maxCount = (self.maxCount < 0) ? KPhotoShowMaxCount :  self.maxCount;
        if (![self validatePhotoCount:maxCount]){
            return ;
        }
        if ([self.collectionViewDelegate respondsToSelector:@selector(pickerCollectionViewDidCameraSelect:)]) {
            [self.collectionViewDelegate pickerCollectionViewDidCameraSelect:self];
        }
        return ;
    }
    ZLPhotoAssets *ass =self.dataArray[indexPath.row];
    if (self.isHeadPortraitScreenshot) {
        NSLog(@"截图！");
        UIImage *image =[ass originImage];
        image = [self imageByScalingToMaxSize:image];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(0, 100.0f, self.frame.size.width, self.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self.delegateVc presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
        return;
    }
    // 图片游览器
    ZLPhotoPickerCollectionViewCell *cell = (ZLPhotoPickerCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 数据源/delegate
    pickerBrowser.delegate = self;
    // 数据源可以不传，传photos数组 photos<里面是ZLPhotoPickerBrowserPhoto>
    pickerBrowser.photos = [self addZLPhotoPickerBrowserPhotoArr:@[ass] withImgVArr:@[cell.cellImgView]];
    // 是否可以删除照片
    //            pickerBrowser.editing = YES;
    // 当前选中的值
    pickerBrowser.currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    // 展示控制器
    [pickerBrowser showPickerVc:_delegateVc];
}

- (NSMutableArray *)addZLPhotoPickerBrowserPhotoArr:(NSArray *)arr withImgVArr:(NSArray *)imgArr;
{
    NSMutableArray * mArr =[NSMutableArray new];
    for (int i=0; i<arr.count; i++)
    {
        ZLPhotoPickerBrowserPhoto *photo =[ZLPhotoPickerBrowserPhoto new];
        ZLPhotoAssets *im = arr[i];
        UIImage *d;
        UIImage *ii;
//        if(im.isCached)
//        {
            d= im.thumbImage;
            ii = im.originImage;
            photo.thumbImage = d;
            photo.photoImage = ii;
//        }
        photo.aspectRatioImage = ii;
        photo.toView = imgArr[i];
        [mArr addObject:photo];
    }
    return mArr;
}

- (NSMutableArray *)addZLPhotoPickerBrowserPhotoArr
{
    NSMutableArray * mArr =[NSMutableArray new];
    for (int i=0; i<self.dataArray.count; i++)
    {
        ZLPhotoAssets *ass =self.dataArray[i];
        UIImage *img =[ass originImage];
        ZLPhotoPickerBrowserPhoto *photo =[ZLPhotoPickerBrowserPhoto new];
        photo.thumbImage = img;
        photo.photoImage = img;
        photo.aspectRatioImage = img;
        [mArr addObject:photo];
    }
    return mArr;
}

#pragma mark 底部View
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ZLPhotoPickerFooterCollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionFooter) {
        ZLPhotoPickerFooterCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        footerView.count = self.dataArray.count;
        reusableView = footerView;
        self.footerView = footerView;
    }else{
        
    }
    return reusableView;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    // 时间置顶的话
    if (self.status == ZLPickerCollectionViewShowOrderStatusTimeDesc) {
        if (!self.firstLoadding && self.contentSize.height > [[UIScreen mainScreen] bounds].size.height) {
            // 滚动到最底部（最新的）
            [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataArray.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
            // 展示图片数
            self.contentOffset = CGPointMake(self.contentOffset.x, self.contentOffset.y + 100);
            self.firstLoadding = YES;
        }
    }else if (self.status == ZLPickerCollectionViewShowOrderStatusTimeAsc){
        // 滚动到最底部（最新的）
        if (!self.firstLoadding && self.contentSize.height > [[UIScreen mainScreen] bounds].size.height) {
            [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            // 展示图片数
            self.contentOffset = CGPointMake(self.contentOffset.x, -self.contentInset.top);
            self.firstLoadding = YES;
        }
    }
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark VPImageCropperDelegate
//完成
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
//    self.portraitImageView.image = editedImage;
    HUDSHOW(@"正在上传..")
//    [busiSystem.releases uploadImg:@[editedImage] observer:self action:@selector(uploadImgNotification:)];
//    [[NSNotificationCenter
//      defaultCenter] postNotificationName:@"dis"
//     object:self];
}
-(void)uploadImgNotification:(BSNotification*)noti
{
    BASENOTIFICATION(noti);
//    [busiSystem.agent chageLogo:busiSystem.releases.Images[0] observer:self callback:@selector(chageLogoNofification:)];
}

//上传成功以后，修改用户信息
-(void)chageLogoNofification:(BSNotification*)noti
{
    if (noti.error.code ==0) {
//        BURelease *rel =[BURelease new];
//        rel.Imagess.Path.Path.Image =busiSystem.releases.Images[0];
//        busiSystem.agent.Image.Image =rel.Imagess.Path.Path.Image;
        [[NSNotificationCenter
          defaultCenter] postNotificationName:@"dis"
         object:self];
//        [self displayRemoteImage:busiSystem.agent.Image imgView:self.imageUserLogo imageName:@"defaultHead1"];
//        [self showDetail];
        //        [busiSystem.agent changeUserInfo:self callback:@selector(changeUserInfoNotification:)];
    }
    else {
        if ([self isKindOfClass:NSClassFromString(@"BaseViewController")] && [busiSystem.errorMonitors indexOfObject:@(noti.error.code)] != NSNotFound)
        {
            BSNetworkCommand *cmd = noti.cmd;
            [self performSelector:@selector(addToHistoryCommand:) withObject:cmd];
            [self performSelector:@selector(showLoadingFailureCoverView:) withObject:@"加载失败,请点击屏幕重试"];
            HUDDISMISS;
        }
        else
            HUDCRY(noti.error.domain, TOAST_LONGERTIMER);
        return;
    }
}


//返回
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
//    NSLog(@"2");
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
