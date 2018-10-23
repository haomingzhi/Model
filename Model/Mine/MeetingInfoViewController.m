//
//  MeetingInfoViewController.m
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "MeetingInfoViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "BUSystem.h"
@interface MeetingInfoViewController ()
{

    TitleDetailTableViewCell *_feeCell;
    TitleDetailTableViewCell *_meetingNameCell;
    TitleDetailTableViewCell *_meetingPosCell;
    TitleDetailTableViewCell *_offLineHandlePosCell;
    TitleDetailTableViewCell *_areaCell;
    TitleDetailTableViewCell *_meetingTimeCell;
    TitleDetailTableViewCell *_orderTimeCell;
    TitleDetailTableViewCell *_countCell;
    TitleDetailTableViewCell *_wayCell;
    TitleDetailTableViewCell *_needDeskCell;
    TitleDetailTableViewCell *_needSignDeskCell;
    TitleDetailTableViewCell *_needTeaCell;
    OnlyTitleTableViewCell *_demoTipCell;
    TitleDetailTableViewCell *_demoCell;
    OnlyTitleTableViewCell *_stateTipCell;
    TitleDetailTableViewCell *_stateCell;
    OnlyBottomBtnTableViewCell *_submitCell;
    TitleDetailTableViewCell * _areaSaCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property(nonatomic,strong)BUGetMyMeetingInfo *meetingInfo;
  @property(nonatomic,strong)  OnlyTitleTableViewCell *tipCell;
@end

@implementation MeetingInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"会议室预定详情";
    [self initTableView];
    HUDSHOW(@"加载中");
    [self getData];
}

-(void)getData
{
    [busiSystem.getMyMeetingInfoManager getMyMeetingInfo:_userInfo observer:self callback:@selector(getDataNotification:)];
}

-(void)getDataNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
        if (busiSystem.getMyMeetingInfoManager.myMeetingInfos.count > 0) {
            _meetingInfo = busiSystem.getMyMeetingInfoManager.myMeetingInfos[0];
        }
        NSString *st;
        if (_meetingInfo.state == 0) {
            st = @"待受理";
        }
        else if (_meetingInfo.state == 1)
        {
            st = @"预定成功";
              [self addTipView];
        }
        else if (_meetingInfo.state == 2)
        {
            st = @"受理失败";
            [self addTipView];
        }
        else
        {
            st = @"已完成";
        }

        [_stateCell setCellData:@{@"title":st,@"detail":_meetingInfo.createTime?:@""}];
        [_stateCell fitServerInfoStateModeB];
        
        
       NSArray *sat = [_meetingInfo.price componentsSeparatedByString:@"-"];
        if (sat.count == 1) {
              [_feeCell setCellData:@{@"title":@"费用",@"detail":[NSString stringWithFormat:@"￥%@(外宾)/￥%@(对内)",sat[0],sat[0]]}];
        }
        else
        [_feeCell setCellData:@{@"title":@"费用",@"detail":[NSString stringWithFormat:@"￥%@(外宾)/￥%@(对内)",sat[0],sat[1]]}];
        [_feeCell fitServerInfoModeK];
        
      
        [_meetingNameCell setCellData:@{@"title":@"会议室名称",@"detail":_meetingInfo.name?:@""}];
        [_meetingNameCell fitServerInfoMode];
        
        
        [_meetingPosCell setCellData:@{@"title":@"会议室位置",@"detail":_meetingInfo.address?:@""}];
        [_meetingPosCell fitServerInfoMode];
        
        
      
        [_offLineHandlePosCell setCellData:@{@"title":@"线下办理处",@"detail":_meetingInfo.officeAddress?:@""}];
        [_offLineHandlePosCell fitServerInfoMode];
        
        
     
        [_areaCell setCellData:@{@"title":@"面积(㎡)",@"detail":[NSString stringWithFormat:@"%ld",_meetingInfo.outAcreage]}];
        [_areaCell fitServerInfoMode];
        

        [_meetingTimeCell setCellData:@{@"title":@"会议时间",@"detail":[_meetingInfo.meetingTime substringToIndex:MIN(10, _meetingInfo.meetingTime.length)]?:@""}];
        [_meetingTimeCell fitServerInfoMode];
        
      
        [_orderTimeCell setCellData:@{@"title":@"预定时长",@"detail":[NSString stringWithFormat:@"%@",_meetingInfo.meetingLong == 0?@"半天":@"全天"]}];
        [_orderTimeCell fitServerInfoMode];
        
        
    
        [_countCell setCellData:@{@"title":@"参会人数",@"detail":[NSString stringWithFormat:@"%ld",_meetingInfo.meetingNumber]}];
        [_countCell fitServerInfoMode];
        
        NSString *mt;
        if (_meetingInfo.type == 1) {
          mt = @"鸡尾酒会";
        }
        else if (_meetingInfo.type == 2)
        {
         mt = @"宴会式";
        }
        else if (_meetingInfo.type == 3)
        {
          mt = @"董事会";
        }
        else if (_meetingInfo.type == 4)
        {
            mt = @"U型";
        }
        else if (_meetingInfo.type == 5)
        {
            mt = @"课桌式";
        }
        else
        {
            mt = @"剧院式";
        }
    
        [_wayCell setCellData:@{@"title":@"摆台形式",@"detail":mt}];
        [_wayCell fitServerInfoMode];
        
        NSString *isp = @"否";
        if (_meetingInfo.hasPlatform == 1) {
            isp = @"是";
        }
        [_needDeskCell setCellData:@{@"title":@"是否需要讲台",@"detail":isp}];
        [_needDeskCell fitServerInfoMode];
    
        NSString *iss = @"否";
        if (_meetingInfo.hasSign  == 1)
        {
            iss = @"是";
        }
        [_needSignDeskCell setCellData:@{@"title":@"是否需要签到台",@"detail":iss}];
        [_needSignDeskCell fitServerInfoMode];
        
     NSString *ist = @"否";
        if (_meetingInfo.hasTea == 1) {
            ist = @"是";
        }
        [_needTeaCell setCellData:@{@"title":@"是否需要茶歇",@"detail":ist}];
        [_needTeaCell fitServerInfoMode];
        
        [_demoCell setCellData:@{@"title":_meetingInfo.remarks?:@""}];
        
        [_areaSaCell setCellData:@{@"title":@"归属园区",@"detail":_meetingInfo.sapId?:@""}];
        [_areaSaCell fitServerInfoModeG];
        if (_meetingInfo.state == 1) {
            if (_meetingInfo.isHandle == 0) {
                _type = 0;
            }
            else
            {
                _type = 1;
            }
        }
        else
        {
        _type = _meetingInfo.state;
        }
        [self addBottomMenuView];
   }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)addBottomMenuView
{
    
    __weak MeetingInfoViewController *weakSelf = self;
    _submitCell.width = __SCREEN_SIZE.width;
    _submitCell.y = __SCREEN_SIZE.height - 64 - 49;
    if (_type == 0) {
        [_submitCell removeFromSuperview];
        [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    else if (_type == 1)
    {
        [_submitCell setCellData:@{@"title":@"确认完成"}];
        [self.view addSubview:_submitCell];
        [_submitCell setHandleAction:^(id o) {
            [weakSelf confirm];
        }];
        [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 50, 0)];
    }
    else
    {
        [_submitCell setCellData:@{@"title":@"删除"}];
        [self.view addSubview:_submitCell];
        [_submitCell setHandleAction:^(id o) {
            [weakSelf deleteOption];
        }];
        [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 50, 0)];
    }
    
    
}

-(void)addTipView
{
    if (!self.tipCell) {
        self.tipCell = [OnlyTitleTableViewCell createTableViewCell];
    }
    if (_meetingInfo.state == 1) {
          if (_meetingInfo.isHandle == 0) {
        [self.tipCell setCellData:@{@"title":[NSString stringWithFormat:@"恭喜您预约成功！请您于%@前（含当日）前往【线下办理处】办理预定手续，超时未办订单将自动取消",_meetingInfo.handlerTime?:@""]}];
        [self.tipCell fitCerFailTipModeB];
          }
        else
        {
            self.tipCell = nil;
        }
    }
    else
    {
      [self.tipCell setCellData:@{@"title":_meetingInfo.failCause?:@""}];
         [self.tipCell fitCerFailTipMode];
    }
   
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

-(void)initTableView
{
    _tableView.refreshHeaderView = nil;
    _tableView.refreshFooterView = nil;
    _stateCell = [TitleDetailTableViewCell createTableViewCell];
    [_stateCell setCellData:@{@"title":@"受理中",@"detail":@""}];
    [_stateCell fitServerInfoStateMode];
    
  
    
    _feeCell = [TitleDetailTableViewCell createTableViewCell];
    [_feeCell setCellData:@{@"title":@"费用",@"detail":@""}];
    [_feeCell fitServerInfoModeK];
    
    _meetingNameCell = [TitleDetailTableViewCell createTableViewCell];
    [_meetingNameCell setCellData:@{@"title":@"会议室名称",@"detail":@""}];
    [_meetingNameCell fitServerInfoMode];
    
    _meetingPosCell = [TitleDetailTableViewCell createTableViewCell];
    [_meetingPosCell setCellData:@{@"title":@"会议室位置",@"detail":@""}];
    [_meetingPosCell fitServerInfoMode];
    
    
    _offLineHandlePosCell = [TitleDetailTableViewCell createTableViewCell];
    [_offLineHandlePosCell setCellData:@{@"title":@"线下办理处",@"detail":@""}];
    [_offLineHandlePosCell fitServerInfoMode];
    
    
    _areaCell = [TitleDetailTableViewCell createTableViewCell];
    [_areaCell setCellData:@{@"title":@"面积(㎡)",@"detail":@""}];
    [_areaCell fitServerInfoMode];
    
    _meetingTimeCell = [TitleDetailTableViewCell createTableViewCell];
    [_meetingTimeCell setCellData:@{@"title":@"会议时间",@"detail":@""}];
    [_meetingTimeCell fitServerInfoMode];
    
    _orderTimeCell = [TitleDetailTableViewCell createTableViewCell];
    [_orderTimeCell setCellData:@{@"title":@"预定时长",@"detail":@""}];
    [_orderTimeCell fitServerInfoMode];
    
    
    _countCell = [TitleDetailTableViewCell createTableViewCell];
    [_countCell setCellData:@{@"title":@"参会人数",@"detail":@""}];
    [_countCell fitServerInfoMode];
    
    
    _wayCell = [TitleDetailTableViewCell createTableViewCell];
    [_wayCell setCellData:@{@"title":@"摆台形式",@"detail":@""}];
    [_wayCell fitServerInfoMode];
    
    _needDeskCell = [TitleDetailTableViewCell createTableViewCell];
    [_needDeskCell setCellData:@{@"title":@"是否需要讲台",@"detail":@""}];
    [_needDeskCell fitServerInfoMode];
    _needSignDeskCell = [TitleDetailTableViewCell createTableViewCell];
    [_needSignDeskCell setCellData:@{@"title":@"是否需要签到台",@"detail":@""}];
    [_needSignDeskCell fitServerInfoMode];
    
    _needTeaCell = [TitleDetailTableViewCell createTableViewCell];
    [_needTeaCell setCellData:@{@"title":@"是否需要茶歇",@"detail":@""}];
    [_needTeaCell fitServerInfoMode];
    
    _demoTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_demoTipCell setCellData:@{@"title":@"备注"}];
    [_demoTipCell fitServerInfoStateMode];
    
    _demoCell = [OnlyTitleTableViewCell createTableViewCell];
    
   _stateTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_stateTipCell setCellData:@{@"title":@"当前状态"}];
    [_stateTipCell fitServerInfoStateMode];
    
    _areaSaCell = [TitleDetailTableViewCell  createTableViewCell];
    [_areaSaCell setCellData:@{@"title":@"归属园区",@"detail":@""}];
    [_areaSaCell fitServerInfoModeG];
    
    _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
    [_submitCell fitWaterInfoMode];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) {
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 2;
    if (_mode == 0 && section == 0) {
        row = 12;
    }
    else if (_mode == 1 && section == 0)
    {
        row = 11;
    }
    if (section == 3) {
        row = 1;
    }
    
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
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
        height = 44;
        if(indexPath.row == 8)
        {
            _wayCell.hidden = YES;
            height = 0;
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            height = 34;
        }
        else
        {
            height = _demoCell.height;
        }
        
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            height = 34;
        }
        else
        {
            height = 26;
        }
        
    }
    else if (indexPath.section == 3)
    {
        height = 44;
    }
    
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if (indexPath.section == 0) {
        NSInteger dx = -(_mode);
        if (indexPath.row == dx) {
            cell = _feeCell;
        }
        else if(indexPath.row == 1 + dx)
        {
            cell = _meetingNameCell;
        }
        else if(indexPath.row == 2 + dx)
        {
            cell = _meetingPosCell;
        }
        else if(indexPath.row == 3 + dx)
        {
            cell = _offLineHandlePosCell;
        }
        else if(indexPath.row == 4 + dx)
        {
            cell = _areaCell;
        }
        else if(indexPath.row == 5 + dx)
        {
            cell = _meetingTimeCell;
        }
        else if(indexPath.row == 6 + dx)
        {
            cell = _orderTimeCell;
        }
        else if(indexPath.row == 7 + dx)
        {
            cell = _countCell;
        }
        else if(indexPath.row == 8 + dx)
        {
            cell = _wayCell;
        }
        else if(indexPath.row == 9 + dx)
        {
            cell = _needDeskCell;
        }
        else if(indexPath.row == 10 + dx)
        {
            cell = _needSignDeskCell;
        }
        else
        {
            cell = _needTeaCell;
        }
        [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
    }
    else if (indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            cell = _demoTipCell;
        }
        else
        {
            cell = _demoCell;
            [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(_demoCell.height, 0, 0, 0)];
        }
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0) {
            cell = _stateTipCell;
        }
        else
        {
            cell = _stateCell;
                           [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(26, 0, 0, 0)];
        }
    }
    else
    {
        cell = _areaSaCell;
        [_areaSaCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)confirm
{
    [[CommonAPI managerWithVC:self] showAlert:@selector(sureRequest:) withTitle:nil withMessage:@"确认该服务已完成？" withObj:@{}];
}

-(void)sureRequest:(NSDictionary *)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        HUDSHOW(@"确认中");
        [busiSystem.getMyMeetingInfoManager sureMyMeetingInfo:_meetingInfo.mooId observer:self callback:@selector(confirmMyMeetingNotification:)];
    }

}

-(void)confirmMyMeetingNotification:(BSNotification *)noti
{
    if(noti.error.code == 0)
    {
        HUDSMILE(@"确认成功", 1);
        //刷新界面
         _type = _meetingInfo.state = 3;
           [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyServer" object:nil];
        [self addBottomMenuView];
          [_stateCell setCellData:@{@"title":@"已完成",@"detail":_meetingInfo.createTime?:@""}];
          [_stateCell fitServerInfoStateModeB];
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
        [busiSystem.getMyMeetingInfoManager deleteMyMeetingInfo:_meetingInfo.mooId observer:self callback:@selector(deleteMyMeetiongNotification:)];
    }

}

-(void)deleteMyMeetiongNotification:(BSNotification *)noti
{
    if(noti.error.code == 0)
    {
        HUDSMILE(@"删除成功", 1);
        //刷新界面
         [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyServer" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)reserveAction:(UIButton *)sender {
}
@end
