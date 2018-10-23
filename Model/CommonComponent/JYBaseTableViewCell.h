//
//  JYBaseTableViewCell.h
//  TestTableView
//
//  Created by wujiayuan on 15/8/13.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JYBaseTableViewCell : NSObject
@property(nonatomic,strong) NSMutableDictionary *dataDic;
@property(nonatomic) CGFloat height;
@property(nonatomic)UITableViewCellAccessoryType    accessoryType;
-(UITableViewCell *)createTableViewCell;
@property(nonatomic,strong)void (^handleAction)(id sender);
@end
