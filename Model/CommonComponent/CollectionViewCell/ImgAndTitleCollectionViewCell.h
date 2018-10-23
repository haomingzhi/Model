//
//  ImgAndTitleCollectionViewCell.h
//  lovecommunity
//
//  Created by air on 16/5/13.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUImageRes.h"
@interface ImgAndTitleCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) void (^delCallback)(id o);
-(void)setCellData:(NSDictionary *)dataDic;
-(void)setCellDataGray:(NSDictionary *)dataDic;
-(void)setCellData:(NSDictionary *)dataDic IndexPath:(BUImageRes *)seleImg;
-(void)OldsetCellData:(NSDictionary *)dataDic IndexPath:(BUImageRes *)seleImg;
-(void)fitThreeMode;
-(void)fitFourMode;
-(void)fitThreeModeB;
-(void)fitServerMode;
-(void)setServerData:(NSDictionary *)dataDic;
-(void)fitHeadMode;
-(void)fitTwoMode;
-(void)fitClassityMode;
@end
