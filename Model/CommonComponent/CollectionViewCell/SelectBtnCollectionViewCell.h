//
//  SelectBtnCollectionViewCell.h
//  yihui
//
//  Created by air on 15/9/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBtnCollectionViewCell : UICollectionViewCell
-(void)setCellData:(NSDictionary *)dataDic;
-(void)fitRowShowMode;
-(void)fitRowShowModeA;
-(void)fitTimeMode;
-(void)fitDateMode;
-(void)fitNormalMode;
-(void)fitNoDateMode;
-(void)fitTypeMode;
-(void)fitTypeModeA;
-(void)fitCellMode;
@end
