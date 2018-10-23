//
//  ConditionsforscreeningViewController.h
//  oranllcshoping
//
//  Created by Steve on 2017/8/9.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConditionsforscreeningViewController : JYBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
- (IBAction)resetAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

- (IBAction)confirmAction:(UIButton *)sender;

@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *selectedArr;
+(ConditionsforscreeningViewController *)createVC:(NSArray *)arr;
@end
