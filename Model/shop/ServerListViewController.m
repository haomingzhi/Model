//
//  ShopInfoViewController.m
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/5.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ServerListViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "ZJMenuWithImgView.h"
#import "BUSystem.h"
#import "TitleDetailTableViewCell.h"
#import "SingleSelectionViewController.h"
#import "ServerInfoViewController.h"
#import "FlashTableViewCell.h"
#import "LoginViewController.h"
#import "FillInServiceOrderInfoViewController.h"
#import "NoDataTableViewCell.h"

@interface ServerListViewController ()
{
     ZJMenuWithImgView *_menuView;
     FlashTableViewCell *_flashCell;
     TitleDetailTableViewCell *_titleCell;
     UISearchBar *_searchBar ;
     NSInteger _requestCount;
     NoDataTableViewCell *_noDataCell;
}
@end

@implementation ServerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = _type.typeName?:@"";
//     [self initMenu];
     [self initTableView];
     HUDSHOW(@"加载中");
     [self getData];
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initMenu{
     _menuView = [[ZJMenuWithImgView alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 40)];
     _menuView.backgroundColor = kUIColorFromRGB(color_2);
     [_menuView setMenuData:@[@"全部分类",@"综合排序"]];
     [self.view addSubview:_menuView];
     [_menuView setCallBack:^(NSDictionary *dic) {
          NSInteger index = [dic[@"index"] integerValue]-10000;
          if (index == 0) {
               NSMutableArray *arr = [NSMutableArray new];
               [arr addObject:@"全部分类"];
               [arr addObject:@"便利店"];
               [arr addObject:@"生鲜超市"];
               [[SingleSelectionViewController toSingleSelectionVC:arr] setHandleAction:^(NSDictionary *dic) {
                    NSInteger index = [dic[@"row"] integerValue];
                    NSString *title = arr[index];
                    [_menuView setTitle:title index:0 isSelect:YES];
               }];
          }else{
               NSMutableArray *arr = [NSMutableArray new];
               [arr addObject:@"销量"];
               [arr addObject:@"价格由高到低"];
               [arr addObject:@"价格由低到高"];
//               [arr addObject:@"销量优先"];
               [[SingleSelectionViewController toSingleSelectionVC:arr] setHandleAction:^(NSDictionary *dic) {
                    NSInteger index = [dic[@"row"] integerValue];
                    NSString *title = arr[index];
                    [_menuView setTitle:title index:1 isSelect:YES];
               }];
          }
     }];
}



-(void)getData{
     _requestCount ++;
     NSString *cityId = [NSString stringWithFormat:@"%ld",(long)busiSystem.agent.cityId];
     [busiSystem.getServiceListManager getList:_searchBar.text typeId:_type.typeId cityId:cityId observer:self callback:@selector(getServiceListNotification:)];
     [self getCarouselList];
}


-(void)getCarouselList{
     _requestCount ++;
     [busiSystem.indexManager getCarouselList:0 postion:@"2" observer:self callback:@selector(getCarouselListNotification:)];
}


-(void)getCarouselListNotification:(BSNotification *)noti
{
     _requestCount -- ;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     if (noti.error.code == 0) {
          NSMutableArray *arr = [NSMutableArray new];
          [busiSystem.indexManager.carouseList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUCarouse *c = obj;
               [arr addObject:@{@"img":c.imagePath?:[BUImageRes new]}];
          }];
          [_flashCell setCellData:@{@"arr":arr}];
          [_flashCell fitHeadMode];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}

-(void)getServiceListNotification:(BSNotification *)noti
{
     
     _requestCount -- ;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     
     if (noti.error.code == 0) {
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getServiceListManager.dataArr];
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
     _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, searchView.width, 34)];
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
     
}


-(void)initTableView
{
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     
     __weak ServerListViewController *weakSelf= self;
     
     _flashCell = [FlashTableViewCell createTableViewCell];
     [_flashCell setCellData:@{@"arr":@[]}];
     [_flashCell fitHeadMode];
     [_flashCell setSelecedtItem:^(NSDictionary *dic) {
          
     }];
     
     _titleCell = [TitleDetailTableViewCell createTableViewCell];
     [_titleCell setCellData:@{@"title":@"服务预约",@"detail":@""}];
     [_titleCell fitShopInfoMode];
     
     
     _noDataCell = [NoDataTableViewCell createTableViewCell];
     [_noDataCell setCellData:@{@"img":@"nodata",@"title":@"暂无服务"}];
     [_noDataCell fitCellMode];
     
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.x = 0;
     _tableView.y = 0;
     _tableView.height = __SCREEN_SIZE.height - 64;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.refreshHeaderView = nil;
     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     _tableView.backgroundColor = kUIColorFromRGB(color_4);
}



#pragma mark - tableView

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               cell = _flashCell;
               [_flashCell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 15, 0, 15)];
          }else{
               cell = _titleCell;
               [_titleCell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 15, 0, 15)];
               
          }
          
     }
     else{
          if (_tableView.dataArr.count == 0) {
               cell = _noDataCell;
          }else{
               ImgAndThreeTitleTableViewCell *tempCell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
               BUServiceInfo *service = _tableView.dataArr[indexPath.row];
               [tempCell setCellData:[service getDic:0]];
               [tempCell fitServerListMode];
               __weak ServerListViewController *weakSelf = self;
               [tempCell setHandleAction:^(id sender) {
                    NSLog(@"立即预约");
                    [weakSelf toOrder:service];
               }];
               [tempCell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(tempCell.height, 15, 0, 15)];
               cell = tempCell;
          }
          
          
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
     return 0.001;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 110;
     
     if (indexPath.section == 0) {
          height = indexPath.row == 0 ? __SCREEN_SIZE.width * 153/360.0:40;
     }else{
          if (_tableView.dataArr.count == 0) {
               height = 250;
          }
     }
     return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self.view endEditing:YES];
     if (indexPath.section == 1 && _tableView.dataArr.count != 0) {
          ServerInfoViewController *vc = [ServerInfoViewController new];
          BUServiceInfo *service = _tableView.dataArr[indexPath.row];
          vc.ID = service.serviceId;
          [self.navigationController pushViewController:vc animated:YES];
     }
     
}

@end
