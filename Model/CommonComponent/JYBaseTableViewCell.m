//
//  JYBaseTableViewCell.m
//  TestTableView
//
//  Created by wujiayuan on 15/8/13.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import "JYBaseTableViewCell.h"

@implementation JYBaseTableViewCell

-(id)init
{
    self = [super init];
    if (self) {
        self.height = -1;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

-(UITableViewCell *)createTableViewCell
{
    return [self createTableViewCellWithHeight: -1];
}

-(UITableViewCell *)createTableViewCellWithHeight:(CGFloat)height
{
    UITableView *tableView = _dataDic[@"tableView"];
    NSString *clsName = _dataDic[@"cellClass"];
         [tableView registerNib:[UINib nibWithNibName:_dataDic[@"cellClass"] bundle:nil] forCellReuseIdentifier:_dataDic[@"cellClass"]];
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:clsName];
      cell.separatorInset = UIEdgeInsetsMake(0, 1990, 0, 0);
    if ([cell respondsToSelector:@selector(setCellData:)]) {
        [cell performSelector:@selector(setCellData:) withObject:_dataDic[@"dataDic"]];
    }
    [cell setValue:^(id sender){
        if (_handleAction) {
            _handleAction(sender);
        }
        
    } forKey:@"handleAction"];
//    tableView.separatorColor = kUIColorFromRGB(color_0xe3e3e3);
    if ([cell respondsToSelector:@selector(heightOfCell)]){
    id h =  [cell performSelector:@selector(heightOfCell) withObject:nil] ;
        _height = [h floatValue];
    }
    if (height != -1) {
        _height = height;
        //调整cell高度
        
    }
    cell.accessoryType = self.accessoryType;
    return cell;
}



-(CGFloat)height
{
    if (_height == -1) {
        [self createTableViewCell];
    }
    return _height;
}
@end
