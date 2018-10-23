//
//  GoodsInfoViewController.m
//  compassionpark
//
//  Created by Steve on 2017/1/22.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "GoodsInfoViewController.h"
#import "GoodsFlashTableViewCell.h"
#import "FiveTitleTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "AddImgTableViewCell.h"
#import "PromoteTableViewCell.h"
#import "AddGoodsNumberViewController.h"
//#import "ConfirmPresentCardOrderViewController.h"
#import "ConfirmOrderOfGoodsViewController.h"
#import "TitleDetailTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
//#import "ConfirmActivityOrderViewController.h"
#import "LoginViewController.h"
//#import "BindGiftCardViewController.h"
//#import "HuanxinKefuManager.h"
#import "JYCommonTool.h"
#import "TitleDetailTableViewCell.h"
#import "ShopInfoViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "ImgsTableViewCell.h"
#import "ZJMenuView.h"
#import "EvalutionListViewController.h"
#import "JYShareManager.h"
#import "NoDataTableViewCell.h"
#import "CartViewController.h"
#import "FillInOrderInfoViewController.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhotoAssets.h"
#import "TitleAndDetailAndImageTableViewCell.h"
#import "SelectedGoodsTypeViewController.h"
#import "JYDatePickViewController.h"
#import "OrderServiceIntruduceViewController.h"
#import <MeiQiaSDK/MeiQiaSDK.h>
#import "MQChatViewManager.h"
#import "SeverCenterViewController.h"
#import "NoCashApproveViewController.h"
#import "FindInfoViewController.h"
#import "FourTabsTableViewCell.h"
#import "ZhiMaAuthViewController.h"

@interface GoodsInfoViewController (){
    CGFloat alp;
    GoodsFlashTableViewCell *_flashCell;
//    FiveTitleTableViewCell *_priceCell;
//    OnlyTitleTableViewCell *_intruducrTitleCell;
    OnlyTitleTableViewCell *_intruduceCell;//图文详情
     OnlyTitleTableViewCell *_rentRegularCell;//租赁规则
    TitleDetailTableViewCell *_promotionTitleCell;
     NoDataTableViewCell *_noEvaCell;
     NoDataTableViewCell *_noPromotionCell;
     TitleAndDetailAndImageTableViewCell *_serviceCell;
     ImgAndThreeTitleTableViewCell *_selectStardardCell;
     TitleAndDetailAndImageTableViewCell *_creditCell;//芝麻信用
     FourTabsTableViewCell *_fourTabsCell;
    UIButton *_backBtn;
    NSInteger _requestCount;
    BOOL _isCollection;//是否收藏
    BOOL _needReloadData;
     BOOL _isEva;
     
     UILabel *_redDotLb;
     NSInteger _cartCount;
     ImgAndThreeTitleTableViewCell *_priceCell;
//     ImgAndThreeTitleTableViewCell *_shopInfoCell;
     OnlyBottomBtnTableViewCell *_showAllEvaCell;
     ZJMenuView *_menuView;
     UIButton *collection;
//     BOOL _canClick;

}
@property (nonatomic,strong) BUGoodsInfo *goodsInfo;
@property (nonatomic,strong) BUProductPrice *productPrice;
@property (nonatomic,assign) NSInteger number;
@property (nonatomic,assign) NSInteger state;//0:"图文详情",1"商品参数",2"租赁规则",3"用户评价"
@property (nonatomic,strong) SelectedGoodsTypeViewController *selectGooodsVc;
@property (nonatomic,strong) NSDate *startDate;
@property (nonatomic,strong) NSDate *endMinDate;
@property (nonatomic,strong) NSDate *endDate;
@property (nonatomic,assign) NSInteger lease;//租期
@property (nonatomic,strong) NSMutableArray *selectedArr;
@property (nonatomic,strong) UILabel *titleLB;
//@property (nonatomic,strong) NSMutableDictionary *dataDic;
@end

@implementation GoodsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//     self.title = @"商品详情";
//     _ID = @"3a62df6fb84f44a3a48fd8dd2fd9455e";
//     _canClick = YES;
     [self initMenu];
     [self addTopView];
    [self initTableView];
    [self initBottomView];
     [self setCenterNav];
//    [self addBackBtn];
    HUDSHOW(@"加载中");
    [self getData];
     [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
     [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

}


-(void)setCenterNav
{
     _titleLB = [UILabel new];
     _titleLB.textColor = kUIColorFromRGB(color_1);
     _titleLB.font = [UIFont systemFontOfSize:18];
     _titleLB.width = __SCREEN_SIZE.width - 80;
     _titleLB.textAlignment = NSTextAlignmentCenter;
     _titleLB.height = 30;
     _titleLB.text = @"";
     
     self.navigationItem.titleView = _titleLB;
}



-(void)initMenu{
     _menuView = [[ZJMenuView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 45)];;
     [_menuView setData:@[@"图文详情",@"商品参数",@"租赁规则",@"用户评价"]];
     _menuView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _menuView.layer.borderWidth = 0.5;
     __weak GoodsInfoViewController *weakSelf = self;
     [_menuView setHandle:^(UIButton *btn) {
          weakSelf.state = btn.tag;
          [weakSelf.tableView reloadData];
     }];
}

-(void)setTableViews
{
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getData{
  
     [self getGoodsData];
     [self getLeaseRule];
     [self getCommentList];
}

-(void)getGoodsData{
    
    _requestCount++;
     [busiSystem.shopManager getGoodsInfo:_ID observer:self callback:@selector(getGoodsDetailNotification:)];
}

-(void)getGoodsDetailNotification:(BSNotification *)noti
{
     _requestCount--;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     if (noti.error.code == 0) {
          
          _goodsInfo = busiSystem.shopManager.goodsInfo;
          
//          if (busiSystem.agent.isLogin) {
               busiSystem.agent.isCredit = _goodsInfo.isCredit;
               busiSystem.agent.creditMoney = _goodsInfo.credit;
//          }
          
//          self.title = _goodsInfo.name;
          [_flashCell setCellData:[_goodsInfo getDic:0]];
          [_flashCell fitGoodsInfoMode];
          [_priceCell setCellData:[_goodsInfo getDic:1]];
          [_priceCell fitGoodsMode];
          
          if (_goodsInfo.isCredit) {
               NSString *str = [NSString stringWithFormat:@"当前芝麻分可减免押金金额¥%.2f",_goodsInfo.credit];
               [_creditCell  setCellData:@{@"title":@"芝麻信用",@"detail":str,@"img":@"arrow_right_goods"}];
               [_creditCell fitGoodsInfoModeC];
          }
          
          [_serviceCell setCellData:[_goodsInfo getDic:2]];
          [_serviceCell fitGoodsInfoModeA];
     
          [_intruduceCell setCellData:[_goodsInfo getDic:3]];
          [_intruduceCell fitHtmlMode];
          
          [_selectStardardCell setCellData:[_goodsInfo getDic:5]];
          [_selectStardardCell fitGoodsModeA];
          
          collection.customImgV.image = [UIImage imageNamed:_goodsInfo.isCollection?@"icon_collection_sel": @"icon_collection_unsel"];
          [_tableView reloadData];
          [_fourTabsCell setCellData:@{@"goods":_goodsInfo?:[BUGoodsInfo new]}];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}


-(void)getCommentList{
     
     _requestCount++;
     [busiSystem.getCommentListManager getCommentList:busiSystem.agent.userId productId:_ID observer:self callback:@selector(getCommentListNotification:)];
}

-(void)getCommentListNotification:(BSNotification *)noti
{
     _requestCount--;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     
     if (noti.error.code == 0) {
          
          _tableView.extroDataArr = [NSMutableArray arrayWithArray:busiSystem.getCommentListManager.getCommentList];
          if (_state == 3) {
               [_tableView reloadData];
          }
//          _tableView.hasMore = busiSystem.getCommentListManager.pageInfo.hasMore;
          [_fourTabsCell setEvaData:@{@"eva":_tableView.extroDataArr}];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}


-(void)getLeaseRule{
     _requestCount ++;
     [busiSystem.shopManager getLeaseRule:self callback:@selector(getLeaseRuleNotification:)];
}


-(void)getLeaseRuleNotification:(BSNotification *)noti
{
     _requestCount--;
     if (_requestCount == 0) {
          HUDDISMISS
     }

     if (noti.error.code == 0) {
          [_rentRegularCell setCellData:@{@"title":busiSystem.shopManager.leaseRule?:@""}];
          [_rentRegularCell fitHtmlMode];
          [_tableView reloadData];
          _fourTabsCell.rentRegularCell = _rentRegularCell;
          _fourTabsCell.rentRegularCellHeight = _rentRegularCell.height;
          [_fourTabsCell.tableViewC reloadData];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}



-(void)addBackBtn{
//    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 34, 10, 18)];
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 32, 40, 18)];
    [_backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    _backBtn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_backBtn];
    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addTopView{
     
     UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, -NAVBARHEIGHT, __SCREEN_SIZE.width, NAVBARHEIGHT)];
     navView.backgroundColor = kUIColorFromRGB(color_2);
     [self.view addSubview:navView];
     [self.view sendSubviewToBack:navView];
     
     
     _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 30-NAVBARHEIGHT, 100, 100)];
     if (__IPHONEX) {
          _backBtn.y = 54-NAVBARHEIGHT;
     }
//     [_backBtn setImage:[UIImage imageNamed:@"arrow_left_gray"] forState:UIControlStateNormal];
     [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
     [_backBtn fitImgAndTitleMode];
     _backBtn.customImgV.image = [UIImage imageNamed:@"arrow_left_gray"];
     _backBtn.customImgV.frame = CGRectMake(15, 0, 30, 30);
     [self.view addSubview:_backBtn];
     _backBtn.userInteractionEnabled = NO;
     
     //     UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width-47.5, 13, 40, 50)];
     //     [shareBtn setImage:[UIImage imageNamed:@"share_gray"] forState:UIControlStateNormal];
     //     [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
     //     [_flashCell.contentView addSubview:shareBtn];
     //
     //     UIButton *collectionBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 90, 13, 40, 50)];
     //     [collectionBtn setImage:[UIImage imageNamed:@"collection_gray"] forState:UIControlStateNormal];
     //     [collectionBtn addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
     //     [_flashCell.contentView addSubview:collectionBtn];
}

#pragma mark - 底部按钮
-(void)initBottomView{
     
     
     
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, __SCREEN_SIZE.height-54 - TABBARNONEHEIGHT-NAVBARHEIGHT, __SCREEN_SIZE.width, 54)];
    view.backgroundColor = kUIColorFromRGB(color_f8f8f8);
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    [self.view addSubview:view];
     
     UIButton *serverBtn = [[UIButton alloc]initWithFrame:CGRectMake(9, 0, 50, view.height)];
//     [serverBtn setImage:[UIImage imageNamed:@"icon_cart"] forState:UIControlStateNormal];
     serverBtn.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     [serverBtn addTarget:self action:@selector(serverAction:) forControlEvents:UIControlEventTouchUpInside];
     [serverBtn fitImgAndTitleMode];
     serverBtn.customImgV.image = [UIImage imageNamed:@"icon_server"];
     serverBtn.customImgV.width = 16;
     serverBtn.customImgV.height = 16;
     serverBtn.customImgV.x = serverBtn.width/2.0 - 8;
     serverBtn.customImgV.y = 12;
     
     serverBtn.customTitleLb.text = @"客服";
     serverBtn.customTitleLb.font = [UIFont systemFontOfSize:12];
     serverBtn.customTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     serverBtn.customTitleLb.width = serverBtn.width;
     serverBtn.customTitleLb.height = 12;
     serverBtn.customTitleLb.x = 0;
     serverBtn.customTitleLb.y = 34;
     [view addSubview:serverBtn];
    

    collection = [[UIButton alloc]initWithFrame:CGRectMake(serverBtn.x+serverBtn.width, 0, 50, view.height)];
     //     [serverBtn setImage:[UIImage imageNamed:@"icon_cart"] forState:UIControlStateNormal];
     collection.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     [collection addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
     [collection fitImgAndTitleMode];
     collection.customImgV.image = [UIImage imageNamed:@"icon_collection_unsel"];
     collection.customImgV.width = 16;
     collection.customImgV.height =16;
     collection.customImgV.x = serverBtn.width/2.0 - 8;
     collection.customImgV.y = 12;
     
     collection.customTitleLb.text = @"收藏";
     collection.customTitleLb.font = [UIFont systemFontOfSize:12];
     collection.customTitleLb.textColor = kUIColorFromRGB(color_0xb0b0b0);
     collection.customTitleLb.width = serverBtn.width;
     collection.customTitleLb.height = 12;
     collection.customTitleLb.x = 0;
     collection.customTitleLb.y = 34;
     [view addSubview:collection];

     
    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(140, 9, __SCREEN_SIZE.width-140-15, 36)];
    [buyBtn setTitle:@"立即下单" forState:UIControlStateNormal];
    [buyBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [buyBtn addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    buyBtn.backgroundColor = kUIColorFromRGB(color_0xf74056);
     buyBtn.layer.cornerRadius = buyBtn.height/2.0;
     buyBtn.layer.shadowRadius = 8;
     buyBtn.layer.shadowOpacity = 0.43;
     buyBtn.layer.shadowOffset = CGSizeMake(0, 0);
     buyBtn.layer.shadowColor = kUIColorFromRGB(color_0xf74056).CGColor;
    [view addSubview:buyBtn];
    
//    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width/2.0, 0, 0.5, view.height)];
//    [line1 setBackgroundColor:kUIColorFromRGB(color_5)];
//    [view addSubview:line1];
    
}



-(void)serverAction:(UIButton *)sender{
     SeverCenterViewController *vc = [SeverCenterViewController new];
     [self.navigationController pushViewController:vc animated:YES];
     
//     MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
//     UIImage *img;
//     if (busiSystem.agent.img.isCached) {
//          img = [UIImage imageWithContentsOfFile:busiSystem.agent.img.Image];
//     }else
//          img = [UIImage imageNamed:@"defaultHead"];
//     [chatViewManager setoutgoingDefaultAvatarImage:img];
//     MQChatViewStyle *aStyle = [chatViewManager chatViewStyle];
////    [aStyle setNavBarTintColor:[UIColor redColor]];
//    [aStyle setNavBackButtonImage:[UIImage imageNamed:@"nav_back"]];
//     [chatViewManager pushMQChatViewControllerInViewController:self];
}


-(void)collectionAction:(UIButton *)sender{
     //   [HuanxinKefuManager kefuHandle:self];
     if (!busiSystem.agent.isLogin) {
          [LoginViewController toLogin:self];
          _needReloadData = YES;
          return;
     }
     [self addGoodsCollect];
}

-(void)addCartAction:(UIButton *)sender{
//   [HuanxinKefuManager kefuHandle:self];
     if (!busiSystem.agent.isLogin) {
          [LoginViewController toLogin:self];
          _needReloadData = YES;
          return;
     }
     NSLog(@"加入购物车");
//     [self addUserCart:_ID];
}



-(void)buyAction:(UIButton *)sender{
    if (!busiSystem.agent.isLogin) {
        [LoginViewController toLogin:self];
        _needReloadData = YES;
        return;
    }
     if (_productPrice == nil) {
          [self createFirstSelectedGoodsTypeVC:0];
     }else
          [self createSelectedGoodsTypeVC:0];
     
     
}

#pragma mark - 第一次创建选择规格控件 0:重新创建 1:设值
-(void)createFirstSelectedGoodsTypeVC:(NSInteger)state{
     NSMutableArray *arr = [NSMutableArray new];
     [_goodsInfo.productAttributeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUProductAttribute *pa = obj;
          NSMutableArray *tempArr = [NSMutableArray new];
          [pa.value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUProductAttributeValue *value = obj;
               if (value.isEnabled) {
                    if (value.isDefault) {
                         [tempArr addObject:@{@"title":value.value?:@"",@"state":@"1"}];
                    }else{
                         [tempArr addObject:@{@"title":value.value?:@"",@"state":@"0"}];
                    }
               }else{
                    [tempArr addObject:@{@"title":value.value?:@"",@"state":@"2"}];
               }
               
          }];
          [arr addObject:@{@"title":pa.title,@"arr":tempArr}];
     }];
     BUImageRes *img = self.goodsInfo.img;
     NSDictionary *dic = @{
                           @"arr":arr,
                           @"selectDate":@(_goodsInfo.priceType == 1),
                           @"sumPrice":@(_goodsInfo.totalMoney),
                           @"rentPrice":@(_goodsInfo.leaseMoney),
                           @"insurancePrice":@(_goodsInfo.insuranceMoney),
                           @"type":@(_goodsInfo.leaseType),
                           @"credit":@(_goodsInfo.credit),
                           @"img":img?:@""
                           };
     NSMutableDictionary *dic1 = [NSMutableDictionary new];
     
     if (_goodsInfo.priceType == 1) {//自定义
          if (_startDate == nil) {
               _startDate = [NSDate date];
               _endMinDate  = [self dateAddDay:2 withData:_startDate];
               _endDate = [self dateAddDay:2 withData:_startDate];
          }
          [dic1 setObject:_startDate forKey:@"startDate"];
          [dic1 setObject:_endDate forKey:@"endDate"];
     }else{
          //添加租期
          NSMutableArray *tempArr = [NSMutableArray new];
          [_goodsInfo.leaseList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUProductLease *value = obj;
               NSString *str = [NSString stringWithFormat:@"%ld%@",(long)value.value,_goodsInfo.leaseType==0?@"月":@"天"];
               if (value.isEnabled) {
                    if ((value.isDefault && state == 0) || (value.value == _lease &&state == 1)) {
                         [tempArr addObject:@{@"title":str,@"state":@"1"}];
                    }else{
                         [tempArr addObject:@{@"title":str,@"state":@"0"}];
                    }
               }else{
                    [tempArr addObject:@{@"title":str,@"state":@"2"}];
               }
               
          }];
          [arr addObject:@{@"title":@"租期",@"arr":tempArr}];
     }
     [dic1 addEntriesFromDictionary:dic];
//     _canClick = NO;
     if (state == 0) {
          _selectGooodsVc = [SelectedGoodsTypeViewController createVC:dic1];
     }else{
          [_selectGooodsVc setData:dic1];
          [_selectGooodsVc fitCellMode];
     }
     
     
     __weak GoodsInfoViewController *weakSelf = self;
     [_selectGooodsVc setHandleGoBack:^(NSDictionary *dic) {
          [weakSelf selectGoodsStardarHandle:dic];
     
     }];
}

#pragma mark - 选择规格控件回调
-(void)selectGoodsStardarHandle:(NSDictionary *)dic{
     NSInteger s = [dic[@"state"] integerValue];
     switch (s) {
          case 0://立即下单
          {
               [self submitOrder:dic];
               
          }
               break;
          case 1://选择开始时间
          {
               JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
               [vc setMinDate:[NSDate date]];
               [vc setDate:_startDate];
               [vc fitDateMode];
               [vc setCallBack:^(NSDate *date) {
                    self.startDate = date;
                    NSTimeInterval time = [self.endDate timeIntervalSinceDate:self.startDate];
                    NSInteger lease = time/(3600*24);
                    self.endMinDate = [self dateAddDay:2 withData:self.startDate];
                    if (lease<2) {
                         self.endDate = [self dateAddDay:2 withData:self.startDate];
                    }
                    NSMutableDictionary *nDic = [[NSMutableDictionary alloc]init];
                    [nDic setObject:self.startDate forKey:@"startDate"];
                    [nDic setObject:self.endDate forKey:@"endDate"];
                    [self.selectGooodsVc setStartAndEndDate:nDic];
                    NSArray *arr = dic[@"arr"];
                    [self selectedStandards:arr withState:@"0"];
               }];
               
          }
               break;
          case 2://选择结束时间
          {
               JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
               [vc setMinDate:self.endMinDate];
               [vc setDate:_endDate];
               [vc fitDateMode];
               [vc setCallBack:^(NSDate *date) {
                    self.endDate = date;
                    NSMutableDictionary *nDic = [[NSMutableDictionary alloc]init];
                    [nDic setObject:self.startDate forKey:@"startDate"];
                    [nDic setObject:self.endDate forKey:@"endDate"];
                    [self.selectGooodsVc setStartAndEndDate:nDic];
                    NSArray *arr = dic[@"arr"];
                    [self selectedStandards:arr withState:@"0"];
               }];
          }
               break;
          case 3://选择规格
          {
               NSArray *arr = dic[@"arr"];
               [self selectedStandards:arr withState:@"0"];
               NSString *str = dic[@"title"];
               if (str.length == 0) {
                    str = _goodsInfo.attributes?:@"";
               }
               [_selectStardardCell setCellData:@{@"title":@"请选择:",@"source":str,@"time":@""}];
               [_selectStardardCell fitGoodsModeA];
               
          }
                break;
          case 4://租赁协议
          {
               FindInfoViewController *vc = [FindInfoViewController new];
               vc.name = @"用户租赁及服务协议";
               vc.content = busiSystem.agent.config.leaseService?:@"";
               [self.navigationController pushViewController:vc animated:YES];
               
          }
                break;
          default:
               break;
     }
     

}


#pragma mark - 立即下单
-(void)submitOrder:(NSDictionary *)dic{
     if (_productPrice != nil) {
          if (_productPrice.leaseMoney == 0.0) {
               HUDCRY(@"租金有误,请重新选择规格", 2);
               return;
          }
          FillInOrderInfoViewController *vc = [FillInOrderInfoViewController new];
          vc.productPrice = self.productPrice;
          vc.goodsInfo = self.goodsInfo;
          vc.startDate = self.startDate;
          vc.endDate = self.endDate;
          vc.lease = _lease;
          vc.dataArr = _selectedArr;
          [self.navigationController pushViewController:vc animated:YES];
     }else{
          NSArray *arr = dic[@"arr"];
          [self selectedStandards:arr withState:@"1"];
     }
}


-(void)getProductPriceNotification:(BSNotification *)noti
{
     HUDDISMISS;
     if (noti.error.code == 0) {
          _productPrice = busiSystem.shopManager.productPrice;
          if (_productPrice.leaseMoney > 0.0) {
               NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[_goodsInfo getDic:1]];
               NSString *price = [NSString stringWithFormat:@"%.2f", _productPrice.leaseMoney];
               NSString *cost = [NSString stringWithFormat:@"商品价值¥%.2f",_productPrice.costMoney];
               [dic setObject:price forKey:@"time"];
               [dic setObject:cost forKey:@"price"];
               [_priceCell setCellData:dic];
               [_priceCell fitGoodsMode];
          }
         
          
          NSInteger s = [noti.extraInfo[@"state"] integerValue];
          if (s == 0) {
               [self createSelectedGoodsTypeVC:1];
          }else{
               if (_productPrice.leaseMoney == 0.0) {
                    HUDCRY(@"租金有误,请重新选择规格", 2);
                    return;
               }
               FillInOrderInfoViewController *vc = [FillInOrderInfoViewController new];
               vc.productPrice = self.productPrice;
               vc.goodsInfo = self.goodsInfo;
               vc.startDate = self.startDate;
               vc.endDate = self.endDate;
               vc.lease = _lease;
                vc.dataArr = _selectedArr;
               [self.navigationController pushViewController:vc animated:YES];
          }
          
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}
#pragma mark - 选择规格 0:重新创建 1:设值
-(void)createSelectedGoodsTypeVC:(NSInteger)state{
     NSMutableArray *arr = [NSMutableArray new];
     [_productPrice.productAttributeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUProductAttribute *pa = obj;
          NSMutableArray *tempArr = [NSMutableArray new];
          NSString *selectStr = @"";
          if (idx <_selectedArr.count) {
               selectStr =  _selectedArr[idx];
          }
          
          [pa.value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUProductAttributeValue *value = obj;
               if (value.isEnabled) {
                    if ([value.value isEqualToString:selectStr] ) {
                         [tempArr addObject:@{@"title":value.value?:@"",@"state":@"1"}];
                    }else{
                         [tempArr addObject:@{@"title":value.value?:@"",@"state":@"0"}];
                    }
               }else{
                    [tempArr addObject:@{@"title":value.value?:@"",@"state":@"2"}];
               }
               
          }];
          [arr addObject:@{@"title":pa.title,@"arr":tempArr}];
     }];
     BUImageRes *img = self.goodsInfo.img;

     NSDictionary *dic = @{
                           @"arr":arr,
                           @"selectDate":@(_goodsInfo.priceType == 1),
                           @"sumPrice":@(_productPrice.totalMoney),
                           @"rentPrice":@(_productPrice.leaseMoney),
                           @"insurancePrice":@(_productPrice.insuranceMoney),
                           @"type":@(_goodsInfo.leaseType),
                           @"credit":@(_goodsInfo.credit),
                           @"img":img?:@""
                           };
     NSMutableDictionary *dic1 = [NSMutableDictionary new];
     
     if (_goodsInfo.priceType == 1) {//自定义选择租期
          if (_startDate == nil) {
               _startDate = [NSDate date];
               _endDate = [self dateAddDay:3 withData:_startDate];
          }
          [dic1 setObject:_startDate forKey:@"startDate"];
          [dic1 setObject:_endDate forKey:@"endDate"];
     }else{
          //添加租期
          NSMutableArray *tempArr = [NSMutableArray new];
          __block NSInteger lease = [_selectedArr.lastObject integerValue];
          [_productPrice.leaseList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUProductLease *value = obj;
               NSString *str = [NSString stringWithFormat:@"%ld%@",(long)value.value,_goodsInfo.leaseType==0?@"月":@"天"];
               if (value.isEnabled) {
                    if (value.value == lease) {
                         [tempArr addObject:@{@"title":str,@"state":@"1"}];
                    }else{
                         [tempArr addObject:@{@"title":str,@"state":@"0"}];
                    }
               }else{
                    [tempArr addObject:@{@"title":str,@"state":@"2"}];
               }
               
          }];
          [arr addObject:@{@"title":@"租期",@"arr":tempArr}];
     }
     [dic1 addEntriesFromDictionary:dic];
//     [_selectGooodsVc.parentDialog dismiss];
//     _canClick = NO;
     if (state == 0) {//重新创建
          _selectGooodsVc = [SelectedGoodsTypeViewController createVC:dic1];
     }else{//设值
          [_selectGooodsVc setData:dic1];
          [_selectGooodsVc fitCellMode];
     }
//
    

     
     
     
}
#pragma mark - 创建商品规格控件
-(void)selectedStandards:(NSArray *)arr withState:(NSString *)state{
     NSMutableArray *tempArr = [NSMutableArray new];
     self.selectedArr = [NSMutableArray new];
     __block NSInteger lease = 0 ;
     NSArray * productAttributeList;
     NSArray * leaseList;
     if (_productPrice == nil) {
          productAttributeList = [NSArray arrayWithArray:_goodsInfo.productAttributeList];
          leaseList = [NSArray arrayWithArray:_goodsInfo.leaseList];
     }else{
          productAttributeList = [NSArray arrayWithArray:_productPrice.productAttributeList];
          leaseList = [NSArray arrayWithArray:_productPrice.leaseList];
     }
     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          UIButton *btn = obj;
          //tag = -1 (未选)
          if (btn.tag >=0) {
               NSInteger section = btn.tag/100;
               NSInteger row = btn.tag%100;
               if (self.goodsInfo.priceType == 0) {//选项
                    if (idx<arr.count-1) {
                         BUProductAttribute *pa = productAttributeList[section];
                         BUProductAttributeValue *pav = pa.value[row];
                         BSJSON *json = [BSJSON new];
                         [json setObject:pa.ID forKey:@"productAttributeId"];
                         [json setObject:pa.title forKey:@"productAttributeName"];
                         [json setObject:pav.value forKey:@"productAttributeValue"];
                         [tempArr addObject:json];
                         [self.selectedArr addObject:pav.value];
                    }else{
                         BUProductLease *pl = leaseList[row];
                         lease = pl.value;
                         [self.selectedArr addObject:@(pl.value)];
                    }
               }else{//自定义选择时间
                    BUProductAttribute *pa = productAttributeList[section];
                    BUProductAttributeValue *pav = pa.value[row];
                    BSJSON *json = [BSJSON new];
                    [json setObject:pa.ID forKey:@"productAttributeId"];
                    [json setObject:pa.title forKey:@"productAttributeName"];
                    [json setObject:pav.value forKey:@"productAttributeValue"];
                    [tempArr addObject:json];
                    [self.selectedArr addObject:pav.value];
               }
               
          }else{
               if (self.goodsInfo.priceType == 0) {//选项
                    if (idx<arr.count-1) {
                         [self.selectedArr addObject:@""];
                    }else{
                         [self.selectedArr addObject:@(0)];
                    }
               }else{
                    [self.selectedArr addObject:@""];
               }
          }
     }];
     if (self.goodsInfo.priceType == 1) {//自定义
          NSTimeInterval time = [self.endDate timeIntervalSinceDate:self.startDate];
          
          lease = (int )time/(3600*24);
          NSInteger i = (int)time%(3600*24);
          if (i != 0) {
               lease++;
          }
          lease++;
     }
     _lease = lease;
     if (tempArr.count != 0) {//有选择规格
          //     HUDSHOW(@"加载中");
          [busiSystem.shopManager getProductPrice:_ID lease:[NSString stringWithFormat:@"%ld",(long)lease] productAttributeList:tempArr observer:self callback:@selector(getProductPriceNotification:) extraInfo:@{@"state":state?:@"0"}];
     }else{//没有选择规格
          if (_productPrice == nil) {
               [self createFirstSelectedGoodsTypeVC:1];
          }else{
               [self createSelectedGoodsTypeVC:1];
          }
          
     }

}

-(NSDate *)dateAddDay:(int)day withData:(NSDate *)date {
     NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
     //NSCalendarIdentifierGregorian:iOS8之前用NSGregorianCalendar
     NSDateComponents *comps = nil;
     
     comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
     //NSCalendarUnitYear:iOS8之前用NSYearCalendarUnit,NSCalendarUnitMonth,NSCalendarUnitDay同理
     
     NSDateComponents *adcomps = [[NSDateComponents alloc] init];
     
//     [adcomps setYear:year];
//
//     [adcomps setMonth:month];
     
     [adcomps setDay:day];
     
     NSDate *newDate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
     
//     NSDateFormatter *df = [NSDateFormatter new];
//     [df setDateFormat:@"YYYY-MM"];
//     NSString *dateStr = [df stringFromDate:newDate];
     
     return newDate;
}


//-(void)getUserInfoNotification:(BSNotification *)noti
//{
//    _requestCount--;
//    if (_requestCount == 0) {
//        BASENOTIFICATION(noti);
//    }
//    else
//    {
//        BASENOTIFICATIONWITHCANMISS(noti, NO);
//    }
//    if (noti.error.code == 0) {
//        
//        if (busiSystem.agent.userInfo.cardNo.length == 0) {
//            UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:nil message:@"您还未绑定礼品卡,需先绑定礼品卡才可兑换商品。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往绑定", nil] ;
//            alert.tag = 1;
//            [alert show];
//            return ;
//        }
//        if (_isActivity) {
//            ConfirmActivityOrderViewController *vc = [ConfirmActivityOrderViewController new];
//            vc.goods = _goodsDetail;
//            vc.num = _number;
//            [self.navigationController pushViewController:vc animated:YES];
//        }else{
//            ConfirmOrderOfGoodsViewController *vc = [ConfirmOrderOfGoodsViewController new];
//            vc.goods = _goodsDetail;
//            vc.num = _number;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//
//        
//        
//    }
//    else
//    {
//        HUDCRY( noti.error.domain , 1);
//    }
//}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if (alertView.tag == 1) {
//            BindGiftCardViewController *vc = [BindGiftCardViewController new];
//            [self.navigationController pushViewController:vc animated:YES];
        }
//     SelectAddressViewController *vc = [SelectAddressViewController new];
//       [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)alertAction{
    NSLog(@"alert");
}


-(void)collectionAction{
//     [self.navigationController popViewControllerAnimated:YES];
     if (!busiSystem.agent.isLogin) {
          [LoginViewController toLogin:self];
          return;
     }
     NSLog(@"collect");
     [self addGoodsCollect];
}

-(void)shareAction{
//     [self.navigationController popViewControllerAnimated:YES];
//     NSLog(@"share");
//     NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"shareLogo@2x" ofType:@"png"];
//     
//     NSString *url = busiSystem.agent.config.shareUrl;
//     [[JYShareManager manager] showSheetView:self withShareTitle:@"尚享生活" withShareContent:@"尚享生活,每天与你相遇" withShareImgUrl:imagePath withUrl:url];
//     [[JYShareManager manager] showSheetView:self withShareTitle:@"" withShareContent:@"" withShareImgUrl:imagePath withUrl:url];
}


-(void)addGoodsCollect{
     HUDSHOW(@"加载中");
     [busiSystem.shopManager addGoodsCollect:_ID userId:busiSystem.agent.userId observer:self callback:@selector(addGoodsCollectNotification:)];
}


-(void)addGoodsCollectNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          NSString *message = busiSystem.shopManager.message;
          HUDSMILE(message , 1);
          if ([message isEqualToString:@"收藏成功"]) {
               _goodsInfo.isCollection = YES;
          }else{
               _goodsInfo.isCollection = NO;
          }
          collection.customImgV.image = [UIImage imageNamed:_goodsInfo.isCollection?@"icon_collection_sel": @"icon_collection_unsel"];
     }
     else
     {
          HUDCRY( noti.error.domain , 2);
     }
}

-(void)addUserCart:(NSString *)goodsId{
     HUDSHOW(@"加载中");
     [busiSystem.userManager addUserCart:goodsId count:1 observer:self callback:@selector(addUserCartNotification:)];
}


-(void)addUserCartNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          HUDSMILE(@"添加成功", 2);
          _cartCount ++;
          _redDotLb.hidden = NO;
          _redDotLb.text = [NSString stringWithFormat:@"%ld",(long)_cartCount];
          CGSize size = [_redDotLb.text size:_redDotLb.font constrainedToSize:CGSizeMake(200, 15)];
          _redDotLb.width = size.width +8;
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}

-(void)initTableView{
    
     __weak GoodsInfoViewController *weakSelf = self;
     
     
     _fourTabsCell = [FourTabsTableViewCell createTableViewCell];
     [_fourTabsCell setHandleAction:^(NSDictionary *dic) {
          NSInteger index = [dic[@"index"] integerValue];
          if (index == 0) {
               weakSelf.tableView.scrollEnabled = YES;
               CGFloat y = [dic[@"y"] floatValue];
               CGRect rect = CGRectMake(0, _tableView.contentOffset.y+y, __SCREEN_SIZE.width, weakSelf.tableView.height);
               [weakSelf.tableView scrollRectToVisible:rect animated:NO];
          }
          else if(index == 1){
               [weakSelf setupPhotoBrowser:dic];
          }
          
     }];
     
     _noEvaCell = [NoDataTableViewCell createTableViewCell];
     [_noEvaCell setCellData:@{@"title":@"暂无评价",@"img":@"noEva"}];
     [_noEvaCell fitCellMode];
     
     
     _noPromotionCell = [NoDataTableViewCell createTableViewCell];
     [_noPromotionCell setCellData:@{@"title":@"暂无相关推荐",@"img":@"nodata"}];
     [_noPromotionCell fitCellMode];
     
     _flashCell = [GoodsFlashTableViewCell createTableViewCell];
     [_flashCell setCellData:@{@"arr":@[]}];
    [_flashCell fitGoodsInfoMode];
     [_flashCell setSelecedtItem:^(NSDictionary *dic) {
//          if (!_canClick) {
//               _canClick = YES;
//               return;
//          }
          NSInteger row = [dic[@"row"] integerValue];
          NSMutableArray *imgArr = [NSMutableArray new];
          NSArray *arr = weakSelf.goodsInfo.pictureList;
          if (arr.count !=0) {
               for (int i =0;i<arr.count;i++) {
                    UIImageView *myImageView = [[UIImageView alloc]init];
                    [imgArr addObject:myImageView];
               }
               [weakSelf setupPhotoBrowser:@{@"arr":arr?:@[],@"row":@(row),@"imgArr":imgArr}];
          }
     }];
     
     

     
    
//    __weak GoodsInfoViewController *weakSelf = self;
    _priceCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
     [_priceCell setCellData:@{@"title":@"",@"source":@"0笔",@"time":@"0.00",@"mark":@"[全新]",@"standards":@"元/天",@"price":@"商品价值¥0.00"}];
    [_priceCell fitGoodsMode];
     
     
     
     _serviceCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_serviceCell setCellData:@{@"arr":@[@"买断须知",@"全新正品",@"售后无忧",@"顺丰包邮"],@"hasMore":@(YES)}];
     [_serviceCell fitGoodsInfoModeA];
     
     
     _creditCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
     [_creditCell  setCellData:@{@"title":@"芝麻信用",@"detail":@"芝麻分650及以上可减免押金",@"img":@"arrow_right_goods"}];
     [_creditCell fitGoodsInfoModeC];
     
     
     _selectStardardCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
     [_selectStardardCell setCellData:@{@"title":@"请选择:",@"source":@"网络/颜色/规格/租期",@"time":@""}];
     [_selectStardardCell fitGoodsModeA];
     [_selectStardardCell setHandleAction:^(NSDictionary *dic) {
//          if (!_canClick) {
//               _canClick = YES;
//               return;
//          }
          if (!busiSystem.agent.isLogin) {
               [LoginViewController toLogin:weakSelf];
               return ;
          }
          if (weakSelf.productPrice == nil) {
               [weakSelf createFirstSelectedGoodsTypeVC:0];
          }else{
               [weakSelf createSelectedGoodsTypeVC:0];
          }
     }];
     
     _showAllEvaCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_showAllEvaCell setCellData:@{@"title":@"查看全部评价"}];
     [_showAllEvaCell fitGoodsInfoMode];
     [_showAllEvaCell setHandleAction:^(id sender) {
          
          EvalutionListViewController *vc = [EvalutionListViewController new];
          vc.goodsId = weakSelf.ID;
          [self.navigationController pushViewController:vc animated:YES];
     }];
     
//     _shopInfoCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
//     [_shopInfoCell setCellData:@{@"img":@"icon_shop",@"title":@"",@"source":@"店铺编号：",@"time":@""}];
//     [_shopInfoCell fitGoodsModeA];
     
//    [_shopInfoCell setHandleAction:^(NSDictionary *dic) {
////         ShopInfoViewController *vc = [ShopInfoViewController new];
////         [weakSelf.navigationController pushViewController:vc animated:YES];
//         [weakSelf.navigationController popViewControllerAnimated:YES];
//    }];
    
     _promotionTitleCell = [TitleDetailTableViewCell createTableViewCell];
     [_promotionTitleCell setCellData:@{@"title":@"相关推荐",@"detail":@""}];
     [_promotionTitleCell fitShopInfoMode];
    
    _intruduceCell = [OnlyTitleTableViewCell createTableViewCell];
    [_intruduceCell setCellData:@{@"title":@""}];
    [_intruduceCell fitHtmlMode];
    
     
     _rentRegularCell = [OnlyTitleTableViewCell createTableViewCell];
     [_rentRegularCell setCellData:@{@"title":@""}];
     [_rentRegularCell fitHtmlMode];
    
    
    [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
    [ImgsTableViewCell registerTableViewCell:_tableView];
     [_tableView registerNib:[UINib nibWithNibName:@"ImgAndThreeTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"promotion"];
    
    _tableView.x = 0;
    
    _tableView.width = __SCREEN_SIZE.width;
   
     _tableView.y =  -NAVBARHEIGHT;
     _tableView.height = __SCREEN_SIZE.height -54- TABBARNONEHEIGHT;
    
   
    _tableView.refreshHeaderView = nil;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     _tableView.showsVerticalScrollIndicator = NO;

     self.view.backgroundColor = kUIColorFromRGB(color_f8f8f8);
    
}

#pragma mark - photo

- (void) setupPhotoBrowser:(NSDictionary *)dic{
     // 图片游览器
     ZLPhotoPickerBrowserViewController *pickerBrowser  = [[ZLPhotoPickerBrowserViewController alloc] init];
     // 数据源/delegate
     //    pickerBrowser.delegate = self;
     // 数据源可以不传，传photos数组 photos<里面是ZLPhotoPickerBrowserPhoto>
     pickerBrowser.photos = [self addZLPhotoPickerBrowserPhotoArr:dic[@"arr"] withImgVArr:dic[@"imgArr"]];
     // 是否可以删除照片
     //    pickerBrowser.editing = YES;
     // 当前选中的值
     pickerBrowser.currentIndexPath = [NSIndexPath indexPathForRow:[dic[@"row"] integerValue] inSection:0];
     // 展示控制器
     [pickerBrowser showPickerVc:self];
     //    [self.navigationController pushViewController:pickerBrowser animated:NO ];
}

- (NSMutableArray *)addZLPhotoPickerBrowserPhotoArr:(NSArray *)arr withImgVArr:(NSArray *)imgArr;
{
     NSMutableArray * mArr =[NSMutableArray new];
     for (int i=0; i<arr.count; i++)
     {
          ZLPhotoPickerBrowserPhoto *photo =[ZLPhotoPickerBrowserPhoto new];
          BUImageRes *im = arr[i];
          UIImage *d;
          UIImage *ii;
          if ([im isKindOfClass:[UIImage class]]) {
               d = (UIImage *)im;
               ii = (UIImage *)im;
               photo.thumbImage = d;
               photo.photoImage = ii;
          }
          else
          {
               if(im.isCached)
               {
                    d= [UIImage imageWithContentsOfFile:im.cacheThumbFile];
                    ii = [UIImage imageWithContentsOfFile:im.cacheFile];
                    photo.thumbImage = d;
                    photo.photoImage = ii;
               }
               else
               {
                    photo.thumbImage = [UIImage imageNamed:@"defaultPicture"];
                    photo.photoImage = [UIImage imageNamed:@"defaultPicture"];
               }
          }
          photo.aspectRatioImage = ii;
          photo.toView = imgArr[i];
          [mArr addObject:photo];
     }
     return mArr;
}


-(void)addUserFavorite{
    HUDSHOW(@"提交中");
    _requestCount++;
    NSString *type = @"1";
     NSString *artId = @"";
//    if (_isPresentCard) {
//        type = @"2";
//    }else{
//        if (_isActivity) {
////            artId = _goodsDetail.actId;
//        }
//    }
   
    
//    [busiSystem.getUserFavoriteManager addUserFavorite:type withId:_ID withArtId:artId withType:@"1"  observer:self callback:@selector(addUserFavoriteNotification:)];
}

-(void)addUserFavoriteNotification:(BSNotification *)noti
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
        _isCollection = YES;
        TOASTSHOW(@"收藏成功!");
        [_tableView reloadData];
         busiSystem.agent.isNeedRefreshTabD = YES;
    }
    else
    {
        HUDCRY( noti.error.domain , 1);
    }
}

-(void)delUserFavorite{
    HUDSHOW(@"提交中");
    _requestCount++;
//    [busiSystem.getUserFavoriteManager delUserFavorite:_ID observer:self callback:@selector(delUserFavoriteNotification:)];
}

-(void)delUserFavoriteNotification:(BSNotification *)noti
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
        _isCollection = NO;
        TOASTSHOW(@"取消收藏成功!");
        [_tableView reloadData];
    }
    else
    {
        HUDCRY( noti.error.domain , 1);
    }
}

/*
-(void)viewWillDisappear:(BOOL)animated
{

    CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor: kUIColorFromRGB(color_mainTheme) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;

    self.navigationController.navigationBar.alpha = 1;

    _tableView.scrollEnabled = NO;
    if (__IOS9) {
        _tableView.delegate = nil;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    [_tableView reloadData];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
    //   if (_tableView.contentOffset.y >= _tableView.contentInset.top && _tableView.contentOffset.y <= _tableView.contentInset.top + 3) {
    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_mainTheme,alp) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    //    }
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [super viewWillAppear:animated];
//    busiSystem.agent.selectedIndex =0;
//    if (busiSystem.agent.gotoOder==YES) {
//        self.tabBarController.selectedIndex=1;
//        busiSystem.agent.gotoOder=NO;
//    }
    if (_needReloadData) {
        _needReloadData = NO;
        if (busiSystem.agent.isLogin) {
            HUDSHOW(@"加载中");
            [self getData];
        }
        
        
    }
    
    
}
 
*/

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

     NSInteger section = 2;
//     if (_state == 3) {
//          section = 1+( _tableView.extroDataArr.count?:1);
//     }
    return section;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row = 2;

    if (section == 0) {
        row = 5;
    }else{
         row = 1;
//         if (_state == 0){//图文详情
//              row = 1;
//         }
//         else if (_state == 1){//商品参数
//              row = _goodsInfo.productParamterList.count;
//         }
//         else if (_state == 2){//租赁规则
//              row = 1;
//         }
//         else{//用户评价
//              if (_tableView.extroDataArr.count == 0) {//无评价
//                   row = 1;
//              }else
//                   row = 2;
//         }

    }
     
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
//    cell = [UITableViewCell new];
     
    if (indexPath.section == 0) {
         cell = [self creatFirstSectionCell:indexPath];
    }else{
         cell = _fourTabsCell;
//         if (_state == 0){//图文详情
//              cell = _intruduceCell;
//         }
//         else if (_state == 1){//商品参数
//              cell = [self createParameterCell:indexPath];
//         }
//         else if (_state == 2){//租赁规则
//              cell = _rentRegularCell;
//         }
//         else{//用户评价
//              cell = [self createEvaInfoCell:indexPath];
//         }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



-(UITableViewCell *)createParameterCell:(NSIndexPath *)indexPath{
     TitleDetailTableViewCell *cell ;
     
     cell = [TitleDetailTableViewCell createTableViewCell];
     BUProductParamter *p = _goodsInfo.productParamterList[indexPath.row];
     NSDictionary *dic = [p getDic];
     [cell setCellData:dic];
     if (indexPath.row == 0) {
          [cell fitGoodsInfoMode:20];
     }else{
          [cell fitGoodsInfoMode:13];
     }
     
     
     return cell;
}

-(UITableViewCell *)createPromotioneCell:(NSIndexPath *)indexPath{
     UITableViewCell *cell;
//     if (indexPath.row == 0) {
//          cell = _promotionTitleCell;
//     }else{
//          if (_goodsDetail.goodsList.count == 0) {
//               cell = _noPromotionCell;
//          }else{
//               ImgAndThreeTitleTableViewCell *tempCell = [_tableView dequeueReusableCellWithIdentifier:@"promotion"];
//               BUGoodsInfo *goods = _goodsDetail.goodsList[indexPath.row -1];
//               [tempCell setCellData:[goods getDic:0]];
//               [tempCell fitShopInfoMode];
//               [tempCell setHandleAction:^(id sender) {
//                    NSLog(@"加入购物车");
//               }];
//               [tempCell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(tempCell.height, 15, 0, 15)];
//               cell = tempCell;
//          }
//
//     }

     [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
     return cell;
}


-(UITableViewCell *)createEvaCell:(NSIndexPath *)indexPath{
     UITableViewCell *cell ;
//     if (indexPath.section == _goodsDetail.commentList.count+1) {//显示全部评价
//          if (_goodsDetail.commentList.count == 0) {
//               cell = _noEvaCell;
//          }else
//               cell = _showAllEvaCell;
//            [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
//
//     }else if (indexPath.section == _goodsDetail.commentList.count+2){//推荐
//          cell = [self createPromotioneCell:indexPath];
//     }else{//评价
//          cell =  [self createEvaInfoCell:indexPath];
//
//     }
   
     return cell;
}

-(UITableViewCell *)createEvaInfoCell:(NSIndexPath *)indexPath{
     UITableViewCell *cell ;
     
     if (_tableView.extroDataArr.count == 0) {
          cell = _noEvaCell;
     }
     else{
          BUGetComment *comment = _tableView.extroDataArr[indexPath.section - 1];
          if (indexPath.row == 0) {
               cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
               NSDictionary *dic = [comment getDic:0];;
               [(ImgAndThreeTitleTableViewCell *)cell setCellData:dic];
               [(ImgAndThreeTitleTableViewCell *)cell fitEvaMode];
               //          if (comment.imageList.count == 0) {
               //               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
               //          }else{
               [(JYAbstractTableViewCell *)cell hiddenSeparatorView];
               //          }
          }else{
               cell = [ImgsTableViewCell dequeueReusableCell:_tableView];
               
               
               //          if (comment.imageList.count == 0) {
               //               cell.hidden = YES;
               //               [(JYAbstractTableViewCell *)cell hiddenSeparatorView];
               //          }else{
               NSDictionary *dic = [comment getDic:1];
               [(ImgsTableViewCell *)cell setCellData:dic];
               [(ImgsTableViewCell *)cell fitMode];
               [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
               //          }
               __weak GoodsInfoViewController *weakSelf = self;
               [(ImgsTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
//                    if (!_canClick) {
//                         _canClick = YES;
//                         return;
//                    }
                    NSInteger row = [dic[@"row"] integerValue];
                    NSMutableArray *imgArr = [NSMutableArray new];
                    NSArray *arr = comment.picList;
                    if (arr.count !=0) {
                         for (int i =0;i<arr.count;i++) {
                              UIImageView *myImageView = [[UIImageView alloc]init];
                              [imgArr addObject:myImageView];
                         }
                         [weakSelf setupPhotoBrowser:@{@"arr":arr?:@[],@"row":@(row),@"imgArr":imgArr}];
                    }
               }];
               
          }
     }
     
     
     
     return cell;
}


-(UITableViewCell *)creatFirstSectionCell:(NSIndexPath *)indexPath{
     UITableViewCell *cell ;
     if (indexPath.row == 0) {
          cell = _flashCell;
          
     }else if (indexPath.row == 1){
          cell =_priceCell;
     }
     else if (indexPath.row == 2){
          cell = _selectStardardCell;
     }
     else if (indexPath.row == 3){
          cell = _creditCell;
     }
     else{
          cell = _serviceCell;
          
     }
//     [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
     return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 35;

     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               height = _flashCell.height;
          }
          else if (indexPath.row == 1){
               height = _priceCell.height;
          }
          else if (indexPath.row == 2){
               height = 72;
          }
          else if (indexPath.row == 3){
               height = 45;
          }
          else{
               height = 80;
          }
     }else {
          height = __SCREEN_SIZE.height -NAVBARHEIGHT - TABBARNONEHEIGHT - 54;
//          if (_state == 0) {
//               height = _intruduceCell.height;
//          }
//          else if (_state == 1){
//               TitleDetailTableViewCell *cell ;
//               cell = [TitleDetailTableViewCell createTableViewCell];
//               BUProductParamter *p = _goodsInfo.productParamterList[indexPath.row];
//               NSDictionary *dic = [p getDic];
//               [cell setCellData:dic];
//               if (indexPath.row == 0) {
//                    [cell fitGoodsInfoMode:20];
//               }else{
//                    [cell fitGoodsInfoMode:13];
//               }
//               if (indexPath.row == _goodsInfo.productParamterList.count-1) {
//                    height = cell.height+20;
//               }else{
//                    height = cell.height;
//               }
//
//
//          }
//          else if (_state == 2){
//               height = _rentRegularCell.height;
//          }else if (_state == 3){
//               if (_tableView.extroDataArr.count == 0) {
//                    height = 250;
//               }else{
//                    UITableViewCell *cell ;
//                    BUGetComment *comment = _tableView.extroDataArr[indexPath.section - 1];
//                    if (indexPath.row == 0) {
//                         cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
//                         NSDictionary *dic = [comment getDic:0];
//                         [(ImgAndThreeTitleTableViewCell *)cell setCellData:dic];
//                         [(ImgAndThreeTitleTableViewCell *)cell fitEvaMode];
//                         height = cell.height;
//                    }else{
//                         cell = [ImgsTableViewCell dequeueReusableCell:_tableView];
//
//                         NSDictionary *dic = [comment getDic:1];
//                         [(ImgsTableViewCell *)cell setCellData:dic];
//                         [(ImgsTableViewCell *)cell fitMode];
//                         height = cell.height;
//
//                    }
//               }
//
//
//
//          }
     }
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     CGFloat height = 0.001;
     if (section == 0 ) {
          height =  10;
     }
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//     if (section == 1) {
//          return 45;
//     }
    return 0.01;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//     if (section == 1) {
//          return _menuView;
//     }
//     return nil;
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
//     if (!_canClick) {
//          _canClick = YES;
//          return;
//     }

     if (indexPath.section == 0){
          if (indexPath.row == 4) {
               NSDictionary *dic = [_goodsInfo getDic:4];
               [OrderServiceIntruduceViewController createVC:dic];
//               [self.navigationController pushViewController:vc animated:YES];
          }else if (indexPath.row == 3){
               if (!busiSystem.agent.isLogin) {
                    _needReloadData = YES;
                    [LoginViewController toLogin:self];
                    return;
               }
//               if (!busiSystem.agent.isCredit) {
//                    NoCashApproveViewController *VC= [NoCashApproveViewController new];
//                    [self.navigationController pushViewController:VC animated:YES];
//               }

               if (busiSystem.agent.isCredit == 0) {
                    _needReloadData = YES;
                    ZhiMaAuthViewController *vc = [ZhiMaAuthViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
               }
               else
               {
                    NoCashApproveViewController *vc = [NoCashApproveViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
               }
          }
     }

}



#pragma mark -- loadNextPage
-(void)loadNextPage{
     _requestCount++;
     [busiSystem.getCommentListManager getCommentListNextPage:self callback:@selector(getCommentListNotification:)];
}


#pragma mark - scroll


-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
     //     [self.navigationController setNavigationBarHidden:YES];
     self.panGesture.enabled = NO;
     self.navigationController.navigationBar.translucent = YES;
     self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//     [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
     self.navigationController.navigationBar.alpha = 0.02;
     //          _backBtn.alpha = 1-d;
     [self scrollViewDidScroll:_tableView];
#ifdef __IPHONE_11_0
     if ([_tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
          _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
     }
#endif

     if (_needReloadData) {
          _needReloadData = NO;
          HUDSHOW(@"加载中");
          [self getGoodsData];
     }

}



-(void)viewWillDisappear:(BOOL)animated{
     [super viewWillDisappear:animated];
     self.panGesture.enabled = YES;
     self.navigationController.navigationBar.translucent = NO;
     self.automaticallyAdjustsScrollViewInsets = YES;
//     alp = 0.1;
     self.navigationController.navigationBar.alpha = 1;
     CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, NAVBARHEIGHT);
     [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,1) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
#ifdef __IPHONE_11_0
     if ([_tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
          _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
     }
#endif
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView != _tableView)
    {
        return;
    }
     
//     CGFloat y = 300;
//     if (y >= scrollView.contentOffset.y+_tableView.y) {
//          if (_tableView.y == 0) {
//               _tableView.y =  -NAVBARHEIGHT;
//               _tableView.height = __SCREEN_SIZE.height -54- TABBARNONEHEIGHT;
//               CGRect rect = CGRectMake(0, scrollView.contentOffset.y-NAVBARHEIGHT, __SCREEN_SIZE.width, scrollView.height);
//               [scrollView scrollRectToVisible:rect animated:NO];
//          }
//
//     }else  //if (y == scrollView.contentOffset.y+_tableView.y+5)
//     {
//          if (_tableView.y != 0) {
//               _tableView.y =  0;
//               _tableView.height = __SCREEN_SIZE.height -54- TABBARNONEHEIGHT-NAVBARHEIGHT;
//               CGRect rect = CGRectMake(0, scrollView.contentOffset.y+NAVBARHEIGHT, __SCREEN_SIZE.width, scrollView.height);
//               [scrollView scrollRectToVisible:rect animated:NO];
//          }
//
//
//     }
     //判断是否滑动到底部
     CGFloat height = scrollView.frame.size.height;
     CGFloat contentOffsetY = scrollView.contentOffset.y;
     CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
     if (bottomOffset <= height && contentOffsetY >height)
     {
          _tableView.scrollEnabled = NO;
          [_fourTabsCell changeTableViewScroll:YES];
     }
//    else{
//          _tableView.scrollEnabled = YES;
//          [_fourTabsCell changeTableViewScroll:NO];
//     }
     
     

    if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= 3) {
        self.navigationController.navigationBar.alpha = 0.02;
         _backBtn.alpha = 1;
        alp = 0.02;
        CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, NAVBARHEIGHT);
        [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,0.1) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];

    }
    else
    {
        CGFloat d =  scrollView.contentOffset.y/124.0;
         if (scrollView.contentOffset.y<0) {
              d = 0;
         }
        if (d > 1) {
            d = 1;
        }else if (d < 0.1)
        {
            d = 0.02;
        }
         if (d <= 0.2) {
              self.navigationController.navigationBar.alpha = 0;
              _backBtn.alpha = 1;
              if (self.titleLB.text.length != 0 ) {
                   self.titleLB.text = @"";
              }
         }else{
              self.navigationController.navigationBar.alpha = d;
              _backBtn.alpha = 0;
              if (self.titleLB.text.length == 0 ) {
                   self.titleLB.text = _goodsInfo.name?:@"";
              }
         }
       
//        if (scrollView.contentOffset.y > 5) {
            CGFloat c = scrollView.contentOffset.y/124.0 + 0.1;
            if (c > 1) {
                c = 1;
            }
            else if (c <= 0.02)
            {
                c = 0.02;
                
            }
            alp = c;
            CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, NAVBARHEIGHT);
            [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,c) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
//        }
//         NSLog(@"y = %.2f d = %.2f c = %.2f",scrollView.contentOffset.y,d,alp);
    }
}
-(void)viewDidLayoutSubviews
{
    //    self.navigationController.view.y = 0;
//    _tableView.width = __SCREEN_SIZE.width;
//    _tableView.height = __SCREEN_SIZE.height - 54-TABBARNONEHEIGHT;
//    _tableView.y = -64;
    if (!self.hasInit) {
        if (!_tableView.isRefreshing) {
            [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }

        self.hasInit = YES;
    }
}

-(void)handleReturnBack:(id)sender
{
    [_tableView setContentOffset:CGPointMake(0, 0)];
    _tableView.scrollEnabled = NO;
    if (__IOS9) {
        _tableView.delegate = nil;
    }
    
    _tableView.scrollEnabled = NO;
    _tableView  = nil;
    _ID = nil;
    [_flashCell setNull];
    [super handleReturnBack:sender];

}




@end
