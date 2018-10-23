//
//  SearchShopViewController.m
//  compassionpark
//
//  Created by Steve on 2017/1/22.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SearchShopViewController.h"
#import "ImgTitleAndDetailCollectionViewCell.h"
//#import "MJRefresh.h"
#import "BUSystem.h"
#import "GoodsInfoViewController.h"
#import "ServerInfoViewController.h"
#import "ZJMenuView.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "ShopInfoViewController.h"
#import "FillInServiceOrderInfoViewController.h"
#import "LoginViewController.h"

@interface SearchShopViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>{
    NSArray *_dataArr;
    UITextField *searchTextField;
     ZJMenuView *_menuView;
     NSInteger _state;//0:店铺 1:服务
}

@end

@implementation SearchShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     self.title = @"店铺详情";
     [self initMenu];
     [self initTableView];
     [self setNavCenter];
     HUDSHOW(@"加载中");
     [self getData];
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}



-(void)getData{
     if (_state == 0) {
          NSString *orderBy = [NSString stringWithFormat:@"%d",1];
          NSString *cityId = [NSString stringWithFormat:@"%ld",(long)busiSystem.agent.cityId];
          [busiSystem.getShopListManager getList:searchTextField.text typeId:@"" orderBy:orderBy longitude:busiSystem.agent.log latitude:busiSystem.agent.lat cityId:cityId observer:self callback:@selector(getShopListNotification:)];
     }else{
          NSString *cityId = [NSString stringWithFormat:@"%ld",(long)busiSystem.agent.cityId];
          [busiSystem.getServiceListManager getList:searchTextField.text typeId:@"" cityId:cityId observer:self callback:@selector(getServiceListNotification:)];
     }
     
}




-(void)getServiceListNotification:(BSNotification *)noti
{
     
//     _requestCount -- ;
//     if (_requestCount == 0) {
          HUDDISMISS;
//     }
     
     if (noti.error.code == 0) {
          _tableView.extroDataArr = [NSMutableArray arrayWithArray:busiSystem.getServiceListManager.dataArr];
          _tableView.hasMore = busiSystem.getServiceListManager.pageInfo.hasMore;
          [_tableView reloadData];
          //          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:0 withTag:@"nodata"];
          //          [[JYNoDataManager manager] fitModeY:100];
          //          [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
     
}

-(void)getShopListNotification:(BSNotification *)noti
{
     
     HUDDISMISS;
     
     if (noti.error.code == 0) {
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getShopListManager.dataArr];
          _tableView.hasMore = busiSystem.getActivityManager.pageInfo.hasMore;
          [_tableView reloadData];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}

-(void)initMenu{
     _menuView = [[ZJMenuView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 40)];
     _menuView.backgroundColor = kUIColorFromRGB(color_2);
     [_menuView setData:@[@"店铺",@"服务"]];
     [self.view addSubview:_menuView];
     __weak SearchShopViewController *weakSelf = self;
     [_menuView setHandle:^(UIButton *btn) {
          
          _state = btn.tag;
          [_tableView reloadData];
          [weakSelf getData];
     }];
     [self.view addSubview:_menuView];
}



-(void)setNavCenter
{
     UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(85, 0, __SCREEN_SIZE.width-85-50, 30)];
     searchView.backgroundColor = kUIColorFromRGB(color_4);
     //     searchView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     //     searchView.layer.borderWidth = 0.5;
     searchView.layer.cornerRadius = searchView.height/2.0;
     searchView.layer.masksToBounds = YES;
     //    searchView.layer.borderWidth = 0.5;
     
     UIImageView *imV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 10, 10)];
     imV.image = [UIImage imageNamed:@"nav_search2"];
     [searchView addSubview:imV];
     
     searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(24, 0,searchView.width-34, searchView.height)];
     searchTextField.placeholder = @"请输入商品和服务";
     searchTextField.font = [UIFont systemFontOfSize:13];
     [searchTextField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
     searchTextField.returnKeyType = UIReturnKeySearch;
     searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
     searchTextField.delegate = self;
     [searchView addSubview:searchTextField];
     
     
     //     UISearchBar *_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, searchView.width, 34)];
     //     _searchBar.placeholder = @"请输入商品和服务";
     //     _searchBar.backgroundColor = kUIColorFromRGB(color_4);
     ////     [_searchBar setSearchFieldBackgroundImage:[[UIImage imageNamed:@"searchBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
     //     _searchBar.backgroundImage = [self createImageColor:kUIColorFromRGB(color_4) size:CGSizeMake(_searchBar.width, _searchBar.height)];
     //     [searchView addSubview:_searchBar];
     //     //    _searchBar.layer.cornerRadius = 15;
     //     //    _searchBar.layer.masksToBounds = YES;
     //     [_searchBar.layer setBorderWidth:8];
     //     [_searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
     //     UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
     //     [searchField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
     //     searchField.keyboardType =
     //    [searchBar setScopeBarBackgroundImage:[UIImage imageNamed:@"testgrad"]];
     //    searchBar.barStyle
     self.navigationItem.titleView =  searchView;
     //     return _searchBar;
}

//-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//     //     BookingListViewController *vc = [BookingListViewController new];
//     //     [self.navigationController pushViewController:vc animated:NO];
//     return NO;
//}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
     [self.view endEditing:YES];
     HUDSHOW(@"加载中");
     [self getData];
     return YES;
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
     [self.view endEditing:YES];
     [self getData];
}


-(void)initTableView
{
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     [_tableView registerNib:[UINib nibWithNibName:@"ImgAndThreeTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//     _infoCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
//     [_infoCell setCellData:@{@"img":@"default",@"default":@"default",@"title":@"新家园便利店",@"source":@"福州市台江区世纪百联",@"time":@"在售产品 18 份 / 已售出 120 份",@"isOpen":@(YES)}];
//     [_infoCell fitShopListMode];
//
//
//     _timeCell = [TitleDetailTableViewCell createTableViewCell];
//     [_timeCell setCellData:@{@"title":@"在售商品",@"detail":@"营业时间：08:30-20:30"}];
//     [_timeCell fitShopInfoMode];/
     
     
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.x = 0;
     _tableView.y = 40;
     _tableView.height = __SCREEN_SIZE.height - 64 -40;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.refreshHeaderView = nil;
//     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}



#pragma mark - tableView

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     ImgAndThreeTitleTableViewCell *cell;
     if (_state == 0) {
          
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
          BUShopInfo *shop = _tableView.dataArr[indexPath.row];
          [cell setCellData:[shop getDic:0]];
          [cell fitShopListMode];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
     }
     else{
          ImgAndThreeTitleTableViewCell *tempCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
          BUServiceInfo *service = _tableView.extroDataArr[indexPath.row];
          [tempCell setCellData:[service getDic:0]];
          [tempCell fitServerListMode];
          __weak SearchShopViewController *weakSelf = self;
          [tempCell setHandleAction:^(id sender) {
               NSLog(@"立即预约");
               [weakSelf toOrder:service];
          }];
          [tempCell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(tempCell.height, 15, 0, 15)];
          cell = tempCell;
          
     }
     
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}


-(void)toOrder:(BUServiceInfo *)serviceInfo{
     if (!busiSystem.agent.isLogin) {
          [LoginViewController toLogin:self];
          return;
     }
     FillInServiceOrderInfoViewController *vc = [FillInServiceOrderInfoViewController new];
     vc.serviceInfo = serviceInfo;
     [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 0;
     if (_state == 0) {//店铺
          row = _tableView.dataArr.count;
     }else{//服务
          row = _tableView.extroDataArr.count;
     }
     
     return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     
     return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//     if (section == 0) {
//          return  40;
//     }
     return 0.001;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//     if (section == 0) {
//          return _menuView;
//     }
//     return nil;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 110;
     
     if (_state == 1) {
          height = 110;
     }
     return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self.view endEditing:YES];
     if (_state == 0) {
          ShopInfoViewController *vc = [ShopInfoViewController new];
          [self.navigationController pushViewController:vc animated:YES];
     }else{
          ServerInfoViewController *vc = [ServerInfoViewController new];
          [self.navigationController pushViewController:vc animated:YES];
     }
}

     
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
     [self.view endEditing:YES];
}


@end
