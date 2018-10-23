//
//  MyServerApplyViewController.m
//  taihe
//
//  Created by air on 2016/11/7.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "MyServerApplyViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "TypeChoseViewController.h"
#import "UnitRepairViewController.h"
#import "PublicRepairViewController.h"
#import "OfficeInfoViewController.h"
#import "LanAndPhoneViewController.h"
#import "WaterInfoViewController.h"
#import "MeetingInfoViewController.h"
#import "SendInfoViewController.h"
#import "LookOrEditRantInfoViewController.h"
#import "PublicApplicationViewController.h"
#import "UnitApplicationViewController.h"
#import "BUSystem.h"
@interface MyServerApplyViewController ()
{
    NSString *_type;
    
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic) TypeChoseViewController *typeVC;
@property (strong, nonatomic)  OnlyBottomBtnTableViewCell *menuView;
@end

@implementation MyServerApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的服务申请";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.shadowImage = nil;
    [self initMenuView];
    [self initTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRefreshing) name:@"refreshMyServer" object:nil];
    HUDSHOW(@"加载中");
    [self getAllData];
}

-(void)getWaterData
{
    [self getDataWithType:@"3"];
    //    [busiSystem.getMyWaterInfoManager getMyWaterInfo:busiSystem.agent.tel withSapid:busiSystem.agent.sapid observer:self callback:@selector(getMyWaterInfoNotification:)];
}

-(void)getMyWaterInfoNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
        _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getMyWaterInfoManager.waterInfos];
        [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:[NSString stringWithFormat:@"server%d",0]];
        [[JYNoDataManager manager] fitModeY:200];
        [_tableView reloadData];
    }
    else
    {
        //        BASENOTIFICATION(noti)
        HUDCRY(noti.error.domain, 1);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initMenuView
{
    __weak MyServerApplyViewController *weakSelf = self;
    _menuView = [OnlyBottomBtnTableViewCell createTableViewCell];
    _menuView.width = __SCREEN_SIZE.width;
    [_menuView setCellData:@{@"title":@"全部"}];
    [_menuView fitMyServerApplyMode:NO];
    [_menuView showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.view addSubview:_menuView];
    [_menuView setHandleAction:^(id o) {
        
        [weakSelf toTypeVC];
    }];
}

-(void)toTypeVC
{
    __weak MyServerApplyViewController *weakSelf = self;
    [_menuView fitMyServerApplyMode:YES];
    self.typeVC = [TypeChoseViewController toTypeVC];
    self.typeVC.cancelAction = ^(){
        [weakSelf.menuView fitMyServerApplyMode:NO];
    };
    self.typeVC.handleAction = ^(NSDictionary *dic){
        [weakSelf.typeVC.parentDialog dismiss];
        [weakSelf.menuView setCellData:dic];
        [weakSelf.menuView fitMyServerApplyMode:NO];
        [weakSelf getFitData:dic[@"title"]];
    };
}

-(void)getFitData:(NSString *)title
{
     HUDSHOW(@"加载中");
    if ([title isEqualToString:@"公区报修"]) {
        [self getPubRepairData];
    }
    else if ([title isEqualToString:@"单元报修"])
    {
        [self getUnitRepairData];
    }
    else if ([title isEqualToString:@"饮用水"])
    {
       
        [self getWaterData];
    }
    else if ([title isEqualToString:@"新装宽带电话"])
    {
        [self getMakePhoneData];
    }
    else if ([title isEqualToString:@"会议室预定"])
    {
        [self getMeetingOrderData];
    }
    else if ([title isEqualToString:@"办公商务"])
    {
        [self getOfficeData];
    }
    else
    {
        [self getAllData];
    }
}

-(void)getAllData
{
    [self getDataWithType:@"0"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.typeVC.curIndexPath = nil;
//    if(self.isFirstResponder
//       
//       )
        
}

-(void)getDataWithType:(NSString *)type
{
    busiSystem.getMyApplyListManager.type = type;
    [busiSystem.getMyApplyListManager getMyApplyList:busiSystem.agent.tel observer:self callback:@selector(getDataNotification:)];
    
}

-(void)getDataNotification:(BSNotification*)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
        _tableView.dataArr = [NSMutableArray arrayWithArray:[busiSystem.getMyApplyListManager getData]];
        [self reloadData];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)getPubRepairData
{
    [self getDataWithType:@"1"];
}

-(void)getUnitRepairData
{
    [self getDataWithType:@"2"];
}

-(void)getMakePhoneData
{
    [self getDataWithType:@"4"];
}

-(void)getMeetingOrderData
{
    [self getDataWithType:@"5"];
}

-(void)getOfficeData
{
    [self getDataWithType:@"6"];
}

-(void)reloadData
{
    [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:[NSString stringWithFormat:@"server%d",0]];
    [[JYNoDataManager manager] fitModeY:200];
    [_tableView reloadData];
}

-(void)toConfirm:(BUGetMyApply *)wid
{
    [[CommonAPI managerWithVC:self] showAlert:@selector(toConfirmServer:) withTitle:nil withMessage:@"确认该服务已完成?" withObj:@{@"id":wid}];
    
}

-(void)toConfirmServer:(NSDictionary *)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        BUGetMyApply *a = dic[@"id"];
        if (a.type == 1) {
            [busiSystem.getPubFixListManager surePubFixList:a.myid observer:self callback:@selector(confirmMyWaterNotification:)];
        }
        else  if (a.type == 2) {
            [busiSystem.getUniFixListManager sureUniFixList:a.myid observer:self callback:@selector(confirmMyWaterNotification:)];
        }
        else if (a.type == 3) {
           [busiSystem.getMyWaterInfoManager confirmMyWater:a.myid observer:self callback:@selector(confirmMyWaterNotification:)];
        }
        else  if (a.type == 4) {
            [busiSystem.getMyNetInfoManager sureMyNetInfo:a.myid observer:self callback:@selector(confirmMyWaterNotification:)];
        }
        else if (a.type == 5) {
            [busiSystem.getMyMeetingInfoManager sureMyMeetingInfo:a.myid observer:self callback:@selector(confirmMyWaterNotification:)];
        }
        else {
            [busiSystem.getMyWorkInfoManager sureMyWorkInfo:a.myid observer:self callback:@selector(confirmMyWaterNotification:)];
        }
        
    }
}

-(void)confirmMyWaterNotification:(BSNotification *)noti
{
    if(noti.error.code == 0)
    {
        HUDSMILE(@"确认成功", 1);
        //        HUDSHOW(@"加载中");
        [self performSelector:@selector(showRefreshing) withObject:nil afterDelay:1];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)showRefreshing
{
    HUDSHOW(@"加载中");
    [self refresh];
}

-(void)refresh
{
    [self getDataWithType:busiSystem.getMyApplyListManager.type];
}

-(void)toDelete:(BUGetMyApply *)wid
{
    [[CommonAPI managerWithVC:self] showAlert:@selector(toDeleteServer:) withTitle:nil withMessage:@"确认删除该订单?" withObj:@{@"id":wid}];
    
}

-(void)toDeleteServer:(NSDictionary*)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        BUGetMyApply *a = dic[@"id"];
        if (a.type == 1) {
            [busiSystem.getPubFixListManager deletePubFixList:a.myid observer:self callback:@selector(deleteMyWaterNotification:)];
        }
        else  if (a.type == 2) {
            [busiSystem.getUniFixListManager deleteUniFixList:a.myid observer:self callback:@selector(deleteMyWaterNotification:)];
        }
       else if (a.type == 3) {
          [busiSystem.getMyWaterInfoManager deleteMyWater:a.myid observer:self callback:@selector(deleteMyWaterNotification:)];
        }
      else  if (a.type == 4) {
          [busiSystem.getMyNetInfoManager deleteMyNetInfo:a.myid observer:self callback:@selector(deleteMyWaterNotification:)];
        }
       else if (a.type == 5) {
           [busiSystem.getMyMeetingInfoManager deleteMyMeetingInfo:a.myid observer:self callback:@selector(deleteMyWaterNotification:)];
        }
       else {
           [busiSystem.getMyWorkInfoManager deleteMyWorkInfo:a.myid observer:self callback:@selector(deleteMyWaterNotification:)];
        }
       
    }
}

-(void)deleteMyWaterNotification:(BSNotification *)noti
{
    if(noti.error.code == 0)
    {
        HUDSMILE(@"删除成功", 1);
        //刷新界面
//        [self refresh];
         [self performSelector:@selector(showRefreshing) withObject:nil afterDelay:1];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)initTableView
{
    _tableView.refreshHeaderView = nil;
    [TitleDetailTableViewCell registerTableViewCell:_tableView];
    [OnlyBottomBtnTableViewCell registerTableViewCell:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

-(void)viewDidLayoutSubviews
{
    _tableView.y = 44;
    _tableView.height = __SCREEN_SIZE.height - 64 - 44;
    _tableView.width = __SCREEN_SIZE.width;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _tableView.dataArr.count;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == _tableView.dataArr.count - 1) {
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    if (indexPath.row == 0) {
        height = 46;
    }
    else if (indexPath.row == 1) {
        height = 15;
    }else
    {
        height = 74;
    }
    return height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 3;
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    BUGetMyApply *w = _tableView.dataArr[indexPath.section];
    w.row = indexPath.section;
    if (indexPath.row == 0) {
        cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
        [(TitleDetailTableViewCell *)cell setCellData:[w getDic:0]];
        [(TitleDetailTableViewCell *)cell fitMyServerApplyModeS];
    }
    else if(indexPath.row == 1)
    {
        cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
        [(TitleDetailTableViewCell *)cell setCellData:[w getDic:1]];
        [(TitleDetailTableViewCell *)cell fitMyServerApplyModeB];
    }
    else
    {
        cell = [OnlyBottomBtnTableViewCell dequeueReusableCell:_tableView];
        [(TitleDetailTableViewCell *)cell setCellData:[w getDic:2]];
        if(w.righttop == 0)
        {
            if (w.type == 4) {
                    [(OnlyBottomBtnTableViewCell *)cell fitMyServerApplyModeB];
                [(OnlyBottomBtnTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
                    NSInteger row = [dic[@"row"] integerValue];
                    BUGetMyApply *w = _tableView.dataArr[row];
                    [self toConfirm:w];
                }];
            }
            else
            {
            [(OnlyBottomBtnTableViewCell *)cell fitMyServerApplyModeC];
            }
        }
        else
        {
            [(OnlyBottomBtnTableViewCell *)cell fitMyServerApplyModeB];
            if (w.righttop == 1) {
                [(OnlyBottomBtnTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
                    NSInteger row = [dic[@"row"] integerValue];
                    BUGetMyApply *w = _tableView.dataArr[row];
                    if (w.type == 1 || w.type == 2) {
                        if (w.reworkSecondEnd == 1) {
                            [self toConfirm:w];
                        }
                        else
                        {
                          [self showSatisfiedTip:w];
                        }
                    }
                    else if(w.type == 4)
                    {
                        [self toDelete:w];
                    }
                    else
                    {
                      [self toConfirm:w];
                    }
                }];
            }
            else
            {
                if(w.type != 1 && w.type != 2)
                {
                [(OnlyBottomBtnTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
                    NSInteger row = [dic[@"row"] integerValue];
                    BUGetMyApply *w = _tableView.dataArr[row];
                    [self toDelete:w];
                }];
                }
                else
                {
                    if (w.righttop == 3 && w.reworkCount <= 2) {
                       [(OnlyBottomBtnTableViewCell *)cell fitMyServerApplyModeD:@"再次申请"];
                        [(OnlyBottomBtnTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
                            NSInteger row = [dic[@"row"] integerValue];
                            BUGetMyApply *w = _tableView.dataArr[row];
                            [self toDelete:w];
                        }];
                        
                        [(OnlyBottomBtnTableViewCell *)cell setExtrHandleAction:^(NSDictionary *dic) {
                            NSInteger row = [dic[@"row"] integerValue];
                            BUGetMyApply *w = _tableView.dataArr[row];
                            [self applyAgain:w];
                        }];
                    }
                    else
                    {
                        [(OnlyBottomBtnTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
                            NSInteger row = [dic[@"row"] integerValue];
                            BUGetMyApply *w = _tableView.dataArr[row];
                            [self toDelete:w];
                        }];
                    }
                }
            }
        }
        //        [(OnlyBottomBtnTableViewCell *)cell fitMyServerApplyModeD:@"再次申请"];
        [(OnlyBottomBtnTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(74, 0, 0, 0)];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BUGetMyApply *w = _tableView.dataArr[indexPath.section];
    if (w.type == 3) {
        WaterInfoViewController *vc = [WaterInfoViewController new];
        vc.userInfo = w.myid;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (w.type == 1)
    {
        PublicRepairViewController *vc = [PublicRepairViewController new];
         vc.userInfo = w.myid;
            [self.navigationController pushViewController:vc animated:YES];
    }
    else if (w.type == 2)
    {
        UnitRepairViewController *vc = [[UnitRepairViewController alloc] initWithNibName:@"PublicRepairViewController" bundle:nil];
         vc.userInfo = w.myid;
                [self.navigationController pushViewController:vc animated:YES];

    }
    else if (w.type == 4)
    {
        LanAndPhoneViewController *vc = [[LanAndPhoneViewController alloc] initWithNibName:@"WaterInfoViewController" bundle:nil];
           vc.userInfo = w.myid;
                  [self.navigationController pushViewController:vc animated:YES];
    }
    else if (w.type == 5)
    {
        MeetingInfoViewController *vc = [MeetingInfoViewController new];
           vc.userInfo = w.myid;
                 [self.navigationController pushViewController:vc animated:YES];
   
    }
        else
    {
        OfficeInfoViewController *vc = [OfficeInfoViewController new];
           vc.userInfo = w.myid;
                [self.navigationController pushViewController:vc animated:YES];

    }
    
}

-(void)applyAgain:(BUGetMyApply*)w
{
  if(w.type == 1)
  {
      [self applyPublicAgain:w];
  }
    else
    {
        [self applyUnitAgain:w];
    }
}


-(void)applyPublicAgain:(BUGetMyApply*)w
{
    PublicApplicationViewController *vc = [PublicApplicationViewController new];
    vc.isAgain = YES;
    vc.dataDic = @{@"id":w.myid };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)applyUnitAgain:(BUGetMyApply*)w
{
    UnitApplicationViewController *vc = [UnitApplicationViewController new];
    vc.isAgain = YES;
      vc.dataDic = @{@"id":w.myid };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)reworkRequest:(NSDictionary*)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        HUDSHOW(@"请求中");
        NSDictionary *dd = dic[@"userInfo"];
        NSString *str = dd[@"str"];
        NSString *myid = dd[@"id"];
        NSString *times = dd[@"times"];
        if ([dd[@"type"] integerValue] == 1) {
            [busiSystem.getPubFixListManager reworkPubFixList:myid  withReason:str withTimes:[NSString stringWithFormat:@"%ld",[times integerValue] + 1] observer:self callback:@selector(reworkPubFixListNotification:)];
        }
        else
        {
        [busiSystem.getUniFixListManager rewokeUniFixList:myid  withReason:str withTimes:[NSString stringWithFormat:@"%ld",[times integerValue] + 1] observer:self callback:@selector(reworkPubFixListNotification:)];
        }
        
    }
}

-(void)reworkPubFixListNotification:(BSNotification*)noti
{
    if(noti.error.code == 0)
    {
        HUDDISMISS;
        [[CommonAPI managerWithVC:self] showConfirmView:nil withMsg:@"您已成功申请返工，请等待管理员与您确认返工开始和完工时间"];
        //        HUDSMILE(@"删除成功", 1);
        //刷新界面
        [self showRefreshing];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

//-(void)confirm
//{
//    [[CommonAPI managerWithVC:self] showAlert:@selector(sureRequest:) withTitle:nil withMessage:@"确认该服务已完成？" withObj:@{}];
//}


-(void)showSatisfiedTip:(BUGetMyApply*)w
{
    SheetOptionViewController *vc = [SheetOptionViewController createVC:self];
    __weak SheetOptionViewController *weakSelf = vc;
    [vc setCallBack:^(UIButton *btn) {
        switch (btn.tag - 100) {
            case 0:
            {
                [self toConfirmServer:@{@"code":@(0),@"id":w}];
            }
                break;
            case 1:
            {
                [weakSelf.parentDialog dismiss];
                [self showTextConfirmTip:w];
                
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

-(void)showTextConfirmTip:(BUGetMyApply*)w
{
    [[TextConfirmViewController createVC: self] setCallBack:^(NSDictionary *dic) {
        NSString *str = dic[@"title"];
        [self showConfirmView:str withId:w.myid withTimes:[NSString stringWithFormat:@"%ld",w.reworkCount] withType:w.type];
        
    }];
}

-(void)showConfirmView:(NSString *)str withId:(NSString *)myid withTimes:(NSString *)times withType:(NSInteger)type
{
    [[CommonAPI managerWithVC:self] showAlertView:nil withMsg:@"很抱歉，此次服务没能让您满意，您可以点击【返工申请】发起免费的返工申请。" withBtnTitle:@"返工申请"  withSel:@selector(reworkRequest:) withUserInfo:@{@"str":str,@"id":myid,@"times":times,@"type":@(type)}];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
