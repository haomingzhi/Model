//
//  SelectBtnsTableViewCell.h
//  yihui
//
//  Created by air on 15/9/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
#define TitleAndSelectBtnCellWidth  70
#define TitleAndSelectBtnScale (40/70.0)
@interface SelectBtnsTableViewCell : JYAbstractTableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>

@end
