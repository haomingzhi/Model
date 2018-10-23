//
//  GoodsInfoViewController.h
//  compassionpark
//
//  Created by Steve on 2017/1/22.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "BUSystem.h"

@interface GoodsInfoViewController : BaseTableViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic) IBOutlet MyTableView *tableViewA;

//@property (assign,nonatomic) BOOL isActivity;//是否活动(为商品时)
@property (nonatomic,strong) NSString *ID;
//@property (nonatomic,strong) BUShopInfo *shopInfo;


@end
