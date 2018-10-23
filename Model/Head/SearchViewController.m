//
//  SearchViewController.m
//  taihe
//
//  Created by air on 2016/11/23.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//
//#import "ActivityInfoViewController.h"
#import "SearchViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "TitleAndImageTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "ScrollerTableViewCell.h"
#import "SearchResultViewController.h"
#import "BUSystem.h"


@interface SearchViewController ()
{
   ScrollerTableViewCell *_hotCell;
     OnlyTitleTableViewCell *_hotTipCell;
     OnlyTitleTableViewCell *_historyTipCell;
     OnlyBottomBtnTableViewCell *_submitCell;
     MySearchBar *_mySearchBar;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self initSearchView];
    [self setRightNavBtn];
     [self setNavCenter];
//    self.navigationItem.titleView = _searchView;
    //    [self dataModel];
    //    [self getData];
    [self initTableView:_tableView];
    _textTf.delegate = self;
      _mySearchBar = [[MySearchBar alloc]initWithFrame:CGRectMake(50, 3,__SCREEN_SIZE.width-50-15, 36)];
     _mySearchBar.delegate = self;
     _mySearchBar.searchType = SearchType_ProductName;
     _mySearchBar.maxCount = 10;
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [_textTf becomeFirstResponder];
}
- (IBAction)searchHandle:(id)sender {
    
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    HUDSHOW(@"搜索中");
       [(MySearchBar*)_mySearchBar addSearchRecord:_textTf.text];
//    [self getData:_textTf.text];
//     [self.view endEditing:YES];
     [self.navigationController.view endEditing:YES];
     SearchResultViewController *vc = [SearchResultViewController new];
     vc.searchText = _textTf.text;
     [self.navigationController pushViewController:vc animated:YES];
    return YES;
}
-(void)getData:(NSString *)keyword
{
//    [busiSystem.searchActivityManager searchActivity:keyword withSapid:busiSystem.agent.sapid observer:self callback:@selector(searchActivityNotification:)];
//    [busiSystem.searchSellerManager getSearchSeller:keyword observer:self callback:@selector(getSearchSellerNotification:)];
     [self.searchView endEditing:YES];
     SearchResultViewController *vc = [SearchResultViewController new];
     [self.navigationController pushViewController:vc animated:YES];
}

-(void)searchActivityNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
//          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.searchActivityManager.data];
        [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:@"serShop"];
        [[JYNoDataManager manager] fitModeY:200];
        [_tableView reloadData];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)getSearchSellerNotification:(BSNotification *)noti
{
//    JYBASENOTIFICATION(noti);
//    _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.searchActivityManager.data];
//    _tableView.hasMore = busiSystem.searchSellerManager.pageInfo.hasMore;
    [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:@"serShop"];
    [[JYNoDataManager manager] fitModeY:200];
    [_tableView reloadData];
}

//-(void)dataModel
//{
//    NSMutableArray *arr = [NSMutableArray array];
//    //    [arr addObject:@{@"img":@"callMe",@"title":@"回复我的"}];
//    //    [arr addObject:@{@"img":@"sysNotice",@"title":@"系统消息"}];
//    _tableView.dataArr = arr;
//    //    _isNoMsg =
//    [[JYNoDataManager manager] addNodataView:_tableView withTip:@"没有找到相关商户" withImg:@"noSearchData" withCount:_tableView.dataArr.count withTag:@"ser"];
//    [[JYNoDataManager manager] fitModeY:200];
//}

-(void)initTableView:(MyTableView *)tableView
{
     __weak SearchViewController *weakSelf = self;
    [TitleAndImageTableViewCell registerTableViewCell:_tableView];
     _tableView.refreshHeaderView = nil;
     _hotTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_hotTipCell setCellData:@{@"title":@"热门搜索"}];
     [_hotTipCell fitSearchMode];
     
     _historyTipCell = [OnlyTitleTableViewCell createTableViewCell];
        [_historyTipCell setCellData:@{@"title":@"历史搜索"}];
       [_historyTipCell fitSearchModeB];
//     NSArray *arr = [(MySearchBar *)_mySearchBar historyData];
//     _tableView.dataArr = [NSMutableArray arrayWithArray:arr];
     [_historyTipCell setHandleAction:^(id sender) {
          [weakSelf deleteAlert];
     }];

     _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_submitCell setCellData:@{@"title":@"删除搜索历史"}];
     [_submitCell fitSearchMode];
     [_submitCell setHandleAction:^(id sender) {
            [weakSelf deleteAlert];
     }];
     _hotCell = [ScrollerTableViewCell createTableViewCell];
     
     NSArray *htArr = busiSystem.agent.config.hotKeywordList?:@[];
     [_hotCell setCellData:@{@"arr":htArr}];
     [_hotCell fitSearchMode];
     [_hotCell setHandleAction:^(UIButton *btn) {
          [weakSelf.navigationController.view endEditing:YES];
          NSInteger index = btn.tag - 200;
         NSString *text = htArr[index];
            [(MySearchBar*)_mySearchBar addSearchRecord:text];
          SearchResultViewController *vc = [SearchResultViewController new];
          vc.searchText = text;
          [weakSelf.navigationController pushViewController:vc animated:YES];
     }];
//    _tableView.backgroundColor = kUIColorFromRGB(color_4);
}

-(void)deleteAlert
{
     [[CommonAPI managerWithVC:self] showAlertView:nil withMsg:@"确认删除全部历史记录?" withBtnTitle:@"确定" withSel:@selector(deleteHandle:)withUserInfo:@{}];
}

-(void)deleteHandle:(NSDictionary *)dic
{
     if ([dic[@"code"] integerValue] == 0) {
          [_mySearchBar clean];
          [_tableView.dataArr removeAllObjects];
          [self.tableView reloadData];
     }
}



-(void)setNavCenter
{
     
     [self setNavigateLefeButtonNULL];
     
     UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, __SCREEN_SIZE.width-15-50, 30)];
     searchView.backgroundColor = kUIColorFromRGB(color_0xefefef);
     //     searchView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     //     searchView.layer.borderWidth = 0.5;
     searchView.layer.cornerRadius = searchView.height/2.0;
     searchView.layer.masksToBounds = YES;
     //    searchView.layer.borderWidth = 0.5;
     
     UIImageView *imV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 10, 10)];
     imV.image = [UIImage imageNamed:@"nav_search2"];
     [searchView addSubview:imV];
     
     _textTf = [[UITextField alloc]initWithFrame:CGRectMake(40, 0,searchView.width-55, searchView.height)];
     _textTf.placeholder = busiSystem.agent.config.keyword?:@"请输入";
     _textTf.font = [UIFont systemFontOfSize:13];
     [_textTf setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
     _textTf.returnKeyType = UIReturnKeySearch;
     _textTf.clearButtonMode = UITextFieldViewModeWhileEditing;
     _textTf.delegate = self;
     [searchView addSubview:_textTf];
     self.navigationItem.titleView =  searchView;

}





-(void)initSearchView
{
    _searchView.backgroundColor = kUIColorFromRGB(color_2);
    _searchView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
    _searchView.layer.cornerRadius = _searchView.height/2.0;
    _searchView.layer.borderWidth = 0.5;
    _searchView.layer.masksToBounds = YES;
    _searchView.width = __SCREEN_SIZE.width - 100;
    _textTf.backgroundColor = kUIColorFromRGB(color_2);
    _textTf.width = _searchView.width - 26;
     _textTf.placeholder = @"输入商品关键词";
}

-(void)viewWillAppear:(BOOL)animated
{
    UIColor * navigationBarColor = kUIColorFromRGB(color_2);
    if (__IOS7)
    {
        CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
        [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor: navigationBarColor withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    }
    else
    {
        CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT );
        //        UIImage *image = [[UIImage imageNamed:@"navbg"] imageToSize:navBarSize];
        //        [[UINavigationBar appearance]  setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor: navigationBarColor withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    }
     NSArray *arr = [(MySearchBar *)_mySearchBar historyData];
     _tableView.dataArr = [NSMutableArray arrayWithArray:arr];
     [_tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    UIColor * navigationBarColor = kUIColorFromRGB(color_2);
    if (__IOS7)
    {
        CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
        [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor: navigationBarColor withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    }
    else
    {
        CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT );
        //        UIImage *image = [[UIImage imageNamed:@"navbg"] imageToSize:navBarSize];
        //        [[UINavigationBar appearance]  setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor: navigationBarColor withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    }
}

-(void)setRightNavBtn
{
    [self setNavigateRightButton:@"取消" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_0xb0b0b0)];
}

-(void)handleDidRightButton:(id)sender
{
//    [self getData:_textTf.text];
     [self.view endEditing:YES];
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)handleReturnBack:(id)sender
{
    [self.searchView endEditing:YES];
    [super handleReturnBack:self];
}

-(CGFloat)tableView:(MyTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
     if (indexPath.section == 0) {
          
     
        if(indexPath.row == 0)
        {
            height = 28;
        }
        else if(indexPath.row == 1)
        {
            height = _hotCell.height;
        }
        else if(indexPath.row == 2)
        {
            height = 35;
        }

        else
        {
            height = 45;
        }
     }else
     {
          height = 45;
     }
   
    return height;
}

-(NSInteger)tableView:(MyTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 2;
     if (section == 1) {
          row =  1 + _tableView.dataArr.count;
     }
    return row;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     if (_tableView.dataArr.count == 0) {
          return 1;
     }
     return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     if (section == 0) {
          return 10;
     }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(UITableViewCell *)tableView:(MyTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(indexPath.section == 0)
    {
          if (indexPath.row == 0) {
               cell = _hotTipCell;
          }
          else if (indexPath.row == 1)
          {
               cell = _hotCell;
          }
     }
     else
     {
          
          if (indexPath.row == 0)
          {
               cell = _historyTipCell;
               [(TitleAndImageTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
          
          else
          {
               NSString *str = _tableView.dataArr[indexPath.row - 1];
               cell = [TitleAndImageTableViewCell dequeueReusableCell:_tableView];
               [(TitleAndImageTableViewCell *)cell setCellData:@{@"title":str,@"img":@"search_del"}];
               [(TitleAndImageTableViewCell *)cell fitSearchMode];
//               [(TitleAndImageTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
//          cell = _submitCell;
//            [_submitCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
     }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//     [self.view endEditing:YES];
     [self.navigationController.view endEditing:YES];
     if (indexPath.section == 1 && indexPath.row >0) {
          NSString *str = _tableView.dataArr[indexPath.row - 1];
//          [(MySearchBar*)_mySearchBar addSearchRecord:str];
          SearchResultViewController *vc = [SearchResultViewController new];
          vc.searchText = str;
          [self.navigationController pushViewController:vc animated:YES];
     }

}

-(void)loadNextPage
{

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
