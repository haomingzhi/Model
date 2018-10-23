//
//  JYBaseTableViewController.m
//  TestTableView
//
//  Created by wujiayuan on 15/8/13.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import "JYBaseTableViewController.h"
#import "JYBaseTableViewCell.h"
#import "ImgTitleAndDetailTableViewCell.h"
@interface JYBaseTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet MyTableView *_tableViewB;
    IBOutlet MyTableView *_tableViewA;
    NSMutableArray *_sectionArr;
     MyTableView *_tableView;
    UIView *_noDataView;
}
@end

@implementation JYBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    if ([_delegate respondsToSelector:@selector(rightHandleActon:)]) {
       [self setRightBtn];
    }
    
    if (_tableStyle == TableStyleGroup) {
        _tableView = _tableViewA;
    }
    else
    {
        _tableView = _tableViewB;
    }
    [self initTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.title = [_delegate getTitle];
}

-(void) setDelegate:(id<JYBaseTableViewDelegate>)delegate
{
    _delegate = delegate;
    [((id)delegate) setValue:self forKey:@"parentViewController"];
}

-(void)setRightBtn
{
    [self setNavigateRightButton:@"完成" font:[UIFont systemFontOfSize:14] color:[UIColor lightGrayColor]];
}

-(void)handleDidRightButton:(id)sender
{
    [_delegate rightHandleActon:sender];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (_tableViewB == _tableView) {
        [_tableViewA removeFromSuperview];
    }
    else
    {
    [_tableViewB removeFromSuperview];
    }
    _tableView.height = __SCREEN_SIZE.height - 64;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(void)deleteAllCelllManager
{
[_sectionArr removeAllObjects];
}
-(void)refreshCurentPage:(id) obj
{
  [_sectionArr removeAllObjects];
    [_sectionArr addObjectsFromArray:obj];
    [_tableView reloadData];
//    if ([_delegate respondsToSelector:@selector(initTableViewCells:withTableView:context:)]) {
//        [_delegate initTableViewCells:_sectionArr withTableView:_tableView context:self];
//    }
//    else
//    {
//        [_delegate initTableViewCells:_sectionArr withTableView:_tableView];
//    }
}

-(void)initTableView
{
//[_delegate registerTableViewCell:@"ImgTitleAndDetailTableViewCell" withTableView:_tableView];
    _sectionArr = [NSMutableArray array];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.refreshHeaderView = nil;
    if ([_delegate respondsToSelector:@selector(initTableViewCells:withTableView:context:)]) {
         [_delegate initTableViewCells:_sectionArr withTableView:_tableView context:self];
    }
    else
    {
    [_delegate initTableViewCells:_sectionArr withTableView:_tableView];
    }
    
    if ([_delegate respondsToSelector:@selector(setFootView:)]) {
        [_delegate setFootView:_tableView];
    }
   else
   {
    _tableView.tableFooterView = [[UIView alloc] init];
   }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_sectionArr.count == 0) {
        if ([_delegate respondsToSelector:@selector(getNoDataView)]) {
            if (!_noDataView) {
                _noDataView = [_delegate getNoDataView];
            }
            [self.view addSubview:_noDataView];
        }
        
    }
    else
    {
        [_noDataView removeFromSuperview];
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
    if ([_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
         [_delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([_delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [_delegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([_delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [_delegate tableView:tableView heightForHeaderInSection:section];
    }
    if (section == 0) {
        return 0.01;
    }
    return 12;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([_delegate respondsToSelector:@selector(deleteCellHandleAction:)]) {
            [_delegate deleteCellHandleAction:indexPath];
        }
    }
}
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
      return   [_delegate tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
       return  [_delegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
     return UITableViewCellEditingStyleNone;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([_delegate respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return  [_delegate sectionIndexTitlesForTableView:tableView];
    }
    return nil;
    
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([_delegate respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return  [_delegate tableView:tableView titleForHeaderInSection:section];
    }
    return nil;
    
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
