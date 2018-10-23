//
//  FillInOrderInfoViewController.m
//  oranllcshoping
//
//  Created by Steve on 2017/7/24.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "FillInServiceOrderInfoViewController.h"
#import "CartTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "TitleAndDetailAndImageTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "ChoseAddressViewController.h"
#import "InvoiceViewController.h"
#import "PayOrderViewController.h"
//#import "SelecteCouponViewController.h"
#import "SelectAddressViewController.h"
#import "BUSystem.h"
#import "TwoTabsTableViewCell.h"
#import "SingleSelectionViewController.h"
#import "TitleDetailTableViewCell.h"
#import "IconAndTitleTableViewCell.h"
#import "cart/PaySuccessViewController.h"
#import "JYDatePickViewController.h"

@interface FillInServiceOrderInfoViewController (){
     ImgAndThreeTitleTableViewCell *_addressCell;
     TitleDetailTableViewCell *_goodsTitleCell;
     TitleAndDetailAndImageTableViewCell *_selectCouponCell;
     TitleAndDetailAndImageTableViewCell *_deductionCell;
     TitleAndDetailAndImageTableViewCell *_sumPriceCell;
     TitleAndDetailAndImageTableViewCell *_freightCell;
     TitleAndDetailAndImageTableViewCell *_couponDeductionCell;
     TitleAndDetailAndImageTableViewCell *_deductionMoneyCell;
     TitleAndDetailAndImageTableViewCell *_activityMoneyCell;
     TitleAndDetailAndImageTableViewCell *_invoiceCell;
     OnlyTitleTableViewCell *_payStyleTitleCell;
     TitleAndDetailAndImageTableViewCell *_onlinePayCell;
     TitleAndDetailAndImageTableViewCell *_outlinePayCell;
     TitleAndDetailAndImageTableViewCell *_noAddressCell;
     TitleAndDetailAndImageTableViewCell *_deliveryTypeCell;
     IconAndTitleTableViewCell *_aliPayCell;
     IconAndTitleTableViewCell *_wxPayCell;
     TwoTabsTableViewCell *_integralCell;
     TitleAndDetailAndImageTableViewCell *_selectTimeCell;
     NSInteger _requestCount;
     
}
@property (nonatomic,strong) UIButton *payBtn;//结算
@property (nonatomic,strong) UIButton *shareBtn;
@property (nonatomic,strong) UIButton *collectionBtn;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UILabel *sumPriceLb;
@property (nonatomic,strong) UILabel *sumPriceTitleLb;
@property (nonatomic,assign) NSInteger payStyle;//1:支付宝 2:微信  3:积分
@property (nonatomic,assign) BOOL isDeduction;//是否使用优币 yes:使用
@property (nonatomic,assign) CGFloat deductionMoney;//优币抵扣费用
@property (nonatomic,strong) BUUserAddress *address;
//@property (nonatomic,strong) BUCoupon *coupon;
@property (nonatomic,strong) BSJSON *json;//开票信息
@property (nonatomic,assign) BOOL isInvoice;
@property (nonatomic,assign) BOOL hasAddress;//是否有地址
@property (nonatomic,assign) NSInteger allJf;
@property (nonatomic,assign) NSInteger jf;
@property (nonatomic,assign) NSInteger expressType;//快递方式 1-同城快递，2-自取，3-跑腿师傅 ,
@property (nonatomic,assign) CGFloat expressPrice;//快递费用
@property (nonatomic,strong) NSString *presetTime;//预约时间
@property (nonatomic,assign) NSInteger integralScale;
@property (nonatomic,assign) CGFloat  payMoney;//快递费用
@property (nonatomic,strong) BUGetOrder *order;
@end

@implementation FillInServiceOrderInfoViewController


- (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view from its nib.
     _sumPrice = _serviceInfo.price;
     _deductionMoney = 0.0;
     _integralCell = 0;
     _expressPrice = 0.0;
//     _integralScale =  busiSystem.agent.config.integralExchange;
     if (_integralScale == 0) {
          _integralScale = 10;
     }
     [self initTableView];
     [self addBottomView];
     self.title = @"服务订单确认";
//     _isDeduction = YES;
     HUDSHOW(@"加载中");
     [self getData];
     
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

-(void)getData{
     _requestCount ++;
     [busiSystem.agent getUserInfo:busiSystem.agent.userId observer:self callback:@selector(getUserInfoNotification:)];
     [self getUserDefaultAddress];
     [self getInfoConfig];
}


-(void)getInfoConfig
{
     _requestCount ++;
     [busiSystem.agent getInfoConfig:self callback:@selector(getInfoConfigNotification:)];
}

-(void)getInfoConfigNotification:(BSNotification *)noti
{
     _requestCount --;
     if (_requestCount == 0) {
          HUDDISMISS
     }
     if (noti.error.code == 0) {
//          _integralScale =  busiSystem.agent.config.integralExchange;
          if (_integralScale == 0) {
               _integralScale = 10;
          }
          [self calculateSumPrice];
          
     }
     else
     {
          HUDCRY(noti.error.domain, 2);
          
     }
}

-(void)getUserInfoNotification:(BSNotification *)noti{
     
     _requestCount--;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     
     if (noti.error.code == 0) {
          self.allJf = busiSystem.agent.userInfo.point;
          [self calculateSumPrice];
          
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}

-(void)getUserDefaultAddress{
     _requestCount ++;
     [busiSystem.agent getUserDefaultAddress:busiSystem.agent.userId observer:self callback:@selector(getUserDefaultAddressNotification:)];
}



-(void)getUserDefaultAddressNotification:(BSNotification *)noti{
     
     _requestCount--;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     if (noti.error.code == 0) {
          _address = busiSystem.agent.userDefaultAddress;
          [_addressCell setCellData:[_address getDic:5]];
          [_addressCell fitOrderAddressMode];
          _hasAddress = YES;
     }else{
          [_addressCell fitNoOrderAddressMode];
          _hasAddress = NO;
     }
     
}


-(void)getShoppingCartItemNotification:(BSNotification *)noti{
     
     _requestCount--;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     
     if (noti.error.code == 0) {
//          BUCartItem *c = busiSystem.orderManager.cartItem;
//          [_selectCouponCell setCellData:@{@"title":@"优惠券",@"detail":[NSString stringWithFormat:@"%ld张可用",(long)c.couponCount]}];
//          [_selectCouponCell fitFillInOrderMode];
//          NSString *sumPrice = [NSString stringWithFormat:@"¥%.2f",c.proPrice];
//          NSString *warn = [NSString stringWithFormat:@"会员价:¥%.2f",c.proVIPPrice];
//          [_sumPriceCell setCellData:@{@"title":@"商品合计",@"detail":sumPrice,@"warn":warn}];
//          [_sumPriceCell fitFillInOrderModeB];
//          if (c.distriMoney == 0) {
//               warn = @"免邮费";
//          }else
//               warn = [NSString stringWithFormat:@"满%.2f免邮费",c.distriMoney];
//          sumPrice = [NSString stringWithFormat:@"¥%.2f",c.shippingPrice];
//          [_freightCell setCellData:@{@"title":@"运费",@"detail":sumPrice,@"warn":warn}];
//          [_freightCell fitFillInOrderModeB];
//          warn = [NSString stringWithFormat:@"减%.2f元",c.actionPrice];
//          sumPrice = [NSString stringWithFormat:@"¥%.2f",c.actionPrice];
//          [_activityMoneyCell setCellData:@{@"title":@"活动优惠",@"detail":sumPrice,@"warn":warn}];
//          [_activityMoneyCell fitFillInOrderModeB];
//          _dataArr = [NSMutableArray arrayWithArray:c.outShoppingCartProductList];
//          [_tableView reloadData];
//          _sumPrice = c.proPrice - c.actionPrice+c.shippingPrice;
//          _sumPriceLb.text = [NSString stringWithFormat:@"¥%.2f",_sumPrice];
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}


-(void)addBottomView{
     UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, __SCREEN_SIZE.height - 64-45, __SCREEN_SIZE.width, 45)];
     bottomView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     bottomView.layer.borderWidth = 0.5;
     [self.view addSubview:bottomView];

     
     _sumPriceTitleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 45)];
     _sumPriceTitleLb.text = @"应付金额:";
     _sumPriceTitleLb.textColor = kUIColorFromRGB(color_1);
     _sumPriceTitleLb.font = [UIFont systemFontOfSize:15.0];
     [_sumPriceTitleLb sizeToFit];
     _sumPriceTitleLb.height = 45;
     [bottomView addSubview:_sumPriceTitleLb];
     
     _sumPriceLb = [[UILabel alloc]initWithFrame:CGRectMake(_sumPriceTitleLb.x + _sumPriceTitleLb.width +2, 0, 100, 45)];
     _sumPriceLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _sumPriceLb.font = [UIFont systemFontOfSize:15.0];
     _sumPriceLb.text = [NSString stringWithFormat:@"¥%.2f",_sumPrice];
     [bottomView addSubview:_sumPriceLb];
     
     _payBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 115, 0, 115, 45)];
     _payBtn.backgroundColor = kUIColorFromRGB(color_3);
     [_payBtn setTitle:@"去结算" forState:UIControlStateNormal];
     [_payBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     _payBtn.titleLabel.font = [UIFont systemFontOfSize:16];
     [_payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
     [bottomView addSubview:_payBtn];
     
}

-(void)payAction{
//     if (_payStyle == 0) {//在线支付
//          PayOrderViewController *vc = [PayOrderViewController new];
//          [self.navigationController pushViewController:vc animated:YES];
//     }else{
//
//     }
  
     
     if (_address == nil) {
          HUDCRY(@"请选择地址",2);
          return;
     }
     
     if (_presetTime == nil) {
          HUDCRY(@"请选择预约时间",2);
          return;
     }
    
//     NSMutableArray *arr = [NSMutableArray new];
//     [_dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//          BUCartGoods *g = obj;
//          BSJSON *j = [BSJSON new];
////          [j setObject:g.productId?:@"" forKey:@"productId"];
////          [ j setObject:@(g.quantity) forKey:@"quantity"];
//          [arr addObject:j];
//
//     }];
//
//     NSString *payPrice = [NSString stringWithFormat:@"%.2f",_sumPrice];
//     NSString *isInvoice = [NSString stringWithFormat:@"%.d",_isInvoice];
     
     NSString *payType= [NSString stringWithFormat:@"%ld",(long)_payStyle];
     CGFloat price;// = _payMoney;
     if (price == 0.0) {
          payType = @"3";
     }
     
     NSString *integral = [NSString stringWithFormat:@"%ld",(long)_jf];
     NSString *expressType = [NSString stringWithFormat:@"%ld",_expressType];
     NSMutableArray *arr = [NSMutableArray new];
     
     
     HUDSHOW(@"加载中");
//     [busiSystem.getOrderListManager orderAdd:@"" withAddrid:_address.addrId withCourierid:@"" withRecyclingtype:@"" withWeight:@"" withUserid:busiSystem.agent.userId?:@"" withGoodslist:arr withPaytype:payType withOrdertype:@"2" withShopid:@"" withIntegral:integral withExpresstype:expressType withLinkid:_serviceInfo.serviceId?:@"" withRemark:@"" stationId:@"" expressFee:@"0" observer:self callback:@selector(submitShoppingCartNotification:)];
}



-(void)submitShoppingCartNotification:(BSNotification *)noti{
     
     
     HUDDISMISS;
     if (noti.error.code == 0) {
          _order  = busiSystem.getOrderListManager.getOrder;
//          if (_order.money == 0.0) {
//
//               PaySuccessViewController *vc = [PaySuccessViewController new];
//               vc.payType = _order.payType;
//               vc.price = _order.money;
//               [self.navigationController pushViewController:vc animated:YES];
//          }else{
//               PayOrderViewController *vc = [PayOrderViewController new];
//               vc.order = _order;
//               [self.navigationController pushViewController:vc animated:YES];
////               [self orderPay:_order];
//
//          }

     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}




-(void)orderPay:(BUGetOrder *)order{
//     HUDSHOW(@"加载中");
      NSString *type = [NSString stringWithFormat:@"%ld",(long)_payStyle];
//     [busiSystem.payManager orderPay:type withOrderid:_order.orderID sourceType:@"1" orderType: _ typeId:<#(NSString *)#> observer:<#(id)#> callback:<#(SEL)#> observer:self  callback:@selector(orderPayNotification:) extraInfo:@{@"type":type?:@""}];
}



-(void)orderPayNotification:(BSNotification *)noti{
     
     HUDDISMISS;
     
     
     if (noti.error.code == 0) {
          NSInteger type = [noti.extraInfo[@"type"] integerValue];
          [[CommonAPI managerWithVC:self] toPay:@{@"payBody":busiSystem.payManager.order.payBody,@"method":@(type)} withBlock:^(NSDictionary *dic) {
               if([dic[@"code"] integerValue] == 0)
               {
                    _order = busiSystem.payManager.order;
                    PaySuccessViewController *vc = [PaySuccessViewController new];
                    vc.payType = _order.payType;
//                    vc.price = _order.money;
                    [self.navigationController pushViewController:vc animated:YES];
                    if (self.handleGoBack) {
                         self.handleGoBack(@{});
                    }
                    
               }
          }];
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}


//计算总价
-(void)calculateSumPrice{
//     NSString *price = [NSString stringWithFormat:@"%.2f",_expressPrice];
//     [_freightCell setCellData:@{@"title":@"配送费",@"detail":price}];
//     [_freightCell fitFillInOrderModeB];
     //积分计算
     CGFloat scale = (CGFloat)_integralScale;
     if (self.allJf >= _sumPrice*scale+_expressPrice*scale) {
          self.jf = _sumPrice*_integralScale+_expressPrice*_integralScale;
          if (_sumPrice+_expressPrice != (int)(_sumPrice+_expressPrice)) {
               self.jf ++;
          }
          _payMoney = 0.0;
     }else{
          self.jf = self.allJf;
          _payMoney = _sumPrice- self.jf/scale+_expressPrice;
          if (_payMoney<0) {
               _payMoney = 0.0;
          }
     }
     _sumPriceLb.text = [NSString stringWithFormat:@"¥%.2f",_payMoney];
     NSString *value = [NSString stringWithFormat:@"%ld",(long)_jf];
     NSString *str = [NSString stringWithFormat:@"积分抵扣(%ld积分=1元）",(long)_integralScale];
     [_integralCell setCellData:@{@"title":str,@"value":value,@"tab1":@"",@"tab2":@"",@"detail":[NSString stringWithFormat:@"可用积分%ld分",self.allJf]}];
     [_integralCell fitReplacementConfirmMode];
     [_tableView reloadData];
}






-(void)initTableView{
     
     
     
//     _integralCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
//     [_integralCell setCellData:@{@"title":@"积分抵扣(10积分=1元)",@"detail":@"可用积分60分"}];
//     [_integralCell fitFillInOrderModeE];
     
     
     __weak FillInServiceOrderInfoViewController *weakSelf = self;
     _integralCell = [TwoTabsTableViewCell createTableViewCell];
     [_integralCell setCellData:@{@"title":@"积分抵扣(10积分=1元）",@"value":@"0",@"tab1":@"",@"tab2":@"",@"detail":[NSString stringWithFormat:@"可用积分%ld分",self.allJf]}];
     [_integralCell fitReplacementConfirmMode];
     __weak TwoTabsTableViewCell *ssw = _integralCell;
     [_integralCell setTabOneCallBack:^(id o) {
          if (weakSelf.jf == 0) {
               HUDCRY(@"积分到达上限", 2);
               return ;
          }
          weakSelf.jf -= _integralScale;
          if (weakSelf.jf <0) {
               weakSelf.jf = 0;
          }
          NSString *str = [NSString stringWithFormat:@"积分抵扣(%ld积分=1元）",(long)_integralScale];
          [ssw setCellData:@{@"title":str,@"value":[NSString stringWithFormat:@"%ld",weakSelf.jf],@"tab1":@"",@"tab2":@"",@"detail":[NSString stringWithFormat:@"可用积分%ld分",weakSelf.allJf]}];
          [ssw fitReplacementConfirmMode];
          CGFloat scale= (CGFloat)_integralScale;
          _payMoney = weakSelf.sumPrice+weakSelf.expressPrice - weakSelf.jf/scale;
          if (_payMoney<0) {
               _payMoney = 0;
          }
          _sumPriceLb.text = [NSString stringWithFormat:@"¥%.2f",_payMoney];
     }];
     [_integralCell setTabTwoCallBack:^(id o) {
          CGFloat scale= (CGFloat)_integralScale;
          if(weakSelf.allJf <= weakSelf.jf || _payMoney <= 0 || weakSelf.allJf == 0 )
          {
               HUDCRY(@"积分到达上限", 2);
               return ;
          }
          if (weakSelf.jf + _integralScale <= weakSelf.sumPrice*scale+weakSelf.expressPrice*scale) {
               weakSelf.jf +=_integralScale;
               if (weakSelf.allJf < weakSelf.jf) {
                    weakSelf.jf = weakSelf.allJf;
               }
          }else{
               weakSelf.jf +=(weakSelf.sumPrice*scale+weakSelf.expressPrice*scale - weakSelf.jf);
               if (weakSelf.sumPrice+weakSelf.expressPrice- (int)(weakSelf.sumPrice+weakSelf.expressPrice)>0) {
                    weakSelf.jf ++;
               }
          }
          NSString *str = [NSString stringWithFormat:@"积分抵扣(%ld积分=1元）",(long)_integralScale];
          [ssw setCellData:@{@"title":str,@"value":[NSString stringWithFormat:@"%ld",weakSelf.jf],@"tab1":@"",@"tab2":@"",@"detail":[NSString stringWithFormat:@"可用积分%ld分",weakSelf.allJf]}];
          [ssw fitReplacementConfirmMode];
          _payMoney = weakSelf.sumPrice+weakSelf.expressPrice - weakSelf.jf/scale;
          if (_payMoney<0) {
               _payMoney = 0.0;
          }
          _sumPriceLb.text = [NSString stringWithFormat:@"¥%.2f",_payMoney];
          //          [weakSelf.submitCell setCellData:@{@"title":@"提交订单",@"detail":[NSString stringWithFormat:@"还需支付：￥%.2f",f]}];
          //          [weakSelf.submitCell fitReplacementConfirmMode];
     }];
     
     _deliveryTypeCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_deliveryTypeCell setCellData:@{@"title":@"配送方式",@"detail":@"同城配送"}];
     [_deliveryTypeCell fitFillInOrderMode];
     
     
     _noAddressCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_noAddressCell setCellData:@{@"img":@"icon_add_orange",@"title":@"选择地址",@"detail":@""}];
     [_noAddressCell fitFillInOrderModeD];
     
     _addressCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
     [_addressCell setCellData:@{@"title":@"",@"source":@"",@"time":@""}];
     [_addressCell fitOrderAddressMode];
     
     _goodsTitleCell = [TitleDetailTableViewCell createTableViewCell];
     [_goodsTitleCell setCellData:@{@"title":@"服务预约"}];
     [_goodsTitleCell fitShopInfoMode];
     
     _payStyleTitleCell = [OnlyTitleTableViewCell createTableViewCell];
     [_payStyleTitleCell setCellData:@{@"title":@"支付方式"}];
     [_payStyleTitleCell fitUserCerMode];
     
     _selectCouponCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_selectCouponCell setCellData:@{@"title":@"优惠券",@"detail":@"5张可用"}];
     [_selectCouponCell fitFillInOrderMode];
     
     
     _selectTimeCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_selectTimeCell setCellData:@{@"title":@"预约时间",@"detail":@"请选择时间"}];
     [_selectTimeCell fitFillInOrderMode];
     
     _invoiceCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_invoiceCell setCellData:@{@"title":@"发票信息",@"detail":@"不开发票"}];
     [_invoiceCell fitFillInOrderMode];
     
     _deductionCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_deductionCell setCellData:@{@"title":@"优币抵扣",@"detail":@"使用200优币可抵扣¥2.00现金"}];
     [_deductionCell fitFillInOrderModeA:_isDeduction];
     
     _sumPriceCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_sumPriceCell setCellData:@{@"title":@"商品合计",@"detail":[NSString stringWithFormat:@"¥%.2f",_sumPrice]}];
     [_sumPriceCell fitFillInOrderMode];
     
     _freightCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_freightCell setCellData:@{@"title":@"配送费",@"detail":@"¥0.00"}];
     [_freightCell fitFillInOrderModeB];
     
     _couponDeductionCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_couponDeductionCell setCellData:@{@"title":@"优惠券",@"detail":@"¥0.00"}];
     [_couponDeductionCell fitFillInOrderModeB];
     
      _deductionMoneyCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_deductionMoneyCell setCellData:@{@"title":@"优币抵扣",@"detail":@"¥0.00"}];
     [_deductionMoneyCell fitFillInOrderModeB];
     
     _activityMoneyCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_activityMoneyCell setCellData:@{@"title":@"活动优惠",@"detail":@"¥8.00",@"warn":@"APP首单减8元"}];
     [_activityMoneyCell fitFillInOrderModeB];
     
//      _onlinePayCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
//     [_onlinePayCell setCellData:@{@"title":@"在线支付",@"detail":@""}];
//     [_onlinePayCell fitFillInOrderModeC:_payStyle == 0];
//
//      _outlinePayCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
//     [_outlinePayCell setCellData:@{@"title":@"货到付款",@"detail":@"需付5元手续费，仅支持2000元以下订单"}];
//     [_outlinePayCell fitFillInOrderModeC:_payStyle == 1];
     
     
     
     _aliPayCell = [IconAndTitleTableViewCell createTableViewCell];
     [_aliPayCell setCellData:@{@"title":@"支付宝",@"img":@"aliPay"}];
     [_aliPayCell fitPayMode:YES];
     
     _wxPayCell = [IconAndTitleTableViewCell createTableViewCell];
     [_wxPayCell setCellData:@{@"title":@"微信支付",@"img":@"wxPay"}];
     [_wxPayCell fitPayMode:NO];
     
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.height = __SCREEN_SIZE.height - 64  -45;
     _tableView.x = 0;
     _tableView.y = 0;
     _tableView.refreshHeaderView = nil;
//     _tableView.backgroundColor = kUIColorFromRGB(color_0xf6f6f6);
     
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSInteger row = 1;
     if (section == 1) {
          row = 4;
     }else if (section == 2){
          row = 1;
     }
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell;
     if (indexPath.section == 0) {
          
//          if (!_hasAddress) {
//               cell = _noAddressCell;
//          }else
          cell = _addressCell;
     }
     else if (indexPath.section == 1){
          if (indexPath.row == 0) {
               cell = _goodsTitleCell;
          }else if(indexPath.row == 1){
               cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
               [(ImgAndThreeTitleTableViewCell *)cell setCellData:[_serviceInfo getDic:4]];
               [(ImgAndThreeTitleTableViewCell *)cell fitFillInServiceOrderMode];
          }
          else if (indexPath.row == 2) {
               cell = _sumPriceCell;
          }
          else if (indexPath.row == 3) {
               cell = _selectTimeCell;
          }
     }
     else if (indexPath.section == 2){
          if (indexPath.row == 0) {
               cell = _integralCell;
          }
          else if (indexPath.row == 1) {
               cell = _payStyleTitleCell;
          }else if (indexPath.row == 2) {
               cell = _aliPayCell;
          }else{
               cell = _wxPayCell;
               
          }
          
     }
//     else if (indexPath.section == 3){
//          if (indexPath.row == 0) {
//               cell = _deliveryTypeCell;
//          }
//          else if (indexPath.row == 1) {
//               cell = _freightCell;
//          }
//          else if (indexPath.row == 2) {
//               cell = _integralCell;
//          }
////          else if (indexPath.row == 3) {
////               cell = _deductionMoneyCell;
////          }
//          else{
//               cell = _activityMoneyCell;
//
//          }
//     }else if (indexPath.section == 4){
//          cell = _invoiceCell;
//     }else if (indexPath.section == 5){
//          if (indexPath.row == 0) {
//               cell = _payStyleTitleCell;
//          }else if (indexPath.row == 1) {
//               cell = _onlinePayCell;
//          }else{
//               cell = _outlinePayCell;
//
//          }
//     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     CGFloat height = 40;
     if (indexPath.section == 0) {
//          if (!_hasAddress) {
//               height = 45;
//          }else
               height = 85;
     }else if (indexPath.section == 1){
          if (indexPath.row == 0) {
               height = 40;
          }else if (indexPath.row == 1){
               height = 106;
          }else{
               height = 40;
          }
     }else if(indexPath.section == 2){
          if (indexPath.row == 0) {
               height = _integralCell.height;
          }else{
               height = 40;
          }
          
     }
     return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     if (indexPath.section == 0) {
          //选择地址
          SelectAddressViewController *vc = [SelectAddressViewController new];
          
          vc.canSelect = YES;
          [self.navigationController pushViewController:vc animated:YES];
          [vc setHandleGoBack:^(NSDictionary *dic) {
               _hasAddress =  YES;
               _address = dic[@"address"];
               [_addressCell setCellData:[_address getDic:5]];
               [_addressCell fitOrderAddressMode];
          }];
     }
     else if (indexPath.section == 1){
          if (indexPath.row == 3) {
               JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
               [vc fitDateTimeMode];
               [vc setCallBack:^(NSDate *date) {
                    NSString *bt =  [BSUtility getDateTimeWithFormat:date Format:@"yyyy-MM-dd HH:mm"];
                    _presetTime = bt;
                    [_selectTimeCell setCellData:@{@"title":@"预约时间",@"detail":bt}];
                    [_selectTimeCell fitFillInOrderMode];
               }];
          }
     }
     else if (indexPath.section == 2 ){
          if (indexPath.row == 2) {
               [_wxPayCell fitPayMode:NO];
               [_aliPayCell fitPayMode:YES];
               _payStyle = 1;
          }else if (indexPath.row == 3){
               [_wxPayCell fitPayMode:YES];
               [_aliPayCell fitPayMode:NO];
               _payStyle = 2;
          }
     }
}

@end
