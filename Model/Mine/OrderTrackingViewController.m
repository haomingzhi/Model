//
//  OrderTrackingViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "OrderTrackingViewController.h"
#import "FourIconBtnTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
@interface OrderTrackingViewController ()
{
     ImgAndThreeTitleTableViewCell *_orderInfoCell;
     FourIconBtnTableViewCell *_stateCell;
     OnlyTitleTableViewCell *_tipCell;
     
}

@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic)  BUTrack *track;
@end

@implementation OrderTrackingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"订单跟踪";
    [self initTableView];
//     HUDSHOW(@"加载中");
//     [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleReturnBack:(id)sender{
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)getData{
//     [busiSystem.orderManager getTrackOrder:busiSystem.agent.userId orderId:_order.orderID observer:self callback:@selector(getTrackOrderNotification:)];
}


-(void)getTrackOrderNotification:(BSNotification *)noti{
     HUDDISMISS;
     if (noti.error.code == 0) {
          _track = busiSystem.orderManager.track;
          NSMutableDictionary *dic = [NSMutableDictionary new];
          [dic addEntriesFromDictionary:[_track getDic:0]];
//          if (_order.outMyOrderItem.count !=0) {
//               BUCartGoods *g = _order.outMyOrderItem.firstObject;
//               [dic setObject:g.pDefImg?:@"" forKey:@"img"];
//          }

          [_orderInfoCell setCellData:dic];
           [_orderInfoCell fitTraceOrderMode];
          [_stateCell setCellData:[_track getDic:1]];
          [_stateCell fitTraceOrderMode];
          [_tableView reloadData];
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}


-(void)initTableView
{
     _tableView.refreshHeaderView = nil;
     _orderInfoCell  = [ImgAndThreeTitleTableViewCell createTableViewCell];
     [_orderInfoCell setCellData:@{@"title":@"配送企业：",@"source":@"快递单号：",@"time":@"联系电话：",@"img":@"default",@"count":@""}];
     [_orderInfoCell fitTraceOrderMode];
     
     _stateCell = [FourIconBtnTableViewCell createTableViewCell];
     [_stateCell setCellData:@{@"oneTitle":@"已接单",@"twoTitle":@"待配送",@"threeTitle":@"配送中",@"fourTitle":@"已签收",@"img":@"",@"himg":@"trace",@"mark":@"traceB",@"hMark":@"traceA",@"title":@"北京",@"detail":@"福州",@"check":@0}];
     [_stateCell fitTraceOrderMode];
     _tipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_tipCell setCellData:@{@"title":@"物流详情"}];
     [_tipCell fitTraceOrderMode];
     
     [TitleDetailTableViewCell registerTableViewCell:_tableView];
     
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  2;
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
     if (section == 0) {
          return 10;
     }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     if (section == 0) {
          return [self createSectionFootView];
     }
    return nil;
}
-(UIView *)createSectionFootView
{
     UIView *v = [UIView new];
     v.height = 10;
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     v.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     line.tag = 9887;
     [v addSubview:line];
     return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               height = 101;
          }
          else
          {
               height = 80;
          }
     }
     else
     {
          if (indexPath.row == 0) {
               height = 35;
          }
          else if (indexPath.row == 1)
          {
               height = 84;
          }
          else
          {
               height = 67;
          }
     }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    switch (section) {
        case 0:
            row = 2;
            break;
        case 1:
            row = _track.outOrderTrackItemModelList.count+1;
            break;
        default:
            break;
    }
    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               cell = _orderInfoCell;
               [_orderInfoCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(101, 0, 0, 0)];
          }
          else
          {
               cell = _stateCell;
            [_stateCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(80, 0, 0, 0)];
          }
     }
     else
     {
          if (indexPath.row == 0) {
               cell = _tipCell;
                  [_tipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
          }

          else
          {
               cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
               BUTrackInfo *info = _track.outOrderTrackItemModelList[indexPath.row-1];
               NSMutableDictionary *dic = [NSMutableDictionary new];
               [dic addEntriesFromDictionary:[info getDic:0]];
               if (indexPath.row == 1) {
                    [dic setObject:@YES forKey:@"isCheck"];
                    [(TitleDetailTableViewCell *)cell setCellData:dic];
                    [(TitleDetailTableViewCell *)cell  fitTraceOrderModeA];
               }else{
                    [dic setObject:@NO forKey:@"isCheck"];
                    [(TitleDetailTableViewCell *)cell setCellData:dic];
                    [(TitleDetailTableViewCell *)cell  fitTraceOrderModeB];
               }
               
          }
     }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
