//
//  OrderInfoViewController.h
//  oranllcshoping
//
//  Created by air on 2017/7/25.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "TitleDetailTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "GoodsInfoViewController.h"
#import "ServerInfoViewController.h"
//#import "ReplacementViewController.h"
#import "BUSystem.h"


@interface OrderInfoViewController : BaseTableViewController
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
 @property(nonatomic,strong) TitleDetailTableViewCell *stateCell;//订单状态
 @property(nonatomic,strong) TitleDetailTableViewCell *stateInfoCell;//订单状态信息
 @property(nonatomic,strong) TitleDetailTableViewCell *addressCell;//地址
 @property(nonatomic,strong) OnlyTitleTableViewCell *goodsTipCell;//商品信息
@property(nonatomic,strong) OnlyTitleTableViewCell *orderTipCell;//订单信息

@property(nonatomic,strong) TitleDetailTableViewCell *goodsTotalCell;//商品合计
@property(nonatomic,strong) TitleDetailTableViewCell *carriageCell;//运费
@property(nonatomic,strong) TitleDetailTableViewCell *couponCell;//优惠劵
@property(nonatomic,strong) TitleDetailTableViewCell *youbiDiscountCell;//优币抵扣
@property(nonatomic,strong) TitleDetailTableViewCell *actDiscountCell;//活动优惠

@property(nonatomic,strong) TitleDetailTableViewCell *billTypeCell;
@property(nonatomic,strong) TitleDetailTableViewCell *billriseCell;
@property(nonatomic,strong) TitleDetailTableViewCell *billContentCell;

@property(nonatomic,strong) TitleDetailTableViewCell *orderNoCell;
@property(nonatomic,strong) TitleDetailTableViewCell *submitTimeCell;
@property(nonatomic,strong) TitleDetailTableViewCell *payWayCell;
@property(nonatomic,strong) TitleDetailTableViewCell *payMoneyCell;//实付金额
@property(nonatomic,strong) TitleDetailTableViewCell *payTimeCell;//付款金额
@property(strong,nonatomic)OnlyBottomBtnTableViewCell *submitCell;
@property (nonatomic,strong) BUGetOrder *order;
@property (nonatomic,strong) BUOrderDetail *orderDetail;
-(void)toGoodsInfoVC:(NSString *)pid;
@end
