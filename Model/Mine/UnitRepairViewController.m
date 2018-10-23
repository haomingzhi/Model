//
//  UnitRepairViewController.m
//  taihe
//
//  Created by air on 2016/11/10.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "UnitRepairViewController.h"
#import "BUSystem.h"
#import "UnitApplicationViewController.h"
@interface UnitRepairViewController ()
@property(nonatomic,strong)TitleDetailTableViewCell *feeCell;
@property(nonatomic,strong)BUGetUniFix *uniFix;
@property(nonatomic)BOOL isNeedTipConfirm;
@end

@implementation UnitRepairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"单元报修详情";
    [self fitMode];
}

-(void)handleReturnBack:(id)sender
{
    if (_isNeedTipConfirm) {
      [[CommonAPI managerWithVC:self] showAlertView:@"您已修改费用，确认放弃本次支付吗？" withMsg:nil withBtnTitle:@"继续支付" withCancelBtnTitle:@"放弃支付"  withSel:@selector(toResultHandle:) withUserInfo:@{}];
    }
    else
    {
        [super handleReturnBack:sender];
    }
}

-(void)toResultHandle:(NSDictionary *)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        
    }
    else
    {
    [super handleReturnBack:nil];
    }
}

-(void)fitMode
{
    _feeCell = [TitleDetailTableViewCell createTableViewCell];
    [_feeCell setCellData:@{@"title":@"费用",@"detail":@""}];
    [_feeCell fitServerInfoMode];
}

-(void)getData
{
    [busiSystem.getUniFixListManager getUniFixList:self.userInfo observer:self callback:@selector(getDataNotification:)];
}

-(void)getDataNotification:(BSNotification *)noti
{
    __weak UnitRepairViewController *weakSelf = self;
    if (noti.error.code == 0) {
        HUDDISMISS;
        if (busiSystem.getUniFixListManager.uniFixList.count > 0) {
            _uniFix = busiSystem.getUniFixListManager.uniFixList[0];
        }
        [self.infoCell setCellData:@{@"title":[NSString stringWithFormat:@"楼栋  %@",_uniFix.house],@"detail":[NSString stringWithFormat:@"楼层  %@",_uniFix.floor],@"detail2":[NSString stringWithFormat:@"单元  %@",_uniFix.unit]}];
        
        //        [_infoCell setCellData:@{@"title":@"区域  走廊",@"detail":@"楼栋  24栋",@"detail2":@"楼层  6层"}];
        [self.infoCell fitThreeTitleModeB];
        
        
        [self.repairTypeCell setCellData:@{@"title":@"维修类型",@"detail":_uniFix.typestr?:@""}];
        [self.repairTypeCell fitServerInfoMode];
        
        
        [self.secondRepairStartTimeCell setCellData:@{@"title":@"第二次返工开始时间",@"detail":[_uniFix.reworkSecondStartTime substringToIndex:MIN(10,_uniFix.reworkSecondStartTime.length)]?:@""}];
        [self.secondRepairStartTimeCell fitServerInfoMode];
        
        
        [self.secondRepairEndTimeCell setCellData:@{@"title":@"第二次返工结束时间",@"detail":[_uniFix.reworkSecondEndTime substringToIndex:MIN(10,_uniFix.reworkSecondEndTime.length)]?:@""}];
        [self.secondRepairEndTimeCell fitServerInfoMode];
        
        
        [self.backStartTimeCell setCellData:@{@"title":@"返工开始时间",@"detail":[_uniFix.reworkOneStartTime substringToIndex:MIN(10, _uniFix.reworkOneStartTime.length)]?:@""}];
        [self.backStartTimeCell fitServerInfoMode];
        
        
        [self.backEndTimeCell setCellData:@{@"title":@"返工结束时间",@"detail":[_uniFix.reworkOneEndTime substringToIndex:MIN(10, _uniFix.reworkOneEndTime.length)]?:@""}];
        [self.backEndTimeCell fitServerInfoMode];
        
        
        [self.repairTimeCell setCellData:@{@"title":@"维修时间",@"detail":[_uniFix.workStartTime substringToIndex:MIN(10, _uniFix.workStartTime.length)]?:@""}];
        [self.repairTimeCell fitServerInfoMode];
        
        
        [self.finishTimeCell setCellData:@{@"title":@"完工时间",@"detail":[_uniFix.workEndTime substringToIndex:MIN(10, _uniFix.workEndTime.length)]?:@""}];
        [self.finishTimeCell fitServerInfoMode];
        
        
        self.imgsCell.mode = AddImgModeMutable;
        [self.imgsCell setCellData:@{@"default":@"defaultServer",@"limitCount":@(_uniFix.imagePath.count),@"arr":[_uniFix getImgArr]?:@[],@"colCount":@3,@"hiddenDelBtn":@YES}];
        [self.imgsCell fitRepairServerMode];

        
      [self.contentCell setCellData:@{@"title":_uniFix.remark?:@""}];
           [self.contentCell fitRepairModeB];
        
        [_feeCell setCellData:@{@"title":@"费用",@"detail":[NSString stringWithFormat:@"￥%ld",_uniFix.pirce]}];
        [_feeCell fitServerInfoMode];
        
        [self.areaCell setCellData:@{@"title":@"归属园区",@"detail":_uniFix.sapname?:@""}];
        [self.areaCell fitServerInfoModeB];
        NSString *st;
        if (_uniFix.state == 0) {
            st = @"待受理";
            self.mode = 0;
        }
        else if (_uniFix.state == 1)
        {
            st = @"受理中";
            if (_uniFix.reworkCount == 0) {
                self.mode = 1;
                if(_uniFix.isSure == 0)
                {
                 [_feeCell fitServerInfoModeD];
                    [_feeCell setHandleAction:^(id o) {
                        [weakSelf showPriceOptionView];
                    }];
                    
                }
                else
                {
                  if(_uniFix.isMoney == 1)
                  {
                      [_feeCell fitServerInfoModeF:@"已支付"];
                  }
                 else
                 {
                  [_feeCell fitServerInfoModeE];
                     [_feeCell setHandleAction:^(id o) {
                         [weakSelf payRightNowOption];
                     }];
                 }
              }
            }
            else if (_uniFix.reworkCount == 1) {
                if (_uniFix.reworkOneEnd == 0) {
                    self.mode = 3;
                }
                else
                self.mode = 6;
                if(_uniFix.isMoney == 1)
                {
                    [_feeCell fitServerInfoModeF:@"已支付"];
                }
            }
            else
            {
                if (_uniFix.reworkSecondEnd == 0) {
                    self.mode = 6;
                }
                else
                self.mode = 7;
                if(_uniFix.isMoney == 1)
                {
                    [_feeCell fitServerInfoModeF:@"已支付"];
                }
            }
        }
        else if (_uniFix.state == 2)
        {
            st = @"受理失败";
             [self addTipView];
            [_feeCell fitServerInfoModeF:@"未支付"];
            self.mode = 5;
        }
        else
        {
            st = @"已完成";
             [_feeCell fitServerInfoModeF:@"已支付"];
            if (_uniFix.reworkCount == 0) {
                self.mode = 3;
            }
            else if (_uniFix.reworkCount == 1) {
                if (_uniFix.reworkOneEnd == 0) {
                    self.mode = 3;
                }
                else
                self.mode = 6;
            }
            else
            {
                if (_uniFix.reworkSecondEnd == 0) {
                    self.mode = 6;
                }
                else
                self.mode = 7;
            }
        }
        
        [self.stateCell setCellData:@{@"title":st,@"detail":_uniFix.createTime?:@""}];
        [self.stateCell fitServerInfoStateModeB];
         [self.tableView reloadData];
        self.type = _uniFix.state;
        [self addBottomMenuView];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)addBottomMenuView
{
    
    __weak UnitRepairViewController *weakSelf = self;
    self.submitCell.width = __SCREEN_SIZE.width;
    self.submitCell.y = __SCREEN_SIZE.height - 64 - 49;
    if (self.type == 0) {
        [self.submitCell removeFromSuperview];
        [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    else if (self.type == 1)
    {
        if(_uniFix.reworkCount == 2)
        {
            NSString *st = @"";
            //            NSDate *dt =   [BSUtility StrToDate:_pubFix.reworkSecondEndTime DateStr:@"yyyy-MM-dd HH:mm:ss"];
            if (_uniFix.reworkSecondEnd == 0 )
            {
                st = @"";
            }
            else
            {
                if(_uniFix.isMoney == 1)
                {
                   st = @"确认完成";
                }
                else
                {
                    st = @"";
                }
            }
            if ([st isEqualToString:@""]) {
                [self.submitCell removeFromSuperview];
                [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            }
            else
            {
                [self.submitCell setCellData:@{@"title":@"确认完成"}];
                [self.view addSubview:self.submitCell];
                [self.submitCell setHandleAction:^(id o) {
                    [weakSelf confirm];
                }];
                [self.submitCell fitRepairModeB];
                [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 50, 0)];
            }
        }
        else
        {
            NSString *st = @"";
            if( _uniFix.reworkCount == 0)
            {
                if (_uniFix.isEnd == 0) {
                    st = @"";
                }
                else
                {
                    if(_uniFix.isMoney == 1)
                    {
                    st = @"是否满意";
                    }
                    else
                    {
                     st = @"";
                    }
                }
            }
            else if( _uniFix.reworkCount == 1)
            {
                //                NSDate *dt =   [BSUtility StrToDate:_pubFix.reworkOneEndTime DateStr:@"yyyy-MM-dd HH:mm:ss"];
                if (_uniFix.reworkOneEnd == 0 )
                {
                    st = @"";
                }
                else
                {
                    if(_uniFix.isMoney == 1)
                    {
                        st = @"是否满意";
                    }
                    else
                    {
                        st = @"";
                    }
                }
            }
            
            if ([st isEqualToString:@""]) {
                [self.submitCell removeFromSuperview];
                [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            }
            else
            {
                [self.submitCell setCellData:@{@"title":@"是否满意"}];
                [self.view addSubview:self.submitCell];
                [self.submitCell setHandleAction:^(id o) {
                    [weakSelf showSatisfiedTip];
                }];
                [self.submitCell fitRepairModeB];
                [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 50, 0)];
            }
        }
        
    }
    else
    {
        if(self.type == 2 )
        {
            [self.submitCell setCellData:@{@"title":@"删除"}];
            [self.view addSubview:self.submitCell];
            [self.submitCell setHandleAction:^(id o) {
                [weakSelf deleteOption];
            }];
            [self.submitCell fitRepairModeB];
        }
        else
        {
            [self.submitCell setCellData:@{@"title":@"删除"}];
            [self.submitCell fitRepairMode];
            [self.submitCell setExtrHandleAction:^(NSDictionary *dic) {
                [weakSelf applyAgain];
            }];
            
            [self.view addSubview:self.submitCell];
            [self.submitCell setHandleAction:^(id o) {
                [weakSelf deleteOption];
            }];
        }
        [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 50, 0)];
    }
}

-(void)applyAgain
{
    UnitApplicationViewController *vc = [UnitApplicationViewController new];
    vc.isAgain = YES;
    vc.dataDic = @{@"areaName":_uniFix.unit?:@"" ,@"areaId":@"", @"house" :_uniFix.house?:@"",@"floor":_uniFix.floor?:@"", @"ptyid":_uniFix.ptyId  ,@"ptyName":_uniFix.typestr, @"remark":_uniFix.remark?:@"" ,@"price":[NSString stringWithFormat:@"%ld",_uniFix.pirce],@"sap":_uniFix.sapId,@"sapName":_uniFix.sapname};
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)confirmPriceView
{
    [[CommonAPI managerWithVC:self] showAlert:@selector(confirmPrice:) withTitle:nil withMessage:@"请您确认维修人员已上门，当前价格为您与维修人员共同确认。" withObj:@{}];
}

-(void)confirmPrice:(NSDictionary *)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        [self fixPriceRequest:[NSString stringWithFormat:@"%ld",_uniFix.pirce]];
    }
}

-(void)fixPriceRequest:(NSString *)price
{
    HUDSHOW(@"确认中");
    [busiSystem.getUniFixListManager sureUniFixPrice:_uniFix.uorId withPrice:price observer:self callback:@selector(sureUniFixPriceNotification:)];
}

-(void)sureUniFixPriceNotification:(BSNotification *)noti
{
    __weak UnitRepairViewController *weakSelf = self;
    if (noti.error.code == 0) {
        HUDDISMISS;
          [_feeCell setCellData:@{@"title":@"费用",@"detail":[NSString stringWithFormat:@"￥%ld",_uniFix.pirce]}];
        [_feeCell fitServerInfoModeE];
        [_feeCell setHandleAction:^(id o) {
            [weakSelf payRightNowOption];
        }];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)getFirstSectionRows:(NSInteger)mode
{
    NSInteger row = 5;
    switch (mode) {
        case 0:
        {
            row = 5;
        }
            break;
        case 1:
        {
            row = 5;
        }
            break;
        case 2:
        {
            row = 5;
        }
            break;
        case 3:
        {
            row = 5;
        }
            break;
        case 4:
        {
            row = 5;
        }
            break;
        case 5:
        {
            row = 5;
        }
            break;
        case 6:
        {
            row = 7;
        }
            break;
        case 7:
        {
            row = 9;
        }break;
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
            case 0:case 1:case 2:case 3:case 4:
            {
                cell = [self getBaseFirstSectionCell:indexPath withMode:0];
            }
                break;
            default:
                break;
        }
    }
    else if (mode == 1)
    {
        switch (indexPath.row) {
             case 0:case 1:case 2:case 3:case 4:
            {
                cell = [self getBaseFirstSectionCell:indexPath withMode:1];
            }
                break;
                
            default:
                break;
        }
    }
    else if (mode == 2)
    {
        switch (indexPath.row) {
              case 0:case 1:case 2:case 3:case 4:
            {
                cell = [self getBaseFirstSectionCell:indexPath withMode:2];
            }
                break;
                
            default:
                break;
        }
    }
    else if (mode == 3)
    {
        switch (indexPath.row) {
             case 0:case 1:case 2:case 3:case 4:
            {
                cell = [self getBaseFirstSectionCell:indexPath withMode:3];
            }
                break;
            default:
                break;
        }
    }
    else if (mode == 4)
    {
        switch (indexPath.row) {
            case 0:case 1:case 2:case 3:case 4:
            {
                cell = [self getBaseFirstSectionCell:indexPath withMode:3];
            }
                break;
            default:
                break;
        }
    }
    else if (mode == 5)
    {
        switch (indexPath.row) {
            case 0:case 1:case 2:case 3:case 4:
            {
                cell = [self getBaseFirstSectionCell:indexPath withMode:3];
            }
                break;
            default:
                break;
        }
    }
    else if (mode == 6)
    {
        switch (indexPath.row) {
             case 0:case 1: case 2:
            {
                cell = [self getFirstSectionCell:indexPath withMode:3];
            }
                break;
            case 3:
            {
                cell = self.backStartTimeCell;
            }
                break;
            case 4:
            {
                cell = self.backEndTimeCell;
            }
                break;
            case 5:
            {
                cell = self.repairTimeCell;
            }
                break;
            case 6:
            {
                cell = self.finishTimeCell;
            }
                break;
            default:
                break;
        }
    }
    else
    {
        switch (indexPath.row) {
            case 0: case 1:case 2:
            {
                cell = [self getFirstSectionCell:indexPath withMode:3];
            }
                break;
                
            case 3:
            {
                cell = self.secondRepairStartTimeCell;
            }
                break;
            case 4:
            {
                cell = self.secondRepairEndTimeCell;
            }
                break;
            case 5:
            {
                cell = self.backStartTimeCell;
            }
                break;
            case 6:
            {
                cell = self.backEndTimeCell;
            }
                break;
            case 7:
            {
                cell = self.repairTimeCell;
            }
                break;
            case 8:
            {
                cell = self.finishTimeCell;
            }
                break;
            default:
                break;
        }
    }
    return cell;
}

-(UITableViewCell *)getBaseFirstSectionCell:(NSIndexPath *)indexPath withMode:(NSInteger)mode
{
    switch (indexPath.row) {
        case 0:case 1:case 2:
        {
          return   [self getFirstSectionCell:indexPath withMode:mode];
        }
            break;
            
        
        case 3:
        {
            return self.repairTimeCell;
        }
            break;
        case 4:
        {
            return self.finishTimeCell;
        }
            break;
        default:
            break;
    }
    return nil;
}

-(UITableViewCell *)getFirstSectionCell:(NSIndexPath *)indexPath withMode:(NSInteger)mode
{
    if (indexPath.row == 0) {
        return self.infoCell;
    }
    else if(indexPath.row == 1)
    {
        return self.repairTypeCell;
    }
    return self.feeCell;
}


-(void)confirm
{
     [[CommonAPI managerWithVC:self] showAlert:@selector(sureRequest:) withTitle:nil withMessage:@"确认该服务已完成？" withObj:@{}];
   }

-(void)sureRequest:(NSDictionary *)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        HUDSHOW(@"确认中");
        [busiSystem.getUniFixListManager sureUniFixList:_uniFix.uorId observer:self callback:@selector(confirmMyUniFixNotification:)];

    }
}

-(void)confirmMyUniFixNotification:(BSNotification *)noti
{
    if(noti.error.code == 0)
    {
        HUDSMILE(@"确认成功", 1);
        //刷新界面
        self.type = _uniFix.state = 3;
         [self.stateCell setCellData:@{@"title":@"已完成",@"detail":_uniFix.createTime?:@""}];
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
        [busiSystem.getUniFixListManager deleteUniFixList:_uniFix.uorId observer:self callback:@selector(deleteMyUniFixNotification:)];

    }

}

-(void)deleteMyUniFixNotification:(BSNotification *)noti
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
        [busiSystem.getUniFixListManager rewokeUniFixList:_uniFix.uorId withReason:str withTimes:[NSString stringWithFormat:@"%ld",_uniFix.reworkCount + 1]  observer:self callback:@selector(reworkUniFixListNotification:)];
    }
    
}

-(void)reworkUniFixListNotification:(BSNotification*)noti
{
    if(noti.error.code == 0)
    {
        HUDDISMISS;
        [[CommonAPI managerWithVC:self] showConfirmView:nil withMsg:@"您已成功申请返工，请等待管理员与您确认返工开始和完工时间"];
        //        HUDSMILE(@"删除成功", 1);
        //刷新界面
        self.type = 0;
       [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyServer" object:nil];
        [self addBottomMenuView];
//        [self.stateCell setCellData:@{@"title":@"已完成",@"detail":_uniFix.createTime?:@""}];
//        [self.stateCell fitServerInfoStateModeB];
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

-(void)addTipView
{
    if (!self.tipCell) {
        self.tipCell = [OnlyTitleTableViewCell createTableViewCell];
    }
    [self.tipCell setCellData:@{@"title":_uniFix.failCause?:@""}];
    [self.tipCell fitCerFailTipMode];
    self.tipCell.backgroundColor = kUIColorFromRGB(color_4);
    UIView *line = [self.tipCell viewWithTag:3221];
    if (!line) {
        line = [UIView new];
        line.tag = 3221;
    }
    
    line.y = 109.5;
    line.height = 0.5;
    line.backgroundColor = kUIColorFromRGB(color_lineColor);
    line.width = __SCREEN_SIZE.width;
    [self.tipCell addSubview:line];
    self.tableView.tableHeaderView = self.tipCell;
}

-(void)showPriceOptionView
{
    [[CommonAPI managerWithVC:self] showSheetOption:@[@"修改价格",@"确认价格"] withSel:@selector(toFitPriceOptionView:) withTitle:nil];
}

-(void)toFitPriceOptionView:(NSDictionary *)dic
{
    if ([dic[@"tag"] integerValue] == 100) {
        TextConfirmViewController *vcc = [TextConfirmViewController createVC:self];
        [vcc fitMode];
        [vcc setCallBack:^(NSDictionary *dic) {
            NSString *price = dic[@"title"];
            _uniFix.pirce = [price integerValue];
            _isNeedTipConfirm = YES;
              [_feeCell setCellData:@{@"title":@"费用",@"detail":[NSString stringWithFormat:@"￥%ld",_uniFix.pirce]}];
//            [self fixPriceRequest:price];
        }];
    }else
        if ([dic[@"tag"] integerValue] == 101) {
            _isNeedTipConfirm = NO;
           [self  confirmPriceView];
        }
}

-(void)payRightNowOption
{
    
    [[CommonAPI managerWithVC:self] showPayOptionView:@selector(payOption:) withUserId:nil withObj:@{}];
}

-(void)payOption:(NSDictionary *)dic
{
    if([dic[@"payWay"] isEqualToString:@"1"])
      {
      [self pay];
      }
    else
    {
     [self pay];
    }
}

-(void)pay
{
    [busiSystem.payManager payUniFix:self.userInfo observer:self callback:@selector(payNotification:)];
}

-(void)payNotification:(BSNotification*)noti
{
//刷新界面显示是否满意
    
    _uniFix.isMoney = 1;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyServer" object:nil];
    [self addBottomMenuView];
     [_feeCell fitServerInfoModeF:@"已支付"];
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
