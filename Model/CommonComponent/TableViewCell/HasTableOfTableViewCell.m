//
//  HasTableOfTableViewCell.m
//  ulife
//
//  Created by air on 15/12/18.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "HasTableOfTableViewCell.h"
#import "IconAndTitleTableViewCell.h"
#import "ConmentTableViewCell.h"
@implementation HasTableOfTableViewCell
{

    NSInteger _type;
    IBOutlet MyTableView *_tableView;
}


- (void)awakeFromNib {
    // Initialization code
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.refreshFooterView = nil;
    _tableView.refreshHeaderView = nil;
    _tableView.dataArr = [NSMutableArray arrayWithArray:@[]];
    [_tableView registerNib:[UINib nibWithNibName:@"IconAndTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"IconAndTitleTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"ConmentTableViewCell" bundle:nil] forCellReuseIdentifier:@"ConmentTableViewCell"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(MyTableView*)tableView
{
    return _tableView;
}

-(void)reloadData
{
    [_tableView reloadData];
    _tableView.height = MAX(_tableView.contentSize.height, __SCREEN_SIZE.height - 64 - 49 - 44);//_tableView.contentSize.height;
    self.height = _tableView.height;//MAX(_tableView.height, __SCREEN_SIZE.height - 64 - 44);
}

-(void)setCellData:(NSDictionary *)dataDic
{
   _type = [dataDic[@"type"] integerValue];
    _tableView.dataArr = dataDic[@"arr"];
  
    if (_tableView.dataArr.count == 0) {
        self.hasInit = YES;
        self.isNoData = YES;
        [self showNoDataView];
        
    }
    else
    {
        self.hasInit = YES;
        self.isNoData = NO;
        [self hiddenNoDataView];
    }
    [self reloadData];
}

-(void)hiddenNoDataView
{

}

-(void)showNoDataView
{

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.hasInit)
        return 1;
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableView.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;

    if (_type == 1) {
        height = 56;
    }
    else
    {
            UITableViewCell *  cell = [self getCellWithType:_type andWithIndexPath:indexPath];
            height = cell.height;
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
    cell = [self getCellWithType:_type andWithIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.handleAction) {
        self.handleAction(@{@"sender":@"1",@"indexPath":indexPath});
    }
}

-(UITableViewCell *)getCellWithType:(NSInteger)type andWithIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSDictionary *dic = _tableView.dataArr[indexPath.row];
    switch (type) {
        case 0:
        {
            cell  = [_tableView dequeueReusableCellWithIdentifier:@"ConmentTableViewCell"];
            ConmentTableViewCell *cCell = (ConmentTableViewCell *)cell;
            [cCell setCellData:dic];
            if (indexPath.row != _tableView.dataArr.count - 1) {
                  [cCell showSeparatorView];
            }
          [cCell setHandleAction:^(id o) {
//             NSInteger row = [o integerValue];
//              NSLog(@"ping lun :%ld",row);
              if (self.imgBtnAction) {
                  self.imgBtnAction(@{@"row":o});
              }
          }];
             [cCell showSeparatorView];
        }
            break;
        case 1:
        {
            cell  = [_tableView dequeueReusableCellWithIdentifier:@"IconAndTitleTableViewCell"];
            IconAndTitleTableViewCell *iCell = (IconAndTitleTableViewCell *)cell;
            NSMutableDictionary *ddic = [NSMutableDictionary dictionaryWithDictionary:dic];
            ddic[@"mode"] = @(1);
            [iCell setCellData:ddic];
            [iCell setHandleAction:^(id o) {
                //             NSInteger row = [o integerValue];
                //              NSLog(@"ping lun :%ld",row);
                if (self.imgBtnAction) {
                    self.imgBtnAction(@{@"row":o});
                }
            }];
            [iCell setImgBtnAction:^(id o) {
                //             NSInteger row = [o integerValue];
                //              NSLog(@"ping lun :%ld",row);
                if (self.imgBtnAction) {
                    self.imgBtnAction(@{@"row":o});
                }
            }];
//             if (indexPath.row != _tableView.dataArr.count - 1) {
             [iCell showSeparatorView];
//             }
        }
            break;
        default:
            break;
    }
    return cell;
}

@end
