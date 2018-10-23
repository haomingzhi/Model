//
//  InviteMemerberDelegateObj.m
//  yihui
//
//  Created by air on 15/9/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "InviteMemerberDelegateObj.h"
#import "JYTableViewCellManager.h"
#import "BUSystem.h"
#import "JYCommonTool.h"
@implementation InviteMemerberDelegateObj
{
    JYTableViewCellManager *_cellManager;
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    NSMutableArray *_tempArr;
    NSMutableArray *_sectionArr;
//    NSMutableArray *_selectedDataArr;
}

-(NSString *)getTitle
{
    if (!_title) {
        return @"邀请成员";
    }
    return _title;
}

-(void)getData
{
//    BUCircleUser *cu = [[BUCircleUser alloc] init];
//    cu.name = @"wo";
//    cu.position = @"橘子科技";
//    cu.company = @"sdfsd";
//    cu.head = [[BUImageRes alloc] init];
//    
//    BUCircleUser *cuc = [[BUCircleUser alloc] init];
//    cuc.name = @"达到";
//    cuc.position = @"kkds";
//    cuc.company = @"dddd";
//    cuc.head = [[BUImageRes alloc] init];
//    [_dataArr addObjectsFromArray:@[cu,cuc]];
//    _sectionArr = [self getSectionData:_dataArr];
//    [self initData:_tempArr];//异步初始化，异步调用
    if (_getDataCallBack) {
        _getDataCallBack(@selector(getCanInviteListNotification:),self);
    }
    else
    {
        busiSystem.circleUserManager.userList = nil;
        [busiSystem.circleUserManager getCanInviteList:busiSystem.homePageManager.cid userId:[NSString stringWithFormat:@"%ld",busiSystem.agent.userId] observer:self callback:@selector(getCanInviteListNotification:)];
    }
}
//-(void)getOutNotification:(BSNotification *)noti
//{
//    BASENOTIFICATION(noti);
//    [self initArrData:busiSystem.circleUserManager.userList];
//}
-(void)initArrData:(NSArray *) arr
{
    [_dataArr addObjectsFromArray:arr];
    _sectionArr = [self getSectionData:_dataArr];
    [self initData:_tempArr];//异步初始化，异步调用
}

-(void)getCanInviteListNotification:(BSNotification *)noti
{
    BASENOTIFICATION(noti);
    [self initArrData:busiSystem.circleUserManager.userList];
//    [_dataArr addObjectsFromArray:busiSystem.circleUserManager.userList];
//    _sectionArr = [self getSectionData:_dataArr];
//      [self initData:_tempArr];//异步初始化，异步调用
}

-(void)initCellsWithData:(NSMutableArray *)cellArr
{
    if (!_selectedDataArr) {
         _selectedDataArr = [NSMutableArray array];
    }
   
    
    [_sectionArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addSectionWithDataObj:_tableView widthCellArr:obj[@"value"] withSectionName:obj[@"key"] withHandleAction:^{
            
        } ];
    }];
  
    [cellArr addObjectsFromArray:[_cellManager getSectionArr]];
    [_tableView reloadData];
    _allCount = _dataArr.count;
    _tableView.height = __SCREEN_SIZE.height - 80 - 64;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"dataDic"]) {
       
//        JYBaseTableViewCell *cell = (JYBaseTableViewCell *)object;
//        if([cell.dataDic[@"dataDic"][@"isChecked"] boolValue])
//        {
//          
//        }
//        else
//        {
          self.changeMark = @"N";
//        }
        NSLog(@"change what:%@",change);
    }
//    else if ([keyPath isEqualToString:@"count"])
//    {
//     self.changeMark = @"N";
//    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    v.height = 22;
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 2, 90, 20)];
    NSDictionary *dic = _sectionArr[section];
    lb.font = [UIFont systemFontOfSize:12];
    lb.textColor = kUIColorFromRGB(mainColor);
    lb.text =  dic[@"key"];
    [v addSubview:lb];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 21.5, __SCREEN_SIZE.width, 0.5)];
    line.backgroundColor = kUIColorFromRGB(color_unSelColor);
    [v addSubview:line];
    return v;

}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}
-(void)initTableViewCells:(NSMutableArray *)cellArr withTableView:(UITableView *)tableView
{
    _cellManager = [JYTableViewCellManager manager];
    //注册cell
    _tableView = tableView;
    _dataArr = [NSMutableArray array];
//    _selectedArr = [NSMutableArray array];
    _tempArr = cellArr;
    [self getData];
//    [_selectedArr addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew context:nil];
}

-(id)inviteJoinCircle
{
    if (_selectedDataArr.count == 0)
    {
        return @(NO);
    }
     HUDSHOW(@"正在邀请");
    if (_inviteCallBack) {
        _inviteCallBack(_selectedDataArr,@selector(inviteJoinCircleNotification:),self);
    }
    else
    {
    [busiSystem.circleUserManager inviteJoinCircle:[NSString stringWithFormat:@"%ld",busiSystem.agent.userId] invitedUsers:_selectedDataArr cid:busiSystem.homePageManager.cid observer:self callback:@selector(inviteJoinCircleNotification:)];
    }
    return @(YES);
}
//-(void)inviteNotification:(BSNotification*)noti
//{
//  BASENOTIFICATION(noti);
//}

-(void)inviteJoinCircleNotification:(BSNotification*)noti
{
    BASENOTIFICATION(noti);
    if (_callBack) {
        _callBack();
    }
}

-(NSInteger)allSelected:(BOOL)isSelected
{
    NSArray *arrs = [_cellManager getSectionArr];
  [arrs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      NSArray *arr = obj;
      NSUInteger udd = idx;
      [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
          JYBaseTableViewCell *cell = obj;
          NSDictionary *dsDic = _sectionArr[udd];
          NSArray *dsArr = dsDic[@"value"];
          BUCircleUser *cUsr = dsArr[idx];
          if (isSelected) {
              if (![_selectedDataArr containsObject:cUsr]) {
//                  [_selectedArr addObject:obj];
                  [_selectedDataArr addObject:cUsr];
              }
          }
          else
          {
//              [_selectedArr removeObject:cell];
              [_selectedDataArr removeObject:cUsr];
          }
          
          cell.dataDic = [NSMutableDictionary dictionaryWithDictionary:cell.dataDic];
          cell.dataDic[@"dataDic"] = [NSMutableDictionary dictionaryWithDictionary:cell.dataDic[@"dataDic"]];
         NSMutableDictionary *dic = cell.dataDic[@"dataDic"];
          dic[@"isChecked"] = @(isSelected);
        [_tableView reloadData];
         
      }];
  }];
    return _allCount;
}
-(void)addSectionWithDataObj:(UITableView *)tableView widthCellArr:(NSArray *)arr withSectionName:(NSString *)sectionName withHandleAction:(void (^)()) handleBlock
{
    void (^handleAction)(NSDictionary *) = ^(NSDictionary *dic){
        UIButton *btn = dic[@"obj"];
        btn.selected = !btn.selected;
        NSIndexPath *indexPath = dic[@"indexPath"];
        JYBaseTableViewCell *cell = [_cellManager getRowCell:indexPath];
        NSDictionary *dsDic = _sectionArr[indexPath.section];
        NSArray *dsArr = dsDic[@"value"];
        BUCircleUser *cUsr = dsArr[indexPath.row];
        if (btn.selected) {
            if(![_selectedDataArr containsObject:cUsr])
            {
//                [_selectedArr addObject:cell];
                [_selectedDataArr addObject:cUsr];
            }
        }
        else
        {
//            [_selectedArr removeObject:cell];
            [_selectedDataArr removeObject:cUsr];
        }
        cell.dataDic = [NSMutableDictionary dictionaryWithDictionary:cell.dataDic];
        cell.dataDic[@"dataDic"] = [NSMutableDictionary dictionaryWithDictionary:cell.dataDic[@"dataDic"]];
        NSMutableDictionary *ddic = cell.dataDic[@"dataDic"];
        ddic[@"isChecked"] = @(btn.selected);
        
    };
    

    [_cellManager addSection];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)  {
        //        NSNumber *n = @(idx);
        BUCircleUser *uc = obj;
        NSDictionary *dic = [(JYBaseData *)obj getDataDic:0];//模型类要实现getDataDic接口协议
        BOOL isSel = [self isInSelectedArr:uc];
        if ( isSel) {
            //            [_selectedArr addObject:cell];
            [_selectedDataArr addObject:uc];
        }
        else
        {
            //            [_selectedArr removeObject:cell];
            [_selectedDataArr removeObject:uc];
        }
        NSMutableDictionary *ddic = [NSMutableDictionary dictionaryWithDictionary:dic];
//        cell.dataDic[@"dataDic"] = [NSMutableDictionary dictionaryWithDictionary:cell.dataDic[@"dataDic"]];
//        NSMutableDictionary *ddic = cell.dataDic[@"dataDic"];
        ddic[@"isChecked"] = @(isSel);
        [[_cellManager addTableViewCell:_tableView cellClass:ddic[@"className"] cellDataDic:ddic handleAction:handleAction]addObserver:self forKeyPath:@"dataDic" options:NSKeyValueObservingOptionOld context:nil];
    }];
    
}

-(BOOL)isInSelectedArr:(BUCircleUser *)user
{
    BOOL isIn=false;
    for (BUCircleUser *u in _inputSelectedDataArr) {
        if ([user.uid isEqualToString:u.uid]) {
            isIn = YES;
            break;
        }
    }
    
    return isIn;
}

-(void)dealloc
{
    [[_cellManager getSectionArr] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *arr = obj;
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            JYBaseTableViewCell *cell = obj;
            [cell removeObserver:self forKeyPath:@"dataDic"];
                    }];
    }];
}

-(NSMutableArray *)getSectionData:(NSArray *)nArr
{
    NSMutableArray *tArr = [NSMutableArray array];
    //NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    dic[@"key"] = @"管理者";
//    dic[@"value"] = [NSMutableArray array];
//    [tArr addObject:dic];
    [nArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BUCircleUser *user = obj;
//        if ([frd.role integerValue] != 3) {
//            NSMutableDictionary *di1 = tArr[0];
//            NSMutableArray *sArr = di1[@"value"];
//            [sArr addObject:frd];
//        }
//        else
//        {
            NSString *pname = [JYCommonTool toPingYin:user.name];
            
            
            //
            BOOL has = NO;
            NSMutableDictionary *selDic;
            for (NSMutableDictionary *obj2 in tArr) {
                NSString *frd2 = obj2[@"key"];
                if ([[[pname substringToIndex:1] uppercaseString] isEqualToString:frd2]) {
                    has = YES;
                    selDic = obj2;
                }
                else
                {
                    if([JYCommonTool hasNumberString:[pname substringToIndex:1]])
                    {
                        if ([frd2 isEqualToString:@"#"]) {
                            has = YES;
                            selDic = obj2;
                        }
                        
                    }
                }
            }
            
            
            if (!has) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                if ([JYCommonTool hasNumberString:[pname substringToIndex:1]]) {
                    dic[@"key"] = @"#";
                }
                else
                {
                    dic[@"key"] = [[pname substringToIndex:1] uppercaseString];
                }
                dic[@"value"] = [NSMutableArray arrayWithObjects:user, nil];
                [tArr addObject:dic];
            }
            else
            {
                NSMutableArray *sArr = selDic[@"value"];
                [sArr addObject:user];
            }
//        }
    }];
    
    [tArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString * v1 = ((NSDictionary *)obj1)[@"key"];
        NSString  *v2 = ((NSDictionary *)obj2)[@"key"];;
        NSComparisonResult sortResult =  [v1 isEqualToString:@"管理者"] ? NSOrderedAscending : [v1 compare:v2];
        return sortResult;
    }];

    return tArr;
}



- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *arr = [NSMutableArray array];
    [_sectionArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"key"] isEqualToString:@"管理者"]) {
            [arr addObject:@"#"];
        }
        else
        {
            [arr addObject:obj[@"key"]];
        }
    }];
    return arr;
    
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = _sectionArr[section];
    
    return dic[@"key"];
    
}
@end
