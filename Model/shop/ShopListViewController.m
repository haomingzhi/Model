//
//  ShopListViewController.m
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/5.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ShopListViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "BUSystem.h"
#import "ZJMenuWithImgView.h"
#import "SingleSelectionViewController.h"
#import "ShopInfoViewController.h"

@interface ShopListViewController ()<UITextFieldDelegate>
{
     UITextField *searchTextField;
     ZJMenuWithImgView *_menuView;
}
@property (nonatomic,assign) NSInteger orderBy;
@end

@implementation ShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self initTableView];
     [self setNavCenter];
     [self initMenu];
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
     NSString *str = _type.typeName?:@"全部商家";
     [_menuView setMenuData:@[str,@"综合排序"]];
     [self.view addSubview:_menuView];
     __weak ShopListViewController *weakSelf = self;
     [_menuView setCallBack:^(NSDictionary *dic) {
          [weakSelf.view becomeFirstResponder];
          NSInteger index = [dic[@"index"] integerValue]-10000;
          if (index == 0) {
               NSMutableArray *arr = [NSMutableArray new];
               [arr addObject:@"全部商家"];
               [busiSystem.shopManager.shopTypeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    BUShopType *t = obj;
                    [arr addObject:t.typeName];
               }];
               
               [[SingleSelectionViewController toSingleSelectionVC:arr] setHandleAction:^(NSDictionary *dic) {
                    [weakSelf.view endEditing:YES];
                    NSInteger index = [dic[@"row"] integerValue];
                    NSString *title = arr[index];
                    if (index == 0) {
                         weakSelf.type = nil;
                    }else{
                         weakSelf.type = busiSystem.shopManager.shopTypeList[index-1];
                    }
                    [_menuView setTitle:title index:0 isSelect:YES];
                    HUDSHOW(@"加载中");
                    [weakSelf getData];
               }];
          }else{
               NSMutableArray *arr = [NSMutableArray new];
               [arr addObject:@"销量最高"];
               [arr addObject:@"离我最近"];
               [arr addObject:@"好评优先"];
               [arr addObject:@"人气最高"];
               __weak ShopListViewController *weakSelf = self;
               [[SingleSelectionViewController toSingleSelectionVC:arr] setHandleAction:^(NSDictionary *dic) {
                    NSInteger index = [dic[@"row"] integerValue];
                    NSString *title = arr[index];
                    [_menuView setTitle:title index:1 isSelect:YES];
                    weakSelf.orderBy = index+1;
                    HUDSHOW(@"加载中");
                    [weakSelf getData];
               }];
          }
     }];
}

-(void)initTableView
{
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     
     
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.x = 0;
     _tableView.y = 40;
     _tableView.height = __SCREEN_SIZE.height - 64 - 40;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.refreshHeaderView = nil;
//     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//     _tableView.bounces = NO;
}


-(void)getData{
     NSString *orderBy = [NSString stringWithFormat:@"%ld",(long)_orderBy];
     NSString *cityId = [NSString stringWithFormat:@"%ld",(long)busiSystem.agent.cityId];
     [busiSystem.getShopListManager getList:searchTextField.text typeId:_type.typeId?:@"" orderBy:orderBy longitude:busiSystem.agent.log latitude:busiSystem.agent.lat cityId:cityId observer:self callback:@selector(getShopListNotification:)];
}

-(void)getShopListNotification:(BSNotification *)noti
{
    
     HUDDISMISS;
    
     if (noti.error.code == 0) {
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getShopListManager.dataArr];
          _tableView.hasMore = busiSystem.getActivityManager.pageInfo.hasMore;
          [_tableView reloadData];
          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:@"nodata"];
          [[JYNoDataManager manager] fitModeY:100];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
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
     searchTextField.placeholder = @"请输入店铺名称";
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





#pragma mark - tableView

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     ImgAndThreeTitleTableViewCell *cell;
     cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
     BUShopInfo *shopInfo = _tableView.dataArr[indexPath.row];
     [cell setCellData:[shopInfo getDic:0]];
     [cell fitShopListMode];
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
     CGFloat height = 118;

     return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self.view endEditing:YES];
     BUShopInfo *t = _tableView.dataArr[indexPath.row];
     if (t.state == 2) {
          HUDCRY(@"店铺已打烊", 2);
          return;
     }
     ShopInfoViewController *vc = [ShopInfoViewController new];
     vc.shopInfo = t;
     vc.shopId = t.shopId;
     [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadNextPage{
     [busiSystem.getShopListManager getListNextPage:self callback:@selector(getShopListNotification:)];
}

@end
