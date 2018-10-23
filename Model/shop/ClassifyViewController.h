//
//  ClassifyDetailViewController.h
//  supermarket
//
//  Created by Steve on 2017/11/3.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "MyCollectionView.h"

@interface ClassifyViewController : BaseTableViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet MyTableView *tableViewA;
@property (weak, nonatomic) IBOutlet MyTableView *tableViewB;
@property (weak, nonatomic) IBOutlet MyCollectionView *collectionView;
@property (nonatomic,strong) NSString *parentID;
@end
