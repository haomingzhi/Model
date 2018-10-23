//
//  ImgAndBtnCollectionViewCell.h
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgAndBtnCollectionViewCell : UICollectionViewCell
-(void)setCellData:(NSDictionary *)dic;
@property(nonatomic,strong)void (^handleAction)(id o);
@property(nonatomic,strong)UIImageView *imageView;
-(void)fitMode;
-(void)fitModeB;
-(void)fitShopMode;
@end
