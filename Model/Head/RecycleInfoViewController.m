//
//  RecycleInfoViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/8.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "RecycleInfoViewController.h"
#import "TitleDetailTableViewCell.h"
#import "ScrollerTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "SingleSelectionViewController.h"
#import "BUSystem.h"
@interface RecycleInfoViewController ()
{
     ScrollerTableViewCell *_scroCell;
     OnlyTitleTableViewCell *_jfTipCell;
     TitleDetailTableViewCell *_metalCell;
     TitleDetailTableViewCell *_paperCell;
     TitleDetailTableViewCell *_plasticCell;
     TitleDetailTableViewCell *_glassCell;
     TitleDetailTableViewCell *_personCell;
     TitleDetailTableViewCell *_tellCell;
     TitleDetailTableViewCell *_adrCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic)NSMutableArray *hArr;
@property (strong, nonatomic)NSMutableArray *iArr;
@end

@implementation RecycleInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"智能小区服务站";
//     _hArr = @[@"金属回收箱",@"纸质回收箱",@"塑料回收箱",@"玻璃回收箱"];
//     _iArr = @[@"metal2",@"paper2",@"plastic2",@"glass2"];
     [self initTableView];
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)viewWillAppear:(BOOL)animated
{
     self.panGesture.enabled = NO;
}

-(void)viewDidDisappear:(BOOL)animated
{
     self.panGesture.enabled = YES;
}
-(void)getData
{
     [busiSystem.dustbinManager getStationInfo:_stationId observer:self callback:@selector(getStationInfoNotification:)];
}

-(void)getStationInfoNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          BUGetStationInfo *station = busiSystem.dustbinManager.stationInfo;
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.dustbinManager.stationInfo.integralList];
          [_scroCell setCellData:[station getDic]];
          [_scroCell fitRecycleInfoModeB];

          self.title = station.name;
          [_personCell setCellData:@{@"title":@"负责人",@"detail":station.principal?:@"",@"img":@"contact"}];
          [_personCell fitRecycleInfoMode];


          [_tellCell setCellData:@{@"title":@"服务电话",@"detail":station.telephone,@"img":@"tell"}];
          [_tellCell fitRecycleInfoMode];



          [_adrCell setCellData:@{@"title":@"地址",@"detail":station.address?:@"",@"img":@"adr"}];
          [_adrCell fitRecycleInfoMode];
          [_tableView reloadData];
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
     __weak RecycleInfoViewController *weakSelf = self;
    self.tableView.refreshHeaderView = nil;
     _scroCell = [ScrollerTableViewCell createTableViewCell];
     [_scroCell setCellData:@{@"bgImg":@"recycleBg",@"leftImg":@"leftBtn",@"rightImg":@"rightBtn",@"recycleInfo":@[]}];
 [_scroCell fitRecycleInfoModeB];
     __weak ScrollerTableViewCell *ff = _scroCell;
//     [_scroCell setHandleAction:^(UIButton *btn) {
//          if (btn.tag == 3001) {
//               SingleSelectionViewController *vc = [SingleSelectionViewController toSingleSelectionVC:weakSelf.hArr];
//               //     vc.curRow = busiSystem.getAreaParkListManager.curRow;
//               [vc setHandleAction:^(NSDictionary *dic){
//                    NSString *tt = weakSelf.hArr[[dic[@"row"] integerValue]];
//                    NSString *fd = weakSelf.iArr[[dic[@"row"] integerValue]];
//                    [ff setCellData:@{@"bgImg":@"recycleBg",@"leftImg":@"leftBtn",@"rightImg":@"rightBtn",@"img":fd?:@"",@"title":tt?:@"",@"recycleInfo":@[@{@"title":@"累计回收",@"count":@"23KG",@"detail1":@"当前仓位：35%",@"detail2":@"满仓50kg",@"value":@(0.8)},@{@"title":@"累计回收",@"count":@"23KG",@"detail1":@"当前仓位：35%",@"detail2":@"满仓50kg",@"value":@(0.5)}],@"aTitle":@"123次",@"aDetail":@"满仓次数",@"bTitle":@"12.3kg",@"bDetail":@"剩余可回收"}];
//                    [ff fitRecycleInfoMode];
//
//               }];
//          }
//     }];

     _jfTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_jfTipCell setCellData:@{@"title":@"回收积分说明"}];
     [_jfTipCell fitRecycleInfoMode];

//     _metalCell = [TitleDetailTableViewCell createTableViewCell];
//     [_metalCell setCellData:@{@"title":@"金属",@"detail":@"23积分/kg",@"img":@"metal"}];
//     [_metalCell fitRecycleInfoMode];
//
//     _paperCell = [TitleDetailTableViewCell createTableViewCell];
//     [_paperCell setCellData:@{@"title":@"纸质",@"detail":@"93积分/kg",@"img":@"paper"}];
//     [_paperCell fitRecycleInfoMode];
//
//     _plasticCell = [TitleDetailTableViewCell createTableViewCell];
//     [_plasticCell setCellData:@{@"title":@"塑料",@"detail":@"88积分/kg",@"img":@"plastic"}];
//     [_plasticCell fitRecycleInfoMode];
     [TitleDetailTableViewCell registerTableViewCell:_tableView];
//
//     _glassCell = [TitleDetailTableViewCell createTableViewCell];
//     [_glassCell setCellData:@{@"title":@"玻璃",@"detail":@"53积分/kg",@"img":@"glass"}];
//     [_glassCell fitRecycleInfoMode];

     _personCell = [TitleDetailTableViewCell createTableViewCell];
     [_personCell setCellData:@{@"title":@"负责人",@"detail":@"陈先生",@"img":@"contact"}];
     [_personCell fitRecycleInfoMode];


     _tellCell = [TitleDetailTableViewCell createTableViewCell];
     [_tellCell setCellData:@{@"title":@"服务电话",@"detail":@"400-400-400",@"img":@"tell"}];
     [_tellCell fitRecycleInfoMode];


     _adrCell = [TitleDetailTableViewCell createTableViewCell];
     [_adrCell setCellData:@{@"title":@"地址",@"detail":@"福州市江北区XXX路XXX小区",@"img":@"adr"}];
     [_adrCell fitRecycleInfoMode];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
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
     if (section == 1) {
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
            BUGetStationInfo *station = busiSystem.dustbinManager.stationInfo;
          if(station.canList.count == 0)
          {
 _scroCell.hidden = YES;
               height = 0.0001;
          }
          else
          {
          height = 275;
               _scroCell.hidden = NO;
          }
     }
     else if (indexPath.section == 1)
     {
          height = 46;
     }
     else
     {
          height = 46;
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
        case 1:
            row =  _tableView.dataArr.count;
            break;
         case 2:
              row = 3;
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
          cell = _scroCell;
     }
     else if (indexPath.section == 1)
     {
//          if (indexPath.row == 0) {
          BUIntegral *itl = _tableView.dataArr[indexPath.row];
          cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
          [(TitleDetailTableViewCell*)cell setCellData:[itl getDic]];
          [(TitleDetailTableViewCell*)cell fitRecycleInfoMode];
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
//          }
//          else if (indexPath.row == 1)
//          {
//               cell = _metalCell;
//               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
//          }
//          else if (indexPath.row == 2)
//          {
//               cell = _paperCell;
//               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
//          }
//          else if (indexPath.row == 3)
//          {
//               cell = _plasticCell;
//               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
//          } else
//          {
//                cell = _glassCell;
//          }
     }
     else
     {
          if (indexPath.row == 0) {
               cell = _personCell;
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
          }
          else if (indexPath.row == 1)
          {
               cell = _tellCell;
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
          }
          else
          {
              cell = _adrCell;
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
