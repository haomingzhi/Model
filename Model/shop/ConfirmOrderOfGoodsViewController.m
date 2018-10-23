//
//  ConfirmOrderOfGoodsViewController.m
//  compassionpark
//
//  Created by Steve on 2017/2/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ConfirmOrderOfGoodsViewController.h"
#import "TitleAndSwichTableViewCell.h"
#import "IconTitleAndImgTableViewCell.h"
#import "TitleAndTextfieldTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "PaySuccessViewController.h"
#import "TitleAndDetailAndImageTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "ChoseAddressViewController.h"
#import "InputPassViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "FiveTitleTableViewCell.h"
#import "MyActionViewController.h"
#import "SelectAddressViewController.h"
#import "ForgetPwdViewController.h"
//#import "PayPwdViewController.h"
#import "SnsCheckViewController.h"
//#import "UserCarToRechargeViewController.h"

@interface ConfirmOrderOfGoodsViewController ()<UIActionSheetDelegate>{
    
    TitleAndDetailAndImageTableViewCell *_distributionCell;
    OnlyBottomBtnTableViewCell *_integralCell;
    TitleAndTextfieldTableViewCell *_remarkCell;
    TitleDetailTableViewCell *_sumPriceCell;
    ImgAndThreeTitleTableViewCell *_productInfoCell;
    OnlyTitleTableViewCell *_goodsTitleCell;
    OnlyTitleTableViewCell *_addressTitleCell;
    ImgAndThreeTitleTableViewCell *_addressCell;
    TitleAndDetailAndImageTableViewCell *_exchangeStyleCell;
    NSInteger _state;//0:收货地址 1:自提点地址
    TitleAndTextfieldTableViewCell *_takeSelfPersonCell;
    TitleAndTextfieldTableViewCell *_takeSelfTellCell;
    FiveTitleTableViewCell *_balanceCell;//余额使用
    NSInteger _requestCount;
    BOOL _needReloadData;
}

@property (nonatomic,assign) BOOL isUseIntegral;
@property (nonatomic,assign) CGFloat integral;
@property (nonatomic,assign) CGFloat sumPrice;
@property (nonatomic,strong) UILabel *priceLb;
@property (nonatomic,strong) BUUserAddress *address;//收货地址
@property (nonatomic,strong) BUUserAddress *takeSelfAddress;//自提地址
@end

@implementation ConfirmOrderOfGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"确认订单";
//    _sumPrice = _goods.sellPrice*_num;
    [self initNotificationCenter];
    [self initTableView];
    [self initBottomView];
     HUDSHOW(@"加载中");
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    if (_needReloadData) {
        _needReloadData = NO;
        HUDSHOW(@"加载中");
        [self getData];
    }
}


-(void)getData{
    _requestCount++;
    NSString *num = [NSString stringWithFormat:@"%ld",(long)_num];
//    [busiSystem.getCardTypeListManager getIntegralInfo:_goods.goodsId withType:@"1" withNum:num
//                                              observer:self callback:@selector(getIntegralInfoNotification:) extraInfo:nil];
    [self getAddress];
    
}




-(void)getIntegralInfoNotification:(BSNotification *)noti
{
    _requestCount--;
    if (_requestCount == 0) {
        BASENOTIFICATION(noti);
    }
    else
    {
        BASENOTIFICATIONWITHCANMISS(noti, NO);
    }
    if (noti.error.code == 0) {
//        HUDDISMISS;
//        _integral = busiSystem.getCardTypeListManager.money;
//        NSString * integral = [NSString stringWithFormat:@"%ld",(long)busiSystem.getCardTypeListManager.integral];
//        NSString * money = [NSString stringWithFormat:@"%.2f",busiSystem.getCardTypeListManager.money];
//        [_integralCell setCellData:@{@"integral":integral,@"money":money}];
//        [_integralCell fitConfirmOrderMode];
    }
    else
    {
        _integral = 0;
        [_integralCell setCellData:@{@"integral":@"0",@"money":@"0"}];
        [_integralCell fitConfirmOrderMode];
        HUDCRY( noti.error.domain , 1);
    }
}


-(void)getAddress{
   
    _requestCount++;
    [busiSystem.agent getUserAddress:busiSystem.agent.userId observer:self callback:@selector(getUserAddressNotification:)];
}

-(void)getUserAddressNotification:(BSNotification *)noti
{
    _requestCount--;
    if (_requestCount == 0) {
        BASENOTIFICATION(noti);
    }
    else
    {
        BASENOTIFICATIONWITHCANMISS(noti, NO);
    }
    if (noti.error.code == 0) {
        //        HUDDISMISS;
        
        if (busiSystem.agent.userAddresses.count !=0) {
            for (BUUserAddress *a  in busiSystem.agent.userAddresses) {
                if (a.isDefault == 1) {
                    _address = a;
                }
            }
            if (!_address) {
                _address = [busiSystem.agent.userAddresses firstObject];
            }
            
            [_addressCell setCellData:[_address getDic:1]];
            [_addressCell fitAddressMode];


        }else{
            [_addressCell fitNoAddressMode];
        }
    }
    else
    {
        HUDCRY( noti.error.domain , 1);
    }
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
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    self.tableView.contentInset = UIEdgeInsetsZero;
}

-(void)initBottomView{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 125, __SCREEN_SIZE.height - 48-64, 125, 48)];
    [btn setTitle:@"确认兑换" forState:UIControlStateNormal];
    [btn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    btn.backgroundColor = kUIColorFromRGB(color_3);
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.layer.borderWidth = 0.5;
    btn.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    [btn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, btn.y, btn.x+0.5, btn.height)];
    view.backgroundColor = kUIColorFromRGB(color_4);
    view.layer.borderColor = kUIColorFromRGB(color_3).CGColor;
    view.layer.borderWidth = 0.5;
    [self.view addSubview:view];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 65, btn.height)];
    title.text = @"需礼品卡支付";
    title.font = [UIFont systemFontOfSize:16];
    [title sizeToFit];
    title.height = btn.height;
    title.textColor = kUIColorFromRGB(color_1);
    [view addSubview:title];
    
    _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(title.x+title.width+4, 0, 100, btn.height)];
    _priceLb.text = [NSString stringWithFormat:@"¥%.2f",_sumPrice];
    _priceLb.font = [UIFont systemFontOfSize:16];
    _priceLb.textColor = kUIColorFromRGB(color_3);
    [view addSubview:_priceLb];

}

-(void)payAction:(UIButton *)sender{
    if (_state == 1) {//自提
        if (_takeSelfAddress == nil) {
            TOASTSHOW(@"请选择自提地址");
            return;
        }
        
        if (_takeSelfPersonCell.textField.text.length == 0) {
            TOASTSHOW(@"请填写自提人姓名");
            return;
        }
        if (_takeSelfTellCell.textField.text.length == 0) {
            TOASTSHOW(@"请填写自提人联系电话");
            return;
        }
        
        
    }else{
        if (_address == nil) {
            TOASTSHOW(@"请选择收货地址");
            return;
        }
    }
    
    
//    if (_isUseIntegral) {
//        if (_sumPrice-_integral > busiSystem.agent.userInfo.cardBalance) {
//            TOASTSHOW(@"礼品卡余额不足");
//            return;
//        }
//    }else{
//        if (_sumPrice > busiSystem.agent.userInfo.cardBalance) {
//            TOASTSHOW(@"礼品卡余额不足");
//            return;
//        }
//    }
    if (busiSystem.agent.userInfo.hasPayPassword != 1) {
        PayPwdViewController *vc = [PayPwdViewController new];
        vc.mode = busiSystem.agent.userInfo.hasPayPassword == 0 ? 0:1;
        [self.navigationController pushViewController:vc animated:YES];
        _needReloadData = YES;
        return;
    }
    
    
    __weak ConfirmOrderOfGoodsViewController *weakSelf = self;
    InputPassViewController *vc = [InputPassViewController createLimitVC];
    vc.titleLb.text = @"输入支付密码";
    [vc setHandleGoBack:^(NSDictionary *dic) {
        int  tag = [dic[@"tag"] intValue];
        //1:忘记密码 2:提现申请
        if(tag == 1) {
            SnsCheckViewController *vc = [[SnsCheckViewController alloc] initWithNibName:@"UnBindWithdrawWayViewController" bundle:nil];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{
            [weakSelf checkPwd:dic[@"pass"]];

            
        }
    }];

}

-(void)checkPwd:(NSString *)pwd{
    HUDSHOW(@"提交中");
    [busiSystem.agent checkPayPassword:pwd observer:self callback:@selector(checkPayPasswordNotification:)];
}


-(void)checkPayPasswordNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        [self toAddOrder];
    }
    else
    {
        HUDCRY( noti.error.domain , 1);
    }
}

-(void)toAddOrder{
    NSString *intergral = @"-1";
    if (self.isUseIntegral) {
        intergral = @"1";
    }
    NSString *expresstype = @"1";
    NSString *addressId;
    NSString *person = @"";
    NSString *tel = @"";
    if (_state == 1) {
        expresstype = @"2";
        addressId = _takeSelfAddress.addrId;
        person = _takeSelfPersonCell.textField.text;
        tel = _takeSelfTellCell.textField.text;
    }else{
        addressId = _address.addrId;
    }
    NSString *number = [NSString stringWithFormat:@"%ld",(long)_num];
//    [busiSystem.getOrderListManager orderAdd:_remarkCell.textField.text withAddrid:addressId withIsintegral:intergral
//                                   withActid:@"" withPaytype:@"3" withNum:number withOrdertype:@"1" withExpresstype:expresstype
//                                 withBuytype:@"-1" withGoodsid:_goods.goodsId withVisitTime:@"" withContacts:person withTelephone:tel observer:self
//                                    callback:@selector(orderAddNotification:) extraInfo:nil];
}


-(void)orderAddNotification:(BSNotification *)noti
{
    
    if (noti.error.code == 0) {
//        [self toPayOrder];
        HUDDISMISS;
        PaySuccessViewController *vc = [PaySuccessViewController new];
//        vc.state = 1;
//        vc.goods = _goods;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        HUDCRY( noti.error.domain , 1);
    }
}


-(void)toPayOrder{
//    BUOrderOper *result = busiSystem.getOrderListManager.orderAddResult;
//    NSString *payStyle = @"3";
//    [busiSystem.payManager orderPay:payStyle withOrderid:result.orderId withTradeno:@""
//                           observer:self callback:@selector(orderPayNotification:)];
}


-(void)orderPayNotification:(BSNotification *)noti
{
    HUDDISMISS;
    if (noti.error.code == 0) {
        PaySuccessViewController *vc = [PaySuccessViewController new];
//        vc.state = 1;
//        vc.goods = _goods;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        HUDCRY( noti.error.domain , 1);
    }
}




-(void)initTableView{
    _distributionCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
    [_distributionCell setCellData:@{@"title":@"配送方式",@"detail":@"在线邮寄",@"img":@"icon_arrow_right"}];
    [_distributionCell fitConfirmGoodsInfoMode];
    
    __weak ConfirmOrderOfGoodsViewController *weakSelf = self;
    _integralCell = [OnlyBottomBtnTableViewCell createTableViewCell];
    [_integralCell setCellData:@{@"integral":@"100",@"money":@"1"}];
    [_integralCell fitConfirmOrderMode];
    [_integralCell setHandleAction:^(NSDictionary *dic) {
        UIButton *btn = dic[@"obj"];
//        weakSelf.isUseIntegral = !weakSelf.isUseIntegral;
//        if (weakSelf.isUseIntegral) {
//            [btn setBackgroundImage:[UIImage imageNamed:@"icon_switch_selected"] forState:UIControlStateNormal];
//            weakSelf.priceLb.text = [NSString stringWithFormat:@"¥%.2f",weakSelf.sumPrice-weakSelf.integral];
//            CGFloat price = weakSelf.sumPrice ;
//            if (price > busiSystem.agent.userInfo.cardBalance) {
//                price = busiSystem.agent.userInfo.cardBalance;
//            }else{
//                price = price - weakSelf.integral;
//            }
//            [_balanceCell setCellData:@{@"priceTitle":[NSString stringWithFormat:@"余额: ¥%.2f",busiSystem.agent.userInfo.cardBalance],@"price":[NSString stringWithFormat:@"%.2f",price]}];
//            [_balanceCell fitConfirmOrderMode];
//        }else{
//            [btn setBackgroundImage:[UIImage imageNamed:@"icon_switch_normal"] forState:UIControlStateNormal];
//            weakSelf.priceLb.text = [NSString stringWithFormat:@"¥%.2f",weakSelf.sumPrice];
//            CGFloat price = weakSelf.sumPrice ;
//            if (price > busiSystem.agent.userInfo.cardBalance) {
//                price = busiSystem.agent.userInfo.cardBalance;
//            }
//            [_balanceCell setCellData:@{@"priceTitle":[NSString stringWithFormat:@"余额: ¥%.2f",busiSystem.agent.userInfo.cardBalance],@"price":[NSString stringWithFormat:@"%.2f",price]}];
//            [_balanceCell fitConfirmOrderMode];
//        }
    }];
    
    _goodsTitleCell = [OnlyTitleTableViewCell createTableViewCell];
    [_goodsTitleCell setCellData:@{@"title":@"商品信息"}];
    [_goodsTitleCell fitMeetingInfoMode];
    
    _addressTitleCell = [OnlyTitleTableViewCell createTableViewCell];
    [_addressTitleCell setCellData:@{@"title":@"收货地址"}];
    [_addressTitleCell fitMeetingInfoMode];
    
    _addressCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
   
    
    _sumPriceCell = [TitleDetailTableViewCell createTableViewCell];
    [_sumPriceCell setCellData:@{@"title":@"共计",@"detail":[NSString stringWithFormat:@"¥%.2f",_sumPrice]}];
    [_sumPriceCell fitConfirmOrderMode];
    
    _productInfoCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
//    NSString *price = [NSString stringWithFormat:@"¥%.2f",_goods.sellPrice];
//    NSString *num = [NSString stringWithFormat:@"x%ld",(long)_num];
//    [_productInfoCell setCellData:@{@"img":_goods.imagePath,@"title":_goods.name,@"source":price,@"time":num}];
//    [_productInfoCell fitProductMode];

    
    _remarkCell = [TitleAndTextfieldTableViewCell createTableViewCell];
    [_remarkCell setCellData:@{@"title":@"备注"}];
    [_remarkCell fitCellMode];
    
    
    _exchangeStyleCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
    [_exchangeStyleCell fitConfirmGoodsInfoMode];
    [_exchangeStyleCell setCellData:@{@"title":@"兑换方式",@"detail":@"充值",@"detailColor":kUIColorFromRGB(color_5),@"img":@"icon_arrow_right"}];
    
    _takeSelfPersonCell = [TitleAndTextfieldTableViewCell createTableViewCell];
    [_takeSelfPersonCell setCellData:@{@"title":@"自提人",@"detail":@"",@"placeholder":@"请输入自提人姓名"}];
    [_takeSelfPersonCell fitCellMode];
    
    _takeSelfTellCell = [TitleAndTextfieldTableViewCell createTableViewCell];
    [_takeSelfTellCell setCellData:@{@"title":@"联系电话",@"placeholder":@"请输入联系电话",@"textField":busiSystem.agent.tel?:@""}];
    _takeSelfTellCell.textField.keyboardType = UIKeyboardTypeNumberPad;
    [_takeSelfTellCell fitConfirmOrderMode];
    
    _balanceCell = [FiveTitleTableViewCell createTableViewCell];
//    CGFloat sum = _goods.sellPrice*_num;
//    if (sum > busiSystem.agent.userInfo.cardBalance) {
//        sum = busiSystem.agent.userInfo.cardBalance;
//    }
//    [_balanceCell setCellData:@{@"priceTitle":[NSString stringWithFormat:@"余额: ¥%.2f",busiSystem.agent.userInfo.cardBalance],@"price":[NSString stringWithFormat:@"%.2f",sum]}];
    [_balanceCell fitConfirmOrderMode];
    
    _tableView.x=0;
    _tableView.y = 0;
    _tableView.width = __SCREEN_SIZE.width;
    _tableView.height = __SCREEN_SIZE.height -44-__NAVBAR_HEIGHT- __STATUSBAR_HEIGHT;
    _tableView.refreshHeaderView = nil;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    //     _tableView.bounces = NO;
    _tableView.separatorColor = kUIColorFromRGB(color_3);
    _tableView.backgroundColor = kUIColorFromRGB(color_9);
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger index = 1;
    if (section == 1) {
        if (_state==0) {
            index = 2;
        }else{
            index = 4;
        }
    }else if (section == 2 || section == 4){
        index = 3;
    }

    return index;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
   
    switch (indexPath.section) {
        case 0:
            cell = _distributionCell;
            break;
        case 1:
            switch (indexPath.row) {
                case 0:{
                    if (_state == 0) {
                        [_addressTitleCell setCellData:@{@"title":@"收货地址"}];
                    }else{
                        [_addressTitleCell setCellData:@{@"title":@"自提点地址"}];
                    }
                    cell = _addressTitleCell;
                    [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_3) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
                }
                    
                    break;
                case 1:
                    cell = _addressCell;
                    if (_state == 1) {//自提
                        if (!_takeSelfAddress) {
                            [_addressCell setCellData:@{@"title":@"选择自提点"}];
                            [_addressCell fitNoAddressMode];
                        }else{
                            [_addressCell setCellData:[_takeSelfAddress getDic:1]];
                            [_addressCell fitAddressMode];
                        }
                        
                        [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_3) withInsets:UIEdgeInsetsMake(68, 0, 0, 0)];
                    }else{//收货
                        if (!_address) {
                            [_addressCell setCellData:@{@"title":@"添加收货地址"}];
                            [_addressCell fitNoAddressMode];
                        }else{
                            [_addressCell setCellData:[_address getDic:1]];
                            [_addressCell fitAddressMode];
                        }
                    }
                    break;
                case 2:
                    cell = _takeSelfPersonCell;
                    [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_3) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
                    break;
                case 3:
                    cell = _takeSelfTellCell;;
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    cell = _goodsTitleCell;
                    [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_3) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
                    break;
                case 1:
                    cell = _productInfoCell;
                    [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_3) withInsets:UIEdgeInsetsMake(90, 0, 0, 0)];
                    break;
                case 2:
                    cell = _sumPriceCell;
                    break;
                default:
                    break;
            }
            break;
        case 3:
            cell = _remarkCell;
            break;
        case 4:
            switch (indexPath.row) {
                case 0:
                    cell = _exchangeStyleCell;
                    [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_3) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
                    break;
                case 1:
                    cell = _integralCell;
                    [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_3) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
                    break;
                case 2:
                    cell = _balanceCell;
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
//    if (cell == nil) {
//        NSLog(@"%@", [NSString stringWithFormat:@"%ld %ld",(long)indexPath.section,(long)indexPath.row]);
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 40.0;
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        height = 68;
    }else if (indexPath.section == 2 && indexPath.row == 1) {
        height = 90;
    }
    
    
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 4) {
        return 0.01;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //    if (_state == 1 && section==0 ) {
    //        return 44;
    //    }
    return 0.01;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    if (indexPath.section == 0) {//配送方式选择
//        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"在线邮寄",@"线下自提", nil];
//        actionSheet.tag = 2140917;
//        [actionSheet showInView:self.view];
        NSDictionary *dic = @{@"titleOne":@"在线邮寄",@"titleTwo":@"线下自提"};
        __weak ConfirmOrderOfGoodsViewController *weakSelf = self;
        MyActionViewController *vc = [MyActionViewController createLimitVC];
        [vc setData:dic];
        [vc setHandleGoBack:^(NSString *str) {
            NSInteger index = [str integerValue];
            if (index == 1) {//在线邮寄
                _state = 0;
                [_distributionCell setCellData:@{@"title":@"配送方式",@"detail":@"在线邮寄",@"img":@"icon_arrow_right"}];
                [weakSelf.tableView reloadData];
            }else {//线下自提
                _state = 1;
                [_distributionCell setCellData:@{@"title":@"配送方式",@"detail":@"线下自提",@"img":@"icon_arrow_right"}];
                [weakSelf.tableView reloadData];
                
            }
        }];
    }else if (indexPath.section == 1 && indexPath.row == 1){//地址选择;
        if (_state == 0) {//收货
            if (!_address) {
                SelectAddressViewController *vc = [SelectAddressViewController new];
                [self.navigationController pushViewController:vc animated:YES];
                _needReloadData = YES;
            }else{
                ChoseAddressViewController *vc = [ChoseAddressViewController new];
                vc.state = 0;
                vc.address = _address;
                __weak ConfirmOrderOfGoodsViewController *weakSelf = self;
                [vc setCallBack:^(NSDictionary *dic) {
                    weakSelf.address = dic[@"address"];
                    [_addressCell setCellData:[weakSelf.address getDic:1]];
                    [_addressCell fitAddressMode];
                }];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{//自提
            ChoseAddressViewController *vc = [ChoseAddressViewController new];
            vc.state = 1;
            vc.address = _address;
            __weak ConfirmOrderOfGoodsViewController *weakSelf = self;
            [vc setCallBack:^(NSDictionary *dic) {
                weakSelf.takeSelfAddress = dic[@"address"];
                [_addressCell setCellData:[weakSelf.takeSelfAddress getDic:3]];
                [_addressCell fitAddressMode];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
        
        
        
    }else if (indexPath.section == 4 && indexPath.row == 0){//充值
        NSDictionary *dic = @{@"titleOne":@"使用已有卡片充值",@"titleTwo":@"前往商城购卡充值"};
        __weak ConfirmOrderOfGoodsViewController *weakSelf = self;
        MyActionViewController *vc = [MyActionViewController createLimitVC];
        [vc setData:dic];
        [vc setHandleGoBack:^(NSString *str) {
            NSInteger index = [str integerValue];
            if (index == 1) {//使用已有卡片充值
//                UserCarToRechargeViewController *vc = [UserCarToRechargeViewController new];
//                [weakSelf.navigationController pushViewController:vc animated:YES];
                _needReloadData = YES;
            }else {//前往商城购卡充值
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                weakSelf.tabBarController.selectedIndex = 1;
            }
        }];
//        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"使用已有卡片充值",@"前往商城购卡充值", nil];
//        actionSheet.tag = 2140918;
//        [actionSheet showInView:self.view];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.view endEditing:YES];
    if (actionSheet.tag == 2140917) {//配送方式选择
        if (buttonIndex == 0) {//在线邮寄
            _state = 0;
            [_tableView reloadData];
        }else if(buttonIndex == 1){//线下自提
            _state = 1;
            [_tableView reloadData];
            
        }
    }else{//充值方式
        if (buttonIndex == 0) {//使用已有卡片充值
            NSLog(@"使用已有卡片充值");
        }else if(buttonIndex == 1){//前往商城购卡充值
            NSLog(@"前往商城购卡充值");
            
        }
    }
    
    
}




@end
