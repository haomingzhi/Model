//
//  FillInOrderInfoViewController.m
//  oranllcshoping
//
//  Created by Steve on 2017/7/24.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "FillInOrderInfoViewController.h"
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
#import "PaySuccessViewController.h"
#import "TitleDetailTableViewCell.h"
#import "TitleAndTextfieldTableViewCell.h"
#import "SelecteCouponViewController.h"
#import "JYCommonTool.h"
#import "FindInfoViewController.h"

@interface FillInOrderInfoViewController (){
     ImgAndThreeTitleTableViewCell *_addressCell;
     OnlyTitleTableViewCell *_goodsTitleCell;
     ImgAndThreeTitleTableViewCell *_goodsInfoCell;
     TitleAndDetailAndImageTableViewCell *_selectCouponCell;
     TitleAndDetailAndImageTableViewCell *_startDateCell;
     TitleAndDetailAndImageTableViewCell *_endDateCell;
     TitleAndDetailAndImageTableViewCell *_deductionCell;
     TitleDetailTableViewCell *_sumPriceCell;
     TitleAndDetailAndImageTableViewCell *_freightCell;
     TitleAndDetailAndImageTableViewCell *_couponDeductionCell;
     TitleAndDetailAndImageTableViewCell *_deductionMoneyCell;
     TitleAndDetailAndImageTableViewCell *_activityMoneyCell;
     TitleAndDetailAndImageTableViewCell *_invoiceCell;
     OnlyTitleTableViewCell *_payStyleTitleCell;
     TitleAndDetailAndImageTableViewCell *_onlinePayCell;
     TitleAndDetailAndImageTableViewCell *_outlinePayCell;
     TitleAndDetailAndImageTableViewCell *_noAddressCell;
     TitleDetailTableViewCell *_deliveryTypeCell;
     TitleDetailTableViewCell *_rentDateCell;
     TitleDetailTableViewCell *_rentMoneyCell;
     TitleDetailTableViewCell *_insuranceMoneyCell;
     TitleDetailTableViewCell *_depositCell;
     TitleDetailTableViewCell *_noDepositCell;
     TitleDetailTableViewCell *_sumDepsitCell;
     TitleAndTextfieldTableViewCell *_remarkCell;
     TwoTabsTableViewCell *_integralCell;
     NSInteger _requestCount;
     UIView *_footerView;
     
}
@property (nonatomic,strong) UIButton *payBtn;//结算
@property (nonatomic,strong) UIButton *shareBtn;
@property (nonatomic,strong) UIButton *collectionBtn;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UILabel *sumPriceLb;
@property (nonatomic,strong) UILabel *depositLb;
@property (nonatomic,strong) UILabel *sumPriceTitleLb;
@property (nonatomic,assign) NSInteger payStyle;//0:在线支付 1:货到付款
@property (nonatomic,assign) BOOL isDeduction;//是否使用优币 yes:使用
@property (nonatomic,assign) CGFloat deductionMoney;//优币抵扣费用
@property (nonatomic,strong) BUUserAddress *address;
@property (nonatomic,strong) BUOrderCoupon *coupon;
@property (nonatomic,strong) BSJSON *json;//开票信息
@property (nonatomic,assign) BOOL isInvoice;
@property (nonatomic,assign) BOOL hasAddress;//是否有地址
@property (nonatomic,assign) NSInteger allJf;
@property (nonatomic,assign) NSInteger jf;
@property (nonatomic,assign) NSInteger expressType;//快递方式 1-同城快递，2-自取，3-跑腿师傅 ,
@property (nonatomic,assign) CGFloat expressPrice;//快递费用
//@property (nonatomic,strong) BUExpressFee *expressFee;
@property (nonatomic,assign) CGFloat payMoney;//付款金额
@property (nonatomic,assign) NSInteger integralScale;//积分比例 1元等于多少积分
@end

@implementation FillInOrderInfoViewController


- (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view from its nib.
       _sumPrice = _productPrice.leaseMoney*(float)_lease+_productPrice.insuranceMoney;

     [self initTableView];
     [self addBottomView];
     [self initNotificationCenter];
     self.title = @"确认订单";
//     _isDeduction = YES;
     HUDSHOW(@"加载中");
     [self getData];
     
}



-(void)initNotificationCenter{
     //监听键盘出现和消失
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
     CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
     //    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
     //     self.view.y = -keyBoardRect.size.height+64;
     _tableView.height = __SCREEN_SIZE.height - NAVBARHEIGHT- keyBoardRect.size.height;
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
     _tableView.height = __SCREEN_SIZE.height - NAVBARHEIGHT- 52;
}


- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

-(void)getData{
     [self getUserDefaultAddress];
     [self getPayMoney];
     [self getCouponList];
}


-(void)getCouponList
{
     _requestCount ++;
     [busiSystem.shopManager OrderCoupon:_goodsInfo.productId observer:self callback:@selector(getOrderCouponNotification:)];
}

-(void)getOrderCouponNotification:(BSNotification *)noti
{
     _requestCount --;
     if (_requestCount == 0) {
          HUDDISMISS
     }
     if (noti.error.code == 0) {
          NSMutableArray *arr = [NSMutableArray new];
          __block CGFloat f ;
          if (_goodsInfo.leaseType == 0) {//长租
               f = _productPrice.leaseMoney;
          }else{//短租
               f = _productPrice.leaseMoney * (CGFloat)_lease ;
          }
          
          [busiSystem.shopManager.couponList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUOrderCoupon *c = obj;
               if (c.threshold == 0 || c.threshold<= f) {
                    [arr addObject:c];
               }
          }];
          busiSystem.shopManager.couponList = [NSArray arrayWithArray:arr];
          if (arr.count == 0) {
               [_selectCouponCell setCellData:@{@"title":@"优惠券",@"detail":@"无可用优惠券"}];
               [_selectCouponCell fitFillInOrderMode];
          }else{
               [_selectCouponCell setCellData:@{@"title":@"优惠券",@"detail":[NSString stringWithFormat:@"%lu张可用",(unsigned long)arr.count]}];
               [_selectCouponCell fitFillInOrderMode];
          }
     }
     else
     {
          HUDCRY(noti.error.domain, 2);
          
     }
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
//          if (_integralScale == 0) {
//               _integralScale = 10;
//          }
          [self calculateSumPrice];
          
     }
     else
     {
          HUDCRY(noti.error.domain, 2);
           
     }
}

-(void)getPayMoney{
     _requestCount ++;
     NSString *lease = [NSString stringWithFormat:@"%ld",(long)_lease];
     [busiSystem.shopManager getPayMoney:_goodsInfo.productId couponId:_coupon.couponId?:@"" lease:lease costMoney:[NSString stringWithFormat:@"%.2f",_productPrice.costMoney] price:[NSString stringWithFormat:@"%.2f",_productPrice.leaseMoney] observer:self callback:@selector(getPayMoneyNotification:)];
}

-(void)getPayMoneyNotification:(BSNotification *)noti{
     
     _requestCount--;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     
     if (noti.error.code == 0) {
          _sumPrice = busiSystem.shopManager.getPayMoney.payMoney;
          _sumPriceLb.text = [NSString stringWithFormat:@"¥%.2f",_sumPrice];
          _depositLb.text = [NSString stringWithFormat:@"可退押金：¥%.2f",busiSystem.shopManager.getPayMoney.depositMoney];
          
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}

-(void)getUserDefaultAddress{
     _requestCount ++;
    [busiSystem.agent getUserAddress:busiSystem.agent.userId?:@"" observer:self callback:@selector(getUserDefaultAddressNotification:)];
}



-(void)getUserDefaultAddressNotification:(BSNotification *)noti{
     
     _requestCount--;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     if (noti.error.code == 0) {
          [busiSystem.agent.userAddresses enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUUserAddress *addr = obj;
               if (addr.isDefault) {
                    _address = addr;
                    *stop = YES;
               }
          }];
          if (_address == nil && busiSystem.agent.userAddresses.count !=0) {
               _address = busiSystem.agent.userAddresses.firstObject;
          }
          if (_address == nil) {
               [_addressCell fitNoAddressMode];
          }else{
               [_addressCell setCellData:[_address getDic:5]];
               [_addressCell fitOrderAddressMode];
          }
     }else{
         
          HUDCRY(noti.error.domain, 2);
     }
     
}


-(void)getExpressInfo{
     _requestCount ++;
     NSString *cityId = [NSString stringWithFormat:@"%ld",(long)busiSystem.agent.cityId];
//     [busiSystem.getOrderListManager getExpressInfo:cityId longitude:busiSystem.agent.log latitude:busiSystem.agent.lat shopId:_shopId observer:self callback:@selector(getExpressInfoNotification:)];
}

-(void)getExpressInfoNotification:(BSNotification *)noti{
     
     _requestCount--;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     
     if (noti.error.code == 0) {
//          _expressFee = busiSystem.getOrderListManager.expressFee;
//          if (_expressFee.expressState == 1) {
//               self.expressType = 1;
//               self.expressPrice = _expressFee.expressFee;
//               [_deliveryTypeCell setCellData:@{@"title":@"配送方式",@"detail":@"同城快递"}];
////               [_deliveryTypeCell fitFillInOrderMode];
//               [_addressCell setCellData:[_address getDic:5]];
//               [_addressCell fitOrderAddressMode];
//          }
//          else if (_expressFee.courierState == 1) {
//               self.expressType = 3;
//               self.expressPrice = _expressFee.courierFee;
//               [_deliveryTypeCell setCellData:@{@"title":@"配送方式",@"detail":@"跑腿师傅"}];
////               [_deliveryTypeCell fitFillInOrderMode];
//               [_addressCell setCellData:[_address getDic:5]];
//               [_addressCell fitOrderAddressMode];
//          }
//          else {
//               self.expressType = 2;
//               self.expressPrice = 0;
//               [_deliveryTypeCell setCellData:@{@"title":@"配送方式",@"detail":@"门店自提"}];
//               [_deliveryTypeCell fitFillInOrderMode];
//               NSString *titleStr = [NSString stringWithFormat:@"%@ %@",_shopName,_shopTell];
//               [_addressCell setCellData:@{@"title":titleStr,@"time":_shopAddress?:@""}];
//               [_addressCell fitOrderAddressMode];
//
//          }
//          [self calculateSumPrice];
     }else{
          HUDCRY(noti.error.domain, 2);
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
     UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, __SCREEN_SIZE.height - NAVBARHEIGHT - TABBARNONEHEIGHT-52, __SCREEN_SIZE.width, 52)];
//     bottomView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
//     bottomView.layer.borderWidth = 0.5;
     [self.view addSubview:bottomView];

     
     _sumPriceTitleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 45)];
     _sumPriceTitleLb.text =  _goodsInfo.leaseType !=0 ?@"需付款：":@"首期需付款：";
     _sumPriceTitleLb.textColor = kUIColorFromRGB(color_5);
     _sumPriceTitleLb.font = [UIFont systemFontOfSize:15.0];
     [_sumPriceTitleLb sizeToFit];
     _sumPriceTitleLb.height = 15;
     [bottomView addSubview:_sumPriceTitleLb];
     
     _sumPriceLb = [[UILabel alloc]initWithFrame:CGRectMake(_sumPriceTitleLb.x + _sumPriceTitleLb.width +2, 10, 100, 15)];
     _sumPriceLb.textColor = kUIColorFromRGB(color_0xf82D45);
     _sumPriceLb.font = [UIFont systemFontOfSize:15.0];
     _sumPriceLb.text = [NSString stringWithFormat:@"¥%.2f",_sumPrice];
     [bottomView addSubview:_sumPriceLb];
     
     
     _depositLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, 200, 12)];
     _depositLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     _depositLb.font = [UIFont systemFontOfSize:12.0];
     _depositLb.text = [NSString stringWithFormat:@"可退押金：¥%.2f",0.00];
     [bottomView addSubview:_depositLb];
     
     _payBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 180, 9, 165, 36)];
     _payBtn.backgroundColor = kUIColorFromRGB(color_0xf74056);
     [_payBtn setTitle:@"确认支付" forState:UIControlStateNormal];
     [_payBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     _payBtn.titleLabel.font = [UIFont systemFontOfSize:15];
     [_payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
     _payBtn.layer.cornerRadius = _payBtn.height/2.0;
     _payBtn.layer.shadowColor = kUIColorFromRGB(color_0xf74056).CGColor;
     _payBtn.layer.shadowOffset = CGSizeMake(0, 0);
     _payBtn.layer.shadowRadius = 8;
     _payBtn.layer.shadowOpacity = 0.43;
     [bottomView addSubview:_payBtn];
     
}

-(void)payAction{
     
//     PayOrderViewController *vc = [PayOrderViewController new];
//     [self.navigationController pushViewController:vc animated:YES];
//     return;
//     if (_payStyle == 0) {//在线支付
//          PayOrderViewController *vc = [PayOrderViewController new];
//          [self.navigationController pushViewController:vc animated:YES];
//     }else{
//
//     }
     
     if (_sumPrice <= 0.0) {
          HUDCRY(@"订单金额有误", 2);
          return;
     }
     
     if (_address == nil) {
          HUDCRY(@"请选择地址",2);
          return;
     }
     

     
     HUDSHOW(@"加载中");
     NSString *couponId = _coupon.couLogId?:@"";
     NSString *startDate = [JYCommonTool stringForDate:_startDate withDateFormat:@"yyyy-MM-dd"];
     NSString *endDate = [JYCommonTool stringForDate:_endDate withDateFormat:@"yyyy-MM-dd"];
     
     [busiSystem.shopManager submitOrder:_goodsInfo.productId receiveAddressId:_address.addressId productItemId:_productPrice.productItemId productItemPriceId:_productPrice.productItemPriceId couponLogId:couponId note:_remarkCell.textField.text defineStartTime:startDate defineEndTime:endDate observer:self callback:@selector(submitOrderNotification:)];
}



-(void)submitOrderNotification:(BSNotification *)noti{
     
     HUDDISMISS;
     
     if (noti.error.code == 0) {
          PayOrderViewController *vc = [PayOrderViewController new];
          vc.order = busiSystem.shopManager.submitOrder;
          NSDate *endDate = [JYCommonTool stringToDate:busiSystem.shopManager.submitOrder.endPayTime withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
          NSDate *startDate = [NSDate date];
          NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
          vc.mode = 1;
          vc.sec = (int)time%60;
          vc.min = (int)time/60;
          vc.isSubmitOrder = YES;
          vc.orderType = @"1";
          vc.typeId = busiSystem.shopManager.submitOrder.orderId;
          [self.navigationController pushViewController:vc animated:YES];
          
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}

//计算总价
-(void)calculateSumPrice{
     NSString *price = [NSString stringWithFormat:@"%.2f",_expressPrice];
     [_freightCell setCellData:@{@"title":@"配送费",@"detail":price}];
     [_freightCell fitFillInOrderModeB];
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
     
     
     __weak FillInOrderInfoViewController *weakSelf = self;
     
     _depositCell = [TitleDetailTableViewCell createTableViewCell];
     [_depositCell setCellData:@{@"title":@"押金",@"detail":[NSString stringWithFormat:@"¥%.2f",_productPrice.costMoney]}];
     [_depositCell fitFillOrderModeB];
     
     
     
     
     _sumDepsitCell = [TitleDetailTableViewCell createTableViewCell];
     CGFloat sumDepsit = _productPrice.costMoney - _goodsInfo.credit;
     if (sumDepsit <0) {
          sumDepsit = 0;
     }
     [_sumDepsitCell setCellData:@{@"title":@"合计押金",@"detail":[NSString stringWithFormat:@"¥%.2f元",sumDepsit]}];
     [_sumDepsitCell fitFillOrderModeA];
     

     _noDepositCell = [TitleDetailTableViewCell createTableViewCell];
     [_noDepositCell setCellData:@{@"title":@"免押金额度",@"detail":[NSString stringWithFormat:@"¥%.2f",sumDepsit==0?_productPrice.costMoney: _goodsInfo.credit]}];
     [_noDepositCell fitFillOrderModeC];
     
     _remarkCell = [TitleAndTextfieldTableViewCell createTableViewCell];
     [_remarkCell setCellData:@{@"title":@"备注：",@"placeholder":@"选填"}];
     [_remarkCell fitFillOrderMode];
     
      NSString *type = _goodsInfo.leaseType ==0 ?@"个月":@"天";
     
     BUImageRes *img = _goodsInfo.img?:[BUImageRes new];
     
     NSMutableArray *arr = [NSMutableArray arrayWithArray:_dataArr];
     if (_goodsInfo.priceType == 0 && arr.count>0) {//租期为选项
          arr = [NSMutableArray arrayWithArray:[_dataArr subarrayWithRange:NSMakeRange(0, _dataArr.count-1)]];
          NSInteger index = [_dataArr.lastObject integerValue];
          
          [arr addObject:[NSString stringWithFormat:@"%ld%@",(long)index,type]];
     }
     
     _goodsInfoCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
     NSDictionary *dic = @{@"title":_goodsInfo.name?:@"",@"source":[NSString stringWithFormat:@"商品价值：%.2f元",_productPrice.costMoney],@"time":@"",@"default":@"default",@"img":img,@"arr":arr};
     [_goodsInfoCell setCellData:dic];
     [_goodsInfoCell fitFillInOrderMode];
     
    
     
     _rentDateCell = [TitleDetailTableViewCell createTableViewCell];
     [_rentDateCell setCellData:@{@"title":@"租赁期数",@"detail":[NSString stringWithFormat:@"%ld%@",(long)_lease,type],@"rich":type}];
     [_rentDateCell fitFillOrderMode:23];
     
     NSString *rich = [NSString stringWithFormat:@"元/%@",_goodsInfo.leaseType ==0 ?@"月":@"天"];
     _rentMoneyCell = [TitleDetailTableViewCell createTableViewCell];
     [_rentMoneyCell setCellData:@{@"title":@"单期租金",@"detail":[NSString stringWithFormat:@"%.2f%@",_productPrice.leaseMoney,rich],@"rich":rich}];
     [_rentMoneyCell fitFillOrderMode:10];
     
     
     _insuranceMoneyCell = [TitleDetailTableViewCell createTableViewCell];
     [_insuranceMoneyCell setCellData:@{@"title":@"意外保险",@"detail":[NSString stringWithFormat:@"%.2f元",_productPrice.insuranceMoney],@"rich":@"元"}];
     [_insuranceMoneyCell fitFillOrderMode:10];
     
     _deliveryTypeCell = [TitleDetailTableViewCell createTableViewCell];
     [_deliveryTypeCell setCellData:@{@"title":@"配送方式",@"detail":@"单程包邮"}];
     [_deliveryTypeCell fitFillOrderMode:10];
     
     
     _noAddressCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_noAddressCell setCellData:@{@"img":@"icon_add_orange",@"title":@"选择地址",@"detail":@""}];
     [_noAddressCell fitFillInOrderModeD];
     
     _addressCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
     [_addressCell setCellData:@{@"title":@"",@"source":@"",@"time":@""}];
     [_addressCell fitOrderAddressMode];
     
     _goodsTitleCell = [OnlyTitleTableViewCell createTableViewCell];
     [_goodsTitleCell setCellData:@{@"title":@"商品信息"}];
     [_goodsTitleCell fitExamTicketMode];
     
     _payStyleTitleCell = [OnlyTitleTableViewCell createTableViewCell];
     [_payStyleTitleCell setCellData:@{@"title":@"支付方式"}];
     [_payStyleTitleCell fitUserCerMode];
     
     _selectCouponCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_selectCouponCell setCellData:@{@"title":@"优惠券",@"detail":@""}];
     [_selectCouponCell fitFillInOrderMode];
     
     
     _startDateCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_startDateCell setCellData:@{@"title":@"开始时间",@"detail":[JYCommonTool stringForDate:_startDate withDateFormat:@"yyyy-MM-dd"]}];
     [_startDateCell fitFillInOrderMode];
     
     _endDateCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_endDateCell setCellData:@{@"title":@"结束日期",@"detail":[JYCommonTool stringForDate:_endDate withDateFormat:@"yyyy-MM-dd"]}];
     [_endDateCell fitFillInOrderMode];
     
     _invoiceCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_invoiceCell setCellData:@{@"title":@"发票信息",@"detail":@"不开发票"}];
     [_invoiceCell fitFillInOrderMode];
     
     _deductionCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_deductionCell setCellData:@{@"title":@"优币抵扣",@"detail":@"使用200优币可抵扣¥2.00现金"}];
     [_deductionCell fitFillInOrderModeA:_isDeduction];
     
     CGFloat p ;
     if (_goodsInfo.leaseType == 0) {//长租
          //首期付款金额
          p = _coupon.price <_productPrice.leaseMoney+_productPrice.insuranceMoney ?_coupon.price:_productPrice.leaseMoney+_productPrice.insuranceMoney;
          _sumPrice =_productPrice.leaseMoney *(float)_lease+_productPrice.insuranceMoney- p;
     }else{//短租
          _sumPrice =_productPrice.leaseMoney *(float)_lease+_productPrice.insuranceMoney- _coupon.price;
     }
     
     if (_sumPrice<0) {
          _sumPrice = 0;
     }
     _sumPriceCell = [TitleDetailTableViewCell createTableViewCell];
     [_sumPriceCell setCellData:@{@"title":@"合计租金",@"detail":[NSString stringWithFormat:@"%.2f元",_sumPrice]}];
     [_sumPriceCell fitFillOrderModeA];
     
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
     
     
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.height = __SCREEN_SIZE.height - NAVBARHEIGHT- TABBARNONEHEIGHT  - 52;
     _tableView.x = 0;
     _tableView.y = 0;
     _tableView.refreshHeaderView = nil;
     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//     _tableView.backgroundColor = kUIColorFromRGB(color_0xf6f6f6);
     
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSInteger row = 1;
     if (section == 1) {
          row = 2;
     }else if (section == 2){
          row = _goodsInfo.priceType == 1?2:0;
     }else if (section == 3){
          row = 4;
     }else if (section == 4){
          row = 2;
     }else if (section == 5){
          row = 4;
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
               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }else{
               cell = _goodsInfoCell;
          }
     }
     else if (indexPath.section == 2){
          if (indexPath.row == 0) {
               cell = _startDateCell;
               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
          else if (indexPath.row == 1) {
               cell = _endDateCell;
//               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
          
     }
     else if (indexPath.section == 3){
          if (indexPath.row == 0) {
               cell = _rentDateCell;
          }else if (indexPath.row == 1) {
               cell = _rentMoneyCell;
          }
          else if (indexPath.row == 2) {
               cell = _insuranceMoneyCell;
          }else{
               cell = _deliveryTypeCell;
          }
          
     }
     else if (indexPath.section == 4){
          if (indexPath.row == 0) {
               cell = _selectCouponCell;
               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
          else if (indexPath.row == 1) {
               cell = _sumPriceCell;
               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
        
     }
     else if (indexPath.section == 5){
          if (indexPath.row == 0) {
               cell = _depositCell;
          }else if (indexPath.row == 1) {
               cell = _noDepositCell;
               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
          }
          else if (indexPath.row == 2) {
               cell = _sumDepsitCell;
               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
          else{
               cell = _remarkCell;
               
               
          }
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     if (section == 5) {
          return 70;
     }
     if (_goodsInfo.priceType == 0 && section == 2 ) {//非自定义
          return 0.001;
     }
     return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
     if (section == 5) {
          if (!_footerView) {
               _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 70)];
               _footerView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
               
               UILabel *lb = [UILabel new];
               lb.textColor = kUIColorFromRGB(color_0xb0b0b0);
               lb.text = @"点击确认支付代表同意";
               lb.font = [UIFont systemFontOfSize:13];
               lb.numberOfLines = 1;
               lb.x = 15;
               lb.y = 15;
               [lb sizeToFit];
               lb.height = 13;
               [_footerView addSubview:lb];
               
               UIButton *btn = [UIButton new];
               [btn setTitleColor:kUIColorFromRGB(color_0x48a3ff) forState:UIControlStateNormal];
               [btn setTitle:@"《用户租赁及服务协议》" forState:UIControlStateNormal];;
               btn.titleLabel.font = [UIFont systemFontOfSize:13];
               btn.x = lb.x+lb.width;
               btn.y = 15;
               [btn sizeToFit];
               btn.height = 13;
               [btn  addTarget:self action:@selector(showAgreement) forControlEvents:UIControlEventTouchUpInside];
               [_footerView addSubview:btn];
          }
          return _footerView;
     }
     return nil;
}

-(void)showAgreement{
     FindInfoViewController *vc = [FindInfoViewController new];
     vc.name = @"用户租赁及服务协议";
     vc.content = busiSystem.agent.config.leaseService?:@"";
     [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     CGFloat height = 40;
     if (indexPath.section == 0) {
          height = 85;
     }
     else if (indexPath.section == 1){
          if (indexPath.row == 0) {
               height = 45;
          }else{
               height = 136;
          }
     }
     
     else if (indexPath.section == 2){
          if (_goodsInfo.priceType == 1) {//自定义
               height = 45;
          }else{
               height = 0.001;
          }
     }
     
     else if (indexPath.section == 3){
          if (indexPath.row == 0) {
               height = 38;
          }else if (indexPath.row == 1) {
               height = 23;
          }
          else if (indexPath.row == 2) {
               height = 23;
          }else{
               height = 46;
          }
     }
     else if(indexPath.section == 4 ){
          height = 45;
     }
     else if (indexPath.section == 5){
          if (indexPath.row == 0) {
               height = 31;
          }else if (indexPath.row == 1) {
               height = 44;
          }else{
               height = 45;
          }
     }
     return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self.view endEditing:YES];
     if (indexPath.section == 0) {
          //选择地址
          ChoseAddressViewController *vc = [ChoseAddressViewController new];
          vc.address = _address;
          [self.navigationController pushViewController:vc animated:YES];
          [vc setHandleGoBack:^(NSDictionary *dic) {
               _hasAddress =  YES;
               _address = dic[@"address"];
               [_addressCell setCellData:[_address getDic:5]];
               [_addressCell fitOrderAddressMode];
               
          }];
     }
     else if (indexPath.section == 4 && indexPath.row == 0){
          if (busiSystem.shopManager.couponList.count == 0) {
               return;
          }
          SelecteCouponViewController *vc = [SelecteCouponViewController new];
          vc.coupon = _coupon;
          [self.navigationController pushViewController:vc animated:YES];
          [vc setHandleGoBack:^(NSDictionary *dic) {
               _coupon = dic[@"obj"];
               if (_coupon.couponId.length !=0 ) {
                    [_selectCouponCell setCellData:@{@"title":@"优惠券",@"detail":[NSString stringWithFormat:@"-¥%.2f",_coupon.price]}];
                    [_selectCouponCell fitFillInOrderMode];
                    
                   
               }else{
                    [_selectCouponCell setCellData:@{@"title":@"优惠券",@"detail":[NSString stringWithFormat:@"%lu张可用",(unsigned long)busiSystem.shopManager.couponList.count]}];
                    [_selectCouponCell fitFillInOrderMode];
                    
               }
               
               
               CGFloat p ;
               if (_goodsInfo.leaseType == 0) {//长租
                    //首期付款金额
                    p = _coupon.price <_productPrice.leaseMoney+_productPrice.insuranceMoney ?_coupon.price:_productPrice.leaseMoney+_productPrice.insuranceMoney;
                    _sumPrice =_productPrice.leaseMoney *(float)_lease+_productPrice.insuranceMoney- p;
               }else{//短租
                    _sumPrice =_productPrice.leaseMoney *(float)_lease+_productPrice.insuranceMoney- _coupon.price;
               }
               
               if (_sumPrice<0) {
                    _sumPrice = 0;
               }
               [_sumPriceCell setCellData:@{@"title":@"合计租金",@"detail":[NSString stringWithFormat:@"%.2f元",_sumPrice]}];
               [_sumPriceCell fitFillOrderModeA];
               
               HUDSHOW(@"加载中");
               [self getPayMoney];
          }];
     }
}

@end
