//
//  TypeChoseViewController.h
//  taihe
//
//  Created by air on 2016/11/8.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "SelectBtnCollectionViewCell.h"
@interface TypeChoseViewController : JYBaseViewController
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)NSIndexPath *curIndexPath;
@property (strong, nonatomic)NSMutableArray *dataArr;
@property(nonatomic,strong)void (^handleAction)(id);
@property(nonatomic,strong)void (^cancelAction)();
-(void)fitMode;
@property (nonatomic,assign) BOOL isRowShow;//是否一行显示
+(TypeChoseViewController *)toTypeVC;
+(TypeChoseViewController *)toTypeVC:(NSMutableArray *)dataArr withHeight:(CGFloat)height;
+(TypeChoseViewController *)toSortVC:(NSMutableArray *)dataArr withHeight:(CGFloat)height;
@end
