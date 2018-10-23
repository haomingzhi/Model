//
//  MySecHandViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/4.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "MySecHandViewController.h"
#import "TwoTabsTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "PublishSecHandDealViewController.h"
#import "ReplacementViewController.h"
#import "BUSystem.h"
@interface MySecHandViewController ()
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation MySecHandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self setTitleLb];
     [self setRightNav];
    [self initTableView];
     HUDSHOW(@"加载中");
     [self getData];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresMySecHandData) name:@"refresMySecHandData" object:nil];
}

-(void)refresMySecHandData
{
   [self getData];
}
-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)setTitleLb
{
     UILabel *tlb = [UILabel new];
     tlb.width = 100;
     tlb.height = 30;
     tlb.textColor = kUIColorFromRGB(color_1);
     tlb.font = [UIFont systemFontOfSize:15];
     tlb.textAlignment = NSTextAlignmentCenter;
     tlb.text = @"我的二手";
     self.navigationItem.titleView = tlb;
;
}
-(void)getData
{
     [busiSystem.secondhandManager.getSecondhandGoodsListManager getList:busiSystem.agent.userId withCityId:[NSString stringWithFormat:@"%d",busiSystem.agent.cityId] withLon:busiSystem.agent.log withLat:busiSystem.agent.lat observer:self callback:@selector(getListNotification:)];
}

-(void)getListNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.secondhandManager.getSecondhandGoodsListManager.dataArr];
          _tableView.hasMore = busiSystem.secondhandManager.getSecondhandGoodsListManager.pageInfo.hasMore;
           [_tableView reloadData];
          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:@"serShop"];
          [[JYNoDataManager manager] fitModeY:150];

     }
     else
     {
          
          HUDCRY(noti.error.domain, 1);
     }
}

-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBar.shadowImage = nil;
}

-(void)setRightNav
{
     [self setNavigateRightButton:@"发布二手" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_1)];
}

-(void)handleDidRightButton:(id)sender
{
     PublishSecHandDealViewController *vc = [PublishSecHandDealViewController new];
     [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView
{
     self.tableView.refreshHeaderView = nil;
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     [TwoTabsTableViewCell registerTableViewCell:_tableView];
     _tableView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return  _tableView.dataArr.count;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{

     return  nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

     return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 44;
     if (indexPath.row == 0) {
          height = 109;
     }
     else
     {
          height = 45;
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 2;

     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

     __weak MySecHandViewController *weakSelf = self;
     BUGetSecondhandGoods *gd = _tableView.dataArr[indexPath.section];
     gd.indexPath = indexPath;
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
          [(ImgAndThreeTitleTableViewCell *)cell setCellData:[gd getDic:indexPath.row]];
          [(ImgAndThreeTitleTableViewCell *)cell fitMySecHandMode];
            [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(109, 0, 0, 0)];
     }
     else
     {
          cell = [TwoTabsTableViewCell dequeueReusableCell:_tableView];
          [(TwoTabsTableViewCell*)cell setCellData:[gd getDic:indexPath.row]];
          [(TwoTabsTableViewCell*)cell fitMySecHandMode];

          [(TwoTabsTableViewCell*)cell setTabOneCallBack:^(id o) {
               [weakSelf toEditMySecVC:indexPath];
          }];

          [(TwoTabsTableViewCell*)cell setTabTwoCallBack:^(id o) {
               [weakSelf delSecGood:indexPath];
          }];
//          [(JYAbstractTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      BUGetSecondhandGoods *gd = _tableView.dataArr[indexPath.section];
     ReplacementViewController *vc = [ReplacementViewController new];
     vc.secondHandGoods = gd;
     [self.navigationController pushViewController:vc animated:YES];
}

-(void)delSecGood:(NSIndexPath*)indexPath
{
     HUDSHOW(@"加载中");
   BUGetSecondhandGoods *gd = _tableView.dataArr[indexPath.section];
     [busiSystem.secondhandManager delSecondhandGoods:gd.goodsId withUserid:busiSystem.agent.userId observer:self callback:@selector(delSecondhandGoodsNotification:) extraInfo:@{@"row":indexPath}];
}

-(void)delSecondhandGoodsNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
        NSIndexPath *indexPath = noti.extraInfo[@"row"];
          [_tableView.dataArr removeObjectAtIndex:indexPath.section];
          [_tableView reloadData];
          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:@"serShop"];
          [[JYNoDataManager manager] fitModeY:150];

     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}

-(void)toEditMySecVC:(NSIndexPath *)indexPath
{
        BUGetSecondhandGoods *gd = _tableView.dataArr[indexPath.section];
     PublishSecHandDealViewController *vc = [PublishSecHandDealViewController new];
     vc.mySec = gd;
     [self.navigationController pushViewController:vc animated:YES];
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
