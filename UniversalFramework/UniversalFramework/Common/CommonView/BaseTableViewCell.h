//
//  JYAbstractTableViewCell.h
//  TestTableView
//
//  Created by wujiayuan on 15/8/29.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import <UIKit/UIKit.h>


#define BaseTableViewCell_separatorInset @"separatorInset"
#define BaseTableViewCell_height @"height"
#define BaseTableViewCell_userData @"userData"

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic,weak) id userData;
/**
 *  比如cell上有按钮，点击事件
 */
@property(nonatomic,strong) void (^handleAction)(id sender);
-(void)setCellData:(NSDictionary *)dataDic;
-(id)heightOfCell;

@end
