//
//  AddImgTableViewCell.h
//  ChaoLiu
//
//  Created by air on 15/7/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#define AddImgListCellWidth 80//((__SCREEN_SIZE.width)/3.0 - 68)
#define AddImgListScale 1


#import "BaseTableViewCell.h"

@interface AddImgTableViewCell : BaseTableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic)NSInteger limitCount;
@end
