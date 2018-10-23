//
//  ViewController.h
//  photographDemo
//
//  Created by liguohuai on 16/4/3.
//  Copyright © 2015年 Renford. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "ZLPhotoPickerViewController.h"
@interface TakePhotoViewController : JYBaseViewController
@property(nonatomic)NSInteger mode;//0相册1 拍照
@property(nonatomic)NSInteger imgsCount;//0拍单个其他数字是限制拍照个数
@property(nonatomic,strong)id<ZLPhotoPickerViewControllerDelegate> photoVCdelgate;//相册委托
@end

