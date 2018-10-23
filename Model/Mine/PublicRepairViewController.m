//
//  PublicRepairViewController.m
//  taihe
//
//  Created by air on 2016/11/10.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "PublicRepairViewController.h"
#import "BUSystem.h"
#import "PublicApplicationViewController.h"
@interface PublicRepairViewController ()
@property(nonatomic,strong)BUGetPubFix *pubFix;

@end

@implementation PublicRepairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"公区报修申请详情";
    [self initTableView];
  
    HUDSHOW(@"加载中");
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData
{
    [busiSystem.getPubFixListManager getPubFixList:_userInfo observer:self callback:@selector(getDataNotification:)];
}

-(void)getDataNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
        if (busiSystem.getPubFixListManager.pubFixList.count > 0) {
            _pubFix = busiSystem.getPubFixListManager.pubFixList[0];
        }
        [self.infoCell setCellData:@{@"title":[NSString stringWithFormat:@"区域  %@",_pubFix.unit?:@""],@"detail":[NSString stringWithFormat:@"楼栋  %@",_pubFix.house],@"detail2":[NSString stringWithFormat:@"楼层  %@",_pubFix.floor]}];

//        [_infoCell setCellData:@{@"title":@"区域  走廊",@"detail":@"楼栋  24栋",@"detail2":@"楼层  6层"}];
        [_infoCell fitThreeTitleModeB];
        
   
        [_repairTypeCell setCellData:@{@"title":@"维修类型",@"detail":_pubFix.typestr?:@""}];
        [_repairTypeCell fitServerInfoMode];
        
   
        [_secondRepairStartTimeCell setCellData:@{@"title":@"第二次返工开始时间",@"detail":[_pubFix.reworkSecondStartTime substringToIndex:MIN(10,_pubFix.reworkSecondStartTime.length)]?:@""}];
        [_secondRepairStartTimeCell fitServerInfoMode];
        
    
        [_secondRepairEndTimeCell setCellData:@{@"title":@"第二次返工结束时间",@"detail":[_pubFix.reworkSecondEndTime substringToIndex:MIN(10,_pubFix.reworkSecondEndTime.length)]?:@""}];
        [_secondRepairEndTimeCell fitServerInfoMode];
        
   
        [_backStartTimeCell setCellData:@{@"title":@"返工开始时间",@"detail":[_pubFix.reworkOneStartTime substringToIndex:MIN(10, _pubFix.reworkOneStartTime.length)]?:@""}];
        [_backStartTimeCell fitServerInfoMode];
        
     
        [_backEndTimeCell setCellData:@{@"title":@"返工结束时间",@"detail":[_pubFix.reworkOneEndTime substringToIndex:MIN(10,_pubFix.reworkOneEndTime.length)]?:@""}];
        [_backEndTimeCell fitServerInfoMode];
        
      
        [_repairTimeCell setCellData:@{@"title":@"维修时间",@"detail":[_pubFix.workStartTime substringToIndex:MIN(10, _pubFix.workStartTime.length)]?:@""}];
        [_repairTimeCell fitServerInfoMode];
        

        [_finishTimeCell setCellData:@{@"title":@"完工时间",@"detail":[_pubFix.workEndTime substringToIndex:MIN(10, _pubFix.workEndTime.length)]?:@""}];
        [_finishTimeCell fitServerInfoMode];
        
        [_contentCell setCellData:@{@"title":_pubFix.remark?:@""}];
        [_contentCell fitRepairModeB];
          _imgsCell.mode = AddImgModeMutable;
          [_imgsCell setCellData:@{@"default":@"defaultServer",@"limitCount":@(_pubFix.imagePath.count),@"arr":[_pubFix getImgArr]?:@[],@"colCount":@3,@"hiddenDelBtn":@YES}];
        [_imgsCell fitRepairServerMode];
        
        [_areaCell setCellData:@{@"title":@"归属园区",@"detail":_pubFix.sapname?:@""}];
        [_areaCell fitServerInfoModeG];
        
        
        NSString *st;
        if (_pubFix.state == 0) {
            st = @"待受理";
            _mode = 0;
           
        }
        else if (_pubFix.state == 1)
        {
            st = @"受理中";
            if (_pubFix.reworkCount == 0) {
                _mode = 1;
            }
            else if (_pubFix.reworkCount == 1) {
                if (_pubFix.reworkOneEnd == 0) {
                    _mode = 2;
                }
                else
                _mode = 4;
            }
            else
            {
                if (_pubFix.reworkSecondEnd == 0) {
                    _mode = 4;
                }
                else
                _mode = 5;
            }
        }
        else if (_pubFix.state == 2)
        {
         st = @"受理失败";
            [self addTipView];
            _mode = 3;
        }
        else
        {
            st = @"已完成";
            if (_pubFix.reworkCount == 0) {
                _mode = 2;
            }
            else if (_pubFix.reworkCount == 1) {
                if (_pubFix.reworkOneEnd == 0) {
                     _mode = 2;
                }
                else
                _mode = 4;
            }
            else
            {
                if (_pubFix.reworkSecondEnd == 0) {
                    _mode = 4;
                }
                else
                _mode = 5;
            }
        }
    
        [_stateCell setCellData:@{@"title":st,@"detail":_pubFix.createTime?:@""}];
        [_stateCell fitServerInfoStateModeB];
        [_tableView reloadData];
        _type = _pubFix.state;
        
        [self addBottomMenuView];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)addBottomMenuView
{
    
    __weak PublicRepairViewController *weakSelf = self;
    _submitCell.width = __SCREEN_SIZE.width;
    _submitCell.y = __SCREEN_SIZE.height - 64 - 49;
    if (_type == 0) {
        [_submitCell removeFromSuperview];
          [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    else if (_type == 1)
    {
        if(_pubFix.reworkCount == 2)
        {
            NSString *st = @"";
//            NSDate *dt =   [BSUtility StrToDate:_pubFix.reworkSecondEndTime DateStr:@"yyyy-MM-dd HH:mm:ss"];
            if (_pubFix.reworkSecondEnd == 0 )
            {
                st = @"";
            }
            else
            {
                st = @"确认完成";
            }
            if ([st isEqualToString:@""]) {
                [_submitCell removeFromSuperview];
                [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            }
            else
            {
            [_submitCell setCellData:@{@"title":@"确认完成"}];
            [self.view addSubview:_submitCell];
            [_submitCell setHandleAction:^(id o) {
                [weakSelf confirm];
            }];
                [_submitCell fitRepairModeB];
                [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 50, 0)];
            }
        }
        else
        {
            NSString *st = @"";
            if( _pubFix.reworkCount == 0)
            {
                if (_pubFix.isEnd == 0) {
                      st = @"";
                }
                else
                st = @"是否满意";
            }
            else if( _pubFix.reworkCount == 1)
            {
//                NSDate *dt =   [BSUtility StrToDate:_pubFix.reworkOneEndTime DateStr:@"yyyy-MM-dd HH:mm:ss"];
                if (_pubFix.reworkOneEnd == 0 )
                {
                    st = @"";
                }
                else
                {
                    st = @"是否满意";
                }
            }
            
            if ([st isEqualToString:@""]) {
                [_submitCell removeFromSuperview];
                [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            }
            else
            {
            [_submitCell setCellData:@{@"title":@"是否满意"}];
            [self.view addSubview:_submitCell];
            [_submitCell setHandleAction:^(id o) {
                [weakSelf showSatisfiedTip];
            }];
                [_submitCell fitRepairModeB];
                [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 50, 0)];
            }
        }
       
    }
    else
    {
        if(_type == 2 )
        {
            [_submitCell setCellData:@{@"title":@"删除"}];
            [self.view addSubview:_submitCell];
            [_submitCell setHandleAction:^(id o) {
                [weakSelf deleteOption];
            }];
            [_submitCell fitRepairModeB];
        }
        else
        {
             [_submitCell setCellData:@{@"title":@"删除"}];
            [_submitCell fitRepairMode];
            [_submitCell setExtrHandleAction:^(NSDictionary *dic) {
                [weakSelf applyAgain];
                                        }];
           
            [self.view addSubview:_submitCell];
            [_submitCell setHandleAction:^(id o) {
                [weakSelf deleteOption];
            }];
        }
        [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 50, 0)];
    }
}



-(void)addTipView
{
    if (!_tipCell) {
          _tipCell = [OnlyTitleTableViewCell createTableViewCell];
    }
    [_tipCell setCellData:@{@"title":_pubFix.failCause?:@""}];
    [_tipCell fitCerFailTipMode];
    _tipCell.backgroundColor = kUIColorFromRGB(color_4);
    UIView *line = [_tipCell viewWithTag:3221];
    if (!line) {
        line = [UIView new];
        line.tag = 3221;
    }
    
    line.y = 109.5;
    line.height = 0.5;
    line.backgroundColor = kUIColorFromRGB(color_lineColor);
    line.width = __SCREEN_SIZE.width;
    [_tipCell addSubview:line];
    _tableView.tableHeaderView = _tipCell;
}

-(void)initTableView
{
    _tableView.refreshHeaderView = nil;
     _tableView.refreshFooterView = nil;
    _tipCell = [OnlyTitleTableViewCell createTableViewCell];
    _infoCell = [TitleDetailTableViewCell createTableViewCell];
    [_infoCell setCellData:@{@"title":@"区域  走廊",@"detail":@"楼栋  栋",@"detail2":@"楼层  层"}];
    [_infoCell fitThreeTitleModeB];
    
    _repairTypeCell = [TitleDetailTableViewCell createTableViewCell];
    [_repairTypeCell setCellData:@{@"title":@"维修类型",@"detail":@""}];
    [_repairTypeCell fitServerInfoMode];
    
    _secondRepairStartTimeCell = [TitleDetailTableViewCell createTableViewCell];
    [_secondRepairStartTimeCell setCellData:@{@"title":@"第二次返工开始时间",@"":@""}];
    [_secondRepairStartTimeCell fitServerInfoMode];
    
    _secondRepairEndTimeCell = [TitleDetailTableViewCell createTableViewCell];
    [_secondRepairEndTimeCell setCellData:@{@"title":@"第二次返工结束时间",@"":@""}];
    [_secondRepairEndTimeCell fitServerInfoMode];
    
    _backStartTimeCell = [TitleDetailTableViewCell createTableViewCell];
    [_backStartTimeCell setCellData:@{@"title":@"返工开始时间",@"":@""}];
    [_backStartTimeCell fitServerInfoMode];
    
    _backEndTimeCell = [TitleDetailTableViewCell createTableViewCell];
    [_backEndTimeCell setCellData:@{@"title":@"返工结束时间",@"":@""}];
    [_backEndTimeCell fitServerInfoMode];
    
    _repairTimeCell = [TitleDetailTableViewCell createTableViewCell];
    [_repairTimeCell setCellData:@{@"title":@"维修时间",@"detail":@""}];
    [_repairTimeCell fitServerInfoMode];
    
    _finishTimeCell = [TitleDetailTableViewCell createTableViewCell];
    [_finishTimeCell setCellData:@{@"title":@"完工时间",@"detail":@""}];
    [_finishTimeCell fitServerInfoMode];
    
    _imgTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_imgTipCell setCellData:@{@"title":@"上传图片"}];
     [_imgTipCell fitServerInfoStateMode];
    
    _imgsCell = [AddImgTableViewCell createTableViewCell];
    [_imgsCell setCellData:@{@"arr":@[]}];
    [_imgsCell fitRepairServerMode];
    
    _contentTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_contentTipCell setCellData:@{@"title":@"具体位置和报修事项描述"}];
    [_contentTipCell fitServerInfoStateModeB];
    
    _contentCell = [OnlyTitleTableViewCell createTableViewCell];
       [_contentCell fitRepairMode];
    
    _statetipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_statetipCell setCellData:@{@"title":@"当前状态"}];
    [_statetipCell fitServerInfoStateMode];
    
    _stateCell = [TitleDetailTableViewCell createTableViewCell];
    [_stateCell setCellData:@{@"title":@"受理中",@"detail":@""}];
    [_stateCell fitServerInfoStateMode];
    _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
    
    _areaCell = [TitleDetailTableViewCell  createTableViewCell];
    [_areaCell setCellData:@{@"title":@"归属园区",@"detail":@""}];
    [_areaCell fitServerInfoModeG];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 2;
    if (section == 0) {
        row = [self getFirstSectionRows:_mode];
    }
    else if(section == 1)
    {
        row = 2;
    }
    else if(section == 2)
    {
        row = 2;
    }
    else  if(section == 3)
    {
        row = 2;
    }
    else
    {
        row = 1;
    }
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        return nil;
    }
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 10)];
    v.backgroundColor = kUIColorFromRGB(color_4);
//    UIView *vl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0.5)];
//    vl.backgroundColor = kUIColorFromRGB(color_lineColor);
    UIView *vl2 = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
    vl2.backgroundColor = kUIColorFromRGB(color_lineColor);
    [v addSubview:vl2];
//    [v addSubview:vl];
    return v;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 35;
    if(indexPath.section == 0)
    {
        height = [self getFirstCellHeight:_mode withIndexPath:indexPath];
        
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
              height = 40;
        }
      else
        height = _imgsCell.height;
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            height = 36;
        }
        else
            height = _contentCell.height;
    }
    else if (indexPath.section == 3)
    {
        if (indexPath.row == 0) {
            height = 34;
        }
        else
            height = 26;
    }
    else
    {
        height = 44;
    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if (indexPath.section == 0) {
        cell = [self getFirstSectionCell:_mode withIndexPath:indexPath];
           [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            cell = _imgTipCell;
//            [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
        }
        else
        {
            cell = _imgsCell;
             [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(_imgsCell.height, 0, 0, 0)];
        }
        
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            cell = _contentTipCell;
        }
        else
        {
            cell = _contentCell;
             [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(_contentCell.height, 0, 0, 0)];
        }
//        [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
    }
    else if (indexPath.section == 3)
    {
        if (indexPath.row == 0) {
            cell = _statetipCell;
        }
        else
        {
            cell = _stateCell;;
             [_stateCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(_stateCell.height, 0, 0, 0)];
        }
    }
    else
    {
        cell = _areaCell;
        [_areaCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(_areaCell.height, 0, 0, 0)];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(NSInteger)getFirstSectionRows:(NSInteger)mode
{
    NSInteger row = 2;
    switch (mode) {
        case 0:
        {
            row = 3;
        }
            break;
        case 1:
        {
           row = 4;
        }
            break;
        case 2:
        {
           row = 4;
        }
            break;
        case 3:
        {
             row = 3;
        }
            break;
        case 4:
        {
             row = 6;
        }
            break;
        case 5:
        {
             row = 8;
        }
            break;
        default:
            break;
    }
    return row;
}

-(UITableViewCell *)getFirstSectionCell:(NSInteger)mode withIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (mode == 0) {
        switch (indexPath.row) {
            case 0:case 1:case 2:
            {
                cell = [self getWaitFirstSectionCell:indexPath];
            }
                break;
            default:
                break;
        }
    }
    else if (mode == 1)
    {
        switch (indexPath.row) {
            case 0:case 1:case 2:case 3:
            {
                cell = [self getFinishFirstSectionCell:indexPath];
            }
                break;

            default:
                break;
        }
    }
    else if (mode == 2)
    {
        switch (indexPath.row) {
            case 0:case 1:case 2:case 3:
            {
                cell = [self getFinishFirstSectionCell:indexPath];
            }
                break;

            default:
                break;
        }
    }
    else if (mode == 3)
    {
        switch (indexPath.row) {
            case 0:case 1:case 2:
            {
                cell = [self getWaitFirstSectionCell:indexPath];
            }
                break;
            default:
                break;
        }
    }
    else if (mode == 4)
    {
        switch (indexPath.row) {
            case 0: case 1:
            {
                cell = [self getBaseFirstSectionCell:indexPath];
            }
                break;
            case 2:
            {
                 cell = _backStartTimeCell;
            }
                break;
            case 3:
            {
                 cell = _backEndTimeCell;
            }
                break;
            case 4:
            {
                cell = _repairTimeCell;
            }
                break;
            case 5:
            {
                cell = _finishTimeCell;
            }
                break;
            default:
                break;
        }
    }
    else
    {
        switch (indexPath.row) {
            case 0: case 1:
            {
                cell = [self getBaseFirstSectionCell:indexPath];
            }
                break;
      
            case 2:
            {
                cell = _secondRepairStartTimeCell;
            }
                break;
                case 3:
            {
                cell = _secondRepairEndTimeCell;
            }
                break;
            case 4:
            {
                cell = _backStartTimeCell;
            }
                break;
            case 5:
            {
                cell = _backEndTimeCell;
            }
                break;
            case 6:
            {
               cell = _repairTimeCell;
            }
                break;
            case 7:
            {
              cell = _finishTimeCell;
            }
                break;
            default:
                break;
        }
    }
    return cell;
}

-(UITableViewCell *)getBaseFirstSectionCell:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return _infoCell;
    }
    return _repairTypeCell;
}

-(UITableViewCell *)getWaitFirstSectionCell:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:case 1:
        {
            return [self getBaseFirstSectionCell:indexPath];
        }
            break;
         case 2:
        {
            return _repairTimeCell;
        }break;
        default:
            break;
    }
    return nil;
}

-(UITableViewCell *)getFinishFirstSectionCell:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:case 1:case 2:
        {
            return [self getWaitFirstSectionCell:indexPath];
        }
            break;
        case 3:
        {
            return _finishTimeCell;
        }break;
        default:
            break;
    }
    return nil;
}


-(CGFloat)getFirstCellHeight:(NSInteger)mode withIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    return height;
}


-(void)confirm
{
      [[CommonAPI managerWithVC:self] showAlert:@selector(sureRequest:) withTitle:nil withMessage:@"确认该服务已完成？" withObj:@{}];
}

-(void)sureRequest:(NSDictionary *)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        HUDSHOW(@"确认中");
        [busiSystem.getPubFixListManager surePubFixList:_pubFix.porId observer:self callback:@selector(confirmMyPubFixNotification:)];
    }
}

-(void)confirmMyPubFixNotification:(BSNotification *)noti
{
    if(noti.error.code == 0)
    {
        HUDSMILE(@"确认成功", 1);
        //刷新界面
       _type = _pubFix.state = 3;
         [_stateCell setCellData:@{@"title":@"已完成",@"detail":_pubFix.createTime?:@""}];
        [self addBottomMenuView];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyServer" object:nil];
//        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)deleteOption
{
    [[CommonAPI managerWithVC:self] showAlert:@selector(deleteRequest:) withTitle:nil withMessage:@"确认删除该订单？" withObj:@{}];
   }

-(void)deleteRequest:(NSDictionary *)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        HUDSHOW(@"删除中");
        [busiSystem.getPubFixListManager deletePubFixList:_pubFix.porId observer:self callback:@selector(deleteMyPubFixNotification:)];

    }
}

-(void)deleteMyPubFixNotification:(BSNotification *)noti
{
    if(noti.error.code == 0)
    {
        HUDSMILE(@"删除成功", 1);
        //刷新界面
        [self.navigationController popViewControllerAnimated:YES];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyServer" object:nil];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)reworkRequest:(NSDictionary*)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        HUDSHOW(@"请求中");
        NSDictionary *dd = dic[@"userInfo"];
       NSString *str = dd[@"str"];
    [busiSystem.getPubFixListManager reworkPubFixList:_pubFix.porId  withReason:str withTimes:[NSString stringWithFormat:@"%ld",_pubFix.reworkCount + 1] observer:self callback:@selector(reworkPubFixListNotification:)];

    }}

-(void)reworkPubFixListNotification:(BSNotification*)noti
{
    if(noti.error.code == 0)
    {
        HUDDISMISS;
        [[CommonAPI managerWithVC:self] showConfirmView:nil withMsg:@"您已成功申请返工，请等待管理员与您确认返工开始和完工时间"];
//        HUDSMILE(@"删除成功", 1);
        //刷新界面
         self.type = 0;
//          [self.stateCell setCellData:@{@"title":@"已完成",@"detail":_pubFix.createTime?:@""}];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyServer" object:nil];
        [self addBottomMenuView];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}


-(void)showSatisfiedTip
{
  SheetOptionViewController *vc = [SheetOptionViewController createVC:self];
    __weak SheetOptionViewController *weakSelf = vc;
    [vc setCallBack:^(UIButton *btn) {
        switch (btn.tag - 100) {
            case 0:
            {
                [self sureRequest:@{@"code":@(0)}];
            }
                break;
            case 1:
            {
                 [weakSelf.parentDialog dismiss];
                [self showTextConfirmTip];
               
            }
                break;
            case 2:
            {
                
            }
                break;
            default:
                break;
        }
        
    }];
}

-(void)showTextConfirmTip
{
    [[TextConfirmViewController createVC: self] setCallBack:^(NSDictionary *dic) {
        NSString *str = dic[@"title"];
        [self showConfirmView:str];
        
    }];
}

-(void)showConfirmView:(NSString *)str
{
    [[CommonAPI managerWithVC:self] showAlertView:nil withMsg:@"很抱歉，此次服务没能让您满意，您可以点击【返工申请】发起免费的返工申请。" withBtnTitle:@"返工申请"  withSel:@selector(reworkRequest:) withUserInfo:@{@"str":str}];
}

-(void)applyAgain
{
    PublicApplicationViewController *vc = [PublicApplicationViewController new];
    vc.isAgain = YES;
    vc.dataDic = @{@"areaName":_pubFix.unit?:@"" ,@"areaId":@"", @"house" :_pubFix.house?:@"",@"floor":_pubFix.floor?:@"", @"ptyid":_pubFix.ptyId  ,@"ptyName":_pubFix.typestr, @"remark":_pubFix.remark?:@"",@"sap":_pubFix.sapId,@"sapName":_pubFix.sapname?:@"" };
    [self.navigationController pushViewController:vc animated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
