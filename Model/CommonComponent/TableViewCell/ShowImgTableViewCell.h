//
//  ShowImgTableViewCell.h
//  yihui
//
//  Created by orange on 15/9/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
#import "JYBaseTableViewCell.h"
@interface ShowImgTableViewCell :JYAbstractTableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) void (^reloadCellBlock) (NSArray *img);
@property (strong, nonatomic) void (^addImgBlock) (void);
-(void)setCellData:(NSDictionary *)dataDic;
-(void)heightOfCell:(NSDictionary *)dataDic;
@end
