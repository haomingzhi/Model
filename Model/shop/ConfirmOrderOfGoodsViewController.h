//
//  ConfirmOrderOfGoodsViewController.h
//  compassionpark
//
//  Created by Steve on 2017/2/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUSystem.h"

@interface ConfirmOrderOfGoodsViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
//@property (nonatomic,strong)  BUGoodsDetail *goods;
@property (nonatomic,assign) NSInteger num;
@end
