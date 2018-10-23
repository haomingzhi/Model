//
//  ReplacementConfirmViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/6.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ReplacementConfirmViewController.h"
#import "PayOrderViewController.h"
#import "ReplacementOrderInfoViewController.h"
#import "PaySuccessViewController.h"
#import "SelectAddressViewController.h"
#import "BUSystem.h"
@interface ReplacementConfirmViewController ()
{
 
}

@property ( nonatomic)NSInteger jf;//使用积分
@property ( nonatomic)NSInteger allJf;//所拥有的积分
@property ( nonatomic)CGFloat needPrice;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;
@property (strong, nonatomic) NSString *addrId;
@property (strong, nonatomic) NSIndexPath *checkIndexPath;
@end

@implementation ReplacementConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"置换订单确认";
     _allJf = busiSystem.agent.userInfo.point;
     _jf = MIN(_allJf, _secondHandGoods.integral);
     _needPrice = _secondHandGoods.price;
        _checkIndexPath = [NSIndexPath indexPathForRow:4 inSection:1];
     HUDSHOW(@"加载中");
     [self getUserDefaultAddressData];
     [self initTableView];
     [self addBottomView];
}

-(void)getUserDefaultAddressData
{
     [busiSystem.agent getUserDefaultAddress:busiSystem.agent.userId observer:self callback:@selector(getUserDefaultAddressNotification:)];
}

-(void)getUserDefaultAddressNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
           _addrId = busiSystem.agent.userDefaultAddress.addrId;
          if (!_addrId||[_addrId isEqualToString:@""]) {
               [_adrCell setCellData:@{@"title":@"请新增服务地址",@"detail":@""}];
               [_adrCell fitReplacementConfirmModeB];
               return;
          }
          _lat = busiSystem.agent.userDefaultAddress.latitude;
          _lon = busiSystem.agent.userDefaultAddress.longitude;
          NSString *addr = busiSystem.agent.userDefaultAddress.address;

//          _cityName = busiSystem.agent.userDefaultAddress.cityName;
          [_adrCell setCellData:@{@"title":[NSString stringWithFormat:@"%@ %@",busiSystem.agent.userDefaultAddress.contacts,busiSystem.agent.userDefaultAddress.tell],@"detail":addr?:@""}];
          [_adrCell fitReplacementConfirmMode];
     }
     else
     {
          _addrId = busiSystem.agent.userDefaultAddress.addrId;
          if (!_addrId||[_addrId isEqualToString:@""]) {
               HUDDISMISS;
               [_adrCell setCellData:@{@"title":@"请新增服务地址",@"detail":@""}];
               [_adrCell fitReplacementConfirmModeB];
               return;
          }
          HUDCRY(noti.error.domain, 1);
     }
}

-(void)initData
{

}

-(void)addBottomView
{
     _submitCell.width = __SCREEN_SIZE.width;
     NSInteger idd = NAVBARHEIGHT;
     _submitCell.y = __SCREEN_SIZE.height - 44 -NAVBARHEIGHT;
     [self.view addSubview:_submitCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView
{
    self.tableView.refreshHeaderView = nil;

     __weak ReplacementConfirmViewController *weakSelf = self;
     _adrCell = [TitleDetailTableViewCell createTableViewCell];
     [_adrCell setCellData:@{@"title":[NSString stringWithFormat:@""],@"detail":_secondHandGoods.address?:@""}];
     [_adrCell fitReplacementConfirmMode];

     _titleCell = [OnlyTitleTableViewCell createTableViewCell];
     [_titleCell setCellData:@{@"title":@"二手置换"}];
     [_titleCell fitReplacementConfirmMode];

     _secHandCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
     if (!_secondHandGoods) {
          [_secHandCell setCellData:@{@"default":@"default"}];
     }
     else
     {
     [_secHandCell setCellData:[_secondHandGoods getDic:0]];
     }
     [_secHandCell fitReplacementConfirmMode];
        CGFloat cjf = busiSystem.agent.config.integralExchange * 1.0;
     _jfCell = [TwoTabsTableViewCell createTableViewCell];
     [_jfCell setCellData:@{@"title":[NSString stringWithFormat:@"积分抵扣(%.0f积分=1元）",cjf],@"value":[NSString stringWithFormat:@"%ld",weakSelf.jf],@"tab1":@"",@"tab2":@"",@"detail":[NSString stringWithFormat:@"可用积分%ld分",weakSelf.allJf - weakSelf.jf]}];
     [_jfCell fitReplacementConfirmMode];

     __weak TwoTabsTableViewCell *ssw = _jfCell;
     [_jfCell setTabOneCallBack:^(id o) {
          if (weakSelf.jf == 0) {
               return ;
          }
          weakSelf.jf --;
          [ssw setCellData:@{@"title":[NSString stringWithFormat:@"积分抵扣(%.0f积分=1元）",cjf],@"value":[NSString stringWithFormat:@"%ld",weakSelf.jf],@"tab1":@"",@"tab2":@"",@"detail":[NSString stringWithFormat:@"可用积分%ld分",weakSelf.allJf - weakSelf.jf]}];
          [ssw fitReplacementConfirmMode];
       CGFloat f = weakSelf.needPrice - weakSelf.jf/cjf;
          [weakSelf.submitCell setCellData:@{@"title":@"提交订单",@"detail":[NSString stringWithFormat:@"还需支付：￥%.2f",f]}];
          [weakSelf.submitCell fitReplacementConfirmMode];
     }];
     [_jfCell setTabTwoCallBack:^(id o) {
          if(weakSelf.allJf == weakSelf.jf || weakSelf.needPrice - weakSelf.jf/cjf == 0)
          {
               return ;
          }
          weakSelf.jf ++;
          [ssw setCellData:@{@"title":[NSString stringWithFormat:@"积分抵扣(%.0f积分=1元）",cjf],@"value":[NSString stringWithFormat:@"%ld",weakSelf.jf],@"tab1":@"",@"tab2":@"",@"detail":[NSString stringWithFormat:@"可用积分%ld分",weakSelf.allJf - weakSelf.jf]}];
          [ssw fitReplacementConfirmMode];
          CGFloat f = weakSelf.needPrice - weakSelf.jf/cjf;
          [weakSelf.submitCell setCellData:@{@"title":@"提交订单",@"detail":[NSString stringWithFormat:@"还需支付：￥%.2f",f]}];
          [weakSelf.submitCell fitReplacementConfirmMode];
     }];

     _payWayCell = [OnlyTitleTableViewCell createTableViewCell];
     [_payWayCell setCellData:@{@"title":@"支付方式"}];
     [_payWayCell fitVipCenterModeB];

     _aliPayCell = [IconAndTitleTableViewCell createTableViewCell];
     [_aliPayCell setCellData:@{@"title":@"支付宝支付",@"img":@"aliPay"}];
     [_aliPayCell fitPayMode:YES];

     _wxPayCell = [IconAndTitleTableViewCell createTableViewCell];
     [_wxPayCell setCellData:@{@"title":@"微信支付",@"img":@"wxPay"}];
     [_wxPayCell fitPayMode:NO];

     _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_submitCell setCellData:@{@"title":@"提交订单",@"detail":[NSString stringWithFormat:@"还需支付：￥%.2f",_needPrice-_jf/cjf]}];
     [_submitCell fitReplacementConfirmMode];
     [_submitCell setHandleAction:^(id o){
          [weakSelf submit];
//          ReplacementOrderInfoViewController *vc = [ReplacementOrderInfoViewController new];
//          //          vc.payType = weakSelf.checkIndexPath.row - 1;
//          //          vc.price = 112;
//          //          vc.mode = 1;
//          //          vc.title = @"支付成功";
//          vc.getOrder = busiSystem.getOrderListManager.getOrder;
//          [self.navigationController pushViewController:vc animated:YES];
     }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{

    return  nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     if (section == 0) {
          return 14;
     }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     if (section == 0) {
          return  [self createSectionFootView:section];
     }
    return nil;
}
-(UIView *)createSectionFootView:(NSInteger)section
{
     UIView *v = [self.tableView viewWithTag:9887 + section];
     if (!v) {
          v = [UIView new];
          v.tag = 9887 + section;
     }
     v.height = 10;
     UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 4)];
     line.image = [UIImage imageContentWithFileName:@"icon_line_address"];

     [v addSubview:line];

     return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
     if (indexPath.section == 0) {
          height = 81;
     }
     else
     {
          if (indexPath.row == 0) {
               height = 41;
          }
          else if (indexPath.row == 1)
          {
               height = 120;
          }
          else if (indexPath.row == 2)
          {
                 height = 60;
          }
          else if (indexPath.row == 3)
          {
                 height = 41;
          }
          else if (indexPath.row == 4)
          {
                 height = 41;
          }else
          {
                 height = 41;
          }
     }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    if(section == 1)
    {
         row = 3;
    }
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
     if (indexPath.section == 0) {
          cell = _adrCell;
     }
     else
     {
          if (indexPath.row == 0) {
               cell = _titleCell;
                   [_titleCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
          }
          else if (indexPath.row == 1)
          {
               cell = _secHandCell;
                   [_secHandCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(120, 0, 0, 0)];
          }
          else if (indexPath.row == 2)
          {
               cell = _jfCell;
                   [_jfCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
          }
          else if (indexPath.row == 3)
          {
               cell = _payWayCell;
                   [_payWayCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
          }
          else if (indexPath.row == 4)
          {
               cell = _aliPayCell;
                   [_aliPayCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
          }else
          {
               cell = _wxPayCell;
               [_wxPayCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
          }
     }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.section == 0) {
          SelectAddressViewController *vc = [SelectAddressViewController new];
          vc.canSelect = YES;
          [vc setHandleGoBack:^(NSDictionary *userData) {
               BUUserAddress   *adr = userData[@"address"];
//               _address = adr.address;
               _lat = adr.latitude;
               _lon = adr.longitude;

//               _cityName = adr.cityName;
               [_adrCell setCellData:@{@"title":[NSString stringWithFormat:@"%@ %@",adr.contacts,adr.tell],@"detail":adr.address?:@""}];
               [_adrCell fitReplacementConfirmMode];
          }];
          [self.navigationController pushViewController:vc animated:YES];
     }
     else
     if (indexPath.section == 1 && indexPath.row >= 4) {
          if (_checkIndexPath != indexPath) {
               IconAndTitleTableViewCell *cll = [tableView cellForRowAtIndexPath:_checkIndexPath];
               [cll fitPayMode:NO];
               IconAndTitleTableViewCell *cvv = [tableView cellForRowAtIndexPath:indexPath];
               [cvv fitPayMode:YES];
               _checkIndexPath = indexPath;
          }
     }
}

-(void)submit
{
     [self.view endEditing:YES];
     HUDSHOW(@"加载中");
     NSString *addrId = _addrId;
     NSString *courierId = @"";
     NSString *weight = @"0";
     NSString *payType = @"0";
     NSString *orderType = @"3";
     NSString *linkId = _secondHandGoods.goodsId?:@"";
     NSString *remark = @"";
     NSString *shopId = @"";
     NSString *integral = [NSString stringWithFormat:@"%ld",_jf];
     NSString *expressType = @"0";
     NSString *recyclingtype = @"";
     NSMutableArray *goodlist = [NSMutableArray new];
     NSString *presetTime = @"";
     [busiSystem.getOrderListManager orderAdd:presetTime withAddrid:addrId withCourierid:courierId withRecyclingtype:recyclingtype withWeight:weight withUserid:busiSystem.agent.userId withGoodslist:goodlist withPaytype:payType withOrdertype:orderType withShopid:shopId withIntegral:integral withExpresstype:expressType withLinkid:linkId withRemark:remark stationId:@"" expressFee:@"0" observer:self callback:@selector(orderAddNotification:)];
}

-(void)orderAddNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
//          [self.navigationController popViewControllerAnimated:YES];
//          ReplacementOrderInfoViewController *vc = [ReplacementOrderInfoViewController new];
//          //          vc.payType = weakSelf.checkIndexPath.row - 1;
//          //          vc.price = 112;
//          //          vc.mode = 1;
//          //          vc.title = @"支付成功";
//          vc.getOrder = busiSystem.getOrderListManager.getOrder;
//          [self.navigationController pushViewController:vc animated:YES];
          [self toFitNext];
          [busiSystem.agent getUserIndex];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}

-(void)toFitNext
{
     CGFloat cjf = busiSystem.agent.config.integralExchange * 1.0;
      CGFloat f = self.needPrice - self.jf/cjf;
     if (f != 0) {
          PayOrderViewController *vc = [PayOrderViewController new];
          vc.order = busiSystem.getOrderListManager.getOrder;
          [vc setHandleGoBack:^(id userData) {
               [[NSNotificationCenter defaultCenter] postNotificationName:@"refresSecHandData" object:nil];
          }];
          [self.navigationController pushViewController:vc animated:YES];
          busiSystem.agent.isNeedRefreshTabD = YES;
     }
     else
     {
           busiSystem.agent.isNeedRefreshTabD = YES;
          PaySuccessViewController *vc = [PaySuccessViewController new];
          [vc fitVIPCenterMode];
//          vc.order = busiSystem.getOrderListManager.getOrder;
          [self.navigationController pushViewController:vc animated:YES];
          [[NSNotificationCenter defaultCenter] postNotificationName:@"refresSecHandData" object:nil];
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
