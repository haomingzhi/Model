//
//  DealViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/1.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "DealViewController.h"
#import "FlashTableViewCell.h"
//#import "ImgAndThreeTitleTableViewCell.h"
#import "FindInfoViewController.h"
#import "TitleDetailTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "ImgTableViewCell.h"
#import "BlankTableViewCell.h"
#import "LoginViewController.h"
#import "BUSystem.h"
//#import "ClassifyListViewController.h"
//#import "OptimizationRecViewController.h"
//#import "GoodsInfoViewController.h"
@interface DealViewController ()
{
    FlashTableViewCell *_flashCell;
//     TwoTabsTableViewCell *_menuCell;
//     TwoTabsTableViewCell *_titleCell;
     BlankTableViewCell *_nodateCell;
     NSInteger _requestCount;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation DealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.navigationItem.titleView = [UIView new];
     [self initTableView];
     [self setLeftNav];
//     HUDSHOW(@"加载中");
     [self getData];
     [self getCarouselListData];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresSecHandData) name:@"refresSecHandData" object:nil];
}

-(void)setLeftNav
{
     UILabel *lb = [UILabel new];
     lb.textColor = kUIColorFromRGB(color_5);
     lb.font = [UIFont boldSystemFontOfSize:20];
     lb.width = 60;
     lb.height = 30;
     lb.text = @"发现";

     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lb];
}

-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)refresSecHandData
{

     [self getData];
     [self getCarouselListData];
}

-(void)getData
{
     _requestCount ++;
     [busiSystem.agent getFind:@"" withUserid:@"" observer:self callback:@selector(getFindNotification:)];
}

-(void)getCarouselListData
{
     _requestCount ++;
     [busiSystem.agent getFoundSlishow:@"" withUserid:@"" observer:self callback:@selector(getCarouselListNotification:)];
}

-(void)getCarouselListNotification:(BSNotification *)noti
{
     _requestCount --;
     if (_tableView.isRefreshing && _requestCount == 0) {
          //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
          [self refreshTableHeaderNotification:noti myTableView:_tableView];
          [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
          _tableView.isRefreshing = NO;
     }
     if (noti.error.code == 0) {
         if( _requestCount == 0)
         {
//          HUDDISMISS;
         }
          NSDictionary *dic =[BUFoundSlishow getArrDicWithThisArr:  busiSystem.agent.foundSlishowArr];
          [_flashCell setCellData:dic];
          [_flashCell fitDealMode];
          [_tableView reloadData];
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}
-(void)getFindNotification:(BSNotification *)noti
{
     _requestCount --;
     if (_tableView.isRefreshing && _requestCount == 0) {
          //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
          [self refreshTableHeaderNotification:noti myTableView:_tableView];
          [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
          _tableView.isRefreshing = NO;
     }
     if (noti.error.code == 0) {
          if( _requestCount == 0)
          {
//               HUDDISMISS;
          }
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.agent.getFindArr];
////          _tableView.hasMore = busiSystem.secondhandManager.getSecondhandGoodsListManager.pageInfo.hasMore;
          [_tableView reloadData];

     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{

     __weak DealViewController *weakSelf = self;
//    self.tableView.refreshHeaderView = nil;
     _flashCell = [FlashTableViewCell createTableViewCell];
     [_flashCell setCellData:@{@"arr":@[]}];
     [_flashCell fitDealMode];
     _flashCell.selecedtItem = ^(NSDictionary *dic){
          NSInteger index = [dic[@"row"] integerValue];
          if (busiSystem.agent.foundSlishowArr.count != 0) {
               BUFoundSlishow *c = busiSystem.agent.foundSlishowArr[index];
               [weakSelf tofitflashVC:c];
//               CommonWebViewViewController *vc = [CommonWebViewViewController setWebViewController:c.name?:@"" withUrl:c.url];
//               vc.hidesBottomBarWhenPushed = YES;
//               [weakSelf.navigationController pushViewController:vc animated:YES];
          }
     };



     _nodateCell = [BlankTableViewCell createTableViewCell];
     _nodateCell.height = 400;
     _nodateCell.width = __SCREEN_SIZE.width;
     [[JYNoDataManager manager] addNodataView:_nodateCell withTip:@"暂无信息" withImg:@"nodata" withCount:0 withTag:@"xxff"];
     [[JYNoDataManager manager] fitModeY:100];
     [OnlyTitleTableViewCell registerTableViewCell:_tableView withTag:@"title"];
     [OnlyTitleTableViewCell registerTableViewCell:_tableView withTag:@"content"];
     [TitleDetailTableViewCell registerTableViewCell:_tableView];
     [ImgTableViewCell registerTableViewCell:_tableView];
     _tableView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
}
-(void)tofitflashVC:(BUFoundSlishow *)q
{
     //（0 无 1 链接地址 2 指定分类 3 指定优选 4 指定商品）
     if (q.type == 1) {
          CommonWebViewViewController *vc = [CommonWebViewViewController setWebViewController:q.name?:@"" withUrl:q.url];
          vc.hidesBottomBarWhenPushed = YES;
          [self.navigationController pushViewController:vc animated:YES];
     }
     else if (q.type == 2){
//          ClassifyListViewController *vc = [ClassifyListViewController new];
//          vc.hidesBottomBarWhenPushed = YES;
//          vc.typetId = q.parmaId;
//          vc.parentId = @"";
//          vc.title = q.name;
//          [self.navigationController pushViewController:vc animated:YES];
     }
     else if (q.type == 3){
//          OptimizationRecViewController *vc = [OptimizationRecViewController new];
//          vc.hidesBottomBarWhenPushed = YES;
//          vc.ID = q.parmaId;
//          [self.navigationController pushViewController:vc animated:YES];
     }
     else if (q.type == 4){
//          GoodsInfoViewController *vc = [GoodsInfoViewController new];
//          vc.hidesBottomBarWhenPushed = YES;
//          vc.ID = q.parmaId;
//          [self.navigationController pushViewController:vc animated:YES];
     }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  MAX(_tableView.dataArr.count + 1, 2);
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
     if (section == 0 && busiSystem.agent.foundSlishowArr.count != 0) {
          return 10;
     }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
     if (indexPath.section == 0) {

               height = _flashCell.height;

     }

     else
     {
          if(_tableView.dataArr.count == 0)
          {
               height = 400;
          }
          else
          {
               if (indexPath.row == 0) {
                    height = 34;
               }
               else if (indexPath.row == 1)
               {
                    BUGetFind *g = _tableView.dataArr[indexPath.section - 1];
                    height = g.rHeight;
               }
               else if (indexPath.row == 2)
               {
                    height = 268/660.0 *__SCREEN_SIZE.width;
               }
               else
               {
                    height = 40;
               }
          }
     }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    switch (section) {
        case 0:
            row = 1;
            break;
//        case 1:
//            row = 1;
//            break;
         default:
              {
                   if (_tableView.dataArr.count == 0) {
                        row = 1;
                   }
                   else
                   {
                        row = 4;

                   }
              }
              break;
//        default:
//              row = 4;
//            break;
    }
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
     if (indexPath.section == 0) {

               cell = _flashCell;

     }
//     else if (indexPath.section == 1)
//     {
//          cell = _titleCell;
//     }
     else
     {
          if (_tableView.dataArr.count == 0) {
               cell = _nodateCell;
          }
          else
          {
               BUGetFind *g = _tableView.dataArr[indexPath.section - 1];
               NSDictionary *dic = [g getDic:indexPath.row];
               if (indexPath.row == 0) {
                  cell =  [OnlyTitleTableViewCell dequeueReusableCell:_tableView withTag:@"title"];
                    [(OnlyTitleTableViewCell *)cell setCellData:dic];
                       [(OnlyTitleTableViewCell *)cell fitDiscoveMode];
               }
               else if (indexPath.row == 1)
               {
                    cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView withTag:@"content"];
                        [(OnlyTitleTableViewCell *)cell setCellData:dic];
                    [(OnlyTitleTableViewCell *)cell fitDiscoveModeB];
                    g.rHeight = cell.height;
               }
               else if (indexPath.row == 2)
               {
                    cell = [ImgTableViewCell dequeueReusableCell:_tableView];
                    [(ImgTableViewCell *)cell setCellData:dic];
                     [(ImgTableViewCell *)cell fitDiscoveMode];
               } else
               {
                    cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
                    [(TitleDetailTableViewCell *)cell setCellData:dic];
                       [(TitleDetailTableViewCell *)cell fitDiscoveMode];
                     [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(40, 15, 0, 15)];
               }
//            BUGetSecondhandGoods *gd = _tableView.dataArr[indexPath.row];
//          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
//          [(ImgAndThreeTitleTableViewCell *)cell setCellData:[gd getDic:0]];
//          [(ImgAndThreeTitleTableViewCell*)cell fitMySecHandDealMode];

          }
     }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(indexPath.section > 0)
     {
          BUGetFind *g = _tableView.dataArr[indexPath.section - 1];
          [self toRead:g.findId?:@""];
          FindInfoViewController *vc= [FindInfoViewController new];
          vc.content = g.content;
          vc.name = g.title;
          vc.hidesBottomBarWhenPushed = YES;
          [self.navigationController pushViewController:vc animated:YES];
     }
}

-(void)refreshCurentPage
{
         _tableView.isRefreshing = YES;
     [self getData];
     [self getCarouselListData];
}

-(void)toRead:(NSString*)sid
{
     [busiSystem.agent upCount:@"1" withDataId:sid observer:nil callback:nil];
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
