//
//  SearchViewController.m
//  yihui
//
//  Created by air on 15/9/8.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "SearchViewController.h"
#import "JYBaseTableViewCell.h"
#import "JYTableViewCellManager.h"
#import "ContactPersonTableViewCell.h"
#import "JYBaseData.h"
#import "JYNoDataViewController.h"
@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
     IBOutlet UISearchBar *_searchBar;
    NSMutableArray *_sectionArr;
     NSMutableArray *_dataArr;
    IBOutlet MyTableView *_tableView;
    JYTableViewCellManager *_cellManager;
    NSMutableArray *_tempArr;
    NSIndexPath *_delIndexPath;
     JYNoDataViewController *_noVc;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"公司名";
    _dataArr = [NSMutableArray array];
    _searchBar =  [self getSearchBar:CGSizeMake(__SCREEN_SIZE.width, 46)];//(UISearchBar *)[[UISearchBar genSearchBar:self withSize:CGSizeMake(__SCREEN_SIZE.width, 44)]viewWithTag:9999];
    [self.view addSubview:_searchBar];
    [self setSearchBar];
    _noVc = [[JYNoDataViewController alloc] initWithNibName:@"JYNoDataViewController" bundle:nil];
    _cellManager = [JYTableViewCellManager manager];
    [self initTableView];
    [self getData];
//    self.view.backgroundColor = kUIColorFromRGB(color_0xf3f3f3);
}

-(UISearchBar *)getSearchBar :(CGSize ) size
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, size.width , size.height)];
    searchBar.tag = 9999;
    [searchBar setBarTintColor:kUIColorFromRGB(color_F3F3F3)];
    searchBar.backgroundColor = kUIColorFromRGB(color_F3F3F3);
//    [searchBar setBarTintColor:[UIColor colorWithRed:254/255.0 green:64/255.0 blue:61/255.0 alpha:1]];
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.translucent = YES;
    searchBar.placeholder = @"搜索";
//    searchBar.layer.cornerRadius = 2;
//    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderColor:kUIColorFromRGB(color_F3F3F3).CGColor];
    [searchBar.layer setBorderWidth:4];
    
    return searchBar;
}

-(void)setSearchBar
{
    _searchBar.delegate = self;
//    [_searchBar setCustomBackground:[UIColor whiteColor]];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
//    _tableView.userInteractionEnabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    [self.view.window addGestureRecognizer:tap];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchStr = searchBar.text;
    if (_searchCallBack) {
        _searchCallBack(searchStr);
    }
 
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *searchStr = searchBar.text;
    if (_searchCallBack) {
        _searchCallBack(searchStr);
    }
}

-(void)tapHandle:(UITapGestureRecognizer *)tap
{
    [tap.view removeGestureRecognizer:tap];
    [self.view endEditing:YES];
    _tableView.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.@"{search}"
}

-(void)initTableView
{
    _sectionArr = [NSMutableArray array];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshHeaderView = nil;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.sectionIndexColor = [UIColor lightGrayColor];
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
}

-(void)getData
{
    if (_callBack) {
        _callBack(_dataArr);
    }
}


-(void)initTableViewSections:(NSArray *)arr//字典数组
{
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addSectionWithDataObj:_tableView widthCellArr:obj[@"value"] withSectionName:obj[@"key"] withHandleAction:^{
            
           
        } ];
    }];
    [_sectionArr addObjectsFromArray:[_cellManager getSectionArr]];
    [_tableView reloadData];
}

-(void)refreshTableView:(NSArray*)arr
{
    [_sectionArr removeAllObjects];
    [_cellManager remvoAllSections];
    [self initTableViewSections:arr];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_sectionArr.count == 0) {
        [tableView addSubview:_noVc.view];
        _noVc.view.width = __SCREEN_SIZE.width;
        [_noVc setNoDataHint:_noDataTip?:@"sorry,您还没有人脉哦!"];
        [_noVc setNoDataImageView:@"icon_no_contacts"];
        if (_mode == NormoalMode) {
            
        }
        else
        {
          [_noVc addNoDataHandleBtn:_noDataBtnTip?:@"寻找人脉"];
        }
        _noVc.handleAction = ^(id obj){
//            self.tabBarController.selectedViewController = self.tabBarController.viewControllers[2];
            if (_noDataBtnCallBack) {
                _noDataBtnCallBack(obj);
            }
        };
    }
    else
    {
        [_noVc.view removeFromSuperview];
    }

    return _sectionArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = _sectionArr[section];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = _sectionArr[indexPath.section];
    JYBaseTableViewCell *obj = arr[indexPath.row];//某个可以用来构造cell的类对象，调用内部构造方法生产cell
    UITableViewCell *cell = [obj createTableViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = _sectionArr[indexPath.section];
    JYBaseTableViewCell * obj = arr[indexPath.row];//某个可以用来构造cell的类对象，调用高度
    CGFloat height = obj.height;
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedRowcallBack) {
        _selectedRowcallBack(indexPath);
    }
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isCanDelete) {
        if(_canDeleteCallBack)
        {
            if (_canDeleteCallBack(indexPath)) {
                return   UITableViewCellEditingStyleDelete;
            }
            else
            {
                return UITableViewCellEditingStyleNone;
            }
        }
        return UITableViewCellEditingStyleDelete;
    }
  
    return UITableViewCellEditingStyleNone;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    v.height = 22;
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 2, 90, 18)];
    lb.font = [UIFont systemFontOfSize:12];
    NSDictionary *dic = _dataArr[section];
    lb.textColor = kUIColorFromRGB(color_main_bottom_press);
    lb.text =  dic[@"key"];
    [v addSubview:lb];
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 21.5, __SCREEN_SIZE.width, 0.5)];
    line.backgroundColor = kUIColorFromRGB(color_text);//[UIColor lightGrayColor];
    [v addSubview:line];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}


//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_cellManager getSection:indexPath.section].count - 1 == indexPath.row) {
//        cell.separatorInset = UIEdgeInsetsMake(0, 1900, 0, 0);
//        NSLog(@"x");
//    }
//   
//}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *v = [[UIView alloc] init];
//    v.height = 1;
//    v.backgroundColor = [UIColor whiteColor];
//    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(50, 0.5, __SCREEN_SIZE.width - 50, 0.5)];
//    line.backgroundColor = [UIColor lightGrayColor];
//    [v addSubview:line];
//    return v;
//}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *arr = [NSMutableArray array];
    [_dataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"key"] isEqualToString:@"管理者"]) {
            [arr addObject:@"#"];
        }
        else
        {
        [arr addObject:obj[@"key"]];
        }
    }];
    return arr;
    
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
     NSDictionary *dic = _dataArr[section];

        return dic[@"key"];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定删除吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        _delIndexPath = indexPath;
        [alert show];
//        NSLog(@"sc sc djjj");
        
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (_deleteCallBack) {
            _deleteCallBack(_delIndexPath);
            _delIndexPath = nil;
        }
    }
}




- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)addTableViewCell:(UITableView *)tableView cellClass:(NSString *)clsName cellDataDic:(NSDictionary *)dataDic handleAction:(void (^)(id sender)) handleAction
{
    JYBaseTableViewCell *cell = [[JYBaseTableViewCell alloc] init];
    cell.dataDic = [NSMutableDictionary dictionaryWithDictionary:@{@"cellClass":clsName,@"tableView":tableView,@"dataDic":dataDic}];
    cell.handleAction = handleAction;
    [_cellManager addRow:cell];
}

-(void)addSectionWithDataObj:(UITableView *)tableView widthCellArr:(NSArray *)arr withSectionName:(NSString *)sectionName withHandleAction:(void (^)()) handleBlock
{
    [_cellManager addSection];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)  {
//        NSNumber *n = @(idx);
        NSInteger inx;
        if (_mode == BtnTipShowMode ||_mode == NormoalMode) {
            inx = 0;
        }
        else if(_mode == BtnShowMode)
        {
            inx = 2;
        }
        NSDictionary *dic = [(JYBaseData *)obj getDataDic:inx];//模型类要实现getDataDic接口协议
        [self addTableViewCell:tableView cellClass:@"ContactPersonTableViewCell" cellDataDic:dic handleAction:^(id sender) {
            if (_callBtncallBack) {
                _callBtncallBack(obj);
            }
        }];
    }];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0,9990,0,0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,9990,0,0)];
    }
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
