//
//  FunctionListViewController.m
//  taihe
//
//  Created by air on 2016/11/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "FunctionListViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "ImgAndTitleListTableViewCell.h"
#import "BUSystem.h"
#import "ServerViewController.h"
#import "PlaceOfMeetingRoomViewController.h"
#import "CleanCompanyInfoViewController.h"
#import "OfficeGoodsCompanyViewController.h"
#import "GreenPlantCompanyInfoViewController.h"
#import "NetCompanyListViewController.h"
#import "PlaceOfMeetingRoomViewController.h"
#import "CleanCompanyInfoViewController.h"
#import "OfficeGoodsCompanyViewController.h"
#import "GreenPlantCompanyInfoViewController.h"
#import "NetCompanyListViewController.h"
#import "MoneyQueryCompanyListViewController.h"
#import "BusCompanyListViewController.h"
#import "WaterCompanyViewController.h"
#import "MoneyCampanyInfoViewController.h"
#import "ActivityViewController.h"
#import "ZoneChoseViewController.h"
#import "ReserveMeetingViewController.h"
#import "NetListViewController.h"
#import "CleanserViewController.h"
#import "RepairsViewController.h"
#import "LiveInViewController.h"
#import "ServerGetWaterInfoViewController.h"
#import "DecorationViewController.h"
#import "GetOfficeWorkViewController.h"
#import "BankServerListViewController.h"
#import "RentGreenPlantViewController.h"
#import "BusinessAgentServerListViewController.h"
#import "LawServerListViewController.h"
#import "OfficeGoodsViewController.h"
#import "ActivityInfoViewController.h"
#import "NoticeInfoViewController.h"
#import "LoginViewController.h"
#import "GovCenterInfoViewController.h"
@interface FunctionListViewController ()
{
    OnlyTitleTableViewCell *_functionTipCell;
    
    OnlyTitleTableViewCell *_addFunctionTipCell;
    BOOL _isNeedSave;
   
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic)NSMutableArray *curServerArr;
@property (strong, nonatomic)NSMutableArray *otherServerArr;

@property (strong, nonatomic)NSMutableArray *curServeDicrArr;
@property (strong, nonatomic)NSMutableArray *otherServerDicArr;
@property (strong, nonatomic)ImgAndTitleListTableViewCell *functionListCell;
@property (strong, nonatomic) ImgAndTitleListTableViewCell *addFunctionCell;
@property ( nonatomic) BOOL isEdit;
@end

@implementation FunctionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"功能列表";
    self.navigationController.navigationBar.translucent = NO;
     self.navigationController.navigationBar.shadowImage = nil;
    [self setRightNav];
    [self initTableView];
//    HUDSHOW(@"加载中");
//    [self getData];
}

-(void)getData
{
    [busiSystem.getServicesManager getServices:busiSystem.agent.sapid observer:self callback:@selector(getServicesNotification:)];
}

-(void)getServicesNotification:(BSNotification *)noti
{
    BASENOTIFICATION(noti);
    _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getServicesManager.data];
    [_tableView reloadData];
}

-(void)setRightNav
{
    [self setNavigateRightButton:@"编辑" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_3)];
}

-(void)handleReturnBack:(id)sender
{
    if (_isNeedSave) {
        [[CommonAPI managerWithVC:self] showAlert:@selector(returnBack:) withTitle:nil withMessage:@"确定放弃本次编辑?" withObj:@{}];
    }
    else
    {
        [super handleReturnBack:sender];
    }
    
}

-(void)returnBack:(NSDictionary*)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        [super handleReturnBack:nil];
    }
}


-(void)handleDidRightButton:(id)sender
{

    _isEdit = !_isEdit;
    if (_isEdit) {
        [_curServeDicrArr removeAllObjects];
        [_curServerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BUServices *lf = obj;
          
                [_curServeDicrArr addObject:[lf getDicWithDel]];
        }];
           [self.functionListCell setCellData:@{@"arr":_curServeDicrArr}];
         [[self setRightButton] setTitle:@"完成" forState:UIControlStateNormal];
    }
    else
    {
        
     [[self setRightButton] setTitle:@"编辑" forState:UIControlStateNormal];
        //    HUDSHOW(@"提交中");
        [self submit];
        [_curServeDicrArr removeAllObjects];
        [_curServerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BUServices *lf = obj;
            
            [_curServeDicrArr addObject:[lf getDic]];
        }];
             [self.functionListCell setCellData:@{@"arr":_curServeDicrArr}];
    }
   
}

-(void)submit
{
    HUDSHOW(@"提交中");
    
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObjectsFromArray:_curServerArr];
    [arr addObjectsFromArray:_otherServerArr];
    [busiSystem.headManager submitUsService:arr observer:self callback:@selector(submitUsServiceNotification:)];
}

-(void)submitUsServiceNotification:(BSNotification *)noti
{
  if(noti.error.code == 0)
  {
      HUDSMILE(@"修改成功", 1);
      _isNeedSave = NO;
      busiSystem.agent.isNeedRefreshTabA = YES;
  }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)initTableView
{
    _tableView.refreshHeaderView = nil;
    _tableView.refreshFooterView = nil;
    __weak FunctionListViewController *weakSelf = self;
    _functionTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_functionTipCell setCellData:@{@"title":@" 当前功能列表"}];
    [_functionTipCell fitFuctionListMode];
    _functionListCell = [ImgAndTitleListTableViewCell createTableViewCell];
    NSMutableArray *arr2 = [NSMutableArray new];
    _curServerArr = [NSMutableArray new];
    [busiSystem.headManager.serviceTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BUServices *l = obj;
        BUServices *lf = [BUServices new];
        lf.state = l.state;
        lf.name = l.name;
        lf.no = l.no;
        lf.sapId = l.sapId;
        lf.imagePath = l.imagePath;
        lf.sstId = l.sstId;
        lf.susId = l.susId;
        if (lf.state == 1) {
            [arr2 addObject:[lf getDic]];
            [_curServerArr addObject:lf];
        }
        
    }];
    _curServeDicrArr = arr2;
    [_functionListCell setCellData:@{@"arr":arr2}];
    _functionListCell.delCallback = ^(NSDictionary *dic){
        NSIndexPath *indexPath = dic[@"row"];
        BUServices *s = weakSelf.curServerArr[indexPath.row];
        s.state = 0;
        [weakSelf.otherServerArr addObject:s];
          [weakSelf.otherServerDicArr addObject:[s getDic]];
         [weakSelf.addFunctionCell setCellData:@{@"arr":weakSelf.otherServerDicArr}];
        
        [weakSelf.curServerArr removeObjectAtIndex:indexPath.row];
        [weakSelf.curServeDicrArr removeObjectAtIndex:indexPath.row];
         [weakSelf.functionListCell setCellData:@{@"arr":weakSelf.curServeDicrArr}];
           [weakSelf.tableView reloadData];
        _isNeedSave = YES;
    };
    
    _functionListCell.handleAction =^(NSDictionary *dic){
        NSIndexPath *indexPath = dic[@"row"];
        if(!weakSelf.isEdit)
        {
            BUServices *ser = weakSelf.curServerArr[indexPath.row];
            [weakSelf toFitVC:ser.sstId];
            return ;
        }
    };
    _addFunctionTipCell = [OnlyTitleTableViewCell createTableViewCell];
    [_addFunctionTipCell setCellData:@{@"title":@"点击添加更多功能"}];
    [_addFunctionTipCell fitFuctionListMode];
    
    _addFunctionCell = [ImgAndTitleListTableViewCell createTableViewCell];
    _otherServerArr = [NSMutableArray new];
     NSMutableArray *arr = [NSMutableArray new];
    [busiSystem.headManager.serviceTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BUServices *l = obj;
        BUServices *lf = [BUServices new];
        lf.state = l.state;
        lf.name = l.name;
        lf.no = l.no;
        lf.sapId = l.sapId;
        lf.imagePath = l.imagePath;
        lf.sstId = l.sstId;
        lf.susId = l.susId;
        if (lf.state == 0) {
            [arr addObject:[lf getDic]];
            [_otherServerArr addObject:lf];
        }
        
    }];
    _otherServerDicArr = arr;
    [_addFunctionCell setCellData:@{@"arr":arr}];
    _addFunctionCell.handleAction = ^(NSDictionary *dic){
         NSIndexPath *indexPath = dic[@"row"];
        if(!weakSelf.isEdit)
        {
             BUServices *ser = weakSelf.otherServerArr[indexPath.row];
            [weakSelf toFitVC:ser.sstId];
            return ;
        }
        if (weakSelf.curServeDicrArr.count == 7) {
            [weakSelf showTip];
            return ;
        }
       
        _isNeedSave = YES;
        BUServices *s = weakSelf.otherServerArr[indexPath.row];
        s.state = 1;
        [weakSelf.curServerArr addObject:s];
         [weakSelf.curServeDicrArr addObject:[s getDicWithDel]];
        [weakSelf.functionListCell setCellData:@{@"arr":weakSelf.curServeDicrArr}];
        
        [weakSelf.otherServerArr removeObjectAtIndex:indexPath.row];
        [weakSelf.otherServerDicArr removeObjectAtIndex:indexPath.row];
        [weakSelf.addFunctionCell setCellData:@{@"arr":weakSelf.otherServerDicArr}];
        [weakSelf.tableView reloadData];
    };
}

-(void)showTip
{
   HUDCRY(@"最多添加7个功能", 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 4;
    
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    if (indexPath.row == 0) {
        height = 35;
    }
    else if (indexPath.row == 1) {
        height = 195;
    }
    else if (indexPath.row == 2) {
        height = 35;
    }
    else
    {
        CGFloat cheight = 92;
        if (__SCREEN_SIZE.width == 375) {
            cheight = 92;
        }
        else if(__SCREEN_SIZE.width == 320)
        {
            cheight = 92;
            
        }else
        {
            
        }
        NSInteger c = (_otherServerArr.count + 3)/4;
       height = cheight * c + 70;
    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
 
        if (indexPath.row == 0) {
            cell = _functionTipCell;
            [_functionTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
        }
         else if (indexPath.row == 1)
         {
             cell = _functionListCell;
             [_functionListCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(195, 0, 0, 0)];
        }
         else if (indexPath.row == 2)
         {
             cell = _addFunctionTipCell;
           [_addFunctionTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
        }
        else
        {
            cell = _addFunctionCell;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)toFitVC:(NSString *)sstId
{
    if (!busiSystem.agent.isLogin) {
        [LoginViewController toLogin:self];
        return;
    }
    
    if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4201"]) {
        PlaceOfMeetingRoomViewController *vc = [PlaceOfMeetingRoomViewController new];
        
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4202"])//生活餐饮
    {
        
        NSArray *arr  = self.tabBarController.viewControllers;
        for (UINavigationController *nvc in arr) {
            for (UIViewController *vc in nvc.viewControllers) {
                if ([vc isKindOfClass:[ServerViewController class]]) {
                    ServerViewController *SVC = (ServerViewController *)vc;
                    SVC.state = 3;
                    SVC.isHeadPush = YES;
                }
            }
        }
        self.tabBarController.selectedIndex = 1;
    }
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4203"])
    {
        NetCompanyListViewController *vc = [NetCompanyListViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4204"])
    {
        CleanCompanyInfoViewController *vc = [CleanCompanyInfoViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4205"])
    {
        RepairsViewController *vc = [RepairsViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4206"])
    {
        DecorationViewController *vc = [DecorationViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4207"])
    {
        LiveInViewController *vc = [LiveInViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4208"])
    {
        BusCompanyListViewController *vc = [BusCompanyListViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4209"])
    {
        OfficeGoodsCompanyViewController *vc = [OfficeGoodsCompanyViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4210"])
    {
        WaterCompanyViewController *vc = [WaterCompanyViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4211"])
    {
        GreenPlantCompanyInfoViewController *vc = [GreenPlantCompanyInfoViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4212"])//租房服务
    {
        NSArray *arr  = self.tabBarController.viewControllers;
        for (UINavigationController *nvc in arr) {
            for (UIViewController *vc in nvc.viewControllers) {
                if ([vc isKindOfClass:[ServerViewController class]]) {
                    ServerViewController *SVC = (ServerViewController *)vc;
                    SVC.state = 4;
                    SVC.isHeadPush = YES;
                }
            }
        }
        self.tabBarController.selectedIndex = 1;
    }
    
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4213"])
    {
        BankServerListViewController *vc = [BankServerListViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4214"])
    {
        BusinessAgentServerListViewController *vc = [BusinessAgentServerListViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4215"])
    {
        LawServerListViewController *vc = [LawServerListViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4216"])//水电充值
    {
        TOASTSHOW(@"暂未开放该功能");
        
    }
    
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4217"])//月卡缴费
    {
        TOASTSHOW(@"暂未开放该功能");
    }
    
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4218"])//临时停车
    {
        TOASTSHOW(@"暂未开放该功能");
    }
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4219"])//物业缴费
    {
        TOASTSHOW(@"暂未开放该功能");
    }
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4220"])//快递代收发
    {
        TOASTSHOW(@"暂未开放该功能");
    }
    else if ([sstId isEqualToString:@"ae325f680e9d458a8f8dc8bf283a4221"])//财务咨询
    {
        MoneyQueryCompanyListViewController *vc = [MoneyQueryCompanyListViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
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

@end
