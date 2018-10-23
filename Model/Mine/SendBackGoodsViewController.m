//
//  SendBackGoodsViewController.m
//  rentingshop
//
//  Created by air on 2018/3/27.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "SendBackGoodsViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"

@interface SendBackGoodsViewController ()
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
@property(nonatomic,strong) TitleDetailTableViewCell *goodsTotalCell;
@property(nonatomic,strong) TitleDetailTableViewCell *carriageCell;
@property(nonatomic,strong) TitleDetailTableViewCell *couponCell;
@property(nonatomic,strong) TitleDetailTableViewCell *youbiDiscountCell;
@property(nonatomic,strong) TitleDetailTableViewCell *actDiscountCell;
@property(nonatomic,strong) OnlyTitleTableViewCell *orderTipCell;
@property(nonatomic,strong) TitleDetailTableViewCell *billTypeCell;
@property(nonatomic,strong) TitleDetailTableViewCell *billriseCell;
@property(nonatomic,strong) TitleDetailTableViewCell *billContentCell;

@property(nonatomic,strong) TitleDetailTableViewCell *orderChaoQiCell;
@property(nonatomic,strong) TitleDetailTableViewCell *chaoQiJinerCell;
@property(nonatomic,strong) TitleDetailTableViewCell *yaJinCell;

@property(nonatomic,strong) OnlyTitleTableViewCell *wuliuTipCell;
@property(nonatomic,strong) TitleDetailTableViewCell *wuliuNameCell;
@property(nonatomic,strong) TitleDetailTableViewCell *wuliuNOCell;
@property(nonatomic,strong)OnlyBottomBtnTableViewCell *submitCell;
@end

@implementation SendBackGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"退还商品";
     [self initTableView];
     [self addBottomView];
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)getData
{
     [busiSystem.myPathManager refund:_orderDetail.orderID withUserid:busiSystem.agent.userId observer:self callback:@selector(refundNotification:)];
}

-(void)refundNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
         BURefund *r = busiSystem.myPathManager.refund;
          _orderDetail = [BUOrderDetail new];
          _orderDetail.othInfo = [BUOthInfo new];
          self.orderDetail.leaseinfo = [BULeaseinfo new];
          _orderDetail.othInfo.orderNO = r.leasInfo.orderNO;
          self.orderDetail.orderID = r.orderId;
          self.orderDetail.othInfo.createTime = r.leasInfo.createTime;
          self.orderDetail.othInfo.leaseBeginTime = r.leasInfo.leaseBeginTime;
          self.orderDetail.othInfo.leaseEndTime = r.leasInfo.leaseEndTime;
          self.orderDetail.othInfo.payType = r.leasInfo.payType;
          self.orderDetail.othInfo.payMoney = [NSString stringWithFormat:@"%.2f",r.leasInfo.payMoney];
          self.orderDetail.othInfo.payTime = r.leasInfo.payTime;
          self.orderDetail.isChao = r.leasInfo.chaoday;
          self.orderDetail.leaseType = r.leasInfo.leaseType;
          self.orderDetail.othInfo.chaoMoney = [NSString stringWithFormat:@"%.2f",r.leasInfo.chaoMoney];
          self.orderDetail.leaseinfo.depositMoney = r.depositMoney;
          [_goodsTotalCell  setCellData:@{@"title":@"订单编号:",@"detail":self.orderDetail.othInfo.orderNO?:@""}];
          [_goodsTotalCell fitSendBackGoodsModeA];
          [_carriageCell  setCellData:@{@"title":@"提交时间:",@"detail":self.orderDetail.othInfo.createTime?:@""}];
          [_carriageCell fitSendBackGoodsMode];

          [_couponCell  setCellData:@{@"title":@"起租时间:",@"detail":self.orderDetail.othInfo.leaseBeginTime?:@"收货后第二天开始计算"}];
          [_couponCell fitSendBackGoodsMode];

          [_youbiDiscountCell  setCellData:@{@"title":@"到期时间:",@"detail":self.orderDetail.othInfo.leaseEndTime?:@"按租期时间计算"}];
          [_youbiDiscountCell fitSendBackGoodsMode];
          NSString *py = @"未支付";
          if (self.orderDetail.othInfo.payType == 1) {
               py = @"支付宝支付";
          }
          else if (self.orderDetail.othInfo.payType == 2)
          {
               py = @"微信支付";
          }
          [_actDiscountCell  setCellData:@{@"title":@"支付方式:",@"detail":py?:@""}];
          [_actDiscountCell fitSendBackGoodsMode];


          [_billTypeCell  setCellData:@{@"title":@"实付金额:",@"detail":[NSString stringWithFormat:@"¥%@",self.orderDetail.othInfo.payMoney]}];
          [_billTypeCell fitSendBackGoodsMode];

          [_billriseCell  setCellData:@{@"title":@"付款时间:",@"detail":[NSString stringWithFormat:@"%@",self.orderDetail.othInfo.payTime]}];
          [_billriseCell fitSendBackGoodsModeB];


          NSString *qi = @"天";
//          if (self.orderDetail.leaseType == 0) {
//               qi = @"月";
//          }
          [_orderChaoQiCell setCellData:@{@"title":@"订单超期",@"detail":[NSString stringWithFormat:@"%ld%@",self.orderDetail.isChao,qi]}];
          [_orderChaoQiCell fitSendBackGoodsModeO:qi withY:14];


          [_chaoQiJinerCell setCellData:@{@"title":@"超期金额",@"detail":[NSString stringWithFormat:@"%@元",self.orderDetail.othInfo.chaoMoney?:@"0"]}];
          [_chaoQiJinerCell fitSendBackGoodsModeO:@"元" withY:10];


          [_yaJinCell setCellData:@{@"title":@"可退押金押金",@"detail":[NSString stringWithFormat:@"￥%@",self.orderDetail.leaseinfo.depositMoney?:@"0"]}];
          [_yaJinCell fitSendBackGoodsModeO2];
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

-(void)initTableView
{
     __weak SendBackGoodsViewController *weakSelf = self;
     self.tableView.refreshHeaderView = nil;
 _orderTipCell = [OnlyTitleTableViewCell createTableViewCell];
     _goodsTotalCell = [TitleDetailTableViewCell createTableViewCell];

     _carriageCell = [TitleDetailTableViewCell createTableViewCell];

     _couponCell = [TitleDetailTableViewCell createTableViewCell];

     _youbiDiscountCell = [TitleDetailTableViewCell createTableViewCell];

     _actDiscountCell = [TitleDetailTableViewCell createTableViewCell];

     _billTypeCell = [TitleDetailTableViewCell createTableViewCell];

     _billriseCell = [TitleDetailTableViewCell createTableViewCell];

     _billContentCell = [TitleDetailTableViewCell createTableViewCell];
     
     [_orderTipCell  setCellData:@{@"title":@"租赁信息"}];
     [_orderTipCell fitSendBackGoodsMode];

//     [_goodsTotalCell  setCellData:@{@"title":@"租赁期数",@"detail":@"30天"}];
//     [_goodsTotalCell fitSendBackGoodsMode];
//
//     [_carriageCell  setCellData:@{@"title":@"提交时间:",@"detail":@"2017-05-01 16:00"}];
//     [_carriageCell fitSendBackGoodsMode];
//
//     [_couponCell  setCellData:@{@"title":@"起租时间",@"detail":@"收货后第二天开始计算"}];
//     [_couponCell fitSendBackGoodsMode];
//
//     [_youbiDiscountCell  setCellData:@{@"title":@"到期时间:",@"detail":@"按租期时间计算"}];
//     [_youbiDiscountCell fitSendBackGoodsMode];
//
//     [_actDiscountCell  setCellData:@{@"title":@"支付方式:",@"detail":@"在线支付/微信支付"}];
//     [_actDiscountCell fitSendBackGoodsMode];
//
//     [_billTypeCell  setCellData:@{@"title":@"实付金额:",@"detail":@"￥2000.00"}];
//     [_billTypeCell fitSendBackGoodsMode];
//     [_billriseCell  setCellData:@{@"title":@"付款时间:",@"detail":@"2017-05-01 16:01"}];
//     [_billriseCell fitSendBackGoodsMode];

     [_goodsTotalCell  setCellData:@{@"title":@"订单编号:",@"detail":self.orderDetail.othInfo.orderNO?:@""}];
     [_goodsTotalCell fitSendBackGoodsModeA];
     [_carriageCell  setCellData:@{@"title":@"提交时间:",@"detail":self.orderDetail.othInfo.createTime?:@""}];
     [_carriageCell fitSendBackGoodsMode];

     [_couponCell  setCellData:@{@"title":@"起租时间:",@"detail":self.orderDetail.othInfo.leaseBeginTime?:@"收货后第二天开始计算"}];
     [_couponCell fitSendBackGoodsMode];

     [_youbiDiscountCell  setCellData:@{@"title":@"到期时间:",@"detail":self.orderDetail.othInfo.leaseEndTime?:@"按租期时间计算"}];
     [_youbiDiscountCell fitSendBackGoodsMode];
     NSString *py = @"未支付";
     if (self.orderDetail.othInfo.payType == 1) {
          py = @"支付宝支付";
     }
     else if (self.orderDetail.othInfo.payType == 2)
     {
          py = @"微信支付";
     }
     [_actDiscountCell  setCellData:@{@"title":@"支付方式:",@"detail":py?:@""}];
     [_actDiscountCell fitSendBackGoodsMode];


     [_billTypeCell  setCellData:@{@"title":@"实付金额:",@"detail":[NSString stringWithFormat:@"¥%@",self.orderDetail.othInfo.payMoney]}];
     [_billTypeCell fitSendBackGoodsMode];

     [_billriseCell  setCellData:@{@"title":@"付款时间:",@"detail":[NSString stringWithFormat:@"%@",self.orderDetail.othInfo.payTime]}];
     [_billriseCell fitSendBackGoodsModeB];

     _orderChaoQiCell = [TitleDetailTableViewCell createTableViewCell];
     NSString *qi = @"天";
     if (self.orderDetail.leaseType == 0) {
          qi = @"月";
     }
     [_orderChaoQiCell setCellData:@{@"title":@"订单超期",@"detail":[NSString stringWithFormat:@"%ld%@",self.orderDetail.isChao,qi]}];
     [_orderChaoQiCell fitSendBackGoodsModeO:qi withY:14];

     _chaoQiJinerCell = [TitleDetailTableViewCell createTableViewCell];
      [_chaoQiJinerCell setCellData:@{@"title":@"超期金额",@"detail":[NSString stringWithFormat:@"%@元",self.orderDetail.othInfo.chaoMoney?:@"0"]}];
  [_chaoQiJinerCell fitSendBackGoodsModeO:@"元" withY:10];

     _yaJinCell = [TitleDetailTableViewCell createTableViewCell];
     [_yaJinCell setCellData:@{@"title":@"可退押金押金",@"detail":[NSString stringWithFormat:@"￥%@",self.orderDetail.leaseinfo.depositMoney?:@"0"]}];
     [_yaJinCell fitSendBackGoodsModeO2];
     _wuliuTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_wuliuTipCell setCellData:@{@"title":@"物流信息"}];
     [_wuliuTipCell fitSendBackGoodsModeB];

     _wuliuNameCell = [TitleDetailTableViewCell createTableViewCell];
     [_wuliuNameCell setCellData:@{@"title":@"物流名称",@"placeholder":@"请输入物流公司"}];
     [_wuliuNameCell fitSendBackGoodsModeW];
      [_wuliuNameCell getTextTf].kbMovingView = self.view;

     _wuliuNOCell = [TitleDetailTableViewCell createTableViewCell];
     [_wuliuNOCell setCellData:@{@"title":@"物流单号",@"placeholder":@"请输入物流单号"}];
     [_wuliuNOCell fitSendBackGoodsModeW];

     [_wuliuNOCell getTextTf].kbMovingView = self.view;
     _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
//     _submitCell.width = __SCREEN_SIZE.width;
//     _submitCell.y = __SCREEN_SIZE.height - NAVBARHEIGHT - 44;
     [_submitCell setCellData:@{@"title":@"确认归还"}];


     //     _submitCell.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     //     _submitCell.layer.borderWidth = 0.5;

     [_submitCell fitSendBackGoodsMode];
     [_submitCell setHandleAction:^(id sender) {
          [weakSelf submit];
     }];
}

-(void)addBottomView
{
     _submitCell.width = __SCREEN_SIZE.width;
     _submitCell.y = __SCREEN_SIZE.height - NAVBARHEIGHT - _submitCell.height;
     [self.view addSubview:_submitCell];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return  3;
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
          return 10;
     }
     if (section == 2) {
          return 70;
     }
     return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 44;
     if(indexPath.section == 0) {
          if (indexPath.row == 0) {
               height = 36;
          }
          else if (indexPath.row == 1)
          {
               height = 36;
          }
          else if (indexPath.row == 7)
          {
               height = 46;
          }
          else
          {
               height = 26;
          }

     }
     else if (indexPath.section == 1)
     {
           if (indexPath.row == 0)
          {
               height = 27;
          }
          else if (indexPath.row == 1)
          {
               height = 24;
          }

          else
          {
               height = 36;
          }
     }
     else
     {
          if (indexPath.row == 3) {
               height = 100;
          }
          else
          {
               height = 46;
          }
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 1;
     switch (section) {
          case 0:
               row = 8;
               break;
          case 1:
               row = 3;
               break;
          case 2:
               row = 3;
               break;
          default:
               break;
     }
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if(indexPath.section == 0) {
          if (indexPath.row == 0) {
               cell = self.orderTipCell;
               [self.orderTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
          }

          else
               if (indexPath.row == 4) {
                    cell = self.youbiDiscountCell;

               }
               else if(indexPath.row == 1)
               {
                    cell = self.goodsTotalCell;

               }
               else if(indexPath.row == 2)
               {
                    cell = self.carriageCell;
               }
               else  if(indexPath.row == 3)
               {
                    cell = self.couponCell;
               }

               else  if(indexPath.row == 5)
               {
                    cell = self.actDiscountCell;
               }
               else  if(indexPath.row == 6)
               {
                    cell = self.billTypeCell;
               }
               else  if(indexPath.row == 7)
               {
                    cell = self.billriseCell;
//                    [self.billriseCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
               }


     }
     else if(indexPath.section == 1)
     {
          if(indexPath.row == 0)
          {
               cell = self.orderChaoQiCell;

          }
          else  if(indexPath.row == 1)
          {
               cell = self.chaoQiJinerCell;

          }

          else
          {
               cell = self.yaJinCell;
               //                    [self.yaJinCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
     }
     else
     {
        if(indexPath.row == 0)
        {
             cell = _wuliuTipCell;
//             [self.wuliuTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
        }
        else if (indexPath.row == 1)
        {
             cell = _wuliuNameCell;
             [self.wuliuNameCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
        }
        else if (indexPath.row == 2)
        {
             cell = _wuliuNOCell;
//             [self.wuliuNOCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
        }
        else
        {
             cell  = _submitCell;
        }
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)submit
{
     if ([_wuliuNameCell getTextTf].text.length == 0) {
          HUDCRY(@"请输入物流名称", 1);
          return;
     }
     if ([_wuliuNOCell getTextTf].text.length == 0) {
          HUDCRY(@"请输入物流单号", 1);
          return;
     }
     HUDSHOW(@"加载中");
     [busiSystem.myPathManager rrfundPath:[_wuliuNOCell getTextTf].text withUserid:busiSystem.agent.userId?:@"" withOrderid:_orderDetail.orderID withBacklogisticscompany:[_wuliuNameCell getTextTf].text observer:self callback:@selector(rrfundPathNotification:)];
}

-(void)rrfundPathNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
           [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshOrderListData" object:nil];
          UIViewController *vc = self.navigationController.viewControllers[1];
          [self.navigationController popToViewController:vc animated:YES];

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

@end
