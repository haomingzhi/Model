//
//  GetCouponCenterViewController.m
//  rentingshop
//
//  Created by air on 2018/3/29.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "GetCouponCenterViewController.h"
#import "CouponTableViewCell.h"
#import "BUSystem.h"
@interface GetCouponCenterViewController ()
@property (weak, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation GetCouponCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"领券中心";
    [self initTableView];
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)getData
{
     [busiSystem.myPathManager  bringStock:busiSystem.agent.userId?:@"" observer:self callback:@selector(bringStockNotification:)];
}

-(void)bringStockNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.myPathManager.getMyCouponArr];
          [_tableView reloadData];
          [[JYNoDataManager manager] addNodataView:_tableView withTip:@"暂无信息" withImg:@"nodata" withCount:_tableView.dataArr.count withTag:[NSString stringWithFormat:@"favc%d",3]];
          [[JYNoDataManager manager] fitModeY:130 ];
     }
     else
     {
          
          HUDCRY(noti.error.domain, 1);
     }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
    self.tableView.refreshHeaderView = nil;
     [CouponTableViewCell registerTableViewCell:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{

    return  nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 85;
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = _tableView.dataArr.count;

    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
     cell = [CouponTableViewCell dequeueReusableCell:_tableView];
        BUGetMyCoupon *o = _tableView.dataArr[indexPath.row];
     o.indexPath = indexPath;
     NSDictionary *dic =[o getDic:4];// @{@"aTitle":@"¥60",@"bTitle":[NSString stringWithFormat:@"满100元可用"],@"cTitle":[NSString stringWithFormat:@"全品类通用券"],@"dTitle":@"适用平台：全平台",@"eTitle":@"有效期至：2017-08-01",@"bgImg":@"coupon_bg",@"btn":@"领取"};//[o getDicB];
     [(JYAbstractTableViewCell *)cell setCellData:dic];
     [(CouponTableViewCell *)cell fitGetCouponCenterMode];
     [(CouponTableViewCell *)cell setHandleAction:^(NSDictionary *dic) {
          NSIndexPath *path = dic[@"row"];
            BUGetMyCoupon *o = _tableView.dataArr[path.row];
          [self getCoup:o.couponId?:@""];
     }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)getCoup:(NSString *)cid
{
     HUDSHOW(@"加载中");
     [busiSystem.myPathManager addCoupon:busiSystem.agent.userId?:@"" withCouponid:cid observer:self callback:@selector(addCouponNotification:)];
}

-(void)addCouponNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
          [self getData];
          HUDSMILE(@"领取成功", 2);
          if (self.handleGoBack) {
               self.handleGoBack(@{});
          }
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
