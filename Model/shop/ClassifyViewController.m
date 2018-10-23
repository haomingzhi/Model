//
//  ClassifyDetailViewController.m
//  supermarket
//
//  Created by Steve on 2017/11/3.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ClassifyViewController.h"
#import "ThreeBtnTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "BUSystem.h"
#import "ZJMenuView.h"
#import "ZoneChoseViewController.h"
#import "GoodsInfoViewController.h"
#import "ImgAndTitleCollectionViewCell.h"
#import "ClassifyListViewController.h"
#import "SearchViewController.h"

@interface ClassifyViewController ()
{
     NSIndexPath *_curIndexPath;
     UIButton *btn;
     NSInteger _requestCount;
}
@property (nonatomic,strong) NSMutableArray *typeArr;
@property (nonatomic,strong) ZJMenuView *menuView;
@property (nonatomic,strong) ZoneChoseViewController *zoneVC;
@property (nonatomic,assign) NSInteger curIndex;
@property (nonatomic,strong) BUClassify *classify;
@property (nonatomic,strong) BUClassifyInfo *classifyInfo;
@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"分类";
     
//     _parentID = @"f89ea0f46e0b4101bfabda354e47c588";
     _curIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
     [self initTableView];
     [self initCollotionView];
     [self addView];
     [self setLeftNav];
     HUDSHOW(@"加载中");
     [self getData];
     
}



-(void)setLeftNav
{
     UILabel *lb = [UILabel new];
     lb.textColor = kUIColorFromRGB(color_1);
     lb.font = [UIFont boldSystemFontOfSize:20];
     lb.width = 100;
     lb.height = 30;
     lb.text = @"商品类目";
     
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lb];
     self.navigationItem.titleView = nil;
}

-(void)getData{
     [self getProType:@""];
}


-(void)getProType:(NSString *)search{
     _requestCount ++;
     [busiSystem.headManager getProType:search observer:self callback:@selector(getProTypeNotification:)];
}

-(void)getProTypeNotification:(BSNotification *)noti{
     _requestCount --;
     if (_requestCount == 0) {
          HUDDISMISS;
     }
     
     if (noti.error.code == 0) {
          _tableViewA.dataArr = [NSMutableArray arrayWithArray:busiSystem.headManager.getProTypeList];
          [_tableViewA reloadData];
          if (_tableViewA.dataArr.count >0) {
               _classify = [_tableViewA.dataArr firstObject];
               _collectionView.dataArr = [NSMutableArray arrayWithArray:_classify.secList];
               [_collectionView reloadData];
          }
          [[JYNoDataManager manager] addNodataView:_collectionView withTip:@"暂无信息" withImg:@"nodata" withCount:_collectionView.dataArr.count withTag:@"classify"];
          [[JYNoDataManager manager] fitModeY:100];
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addView{
     
     UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(95, 10, __SCREEN_SIZE.width-95-15, 30)];
     searchView.backgroundColor = kUIColorFromRGB(color_0xefefef);
     //     searchView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     //     searchView.layer.borderWidth = 0.5;
     searchView.layer.cornerRadius = 6.0;
     searchView.layer.masksToBounds = YES;
     //    searchView.layer.borderWidth = 0.5;
     [self.view addSubview:searchView];
     
     UIImageView *imV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 10, 10)];
     imV.image = [UIImage imageNamed:@"nav_search2"];
     [searchView addSubview:imV];
     
     UITextField *searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 0,searchView.width-40-10, searchView.height)];
     searchTextField.placeholder = busiSystem.agent.config.keyword?:@"请输入";
     searchTextField.font = [UIFont systemFontOfSize:13];
     [searchTextField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
     searchTextField.delegate = self;
     searchTextField.returnKeyType = UIReturnKeySearch;
     [searchView addSubview:searchTextField];
     
     
//     _menuView = [[ZJMenuView alloc]initWithFrame:CGRectMake(78, 0, __SCREEN_SIZE.width - 78 - 30, 40)];
//     [_menuView setData:@[]];
//     [self.view addSubview:_menuView];
//     _menuView.backgroundColor = kUIColorFromRGB(color_2);
//     __weak ClassifyViewController *weakSelf = self;
//     [_menuView setHandle:^(UIButton *btn) {
//          NSInteger index = btn.tag;
//          weakSelf.curIndex = index;
//          [weakSelf.menuView setCurrenItem:weakSelf.curIndex animated:NO];
////          BUClassify *a = weakSelf.typeArr[weakSelf.curIndex];
////          HUDSHOW(@"加载中");
////          [weakSelf getProdcuctListByClassID:a.pcId];
//     }];
//
//     btn = [[UIButton alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width-30, 0, 30, 40)];
//     [btn setImage:[UIImage imageNamed:@"icon_down_arrow"] forState:UIControlStateNormal];
//     [btn addTarget:self action:@selector(toSelectType) forControlEvents:UIControlEventTouchUpInside];
//     btn.backgroundColor = kUIColorFromRGB(color_2);
//     [self.view addSubview:btn];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
     SearchViewController *vc = [SearchViewController new];
     vc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:vc animated:YES];
     return NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
     [self.view endEditing:YES];
     HUDSHOW(@"加载中");
     [self getProType:textField.text];
     return YES;
}

-(void)toSelectType{
     __weak ClassifyViewController *weakSelf = self;
     self.zoneVC = (ZoneChoseViewController *)[ZoneChoseViewController toTypeVC];
     NSMutableArray *arr = [NSMutableArray new];
     [_typeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//          BUClassify *a = obj;
//          [arr addObject:a.pClassName];
     }];
     self.zoneVC.dataArr = arr;
     self.zoneVC.cancelAction = ^(){

     };
     self.zoneVC.handleAction = ^(NSDictionary *dic){
          [weakSelf.zoneVC.parentDialog dismiss];
          weakSelf.curIndex = [dic[@"index"] integerValue];
//          [weakSelf.menuView setCurrenItem:weakSelf.curIndex animated:NO];
//          BUClassify *a = weakSelf.typeArr[weakSelf.curIndex];
//          HUDSHOW(@"加载中");
//          [weakSelf getProdcuctClassListData:a.pcId];
     };
}


-(void)initTableView
{
     
     
     [TitleDetailTableViewCell registerTableViewCell:_tableViewA];
     
     _tableViewA.refreshHeaderView = nil;
     _tableViewA.separatorStyle = UITableViewCellSeparatorStyleNone;
     _tableViewA.refreshFooterView = nil;
     _tableViewA.height = __SCREEN_SIZE.height - TABBARHEIGHT - TABBARHEIGHT;
     _tableViewA.width = 80;
     _tableViewA.x = 0;
     _tableViewA.y = 0;
     _tableViewA.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     _tableViewA.bounces = NO;
     _tableViewA.showsVerticalScrollIndicator = NO;
     
//     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableViewB];
//     _tableViewB.refreshHeaderView = nil;
//     _tableViewB.separatorStyle = UITableViewCellSeparatorStyleNone;
//     _tableViewB.refreshFooterView = nil;
//     _tableViewB.height = __SCREEN_SIZE.height - 64-45;
//     _tableViewB.width = __SCREEN_SIZE.width -78;
//     _tableViewB.x = 78;
//     _tableViewB.y = 45;
//     _tableViewB.backgroundColor = kUIColorFromRGB(color_4);
//     _tableViewB.showsVerticalScrollIndicator = NO;
     
     self.view.backgroundColor  = kUIColorFromRGB(color_2);
}


-(void)initCollotionView
{
     
     
     [TitleDetailTableViewCell registerTableViewCell:_tableViewA];
     
     _collectionView.refreshHeaderView = nil;
     _collectionView.refreshFooterView = nil;
     _collectionView.height = __SCREEN_SIZE.height - TABBARHEIGHT - TABBARHEIGHT-50;
     _collectionView.width = __SCREEN_SIZE.width-80;
     _collectionView.delegate = self;
     _collectionView.dataSource = self;
     _collectionView.x = 80;
     _collectionView.y = 50;
     _collectionView.backgroundColor = kUIColorFromRGB(color_2);
//     _collectionView.bounces = YES;
     _collectionView.showsVerticalScrollIndicator = NO;
     
      [_collectionView registerNib:[UINib nibWithNibName:@"ImgAndTitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImgAndTitleCollectionViewCell"];
}

#pragma mark --UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     NSInteger count = 1;
     return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
     NSInteger count = 1;

     count = _tableViewA.dataArr.count;

     return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
//     if (_tableViewA == tableView) {
           cell = [self createTableViewACell: indexPath withTableView:(MyTableView*)tableView];
//     }
//     else{
//          cell = [self createTableViewBCell: indexPath withTableView:(MyTableView*)tableView];
//     }
     
     return cell;
}



-(UITableViewCell *)createTableViewACell:(NSIndexPath *)indexPath withTableView:(MyTableView *)_tableView
{
     UITableViewCell *cell;
  
     cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
     BUClassify *c = _tableViewA.dataArr[indexPath.row];
     [(TitleDetailTableViewCell *)cell setCellData:[c getDic]];
     
     if (indexPath.row == _curIndexPath.row) {
           [(TitleDetailTableViewCell *)cell fitClassifyDetailMode:YES];
     }else
         [(TitleDetailTableViewCell *)cell fitClassifyDetailMode:NO];

     
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return  cell;
}


-(UITableViewCell *)createTableViewBCell:(NSIndexPath *)indexPath withTableView:(MyTableView *)_tableView
{
     UITableViewCell *cell;
    
     cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
     BUGoodsInfo *g = _tableViewB.dataArr[indexPath.row];
     [(ImgAndThreeTitleTableViewCell *)cell setCellData:[g getDic:0]];
     [(ImgAndThreeTitleTableViewCell *)cell fitClassifyDetailMode];
     __weak ClassifyViewController *weakSelf = self;
     [(ImgAndThreeTitleTableViewCell *)cell setHandleAction:^(id sender) {
//          BUGoodsInfo *g = _tableViewB.dataArr[indexPath.row];
//          [weakSelf addShoppingCart:g.pId];
     }];
      [(ImgAndThreeTitleTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 15, 0, 0)];
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
     CGFloat height = 50;
//     if(tableView == _tableViewA)
//     {
//          height = 40;
//     }
//     else
//     {
//          height = 110;
//     }
     return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     return 0.01;
}


//行的选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self.view endEditing:YES];
     if ( tableView == _tableViewA) {
          _curIndexPath = indexPath;
          [_tableViewA reloadData];

          _classify = [_tableViewA.dataArr objectAtIndex:indexPath.row];
          _collectionView.dataArr = [NSMutableArray arrayWithArray:_classify.secList];
          [_collectionView reloadData];

          [[JYNoDataManager manager] addNodataView:_collectionView withTip:@"暂无信息" withImg:@"nodata" withCount:_collectionView.dataArr.count withTag:@"classify"];
          [[JYNoDataManager manager] fitModeY:100];
     }else{
          GoodsInfoViewController *vc = [GoodsInfoViewController new];
          BUGoodsInfo *g = _tableViewB.dataArr[indexPath.row];
//          vc.productId = g.pId;
          [self.navigationController pushViewController:vc animated:YES];
     }
     
     
}

-(void)loadNextPage{
//     if (_curIndexPath.row == 0) {
//          [busiSystem.getPromotionsProductPageListManager getListNextPage:self callback:@selector(getPotterBespokeListNextPage:callback:extraInfo:)];
//     }
//     else  if (_curIndexPath.row == 1) {
//          [busiSystem.getPopularityProductPageListManager getListNextPage:self callback:@selector(getPopularityProductPageListNotification:)];
//     }
//     else  if (_curIndexPath.row == 2) {
//          [busiSystem.getHotProductPageListManager getListNextPage:self callback:@selector(getHotProductPageListNotification:)];
//     }
//     else {
//          [busiSystem.getProdcuctListByClassIDManager getListNextPage:self callback:@selector(getProdcuctListByClassIDNotification:)];
//     }
}

#pragma mark - collection view
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
     return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     NSInteger row = _collectionView.dataArr.count;
    
     return row;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
//     if (__SCREEN_SIZE.width == 320) {
//          return  CGSizeMake(70, 110);
//     }else
//          return  CGSizeMake(80, 110);
     return  CGSizeMake((__SCREEN_SIZE.width-90)/3.0, 110);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     ImgAndTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImgAndTitleCollectionViewCell" forIndexPath:indexPath];
     BUClassifyInfo *c = [_collectionView.dataArr objectAtIndex:indexPath.row];
     [cell setCellData:[c getDic]];
     [cell fitClassityMode];
     return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     [self.view endEditing:YES];
     ClassifyListViewController *vc= [ClassifyListViewController new];
     vc.hidesBottomBarWhenPushed = YES;
     BUClassifyInfo *c = [_collectionView.dataArr objectAtIndex:indexPath.row];
     vc.title = c.name;
     vc.typetId = c.typetId;
     vc.parentId = c.parentId;
     [self.navigationController pushViewController:vc animated:YES];
}


@end
