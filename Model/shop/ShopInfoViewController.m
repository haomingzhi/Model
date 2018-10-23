//
//  ShopInfoViewController.m
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/5.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ShopInfoViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "ZJMenuWithImgView.h"
#import "BUSystem.h"
#import "TitleDetailTableViewCell.h"
#import "SingleSelectionViewController.h"
#import "GoodsInfoViewController.h"
#import "cart/CartViewController.h"
#import "NoDataTableViewCell.h"
#import "LoginViewController.h"

@interface ShopInfoViewController ()
{
     ZJMenuWithImgView *_menuView;
     ImgAndThreeTitleTableViewCell *_infoCell;
     TitleDetailTableViewCell *_timeCell;
     NoDataTableViewCell *_noDataCell;
     NSInteger _requestCount;
     UILabel *_redDotLb;
     NSInteger _cartCount;
     
}
@property (nonatomic,strong) NSMutableArray *goodsTypeList;
@property (nonatomic,strong) BUShopType *type;
@property (nonatomic,assign) NSInteger orderBy;
@end

@implementation ShopInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"店铺详情";
     [self initMenu];
     [self initTableView];
     [self initNav];
     HUDSHOW(@"加载中");
     [self getData];
//     [self setNavigateRightButton:[UIImage imageNamed:@"nav_cart"] observer:self callBack:@selector(goToCart)];
     

}

-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
     [self getUserCartCount];
}


-(void)initNav{
     //    [self setNavigateRightButton:[UIImage imageNamed:@"icon_message"] observer:self callBack:@selector(messageAction)];
     UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 37, 37)];;
     [btn setImage:[UIImage imageNamed:@"nav_cart"] forState:UIControlStateNormal];
     [btn addTarget:self action:@selector(goToCart) forControlEvents:UIControlEventTouchUpInside];
     
     _redDotLb = [[UILabel alloc]initWithFrame:CGRectMake(24, 5, 13, 13)];
     _redDotLb.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     _redDotLb.layer.cornerRadius = _redDotLb.height/2.0;;
     _redDotLb.layer.masksToBounds = YES;
     _redDotLb.textColor = kUIColorFromRGB(color_2);
     _redDotLb.hidden = YES;
     _redDotLb.textAlignment = NSTextAlignmentCenter;
     _redDotLb.font = [UIFont systemFontOfSize:10];
     [btn addSubview:_redDotLb];
     
     [self setNavigateRightView:btn];
     //     [self setNavigateRightButton:[UIImage imageNamed:@"nav_cart"] observer:self callBack:@selector(goToCart)];
}

-(void)getUserCartCount{
     if (!busiSystem.agent.isLogin) {
          _redDotLb.hidden = YES;
          return;
     }
     _requestCount ++;
     [busiSystem.userManager getUserCartCount:busiSystem.agent.userId observer:self callback:@selector(getUserCartCountNotification:)];
}


-(void)getUserCartCountNotification:(BSNotification *)noti
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
          _cartCount = busiSystem.userManager.cartCount;
          if (_cartCount == 0) {
               _redDotLb.hidden = YES;
          }else{
               _redDotLb.hidden = NO;
               _redDotLb.text = [NSString stringWithFormat:@"%ld",(long)_cartCount];
               CGSize size = [_redDotLb.text size:_redDotLb.font constrainedToSize:CGSizeMake(200, 15)];
               _redDotLb.width = size.width +8;
          }
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}

-(void)goToCart{
     if (!busiSystem.agent.isLogin) {
          [LoginViewController toLogin:self];
          return;
     }
     CartViewController *vc = [CartViewController new];
     vc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initMenu{
     _menuView = [[ZJMenuWithImgView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 40)];
     _menuView.backgroundColor = kUIColorFromRGB(color_2);
     NSString *str = @"全部分类";
     [_menuView setMenuData:@[str,@"综合排序"]];
     [self.view addSubview:_menuView];
     [_menuView setTitle:@"全部分类" index:0 isSelect:NO];
     __weak ShopInfoViewController *weakSelf = self;
     [_menuView setCallBack:^(NSDictionary *dic) {
          NSInteger index = [dic[@"index"] integerValue]-10000;
          if (index == 0) {
               NSMutableArray *arr = [NSMutableArray new];
               [arr addObject:@"全部分类"];
               [weakSelf.goodsTypeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    BUShopType *type = obj;
                    [arr addObject:type.typeName];
               }];
               [[SingleSelectionViewController toSingleSelectionVC:arr] setHandleAction:^(NSDictionary *dic) {
                    NSInteger index = [dic[@"row"] integerValue];
                    NSString *title = arr[index];
                    [_menuView setTitle:title index:0 isSelect:YES];
                    if (index == 0) {
                         weakSelf.type = nil;
                    }else{
                         weakSelf.type = weakSelf.goodsTypeList[index-1];
                    }
                    HUDSHOW(@"加载中");
                    [self getGoodsList];
               }];
          }else{
               NSMutableArray *arr = [NSMutableArray new];
               [arr addObject:@"销量"];
               [arr addObject:@"价格由高到低"];
               [arr addObject:@"价格由低到高"];
               [[SingleSelectionViewController toSingleSelectionVC:arr] setHandleAction:^(NSDictionary *dic) {
                    NSInteger index = [dic[@"row"] integerValue];
                    NSString *title = arr[index];
                    [_menuView setTitle:title index:1 isSelect:YES];
                    weakSelf.orderBy = index+1;
                    HUDSHOW(@"加载中");
                    [self getGoodsList];
               }];
          }
     }];
}



-(void)getData{
     if (!_shopInfo) {
          _requestCount++;
          [busiSystem.shopManager getShopInfo:_shopId observer:self callback:@selector(getShopInfoNotification:)];
     }
     _requestCount ++;
     [busiSystem.shopManager getGoodsTypeList:_shopId observer:self callback:@selector(getGoodsTypeListNotification:)];
     [self getGoodsList];
     
}


-(void)getGoodsList{
     _requestCount ++;
     NSString *orderBy = [NSString stringWithFormat:@"%ld",(long)_orderBy];
     [busiSystem.getGoodsListManager getList:_shopId typeId:_type.typeId?:@"" orderBy:orderBy observer:self callback:@selector(getGoodsListNotification:)];
}


-(void)getGoodsListNotification:(BSNotification *)noti
{
     _requestCount -- ;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     if (noti.error.code == 0) {
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getGoodsListManager.dataArr];
          _tableView.hasMore = busiSystem.getGoodsListManager.pageInfo.hasMore;
          [_tableView reloadData];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}

-(void)getGoodsTypeListNotification:(BSNotification *)noti
{
     _requestCount -- ;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     if (noti.error.code == 0) {
          _goodsTypeList = [NSMutableArray arrayWithArray:busiSystem.shopManager.goodsTypeList];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}

-(void)getShopInfoNotification:(BSNotification *)noti
{
     _requestCount -- ;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     if (noti.error.code == 0) {
          _shopInfo = busiSystem.shopManager.shopInfo;
          [_infoCell setCellData:[_shopInfo getDic:0]];
          [_infoCell fitShopListMode];
          [_timeCell setCellData:[_shopInfo getDic:1]];
          [_timeCell fitShopInfoMode];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}

-(void)setNavCenter
{
     UISearchBar * _searchBar = [self setNavCenterView];
     _searchBar.delegate = self;
}
-( UISearchBar *)setNavCenterView
{
     UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(85, 0, __SCREEN_SIZE.width-85-67, 34)];
     searchView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     searchView.layer.borderWidth = 0.5;
     searchView.layer.cornerRadius = searchView.height/2.0;
     searchView.layer.masksToBounds = YES;
     //    searchView.layer.borderWidth = 0.5;
     UISearchBar *_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, searchView.width, 34)];
     _searchBar.placeholder = @"请输入店铺名称";
     
     _searchBar.backgroundColor = [UIColor yellowColor];
     //    [_searchBar setSearchFieldBackgroundImage:[[UIImage imageNamed:@"searchBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
     //    [searchBar setse:];
     [searchView addSubview:_searchBar];
     //    _searchBar.layer.cornerRadius = 15;
     //    _searchBar.layer.masksToBounds = YES;
     [_searchBar.layer setBorderWidth:8];
     [_searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
     UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
     [searchField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
     //    [searchBar setScopeBarBackgroundImage:[UIImage imageNamed:@"testgrad"]];
     //    searchBar.barStyle
     self.navigationItem.titleView =  searchView;
     return _searchBar;
}


//-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//     //     BookingListViewController *vc = [BookingListViewController new];
//     //     [self.navigationController pushViewController:vc animated:NO];
//     return NO;
//}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
     [self.view endEditing:YES];
//     HUDSHOW(@"加载中")
}


-(void)addUserCart:(NSString *)goodsId{
     if (!busiSystem.agent.isLogin) {
          [LoginViewController toLogin:self];
          return;
     }
     HUDSHOW(@"加载中");
     [busiSystem.userManager addUserCart:goodsId count:1 observer:self callback:@selector(addUserCartNotification:)];
}


-(void)addUserCartNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          HUDSMILE(@"添加成功", 2);
          _redDotLb.hidden = NO;
          _cartCount++;
          _redDotLb.text = [NSString stringWithFormat:@"%ld",(long)_cartCount];
          CGSize size = [_redDotLb.text size:_redDotLb.font constrainedToSize:CGSizeMake(200, 15)];
          _redDotLb.width = size.width +8;
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}

-(void)initTableView
{
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     _infoCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
     [_infoCell setCellData:[_shopInfo getDic:0]];
     [_infoCell fitShopListMode];
     
     
     _timeCell = [TitleDetailTableViewCell createTableViewCell];
     [_timeCell setCellData:[_shopInfo getDic:1]];
     [_timeCell fitShopInfoMode];
     
     
     _noDataCell = [NoDataTableViewCell createTableViewCell];
     [_noDataCell setCellData:@{@"img":@"nodata",@"title":@"暂无信息"}];
     [_noDataCell fitCellMode];
     
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.x = 0;
     _tableView.y = 0;
     _tableView.height = __SCREEN_SIZE.height - 64;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.refreshHeaderView = nil;
     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}



#pragma mark - tableView

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               cell = _infoCell;
               [_infoCell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 15, 0, 15)];
          }else{
               cell = _timeCell;
//               [_timeCell hiddenSeparatorView];
          }
          
     }
     else{
          if (_tableView.dataArr.count == 0) {
               cell = _noDataCell;
          }else{
               ImgAndThreeTitleTableViewCell *tempCell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
               BUGoodsInfo *goods = _tableView.dataArr[indexPath.row];
               [tempCell setCellData:[goods getDic:0]];
               [tempCell fitShopInfoMode];
               __weak ShopInfoViewController *weakSelf = self;
               [tempCell setHandleAction:^(id sender) {
                    NSLog(@"加入购物车");
                    [weakSelf addUserCart:goods.productId];
               }];
               [tempCell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(tempCell.height, 15, 0, 15)];
               cell = tempCell;
               
          }
          
          
          
     }
     
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 2;
     if (section == 1) {
          row = _tableView.dataArr.count?:1;
     }
     
     return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     
     return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     if (section == 1) {
          return  40;
     }
     return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     if (section == 1) {
          return _menuView;
     }
     return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 110;
     
     if (indexPath.section == 0) {
          height = indexPath.row == 0 ?118:40;
     }
     return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self.view endEditing:YES];
     if (indexPath.section != 0 && _tableView.dataArr.count != 0) {
          GoodsInfoViewController *vc = [GoodsInfoViewController new];
          BUGoodsInfo *goods = _tableView.dataArr[indexPath.row];
          vc.ID = goods.productId;
//          vc.shopInfo = _shopInfo;
          [self.navigationController pushViewController:vc animated:YES];
     }
     
}

@end
