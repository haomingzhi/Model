//
//  MyFavViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/5.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "MyFavViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "ServerInfoViewController.h"
#import "ErrandServerInfoViewController.h"
#import "GoodsInfoViewController.h"
#import "BUSystem.h"
@interface MyFavViewController ()

@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@end

@implementation MyFavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"我的收藏";
     [self initTableView];
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)getData
{
     [busiSystem.myPathManager getColloc:busiSystem.agent.userId observer:self callback:@selector(getListNotification:)];
}

-(void)getListNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
     HUDDISMISS;
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.myPathManager.getCollocArr];
//          _tableView.hasMore = busiSystem.getCollectListManager.pageInfo.hasMore;
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
     self.panGesture.enabled = NO;
     self.navigationController.navigationBar.shadowImage = nil;
}

-(void)viewDidDisappear:(BOOL)animated
{
     self.panGesture.enabled = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     self.tableView.refreshHeaderView = nil;
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return _tableView.dataArr.count;
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
     return nil;//[self createSectionFootView:section];
}
-(UIView *)createSectionFootView:(NSInteger)section
{
     UIView *v = [self.tableView viewWithTag:9887 + section];
     if (!v) {
          v = [UIView new];
          v.tag = 9887 + section;
     }
     v.height = 10;
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     v.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);

     [v addSubview:line];

     return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 135;
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 1;//_tableView.dataArr.count;

     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     BUGetColloc *co =  _tableView.dataArr[indexPath.section];
     co.indexPath = indexPath;
//      NSDictionary *dic = @{@"title":@"DJI大疆 晓 Mavic Air 便携可折叠 4K无人机",@"source":[NSString stringWithFormat:@"¥99元/月"],@"time":[NSString stringWithFormat:@"商品价值：¥6499.00"],@"default":@"default"};
     UITableViewCell *cell;
     cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
     [(ImgAndThreeTitleTableViewCell*)cell setCellData:[co getDic]];
     [(ImgAndThreeTitleTableViewCell*)cell fitMyfavMode];
     [(ImgAndThreeTitleTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
          NSIndexPath *path = dic[@"row"];
           [[CommonAPI managerWithVC:self] showAlertView:@"删除收藏" withMsg:@"是否确认删除该收藏" withBtnTitle:@"确认"   withSel:@selector(toDelProcessResult:) withUserInfo:@{@"path":path}];

     }];
//     [(ImgAndThreeTitleTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(135, 0, 0, 0)];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}
-(void)toDelProcessResult:(NSDictionary *)dic
{
     NSInteger tag = [dic[@"tag"] integerValue];
     if (tag == 100) {
          NSDictionary *userInfo = dic[@"userInfo"];
          NSIndexPath *path = userInfo[@"path"];
         [self delCol:path];
     }
}
//-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//     UITableViewRowAction *layTopRowAction2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//          NSLog(@"点击了删除");
//          [self delCol:indexPath];
//
//     }];
//
//
//     NSArray *arr = @[layTopRowAction2];
//     return arr;
//}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
          BUGetColloc *co =  _tableView.dataArr[indexPath.section];
          GoodsInfoViewController  *vc = [GoodsInfoViewController new];
          vc.ID = co.productId;
          [self.navigationController pushViewController:vc animated:YES];

}

-(void)delCol:(NSIndexPath *)indexPath
{
     HUDSHOW(@"加载中");
     BUGetColloc *co = _tableView.dataArr[indexPath.section];
     [busiSystem.myPathManager addandUpCon:busiSystem.agent.userId?:@"" withProductid:co.productId?:@"" observer:self callback:@selector(addandUpConNotification:)  extraInfo:@{@"row":indexPath}];
//     [busiSystem.getCollectListManager delGoodsCollect:[NSString stringWithFormat:@"%d",co.productType] withGoodsid:co.goodsId withUserid:busiSystem.agent.userId observer:self callback:@selector(delGoodsCollectNotification:) extraInfo:@{@"row":indexPath}];
}

-(void)addandUpConNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          NSIndexPath *indexPath = noti.extraInfo[@"row"];
          [_tableView.dataArr removeObjectAtIndex:indexPath.row];
          [_tableView reloadData];
          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:@"serShop"];
          [[JYNoDataManager manager] fitModeY:150];
          busiSystem.agent.isNeedRefreshTabD = YES;
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
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
