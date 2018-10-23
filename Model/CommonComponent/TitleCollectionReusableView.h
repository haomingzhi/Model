//
//  TitleCollectionReusableView.h
//  oranllcshoping
//
//  Created by Steve on 2017/8/9.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCollectionReusableView : UICollectionReusableView
@property (strong, nonatomic) UILabel *titleLb;
-(void)setCellData:(NSDictionary *)dataDic;
-(void)fitCellMode;
@end
