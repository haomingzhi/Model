//
//  WaterInfoViewController.m
//  taihe
//
//  Created by air on 2016/11/10.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "WaterInfoViewController.h"
#import "BUSystem.h"
@interface WaterInfoViewController ()

@property (strong, nonatomic) BUGetMyWaterInfo *water;
@end

@implementation WaterInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"饮用水申请详情";
    [self initData];
    [self initTableView];
    [self addBottomMenuView];
}

-(void)viewWillAppear:(BOOL)animated
{
    _userInfo = nil;
}

-(void)initData
{
    if ([self.userInfo isKindOfClass:[BUGetMyWaterInfo class]]) {
        _water = _userInfo;
        //        [_tableView reloadData];
    }
    else
    {
        HUDSHOW(@"加载中");
        [self getData];
    }
}

-(void)getData
{
    [busiSystem.getMyWaterInfoManager getMyWaterInfo:_userInfo observer:self callback:@selector(getDataNotification:)];
}

-(void)getDataNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
        if (busiSystem.getMyWaterInfoManager.waterInfos.count > 0) {
            _water = busiSystem.getMyWaterInfoManager.waterInfos[0];
            [_infoCell setCellData:@{@"title":[NSString stringWithFormat:@"楼栋  %@",_water.house],@"detail":[NSString stringWithFormat:@"楼层  %@",_water.floor],@"detail2":[NSString stringWithFormat:@"单元  %@",_water.unit]}];
            [_infoCell fitThreeTitleMode];
            
            NSString *st;
            if (_water.state == 0) {
                st = @"待受理";
            }
            else if (_water.state == 1)
            {
                st = @"受理中";
            }
            else if (_water.state == 2)
            {
                st = @"已完成";
            }
            else
            {
                st = @"受理失败";
                [self addTipView];
            }
            [_stateCell setCellData:@{@"title":st?:@"",@"detail":_water.createTime?:@""}];
            [_stateCell fitServerInfoStateModeB];
            
            [_typeCell setCellData:@{@"title":@"类型",@"detail":_water.name?:@""}];
            [_typeCell fitServerInfoMode];
            
            
            [_priceCell setCellData:@{@"title":@"单价",@"detail":[NSString stringWithFormat:@"￥%.2f",_water.pirce]}];
            [_priceCell fitServerInfoModeC];
            
            [_stateTipCell setCellData:@{@"title":@"当前状态",@"detail":@""}];
            [_stateTipCell fitServerInfoStateMode];
            
            [_countCell setCellData:@{@"title":@"数量",@"detail":[NSString stringWithFormat:@"%ld",_water.count]}];
            [_countCell fitServerInfoMode];
            
            [_sendTimeCell setCellData:@{@"title":@"送货时间",@"detail":_water.deliverydate?:@""}];
            [_sendTimeCell fitServerInfoModeH];
            
         
            [_areaCell setCellData:@{@"title":@"归属园区",@"detail":_water.areaParkName?:@""}];
            [_areaCell fitServerInfoModeG];
            
            [_tableView reloadData];
            _mode = _water.state;
              [self addBottomMenuView];
        }
        
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)addBottomMenuView
{
    
    __weak WaterInfoViewController *weakSelf = self;
    _submitCell.width = __SCREEN_SIZE.width;
    _submitCell.y = __SCREEN_SIZE.height - 64 - 49;
    if (_mode == 0) {
        [_submitCell removeFromSuperview];
    }
    else if (_mode == 1)
    {
        [_submitCell setCellData:@{@"title":@"确认完成"}];
        [self.view addSubview:_submitCell];
        
        [_submitCell setHandleAction:^(id o) {
            [weakSelf confirm];
        }];
    }
    else
    {
        [_submitCell setCellData:@{@"title":@"删除"}];
        [self.view addSubview:_submitCell];
        [_submitCell setHandleAction:^(id o) {
            [weakSelf deleteOption];
        }];
    }
}

-(void)confirm
{
    [[CommonAPI managerWithVC:self] showAlert:@selector(sureRequest:) withTitle:nil withMessage:@"确认该服务已完成？" withObj:@{}];
}

-(void)sureRequest:(NSDictionary *)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        HUDSHOW(@"确认中");
        [busiSystem.getMyWaterInfoManager confirmMyWater:_water.wwoId observer:self callback:@selector(confirmMyWaterNotification:)];
    }
    
}


-(void)confirmMyWaterNotification:(BSNotification *)noti
{
    if(noti.error.code == 0)
    {
        HUDSMILE(@"确认成功", 1);
        //刷新界面
        _mode = _water.state = 2;
          [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyServer" object:nil];
        [self addBottomMenuView];
        [_stateCell setCellData:@{@"title":@"已完成",@"detail":_water.createTime?:@""}];
        [_stateCell fitServerInfoStateMode];
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
        [busiSystem.getMyWaterInfoManager deleteMyWater:_water.wwoId observer:self callback:@selector(deleteMyWaterNotification:)];
    }    
    
}


-(void)deleteMyWaterNotification:(BSNotification *)noti
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

-(void)addTipView
{
    if (!self.tipCell) {
        self.tipCell = [OnlyTitleTableViewCell createTableViewCell];
    }
    [self.tipCell setCellData:@{@"title":_water.failCause?:@""}];
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

-(void)initTableView
{
    _tableView.refreshHeaderView = nil;
    _infoCell = [TitleDetailTableViewCell createTableViewCell];
    [_infoCell setCellData:@{@"title":[NSString stringWithFormat:@"楼栋  %@",_water.house],@"detail":[NSString stringWithFormat:@"楼层  %@",_water.floor],@"detail2":[NSString stringWithFormat:@"单元  %@",_water.unit]}];
    [_infoCell fitThreeTitleMode];
    
    _stateCell = [TitleDetailTableViewCell createTableViewCell];
    NSString *st;
    if (_water.state == 0) {
        st = @"待受理";
    }
    else if (_water.state == 1)
    {
        st = @"受理中";
    }
    else if (_water.state == 2)
    {
        st = @"已完成";
    }
    else
    {
        st = @"受理失败";
        [self addTipView];
    }
    [_stateCell setCellData:@{@"title":st?:@"",@"detail":_water.createTime?:@""}];
    [_stateCell fitServerInfoStateMode];
    
    _typeCell = [TitleDetailTableViewCell createTableViewCell];
    [_typeCell setCellData:@{@"title":@"类型",@"detail":_water.name?:@""}];
    [_typeCell fitServerInfoMode];
    
    _priceCell = [TitleDetailTableViewCell createTableViewCell];
    [_priceCell setCellData:@{@"title":@"单价",@"detail":[NSString stringWithFormat:@"%.2f",_water.pirce]}];
    [_priceCell fitServerInfoModeC];
    
    _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
    [_submitCell fitWaterInfoMode];
    
    _stateTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_stateTipCell setCellData:@{@"title":@"当前状态",@"detail":@""}];
    [_stateTipCell fitServerInfoStateMode];
    
    _countCell = [TitleDetailTableViewCell createTableViewCell];
    [_countCell setCellData:@{@"title":@"数量",@"detail":[NSString stringWithFormat:@"%ld",_water.count]}];
    [_countCell fitServerInfoMode];
    
    _sendTimeCell = [TitleDetailTableViewCell createTableViewCell];
    [_sendTimeCell setCellData:@{@"title":@"送货时间",@"detail":_water.deliverydate?:@""}];
    [_sendTimeCell fitServerInfoMode];
    
    _areaCell = [TitleDetailTableViewCell  createTableViewCell];
    [_areaCell setCellData:@{@"title":@"归属园区",@"detail":_water.areaParkName?:@""}];
    [_areaCell fitServerInfoModeG];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
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
    if (section == 0) {
        row = 5;
    }
    else if (section == 2)
    {
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
        
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            height = 34;
        }
        else
        {
            height = 26;
        }
        
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
        if (indexPath.row == 0) {
            cell = _infoCell;
        }
        else  if (indexPath.row == 1) {
            cell = _typeCell;
        }
        else if(indexPath.row == 2)
        {
            cell = _priceCell;
        }
        else if (indexPath.row == 3)
        {
            cell = _countCell;
        }
        else{
            cell = _sendTimeCell;
        }
        [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            cell = _stateTipCell;
        }
        else
        {
            cell = _stateCell;
               [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(26, 0, 0, 0)];
        }
        
    }else
    {
        cell = _areaCell;
        [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
