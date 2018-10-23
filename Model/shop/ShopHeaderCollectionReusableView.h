//
//  ShopHeaderCollectionReusableView.h
//  compassionpark
//
//  Created by Steve on 2017/1/22.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopHeaderCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *detailLb;
@property (weak, nonatomic) IBOutlet UIImageView *lineImage;
@property (strong,nonatomic) void  (^handleAction)(id o);
-(void)fitCellMode;
-(void)fitExamMode;
-(void)setCellData:(NSDictionary *)dataDic;
@end
