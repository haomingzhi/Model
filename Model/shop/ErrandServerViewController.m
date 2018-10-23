//
//  ErrandServerViewController.m
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/6.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ErrandServerViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "BUSystem.h"
#import "ErrandServerInfoViewController.h"

@interface ErrandServerViewController ()<UISearchBarDelegate>
{
     UISearchBar *_searchBar;
}
@end

@implementation ErrandServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self initTableView];
     [self setNavCenter];
     HUDSHOW(@"加载中");
     [self getData];
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}


-(void)initTableView
{
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     
     
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.x = 0;
     _tableView.y = 0;
     _tableView.height = __SCREEN_SIZE.height - 64;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.refreshHeaderView = nil;
     //     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


-(void)getData{
     NSString *cityId = [NSString stringWithFormat:@"%ld",(long)busiSystem.agent.cityId];
     cityId = @"0";
     [busiSystem.getCourierListManager getList:_searchBar.text longitude:busiSystem.agent.log latitude:busiSystem.agent.lat cityId:cityId observer:self callback:@selector(getCourierListNotification:)];
}


-(void)getCourierListNotification:(BSNotification *)noti
{
     
//     _requestCount -- ;
//     if (_requestCount == 0) {
          HUDDISMISS;
//     }
     
     if (noti.error.code == 0) {
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getCourierListManager.dataArr];
          _tableView.hasMore = busiSystem.getServiceListManager.pageInfo.hasMore;
          [_tableView reloadData];
          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count  withTag:@"nodata"];
          [[JYNoDataManager manager] fitModeY:100];
          [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
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
     _searchBar.placeholder = @"请输入跑腿师傅的名称";
     _searchBar.delegate = self;
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
     searchField.font = [UIFont systemFontOfSize:13];
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





#pragma mark - tableView

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     ImgAndThreeTitleTableViewCell *cell;
     cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
     BUCourier *c = _tableView.dataArr[indexPath.row];
     [cell setCellData:[c getDic:0]];
     [cell fitErrandServerListListMode];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = _tableView.dataArr.count;
     
     
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
     CGFloat height = 100;
     
     return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self.view endEditing:YES];
     ErrandServerInfoViewController *vc = [ErrandServerInfoViewController new];
     BUCourier *c = _tableView.dataArr[indexPath.row];
     vc.ID = c.courierId;
//     vc.courier = c;
     [self.navigationController pushViewController:vc animated:YES];
}


-(void)loadNextPage{
     [busiSystem.getCourierListManager getListNextPage:self callback:@selector(getCourierListNotification:)];
}

@end
