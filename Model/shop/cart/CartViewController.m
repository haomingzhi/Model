//
//  CartViewController.m
//  oranllcshoping
//
//  Created by Steve on 2017/7/19.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "CartViewController.h"
#import "CartTableViewCell.h"
#import "FillInOrderInfoViewController.h"
#import "OrderServiceIntruduceViewController.h"
#import "SelectedGoodsTypeViewController.h"
#import "BUSystem.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "LoginViewController.h"
//#import "PopularityRecViewController.h"
#import "ChoseAddressViewController.h"
#import "GoodsInfoViewController.h"

@interface CartViewController ()
{
     UIView *bottomView;
     UIButton *topBtn;
     ImgAndThreeTitleTableViewCell *_noDataCell;
     TitleDetailTableViewCell *_sepcTipCell;
     
}
@property (nonatomic,strong) NSMutableArray *selectedArr;
@property (nonatomic,strong) NSMutableArray *numsArr;
@property (nonatomic,assign) BOOL isEdit;
@property (nonatomic,assign) BOOL isAllSelected;
@property (nonatomic,strong) UIImageView *allSelectedImv;
@property (nonatomic,strong) UIButton *payBtn;//结算
@property (nonatomic,strong) UIButton *shareBtn;
@property (nonatomic,strong) UIButton *collectionBtn;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UILabel *sumPriceLb;
@property (nonatomic,strong) UILabel *sumPriceTitleLb;
@property (nonatomic,assign) CGFloat sumPrice;
@property (nonatomic,strong) NSMutableArray *dataArr;//可用
//@property (nonatomic,strong) NSMutableArray *outOfRangeArr;//超出范围
@property (nonatomic,strong) NSMutableArray *outOfDateArr;//失效
@property (nonatomic,assign) BOOL isNoData;//是否有数据
@property (nonatomic,assign) BOOL isPushLogin;//是否去登录
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self setNavigate];
//     [self addTopView];
     [self initTableView];
     [self addBottomView];
     self.title = @"购物车";
//     [self testData];
}

-(void)testData{
     _dataArr = [NSMutableArray new];
     BUCartSumPrice *sum = [BUCartSumPrice new];
     sum.dataArr = [NSMutableArray arrayWithArray:@[@""]];
     [_dataArr addObject:sum];
}

-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
//     if (busiSystem.agent.isLogin) {
     HUDSHOW(@"加载中");
     [self getData];
//     }else{
//
//          LoginViewController *vc = [LoginViewController new];
//          vc.isPushHome = YES;
//          vc.hidesBottomBarWhenPushed = YES;
//          [self.navigationController pushViewController:vc animated:YES];
//          [vc setHandleGoBack:^(id userData) {
//               HUDSHOW(@"加载中");
//               [self getData];
//          }];
//
//
//     }
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData{
//     HUDSHOW(@"加载中");
//     [busiSystem.orderManager getShoppingCartList:busiSystem.agent.userId?:@"" log:busiSystem.agent.log?:@"0" lat:busiSystem.agent.lat?:@"0" observer:self callback:@selector(getShoppingCartListNotification:)];
     [busiSystem.userManager getShoppingCartList:busiSystem.agent.userId observer:self callback:@selector(getShoppingCartListNotification:)];
}


-(void)getShoppingCartListNotification:(BSNotification *)noti{
     
     if (_tableView.isRefreshing) {
          //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
          [self refreshTableHeaderNotification:noti myTableView:_tableView];
          [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
          _tableView.isRefreshing = NO;
     }
     if (noti.error.code == 0) {
          HUDDISMISS;
          _dataArr = [NSMutableArray arrayWithArray:busiSystem.userManager.cartInfo.shopList];
          _outOfDateArr = [NSMutableArray arrayWithArray:busiSystem.userManager.cartInfo.invalidGoodsList];
          if (_dataArr.count == 0 && _outOfDateArr.count ==0 ) {
               if (_isEdit) {
                    [self handleDidRightButton:nil];
                    _isEdit = NO;
               }
               [self setNavigateRightButton:@"" font:[UIFont systemFontOfSize:13] color:kUIColorFromRGB(color_1)];
               _isNoData = YES;
//               [self getPopularityProductData];
               _tableView.y = 0;
               _tableView.height = __SCREEN_SIZE.height - 64;
               topBtn.x = __SCREEN_SIZE.width*2;
               [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:0 withTag:@"nodata"];
               [[JYNoDataManager manager] fitModeY:100];
          }else{
               _isNoData = NO;
               [_tableView reloadData];
               HUDDISMISS;
               _tableView.height = __SCREEN_SIZE.height - 64;
               topBtn.x = 0;
               _isEdit = NO;
               [self editChangeBottom];
               [self setNavigateRightButton:@"编辑" font:[UIFont systemFontOfSize:13] color:kUIColorFromRGB(color_1)];
               [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:1 withTag:@"nodata"];
               [[JYNoDataManager manager] fitModeY:100];
          }
          

     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}

-(void)getPopularityProductData{
//     _requestCount ++;
//     [busiSystem.getPopularityProductPageListManager getList:busiSystem.agent.storeId observer:self callback:@selector(getPopularityProductPageListNotification:)];
}

-(void)getPopularityProductPageListNotification:(BSNotification *)noti{
//     _requestCount --;
//     if (_requestCount == 0) {
          HUDDISMISS;
//     }
     
     if (noti.error.code == 0) {
//          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getPopularityProductPageListManager.dataArr];
          [_tableView reloadData];
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}


-(void)addBottomView{
     bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, __SCREEN_SIZE.height - 64-45, __SCREEN_SIZE.width, 45)];
     bottomView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     bottomView.layer.borderWidth = 0.5;
     bottomView.backgroundColor = kUIColorFromRGB(color_2);
     [self.view addSubview:bottomView];
     bottomView.hidden = YES;
     
//     _allSelectedImv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 15, 15)];
//     _allSelectedImv.image = [UIImage imageContentWithFileName:@"icon_unselected"];
//     [bottomView addSubview:_allSelectedImv];
//
//     UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(47, 0, 30, 45)];
//     label.textColor = kUIColorFromRGB(color_8);
//     label.font = [UIFont systemFontOfSize:13.0];
//     label.text = @"全选";
//     [bottomView addSubview:label];
     
//     UIButton *allselectedBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 45)];
//     [allselectedBtn addTarget:self action:@selector(allSelectedAction) forControlEvents:UIControlEventTouchUpInside];
//     [bottomView addSubview:allselectedBtn];
//
//     _sumPriceTitleLb = [[UILabel alloc]initWithFrame:CGRectMake(93, 0, 100, 45)];
//     _sumPriceTitleLb.text = @"商品总价:";
//     _sumPriceTitleLb.textColor = kUIColorFromRGB(color_1);
//     if (__SCREEN_SIZE.width >320) {
//          _sumPriceTitleLb.font = [UIFont systemFontOfSize:15.0];
//     }else{
//          _sumPriceTitleLb.font = [UIFont systemFontOfSize:13.0];
//     }
     
//     [_sumPriceTitleLb sizeToFit];
//     _sumPriceTitleLb.height = 45;
//     [bottomView addSubview:_sumPriceTitleLb];
     
//     _sumPriceLb = [[UILabel alloc]initWithFrame:CGRectMake(_sumPriceTitleLb.x + _sumPriceTitleLb.width +2, 0, 100, 45)];
//     _sumPriceLb.textColor = kUIColorFromRGB(color_0xf82D45);
//
//     if (__SCREEN_SIZE.width >320) {
//          _sumPriceLb.font = [UIFont systemFontOfSize:15.0];
//     }else{
//          _sumPriceLb.font = [UIFont systemFontOfSize:13.0];
//     }
//     _sumPriceLb.text = @"¥0.00";
//     [bottomView addSubview:_sumPriceLb];
//
//     _payBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 115, 0, 115, 45)];
//     _payBtn.backgroundColor = kUIColorFromRGB(color_3);
//     [_payBtn setTitle:@"去结算" forState:UIControlStateNormal];
//     [_payBtn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
//     _payBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//     [_payBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
//     [bottomView addSubview:_payBtn];
//
     _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width-70-15, 7.5, 70, 30)];
     [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
     _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
     [_deleteBtn setTitleColor:kUIColorFromRGB(color_7) forState:UIControlStateNormal];
     _deleteBtn.layer.masksToBounds = YES;
     _deleteBtn.layer.cornerRadius = 6.0;
     _deleteBtn.layer.borderColor = kUIColorFromRGB(color_7).CGColor;
     _deleteBtn.layer.borderWidth = 0.5;
     [_deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
     [bottomView addSubview:_deleteBtn];
     
//     _collectionBtn = [[UIButton alloc]initWithFrame:CGRectMake(_deleteBtn.x - 15 - 80, 7.5, 80, 30)];
//     [_collectionBtn setTitle:@"已到收藏夹" forState:UIControlStateNormal];
//     _collectionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//     [_collectionBtn setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
//     _collectionBtn.layer.masksToBounds = YES;
//     _collectionBtn.layer.cornerRadius = 6.0;
//     _collectionBtn.layer.borderColor = kUIColorFromRGB(color_8).CGColor;
//     _collectionBtn.layer.borderWidth = 0.5;
//     [_collectionBtn addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
//     [bottomView addSubview:_collectionBtn];
//
//     _shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(_collectionBtn.x - 15 - 80, 7.5, 80, 30)];
//     [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
//     _shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//     [_shareBtn setTitleColor:kUIColorFromRGB(color_8) forState:UIControlStateNormal];
//     _shareBtn.layer.masksToBounds = YES;
//     _shareBtn.layer.cornerRadius = 6.0;
//     _shareBtn.layer.borderColor = kUIColorFromRGB(color_8).CGColor;
//     _shareBtn.layer.borderWidth = 0.5;
//     [_shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
//     [bottomView addSubview:_shareBtn];
     
     [self editChangeBottom];
     
}

-(void)shareAction{
     
}

-(void)collectionAction{
     
}

-(void)deleteAction:(UIButton *)btn{
     NSMutableArray *arr = [NSMutableArray new];
     [_dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUCartShopInfo *sum = obj;
          [sum.goodsList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUCartShopGoods *g = obj;
               if (g.isSelected) {
                    [arr addObject:g.waterId];
               }
          }];
     }];
     if (arr.count == 0) {
          HUDCRY(@"请选择商品", 2);
          return;
     }
     [[CommonAPI managerWithVC:self] showAlert:@selector(deleteHandle:) withTitle:[NSString stringWithFormat:@"确定删除购物车中%lu种商品吗？",(unsigned long)arr.count] withMessage:nil withObj:@{@"arr":arr}];
}


-(void)deleteHandle:(NSDictionary *)dic{
     if ([dic[@"code"] integerValue]==0) {
          NSMutableArray *arr = dic[@"arr"];
          [self deleteGoods:arr];
     }
}



-(void)deleteGoods:(NSMutableArray *)arr{
    //arr 购物车商品id
     HUDSHOW(@"加载中");
     [busiSystem.orderManager shoppingCartDelBatch:arr  observer:self callback:@selector(shoppingCartDelBatchNotification:) extraInfo:@{@"arr":arr?:@[]}];
}


-(void)shoppingCartDelBatchNotification:(BSNotification *)noti{
     if (noti.error.code == 0) {
          [self getData];
//          [_tableView reloadData];
          
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}



-(void)addShoppingCart:(NSString *)productId withProCount:(NSInteger)proCount{
//     HUDSHOW(@"提交中");
//     [busiSystem.orderManager addShoppingCart:productId storeId:busiSystem.agent.storeId withProCount:proCount userId:busiSystem.agent.userId?:@"" observer:self callback:@selector(addShoppingCartNotification:)];
     [busiSystem.userManager addUserCart:productId count:proCount observer:self callback:@selector(addShoppingCartNotification:)];
}

-(void)addShoppingCartNotification:(BSNotification *)noti{
     
     if (noti.error.code == 0) {
//          HUDDISMISS;
//          HUDSMILE(@"添加成功", 1);
//          [self getData];
     }else{
          HUDCRY(noti.error.domain, 2);
          [self getData];
     }
     
}


-(void)payAction{
     if (_sumPrice == 0) {
          TOASTSHOW(@"请选择商品");
          return;
     }
     FillInOrderInfoViewController *vc = [FillInOrderInfoViewController new];
//     vc.sumPrice = _sumPrice;
     
     [self.navigationController pushViewController:vc animated:YES];
}

-(void)allSelectedAction{
     if (!_isAllSelected) {
          [_selectedArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BOOL state = [obj boolValue];
               if (!state) {
                    [_selectedArr replaceObjectAtIndex:idx withObject:@(YES)];
               }
          }];
          _isAllSelected = YES;
          [self calculateSumPrice];
          _allSelectedImv.image = [UIImage imageNamed:@"icon_selected"];
     }else{
          [_selectedArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BOOL state = [obj boolValue];
               if (state) {
                    [_selectedArr replaceObjectAtIndex:idx withObject:@(NO)];
               }
          }];
          _isAllSelected = NO;
          _sumPriceLb.text = @"¥0.00";
          _allSelectedImv.image = [UIImage imageNamed:@"icon_unselected"];
     }
     [_tableView reloadData];
}

//计算总价
-(void)calculateSumPrice{
//     _sumPrice = 0.0;

     [_dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUCartShopInfo *sum = obj;
          sum.isAllSelected  = YES;
          sum.sumPrice = 0.0;
          [sum.goodsList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUCartShopGoods *g = obj;
               if (g.isSelected) {
                    sum.sumPrice += g.count * g.salePrice;
               }else{
                    sum.isAllSelected  = NO;
               }
          }];
         
     }];
     [_tableView reloadData];
//     _sumPriceLb.text = [NSString stringWithFormat:@"¥%.2f",_sumPrice];
}

-(void)setNavigate{
     [self setNavigateRightButton:@"编辑" font:[UIFont systemFontOfSize:13] color:kUIColorFromRGB(color_1)];
}
-(void)handleDidRightButton:(id)sender{
     if (_isNoData) {
          return;
     }
     
     if (_isEdit) {
          [self setNavigateRightButton:@"编辑" font:[UIFont systemFontOfSize:13] color:kUIColorFromRGB(color_1)];
     }else{
          [self setNavigateRightButton:@"完成" font:[UIFont systemFontOfSize:13] color:kUIColorFromRGB(color_1)];
     }
     _isEdit = !_isEdit;
     [_tableView reloadData];
     [self editChangeBottom];
}

-(void)editChangeBottom{
     if (!_isEdit) {
          _deleteBtn.hidden = YES;
          _deleteBtn.userInteractionEnabled = NO;
          
          
          bottomView.hidden = YES;
         _tableView.height = __SCREEN_SIZE.height - 64;
     }else{
          _deleteBtn.hidden = NO;
          _deleteBtn.userInteractionEnabled = YES;
          bottomView.hidden = NO;
          _tableView.height = __SCREEN_SIZE.height - 64-45;
     }
//     if (!_isEdit) {
//          _shareBtn.hidden = YES;
//          _shareBtn.userInteractionEnabled = NO;
//          _collectionBtn.hidden = YES;
//          _collectionBtn.userInteractionEnabled = NO;
//          _deleteBtn.hidden = YES;
//          _deleteBtn.userInteractionEnabled = NO;
//
//
//          _payBtn.hidden = NO;
//          _payBtn.userInteractionEnabled = YES;
//          _sumPriceLb.hidden = NO;
//          _sumPriceTitleLb.hidden = NO;
//     }else{
//          _shareBtn.hidden = NO;
//          _shareBtn.userInteractionEnabled = YES;
//          _collectionBtn.hidden = NO;
//          _collectionBtn.userInteractionEnabled = YES;
//          _deleteBtn.hidden = NO;
//          _deleteBtn.userInteractionEnabled = YES;
//
//
//          _payBtn.hidden = YES;
//          _payBtn.userInteractionEnabled = NO;
//          _sumPriceLb.hidden = YES;
//          _sumPriceTitleLb.hidden = YES;
//     }
}

-(void)addTopView{
     topBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 30)];
     topBtn.backgroundColor = kUIColorFromRGB(color_0xadcafc);
     [topBtn addTarget:self action:@selector(topBtnAction) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:topBtn];
     
//     UIImageView *noticeImv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 4, 17, 16)];
//     noticeImv.image = [UIImage imageNamed:@"h_notice"];
//     [topBtn addSubview:noticeImv];
     
     
     UIImageView *arrowImv = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 15, 9.5, 6, 11)];
     arrowImv.image = [UIImage imageNamed:@"arrow_right_blue"];
     [topBtn addSubview:arrowImv];
     
     UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15 ,0, arrowImv.x- 15-47, 30)];
     title.text = [NSString stringWithFormat:@"[配送到] %@",busiSystem.agent.address.delAddress?:@"配送地址"];
     title.textColor = kUIColorFromRGB(color_3);
     title.font = [UIFont systemFontOfSize:12];
     [topBtn addSubview:title];
}

-(void)topBtnAction{
//     NSLog(@"top");
     ChoseAddressViewController *vc = [ChoseAddressViewController new];
     [self.navigationController pushViewController:vc animated:YES];
}

-(void)initTableView{
     
     __weak CartViewController *weakSelf = self;
     
     [CartTableViewCell registerTableViewCell:_tableView];
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     [TitleDetailTableViewCell registerTableViewCell:_tableView];
     [OnlyTitleTableViewCell registerTableViewCell:_tableView];
     
     [_tableView registerNib:[UINib nibWithNibName:@"ImgAndThreeTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"goods"];
     
     _noDataCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
     [_noDataCell setCellData:@{@"title":@"购物车空空如也哦",@"source":@"去挑选几件喜欢的商品吧",@"img":@"noData_cart"}];
     [_noDataCell fitNoCartMode];
     [_noDataCell setHandleAction:^(id sender) {
          self.tabBarController.selectedIndex = 0;
     }];
     
     _sepcTipCell = [TitleDetailTableViewCell createTableViewCell];
     [_sepcTipCell setCellData:@{@"title":@"人气推荐",@"detail":@"更多推荐",@"img":@"noData_cart"}];
     [_sepcTipCell fitHeadModeB];
     [_sepcTipCell setHandleAction:^(id sender) {
//          PopularityRecViewController *vc = [PopularityRecViewController new];
//          vc.hidesBottomBarWhenPushed = YES;
//          [weakSelf.navigationController pushViewController:vc animated:YES];
     }];
     
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.height = __SCREEN_SIZE.height - 64;
     _tableView.x = 0;
     _tableView.y = 0;
//     _tableView.refreshHeaderView = nil;
     _tableView.backgroundColor = kUIColorFromRGB(color_4);
     _tableView.showsVerticalScrollIndicator = NO;
     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     
     
     if (_isNoData) {
          return 1;
     }
     return _dataArr.count+ (_outOfDateArr.count !=0 ?1:0);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSInteger row = 1;
     if (_isNoData) {
          row = _tableView.dataArr.count +2;
     }else{
          if (section <_dataArr.count) {
               BUCartShopInfo *shopInfo = _dataArr[section];
               row = shopInfo.goodsList.count +2;
          }
          else{
               row = _outOfDateArr.count +2;
          }
     }
     
     
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
     UITableViewCell *cell;
     
//     if (_isNoData) {
//          cell =  [self createDTableView:indexPath];
//     }else{
          if (indexPath.section <_dataArr.count) {
               cell =  [self createATableView:indexPath];
          }
//          else if (indexPath.section <_dataArr.count+_outOfRangeArr.count) {
//               cell =  [self createBTableView:indexPath];
//          }
          else{
               cell =  [self createCTableView:indexPath];
          }
          [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
//     }
     
     
     
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}


-(UITableViewCell *)createDTableView:(NSIndexPath *)indexPath{
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = _noDataCell;
           [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(225, 0, 0, 0)];
     }
     else if (indexPath.row == 1){
          cell = _sepcTipCell;
     }else{
          NSLog(@"%ld - %ld",(long)indexPath.row,(long)indexPath.section);
          cell = [_tableView dequeueReusableCellWithIdentifier:@"goods"];
//          BUGoodsInfo *pg  =  _tableView.dataArr[indexPath.row - 2];
//          [(ImgAndThreeTitleTableViewCell *)cell setCellData:[pg getDic]];
          [(ImgAndThreeTitleTableViewCell *)cell fitHeadMode];
          [(ImgAndThreeTitleTableViewCell *)cell setHandleAction:^(id sender) {
               HUDSHOW(@"提交中");
//               [self addShoppingCart: withProCount:1];
          }];
          [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
          
     }
     return cell;
}

-(UITableViewCell *)createATableView:(NSIndexPath *)indexPath{
     UITableViewCell *cell;
     BUCartShopInfo *sum = _dataArr[indexPath.section];
     if (indexPath.row == 0) {
          cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
          [(TitleDetailTableViewCell *)cell setCellData:[sum getDic:0]];
          [(TitleDetailTableViewCell *)cell fitCartMode:sum.isAllSelected];
          __weak CartViewController *weakSelf = self;
          [(TitleDetailTableViewCell *)cell setHandleAction:^(id sender) {
               [sum setAllSel];
               [weakSelf.tableView reloadData];
          }];
     }
     else if (indexPath.row == sum.goodsList.count+1){
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
          [(ImgAndThreeTitleTableViewCell *)cell setCellData:[sum getDic:1]];
          [(ImgAndThreeTitleTableViewCell *)cell fitCartMode];
          __weak CartViewController *weakSelf = self;
          [(ImgAndThreeTitleTableViewCell *)cell setHandleAction:^(id sender) {
               
               if (sum.sumPrice > 0.0) {
                    NSMutableArray *arr =[NSMutableArray new];
                    [sum.goodsList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                         BUCartShopGoods *g = obj;
                         if (g.isSelected) {
                              [arr addObject:g];
                         }
                    }];
                    
                    
                    FillInOrderInfoViewController *vc = [FillInOrderInfoViewController new];
                    vc.dataArr = arr;
//                    vc.shopId = sum.shopId;
//                    vc.shopName = sum.shopName;
//                    vc.shopAddress = sum.address;
//                    vc.shopTell = sum.telephone;
                    vc.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
               }else{
                    HUDCRY(@"请选择商品", 2);
               }
          }];
     }
     else{
          CartTableViewCell *tempCell = [CartTableViewCell dequeueReusableCell:_tableView];
          BUCartShopGoods *g = sum.goodsList[indexPath.row -1];
          [tempCell setCellData:[g getDic:0]];
          BOOL isSelected = g.isSelected;
          [tempCell setIsSelect:isSelected isEdit:NO];
          [tempCell fitCellMode];
          __block NSInteger section = indexPath.section;
          __weak CartViewController *weakSelf = self;
          [tempCell setHandleAction:^(NSDictionary *dic){
               int index = [dic[@"index"] intValue];
               BUCartShopInfo *sum = _dataArr[indexPath.section];
               BUCartShopGoods *g = sum.goodsList[indexPath.row -1];
               if (index == 1) {//选中
                    g.isSelected = !g.isSelected;
                    [weakSelf calculateSumPrice];
                    [weakSelf.tableView reloadData];
                    
               }
               else if(index == 3){ // 增加减少商品数量
                    NSInteger num = [dic[@"num"] integerValue];
                    if (num == 0) {
                         [[CommonAPI managerWithVC:weakSelf] showAlert:@selector(deleteHandle:) withTitle:g.name?:@"" withMessage:@"确定删除吗？" withObj:@{@"arr":@[g.waterId]}];
                    }else{
                         [weakSelf addShoppingCart:g.goodsId withProCount:num-g.count ];
                         g.count = num;
                         [weakSelf calculateSumPrice];
                    }
                    
               }
               
          }];
          cell = tempCell;
     }
     return cell;
}



//-(UITableViewCell *)createBTableView:(NSIndexPath *)indexPath{
//     UITableViewCell *cell;
//     BUCartSumPrice *sum = _outOfRangeArr[indexPath.section - _dataArr.count];
//     if (indexPath.row == 0) {
//          cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
//          [(OnlyTitleTableViewCell *)cell setCellData:@{@"title":@"以下门店超出配送范围"}];
//          [(OnlyTitleTableViewCell *)cell fitCartMode];
//     }
//     else if (indexPath.row == 1){
//          cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
//          [(OnlyTitleTableViewCell *)cell setCellData:@{@"title":sum.sName?:@""}];
//          [(OnlyTitleTableViewCell *)cell fitCartModeA];
//          __weak CartViewController *weakSelf = self;
//          [(OnlyTitleTableViewCell *)cell setHandleAction:^(id sender) {
//               NSMutableArray *arr = [NSMutableArray new];
//               [weakSelf.outOfRangeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    BUCartSumPrice *sum = obj;
//                    [sum.dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                         BUCartGoods *g = obj;
//                         [arr addObject:g.shoppingCardItemId];
//                    }];
//
//               }];
//               [[CommonAPI managerWithVC:weakSelf] showAlert:@selector(deleteHandle:) withTitle:@"确定删除失效商品吗？" withMessage:nil withObj:@{@"arr":arr}];
//          }];
//     }
//     else{
//          ImgAndThreeTitleTableViewCell *tempCell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
//          BUCartGoods *g = sum.dataArr[indexPath.row -2];
//          [tempCell setCellData:[g getDic:1]];
//          [tempCell fitCartModeA];
//          cell = tempCell;
//     }
//     return cell;
//}


-(UITableViewCell *)createCTableView:(NSIndexPath *)indexPath{
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
          [(OnlyTitleTableViewCell *)cell setCellData:@{@"title":@"库存原因而导致失效的商品"}];
          [(OnlyTitleTableViewCell *)cell fitCartMode];
          [(OnlyTitleTableViewCell *)cell setHandleAction:nil];
     }
     else if (indexPath.row == 1){
          cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
          [(OnlyTitleTableViewCell *)cell setCellData:@{@"title":@"失效商品"}];
          [(OnlyTitleTableViewCell *)cell fitCartModeA];
          __weak CartViewController *weakSelf = self;
          [(OnlyTitleTableViewCell *)cell setHandleAction:^(id sender) {
               NSMutableArray *arr = [NSMutableArray new];
               [weakSelf.outOfDateArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    BUCartShopGoods *g = obj;
                    [arr addObject:g.waterId];
               }];
               [[CommonAPI managerWithVC:weakSelf] showAlert:@selector(deleteHandle:) withTitle:@"确定删除失效商品吗？" withMessage:nil withObj:@{@"arr":arr}];
          }];
          
     }
     else{
          ImgAndThreeTitleTableViewCell *tempCell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
          BUCartGoods *g = _outOfDateArr[indexPath.section -_dataArr.count];
          [tempCell setCellData:[g getDic:1]];
          [tempCell fitCartModeA];
          cell = tempCell;
     }
     return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     CGFloat height = 10;
     if (section == _dataArr.count-1) {
          height = 0.001;

     }
     
     return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//     CGFloat height = 10;
//     if (section == _dataArr.count-1) {
//          height = 0.001;
//
//     }
//     else if (section ==  _dataArr.count -1) {
//          height = 0.001;
//     }
     return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSInteger height = 45;
     
     if (_isNoData) {
          if (indexPath.row == 0) {
               height = 225;
          }
          else if (indexPath.row == 1){
               height =30;
          }else{
               height = 109;
          }
     }else{
          if (indexPath.section <_dataArr.count) {
               BUCartShopInfo *sum = _dataArr[indexPath.section];
               if (indexPath.row == 0) {
                    height = 45;
               }else if(indexPath.row == sum.goodsList.count +1){
                    height = 45;
               }
               else{
                    height = 106;
               }
          }
          else if (indexPath.section <_dataArr.count) {
               if (indexPath.row == 0) {
                    height = 25;
               }else if(indexPath.row == 1){
                    height = 55;
               }
               else{
                    height = 55;
               }
          }
          else{
               if (indexPath.row == 0) {
                    height = 25;
               }else if(indexPath.row == 1){
                    height = 45;
               }
               else{
                    height = 55;
               }
          }
     }
     
     
     return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self.view endEditing:YES];
     if (indexPath.section <_dataArr.count) {
           BUCartShopInfo *sum = _dataArr[indexPath.section];
          if (indexPath.row >0 && indexPath.row<=sum.goodsList.count) {
               BUCartShopGoods *g = sum.goodsList[indexPath.row-1];
               GoodsInfoViewController *vc = [GoodsInfoViewController new];
               vc.ID = g.goodsId;
               [self.navigationController pushViewController:vc animated:YES];
          }
     }
     else{
          if (indexPath.row >1) {
               BUCartShopGoods *g = _outOfDateArr[indexPath.row-2];
               GoodsInfoViewController *vc = [GoodsInfoViewController new];
               vc.ID = g.goodsId;
               [self.navigationController pushViewController:vc animated:YES];
          }
     }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
     [self.view endEditing:YES];
}

-(void)refreshCurentPage{
     _tableView.isRefreshing = YES;
     [self getData];
}

@end
