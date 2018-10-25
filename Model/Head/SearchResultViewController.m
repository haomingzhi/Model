//
//  SearchResultViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/2.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SearchResultViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "IconAndTitleTableViewCell.h"
#import "BUSystem.h"
//#import "GoodsInfoViewController.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController
{
  
     BOOL isFirstAppear;
}


-(void)initTableView:(MyTableView *)tb
{
     tb.refreshHeaderView = nil;
     
     [ImgAndThreeTitleTableViewCell registerTableViewCell:tb];
     [IconAndTitleTableViewCell registerTableViewCell:tb];
}

-(void)handleReturnBack:(id)sender
{
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {

     [super viewDidLoad];
//     [self initSearchView];
     [self setNavCenter];
     [self setRightNavBtn];
     [self initTableView:_tableView];
     isFirstAppear = YES;
     _searchView.hidden = YES;
//      self.navigationItem.titleView = _searchView;
     _textTf.text = _searchText;
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)getData
{
     
//     [busiSystem.headManager.getSearchListManager getList:_searchText observer:self callback:@selector(getListNotification:)];
}
-(void)getListNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          if (_tableView.isRefreshing) {
               //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
               [self refreshTableHeaderNotification:noti myTableView:_tableView];
               [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
               _tableView.isRefreshing = NO;
          }
//          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.headManager.getSearchListManager.dataArr];
//          _tableView.hasMore = busiSystem.headManager.getSearchListManager.pageInfo.hasMore;
          [_tableView reloadData];
          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无结果" withImg:@"noSearch" withCount:_tableView.dataArr.count withTag:[NSString stringWithFormat:@"favc%d",0]];
          [[JYNoDataManager manager] fitModeY:130];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}

-(void)initSearchView
{
     _searchView.backgroundColor = kUIColorFromRGB(color_2);
     _searchView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     _searchView.layer.cornerRadius = 4;
     _searchView.layer.borderWidth = 0.5;
     _searchView.layer.masksToBounds = YES;
     _searchView.width = __SCREEN_SIZE.width - 100;
     _textTf.backgroundColor = kUIColorFromRGB(color_2);
     _textTf.width = _searchView.width - 26;
     _textTf.delegate = self;
     _textTf.keyboardType = UIReturnKeySearch;
}


-(void)setRightNavBtn
{
     [self setNavigateRightButton:@"取消" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_0xb0b0b0)];
}

-(void)handleDidRightButton:(id)sender
{
     //    [self getData:_textTf.text];
     [self.searchView endEditing:YES];
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)setNavCenter
{
     UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(85, 0, __SCREEN_SIZE.width-85-50, 30)];
     searchView.backgroundColor = kUIColorFromRGB(color_0xefefef);
     //     searchView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     //     searchView.layer.borderWidth = 0.5;
     searchView.layer.cornerRadius = searchView.height/2.0;
     searchView.layer.masksToBounds = YES;
     //    searchView.layer.borderWidth = 0.5;
     
     UIImageView *imV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 10, 10)];
     imV.image = [UIImage imageNamed:@"nav_search2"];
     [searchView addSubview:imV];
     
     UITextField *searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 0,searchView.width-40-10, searchView.height)];
     searchTextField.placeholder =  busiSystem.agent.config.keyword?:@"请输入";
     searchTextField.font = [UIFont systemFontOfSize:13];
     [searchTextField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
     searchTextField.delegate = self;
     [searchView addSubview:searchTextField];
     searchTextField.text  = _searchText;
     searchTextField.returnKeyType = UIReturnKeySearch;
     
     self.navigationItem.titleView =  searchView;
     //     return _searchBar;
}





-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
     HUDSHOW(@"加载中");
     _searchText = textField.text;
     [self getData];
     return YES;
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}



#pragma mark --UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     NSInteger count = 1;
     return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
     NSInteger count = _tableView.dataArr.count;
     return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     cell = [self createOrderCell: indexPath withTableView:tableView];
     return cell;
}

-(UITableViewCell *)createOrderCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)tableView
{
     UITableViewCell *cell;
//     BUGoodsInfo *g = _tableView.dataArr[indexPath.row];
     cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
//     BUHeadGoods *g = _tableView.dataArr[indexPath.row];
//     NSDictionary *dic = [g getDic];
     //@{@"title":@"iPhone X 全新国行",@"source":[NSString stringWithFormat:@"%.2f",200.0],@"time":[NSString stringWithFormat:@"元/%@",@"月"],@"default":@"default",@"img": @"orderEx",@"isPost":@(YES),@"isSecondHand":@(YES)};
//     [(JYAbstractTableViewCell *)cell setCellData:dic];
     [(ImgAndThreeTitleTableViewCell *)cell fitSearchResultMode];

     [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(135, 15, 0, 15)];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return  cell;
}


#pragma mark --UITableViewDelegate

//设置section头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 135;

     return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     return nil;
}
//行的选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self.view endEditing:YES];
//     BUHeadGoods *g = _tableView.dataArr[indexPath.row];
//     GoodsInfoViewController *vc = [GoodsInfoViewController new];
//     vc.ID = g.productId;
//     [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark --page
-(void)refreshCurentPage
{
     _tableView.isRefreshing = YES;
     [self getData];
}



-(void) loadNextPage
{
//         [busiSystem.headManager.getSearchListManager getDataNextPage:self callback:@selector(getListNotification:)];
}
@end
