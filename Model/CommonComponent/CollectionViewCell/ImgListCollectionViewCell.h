//
//  ImgListCollectionViewCell.h
//  ChaoLiu
//
//  Created by air on 15/7/22.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgListCollectionViewCell : UICollectionViewCell
-(void)setCellData:(NSDictionary *)dataDic;
//@property(nonatomic,strong)void (^deleteHandle)(NSInteger row);
@property(nonatomic,strong)UIImageView *imageView;
@end
