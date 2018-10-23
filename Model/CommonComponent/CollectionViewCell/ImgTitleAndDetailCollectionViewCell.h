//
//  ImgTitleAndDetailCollectionViewCell.h
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgTitleAndDetailCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) void (^callBack)(id o);
-(void)setCellData:(NSDictionary *)dic;
@property(nonatomic,strong)UIImageView *imageView;
-(void)fitMode;
-(void)fitPerformanceMode:(NSIndexPath *)indexPath;
-(void)fitShopMode:(NSIndexPath*)indexPath;
-(void)fitTitleAndDetailMode;
-(void)fitOnlyImageMode;
-(void)fitOnlyTitleMode;
-(void)fitHistoryShopMode:(NSIndexPath*)indexPath;
-(void)fitFavShopMode:(NSIndexPath*)indexPath;
-(void)fitTypeMode;
-(void)fitTypeModeA;
@end
