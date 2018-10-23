//
//  ToDoorRecycleViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/5.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ToDoorRecycleViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "TwoTabsTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "TextViewCanChangeTableViewCell.h"
#import "JYDatePickViewController.h"
#import "SingleSelectionViewController.h"
#import "SelectAddressViewController.h"
#import "BUSystem.h"
@interface ToDoorRecycleViewController ()
{
     TitleDetailTableViewCell *_adrCell;
     TwoTabsTableViewCell *_recycleIntentionCell;
     TitleDetailTableViewCell *_recycleTypeCell;
     TwoTabsTableViewCell *_weightCell;
     TitleDetailTableViewCell *_timeCell;
     TextViewCanChangeTableViewCell *_textViewCell;
             OnlyBottomBtnTableViewCell *_submitCell;
     NSInteger _requestCount;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic)NSString *time;
@property (strong, nonatomic)NSString *address;
@property ( nonatomic)NSInteger weight;
@property (strong, nonatomic)NSString *attion;
@property (strong, nonatomic)NSString *addrId;
@property (strong, nonatomic)NSString *remark;
@property (strong, nonatomic)NSString *recyclingtype;
@property (strong, nonatomic)NSMutableArray *typeNameArr;
@end

@implementation ToDoorRecycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"上门回收";
     self.attion = @"1";
     [self initTableView];
     HUDSHOW(@"加载中");
     [self getUserDefaultAddressData];
     [self getTypeData];
     [self addBottomView];
          [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAddressData) name:@"refreshAddressData" object:nil];
}
-(void)refreshAddressData
{
     HUDSHOW(@"加载中");
     [self getUserDefaultAddressData];
}
-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)getTypeData
{
     _requestCount ++;
     [busiSystem.dustbinManager getDustbinTypeList:self callback:@selector(getDustbinTypeListNotification:)];
}
-(void)getDustbinTypeListNotification:(BSNotification*)noti
{
     _requestCount--;

     if (noti.error.code == 0) {
          if (_requestCount == 0) {
               HUDDISMISS;
          }
          _typeNameArr = [NSMutableArray new];
          [busiSystem.dustbinManager.dustbinType enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUDustbinType *ty = obj;
               [_typeNameArr addObject:ty.typeName];
          }];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}
-(void)getUserDefaultAddressData
{
     _requestCount++;
     [busiSystem.agent getUserDefaultAddress:busiSystem.agent.userId observer:self callback:@selector(getUserDefaultAddressNotification:)];
}

-(void)getUserDefaultAddressNotification:(BSNotification*)noti
{
     _requestCount --;
     if (noti.error.code == 0) {
          if (_requestCount == 0) {
                   HUDDISMISS;
          }

//          _lat = busiSystem.agent.userDefaultAddress.latitude;
//          _lon = busiSystem.agent.userDefaultAddress.longitude;
          _addrId = busiSystem.agent.userDefaultAddress.addressId;
          if (!_addrId||[_addrId isEqualToString:@""]) {
               if (_requestCount == 0) {
                    HUDDISMISS;
               }

               [_adrCell setCellData:@{@"title":@"请新增服务地址",@"detail":@""}];
               [_adrCell fitToDoorRecycleModeC];
               return;
          }
          NSString *addr = busiSystem.agent.userDefaultAddress.address;
          NSString *detail = busiSystem.agent.userDefaultAddress.address;
          _addrId = busiSystem.agent.userDefaultAddress.addressId;
          [_adrCell setCellData:@{@"title":[NSString stringWithFormat:@"联系人：%@",busiSystem.agent.userDefaultAddress.userName],@"detail":[NSString stringWithFormat:@"服务地址：%@%@",addr?:@"",detail]}];
          [_adrCell fitToDoorRecycleModeB];
     }
     else
     {

          _addrId = busiSystem.agent.userDefaultAddress.addressId;
          if (!_addrId||[_addrId isEqualToString:@""]) {
               if (_requestCount == 0) {
                    HUDDISMISS;
               }
               [_adrCell setCellData:@{@"title":@"请新增服务地址",@"detail":@""}];
               [_adrCell fitToDoorRecycleModeC];
               return;
          }
          HUDCRY(noti.error.domain, 1);
     }
}


-(void)addBottomView
{
     _submitCell.width = __SCREEN_SIZE.width;
     _submitCell.y = __SCREEN_SIZE.height - 64 - 44;
     _submitCell.x = 0;
     [self.view addSubview:_submitCell];
}

-(void)viewDidLayoutSubviews
{
     _tableView.height = __SCREEN_SIZE.height - 64 - 45;
     _tableView.width = __SCREEN_SIZE.width;
}
-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBar.shadowImage = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     self.tableView.refreshHeaderView = nil;
     __weak ToDoorRecycleViewController *weakSelf = self;
     _adrCell = [TitleDetailTableViewCell createTableViewCell];
     [_adrCell setCellData:@{@"title":@"",@"detail":@""}];
     [_adrCell fitToDoorRecycleModeB];
     
     _recycleIntentionCell = [TwoTabsTableViewCell createTableViewCell];
     [_recycleIntentionCell setCellData:@{@"tab1":@"废品卖钱",@"tab2":@"爱心捐赠",@"title":@"回收意向",@"select":@0}];
     [_recycleIntentionCell fitToDoorRecycleMode];
     __weak TwoTabsTableViewCell *wer = _recycleIntentionCell;
     [_recycleIntentionCell setTabOneCallBack:^(id o) {
          [wer setCellData:@{@"tab1":@"废品卖钱",@"tab2":@"爱心捐赠",@"title":@"回收意向",@"select":@0}];
          [wer fitToDoorRecycleMode];
          weakSelf.attion = @"1";
     }];

     [_recycleIntentionCell setTabTwoCallBack:^(id o) {
          [wer setCellData:@{@"tab1":@"废品卖钱",@"tab2":@"爱心捐赠",@"title":@"回收意向",@"select":@1}];
          [wer fitToDoorRecycleMode];
           weakSelf.attion = @"2";
     }];

     _recycleTypeCell = [TitleDetailTableViewCell createTableViewCell];
     [_recycleTypeCell setCellData:@{@"title":@"回收类别",@"detail":@"请选择"}];
     [_recycleTypeCell fitToDoorRecycleMode];
     
     _weightCell = [TwoTabsTableViewCell createTableViewCell];
     [_weightCell setCellData:@{@"title":@"重量估计",@"value":@"0",@"tab1":@"",@"tab2":@"",@"unit":@"kg"}];
     [_weightCell fitToDoorRecycleModeB];
     __weak TwoTabsTableViewCell *ssw = _weightCell;
     [_weightCell setTabOneCallBack:^(id o) {
          if (weakSelf.weight == 0) {
               return ;
          }
          weakSelf.weight --;
          [ssw setCellData:@{@"title":@"重量估计",@"value":[NSString stringWithFormat:@"%ld",weakSelf.weight],@"tab1":@"",@"tab2":@"",@"unit":@"kg"}];
          [ssw fitToDoorRecycleModeB];
     }];
     [_weightCell setTabTwoCallBack:^(id o) {
          weakSelf.weight ++;
          [ssw setCellData:@{@"title":@"重量估计",@"value":[NSString stringWithFormat:@"%ld",weakSelf.weight],@"tab1":@"",@"tab2":@"",@"unit":@"kg"}];
          [ssw fitToDoorRecycleModeB];
     }];

     _timeCell = [TitleDetailTableViewCell createTableViewCell];
     [_timeCell setCellData:@{@"title":@"预约时间",@"detail":@"请选择时间"}];
  [_timeCell fitToDoorRecycleMode];

     _textViewCell = [TextViewCanChangeTableViewCell createTableViewCell];
     [_textViewCell setCellData:@{@"placeholder":@"请写留言描述回收物品的注意事项"}];
     [_textViewCell fitToDoorRecycleMode];



     _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_submitCell setCellData:@{@"title":@"立即预约"}];
     [_submitCell fitEditNickMode];
     [_submitCell setHandleAction:^(id sender) {
          [weakSelf submit];
     } ];
}

-(void)submit
{
     [self.view endEditing:YES];
     if (!_recyclingtype|| [_recyclingtype isEqualToString:@""]) {
          HUDCRY(@"请选择回收类别", 1);
          return;

     }
     if (!_time|| [_time isEqualToString:@""]||[_time isEqualToString:@"请选择"]) {
          HUDCRY(@"请选择预约时间", 1);
          return;
     }
     HUDSHOW(@"加载中");
     _remark = _textViewCell.textView.text;

     [busiSystem.orderManager recyclingOrderAdd:busiSystem.agent.userId?:@"" withAddrid:_addrId withRemark:_remark withRecyclingtype:_recyclingtype withWeight:[NSString stringWithFormat:@"%ld",_weight] withType:_attion?:@"" withPresettime:_time?:@"" observer:self callback:@selector(recyclingOrderAddNotification:)];
}

-(void)recyclingOrderAddNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          [self.navigationController popViewControllerAnimated:YES];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
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

     return 0.001;
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
     CGFloat height = 44;
     if (indexPath.row == 0) {
          height = 61;
     }
     else if (indexPath.row == 1)
     {
          height = 51;
     }
     else if (indexPath.row == 2)
     {
          height = 45;
     }
     else if (indexPath.row == 3)
     {
          height = 46;
     }
     else if (indexPath.row == 4)
     {
          height = 46;
     }
     else
     {
          height = 130;
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 6;

     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = _adrCell;
          [_adrCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(61, 0, 0, 0)];
     }
     else if (indexPath.row == 1)
     {
          cell = _recycleIntentionCell;
           [_recycleIntentionCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(51, 0, 0, 0)];
     }
     else if (indexPath.row == 2)
     {
          cell = _recycleTypeCell;
           [_recycleTypeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
     }
     else if (indexPath.row == 3)
     {
          cell = _weightCell;
           [_weightCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
     }
     else if (indexPath.row == 4)
     {
          cell = _timeCell;
           [_timeCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
     }
     else
     {
          cell = _textViewCell;
           [_textViewCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(130, 0, 0, 0)];
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(indexPath.row == 0)
     {
          SelectAddressViewController *vc = [SelectAddressViewController new];
          vc.canSelect = YES;
          [vc setHandleGoBack:^(NSDictionary *userData) {

//               _lon = userData[@"lon"];
            BUUserAddress   *adr = userData[@"address"];
               _addrId = adr.addressId?:@"";
//               _cityName = userData[@"cityName"];
               _address = adr.address;
               [_adrCell setCellData:@{@"title":[NSString stringWithFormat:@"联系人：%@",adr.userName],@"detail":[NSString stringWithFormat:@"%@%@",_address?:@"",adr.address]}];
               [_adrCell fitToDoorRecycleModeB];
          }];
          [self.navigationController pushViewController:vc animated:YES];
     }
     else
     if (indexPath.row == 2)
     {
//          NSArray *arr = @[@"ddd",@"xx",@"fff"];
          SingleSelectionViewController *vc = [SingleSelectionViewController toSingleSelectionVC:_typeNameArr];
          //     vc.curRow = busiSystem.getAreaParkListManager.curRow;
          [vc setHandleAction:^(NSDictionary *dic){
               NSString *tt = _typeNameArr[[dic[@"row"] integerValue]];
               BUDustbinType *tbv = busiSystem.dustbinManager.dustbinType[[dic[@"row"] integerValue]];
               _recyclingtype = tbv.typeId;
               [_recycleTypeCell setCellData:@{@"title":@"回收类别",@"detail":tt?:@"请选择"}];
               [_recycleTypeCell fitToDoorRecycleMode];
//               BUStroe *s =   busiSystem.indexManager.storeList[[dic[@"row"] integerValue]];
//               busiSystem.agent.storeId = s.sId;
//               HUDSHOW(@"加载中");
//               [self getRecProData];
//               [self getDefaultAddressData];
          }];
     }else
     if (indexPath.row == 4) {
          JYDatePickViewController *vc = [JYDatePickViewController createLimitVC];
          [vc fitDateTimeMode];
          [vc setCallBack:^(NSDate *date) {
               NSString *bt =  [BSUtility getDateTimeWithFormat:date Format:@"yyyy-MM-dd HH:mm:ss"];
               _time = bt;
               [_timeCell setCellData:@{@"title":@"预约时间",@"detail":_time?: @"请选择时间"}];
               [_timeCell fitToDoorRecycleMode];
          }];
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
