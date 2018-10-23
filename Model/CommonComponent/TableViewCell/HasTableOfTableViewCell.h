//
//  HasTableOfTableViewCell.h
//  ulife
//
//  Created by air on 15/12/18.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface HasTableOfTableViewCell : JYAbstractTableViewCell<UITableViewDataSource,UITableViewDelegate>
//@property(nonatomic,strong) id<UITableViewDataSource> dataSource;
//@property(nonatomic,strong) id<UITableViewDelegate> delegate;
@property(nonatomic,strong)  void (^imgBtnAction)(id sender);
@property(nonatomic,strong) MyTableView *tableView;
-(void)reloadData;
@end
