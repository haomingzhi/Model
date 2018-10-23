//
//  OfficeInfoViewController.m
//  taihe
//
//  Created by air on 2016/11/10.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "OfficeInfoViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "BUSystem.h"
@interface OfficeInfoViewController ()
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic) OnlyTitleTableViewCell *stateTipCell;
@property (strong, nonatomic)OnlyBottomBtnTableViewCell *submitCell;
@property (strong, nonatomic)TitleDetailTableViewCell *typeCell;
@property (strong, nonatomic)TitleDetailTableViewCell *priceCell;
@property (strong, nonatomic)TitleDetailTableViewCell *stateCell;
@property(strong,nonatomic)OnlyTitleTableViewCell *tipCell;
@property (strong, nonatomic)TitleDetailTableViewCell *areaCell;
@property(nonatomic,strong)BUGetMyWorkInfo *myworkInfo;
@end

@implementation OfficeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"办公商务申请详情";
    [self initTableView];
    HUDSHOW(@"加载中");
    [self getData];
}

-(void)getData
{
    [busiSystem.getMyWorkInfoManager getMyWorkInfo:_userInfo observer:self callback:@selector(getDataNotification:)];
}

-(void)getDataNotification:(BSNotification *)noti
{
    
    __weak OfficeInfoViewController *weakSelf = self;
    if (noti.error.code == 0) {
        HUDDISMISS;
        if (busiSystem.getMyWorkInfoManager.myWorkInfos.count > 0) {
            _myworkInfo = busiSystem.getMyWorkInfoManager.myWorkInfos[0];
        }
        [_priceCell setCellData:@{@"title":@"价格",@"detail":[NSString stringWithFormat:@"￥%.2f",_myworkInfo.pirce]}];
        [_priceCell fitServerInfoModeF:@"已支付"];
        NSString *st;
        if (_myworkInfo.state == 0) {
            st = @"待付款";
            [_priceCell fitServerInfoModeE];
            [_priceCell setHandleAction:^(id o) {
                [weakSelf payRightNowOption];
            }];
        }
        else if (_myworkInfo.state == 1)
        {
            st = @"受理中";
        }
        else if (_myworkInfo.state == 2)
        {
            st = @"受理失败";
            [self addTipView];
              [_priceCell fitServerInfoModeF:@"未支付"];
        }
        else
        {
            st = @"已完成";
        }
        [_stateCell setCellData:@{@"title":st,@"detail":_myworkInfo.createTime?:@""}];
        [_stateCell fitServerInfoStateModeB];
        
      
        [_typeCell setCellData:@{@"title":@"类型",@"detail":_myworkInfo.name?:@""}];
        [_typeCell fitServerInfoMode];
        
      
      
        
//        [_stateTipCell setCellData:@{@"tilte":@"当前状态"}];
//        [_stateTipCell fitServerInfoStateMode];
        
        [_areaCell setCellData:@{@"title":@"归属园区",@"detail":_myworkInfo.sapId?:@""}];
        [_areaCell fitServerInfoModeG];
        _mode = _myworkInfo.state;
        [self addBottomMenuView];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)addBottomMenuView
{
    
    __weak OfficeInfoViewController *weakSelf = self;
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

//-(void)addTipView
//{
//    if (!_tipCell) {
//        _tipCell = [TitleDetailTableViewCell createTableViewCell];
//    }
//    
//    _tableView.tableHeaderView = _tipCell;
//}
-(void)initTableView
{
    _tableView.refreshHeaderView = nil;
    _stateCell = [TitleDetailTableViewCell createTableViewCell];
    [_stateCell setCellData:@{@"title":@"受理中",@"detail":@""}];
    [_stateCell fitServerInfoStateMode];
    
     _typeCell = [TitleDetailTableViewCell createTableViewCell];
    [_typeCell setCellData:@{@"title":@"类型",@"detail":@""}];
    [_typeCell fitServerInfoMode];
    
     _priceCell = [TitleDetailTableViewCell createTableViewCell];
    [_priceCell setCellData:@{@"title":@"价格",@"detail":@""}];
    [_priceCell fitServerInfoModeB];
    
     _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
    [_submitCell fitWaterInfoMode];
    
   _stateTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_stateTipCell setCellData:@{@"title":@"当前状态"}];
    [_stateTipCell fitServerInfoStateMode];
    
    _areaCell = [TitleDetailTableViewCell  createTableViewCell];
    [_areaCell setCellData:@{@"title":@"归属园区",@"detail":@""}];
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
    if (section == 2) {
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
        
    }else
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
            cell = _typeCell;
        }
        else
        {
            cell = _priceCell;
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
    }
    else
    {
        cell = _areaCell;
         [_areaCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
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
        [busiSystem.getMyWorkInfoManager sureMyWorkInfo:_myworkInfo.bwoId observer:self callback:@selector(confirmMyWorkInfoNotification:)];
    }
    
}

-(void)confirmMyWorkInfoNotification:(BSNotification *)noti
{
    if(noti.error.code == 0)
    {
        HUDSMILE(@"确认成功", 1);
        //刷新界面
        _mode = _myworkInfo.state = 3;
        [self addBottomMenuView];
        [_stateCell setCellData:@{@"title":@"已完成",@"detail":_myworkInfo.createTime?:@""}];
        [_stateCell fitServerInfoStateModeB];
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
        [busiSystem.getMyWorkInfoManager deleteMyWorkInfo:_userInfo observer:self callback:@selector(deleteMyWorkInfoNotification:)];
    }
    
}

-(void)deleteMyWorkInfoNotification:(BSNotification *)noti
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
    [self.tipCell setCellData:@{@"title":_myworkInfo.failCause?:@""}];
    [self.tipCell fitCerFailTipMode];
    self.tipCell.backgroundColor = kUIColorFromRGB(color_4);
    UIView *line = [self.tipCell viewWithTag:3221];
    if (!line) {
        line = [UIView new];
        line.tag = 3221;
    }
    
    line.y = self.tipCell.height - 0.5;
    line.height = 0.5;
    line.backgroundColor = kUIColorFromRGB(color_lineColor);
    line.width = __SCREEN_SIZE.width;
    [self.tipCell addSubview:line];
    self.tableView.tableHeaderView = self.tipCell;
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
    [busiSystem.payManager payMyWorkInfo:self.userInfo observer:self callback:@selector(payNotification:)];
}

-(void)payNotification:(BSNotification*)noti
{
    //刷新界面显示是否满意
    _mode = 0;;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyServer" object:nil];
    [self addBottomMenuView];
    [_priceCell fitServerInfoModeF:@"已支付"];
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
