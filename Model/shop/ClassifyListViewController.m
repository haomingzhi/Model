//
//  ClassifyListViewController.m
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/7.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ClassifyListViewController.h"
#import "ImgAndTitleCollectionViewCell.h"
#import "ZJMenuView.h"
#import "ShopListViewController.h"
#import "ErrandServerViewController.h"
#import "ServerListViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "GoodsInfoViewController.h"

@interface ClassifyListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
     ZJMenuView *_menuView;
     NSInteger _state;
}
@property (nonatomic,strong) NSMutableArray *shopList;
@property (nonatomic,strong) NSMutableArray *serviceList;
@end

@implementation ClassifyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//     self.title = @"全部分类";
     _shopList = [NSMutableArray arrayWithArray:busiSystem.shopManager.shopTypeList];
     _serviceList = [NSMutableArray arrayWithArray:busiSystem.shopManager.serviceTypeList];
     [self initTableView];
     HUDSHOW(@"加载中");
     [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData{
     [busiSystem.headManager getTypeInfo:_typetId withParentId:_parentId observer:self callback:@selector(getTypeInfoNotification:)];
}


-(void)getTypeInfoNotification:(BSNotification *)noti{

     
     if (noti.error.code == 0) {
//          if (_tableView.isRefreshing) {
//               //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
//               [self refreshTableHeaderNotification:noti myTableView:_tableView];
//               [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
//               _tableView.isRefreshing = NO;
//          }
          HUDDISMISS;
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.headManager.getTypeInfoList];
          [_tableView reloadData];
          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:@"nodata"];
          [[JYNoDataManager manager] fitModeY:100];
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}

-(void)initTableView
{
     _tableView.refreshHeaderView = nil;
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     _tableView.backgroundColor = kUIColorFromRGB(color_2);
     _tableView.x = 0;
     _tableView.y = 0;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.height = __SCREEN_SIZE.height - NAVBARHEIGHT;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return  _tableView.dataArr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 135;
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 1;
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     
     UITableViewCell *cell;
    
     cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:tableView];
     BUHeadGoods *g = _tableView.dataArr[indexPath.section];
     NSDictionary *dic = [g getDic];
  //@{@"title":@"iPhone X 全新国行",@"source":[NSString stringWithFormat:@"%.2f",200.0],@"time":[NSString stringWithFormat:@"元/%@",@"月"],@"default":@"default",@"img":@"orderEx",@"isPost":@(YES),@"isSecondHand":@(YES)};
     [(JYAbstractTableViewCell *)cell setCellData:dic];
     [(ImgAndThreeTitleTableViewCell *)cell fitSearchResultMode];
     [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(135, 15, 0, 15)];

     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     GoodsInfoViewController *vc = [GoodsInfoViewController new];
     BUHeadGoods *g = _tableView.dataArr[indexPath.section];
     vc.ID = g.productId;
     [self.navigationController pushViewController:vc animated:YES];
}



@end
