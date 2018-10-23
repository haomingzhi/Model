//
//  RecordInfoViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "RecordInfoViewController.h"

#import "LoginViewController.h"
//#import "HuanxinKefuManager.h"
@interface RecordInfoViewController ()
{
   
}

@end

@implementation RecordInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"记录详情";
     [self initTableView];
//     [self setNavigateRightButton:@"nav_kefu"];
     HUDSHOW(@"加载中");
     [self getData];
}

-(void)getData{

//     [busiSystem.getAfterSaleListManager getAfterSaleDetail:_orderBackID observer:self callback:@selector(getBackOrderItemNotification:)];
     [busiSystem.myPathManager saleInfo:_orderBackID withUserid:busiSystem.agent.userId observer:self callback:@selector(saleInfoNotification:)];
}


-(void) saleInfoNotification:(BSNotification *) noti
{

     if (noti.error.code == 0) {
          HUDDISMISS;
          _backInfo = busiSystem.myPathManager.saleInfo;
          [_auditCell setCellData:[_backInfo getDic:0]];
          [_auditCell fitRecordInfoMode];
          [_queCell setCellData:@{@"title":_backInfo.content?:@""}];
          [_queCell fitRecordInfoModeC];
          [_auditNoteCell setCellData:@{@"title":_backInfo.note?:@""}];
          [_auditNoteCell fitRecordInfoModeC];
//          BUTimeList *t = _backInfo.timeList.firstObject;
          NSString *title = [NSString stringWithFormat:@"审核进度：%@",_backInfo.stateName?: @""];
          [_auditTipCell setCellData:@{@"title":title}];
          [_auditTipCell fitRecordInfoModeA];
          [_stateCell setCellData:[_backInfo getDic:1]];
          [_stateCell fitRecordInfoMode];
          [_tableView reloadData];
     }else{
          HUDCRY(noti.error.domain, 2);
     }
     
}


//-(void)handleDidRightButton:(id)sender
//{
//     if (!busiSystem.agent.isLogin) {
//          [LoginViewController toLogin:self];
//          return;
//     }
//     [HuanxinKefuManager kefuHandle:self];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     _stateCell = [TitleDetailTableViewCell createTableViewCell];
     [_stateCell setCellData:@{@"title":@"服务单号：",@"detail":@"申请时间："}];
     [_stateCell fitRecordInfoMode];
     
     _auditTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_auditTipCell setCellData:@{@"title":@"审核进度："}];
     [_auditTipCell fitRecordInfoModeA];
     _auditCell = [FiveBtnTableViewCell createTableViewCell];
     [_auditCell setCellData:@{@"aTitle":@"提交申请",@"bTitle":@"处理完成",@"cTitle":@"处理完成",@"dTitle":@"处理完成",@"eTitle":@"处理完成",@"aDetail":@"2017-05-10 01:10:40",@"bDetail":@"2017-05-10 01:10:40",@"cDetail":@"2017-05-10 01:10:40",@"dDetail":@"2017-05-10 01:10:40",@"eDetail":@"2017-05-10 01:10:40",@"aimg":@"done",@"bimg":@"done",@"cimg":@"done",@"dimg":@"done",@"eimg":@"unDone",@"check":@3,@"hMark":@"trace",@"mark":@"已完成"}];
     [_auditCell fitRecordInfoMode];
     _queTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_queTipCell setCellData:@{@"title":@"问题描述"}];
      [_queTipCell fitRecordInfoModeB];
     
     _queCell = [OnlyTitleTableViewCell createTableViewCell];
       [_queCell setCellData:@{@"title":@""}];
     [_queCell fitRecordInfoModeC];
     
     _auditNoteTipCell = [OnlyTitleTableViewCell createTableViewCell];
       [_auditNoteTipCell setCellData:@{@"title":@"审核留言"}];
      [_auditNoteTipCell fitRecordInfoModeB];
     
     _auditNoteCell = [OnlyTitleTableViewCell createTableViewCell];
       [_auditNoteCell setCellData:@{@"title":@""}];
     [_auditNoteCell fitRecordInfoModeC];
     _tableView.refreshHeaderView = nil;
     _tableView.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 4;
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
     if(section == 0)
          return 0.001;
     return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 44;
     if (indexPath.section == 0 ) {
          height = 59;
     }
     else if(indexPath.section == 1)
     {
          if (indexPath.row == 0) {
               height = 36;
          }
          else
          {
               height = 125;
          }
     }
     else if (indexPath.section == 2)
     {
          if (indexPath.row == 0) {
                height = 36;
          }
          else
          {
                height = _queCell.height;
          }
          
     }
     else
     {
          if (indexPath.row == 0) {
                height = 36;
          }
          else
          {
                 height = _auditNoteCell.height;
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
          case 1:
               row = 2;
               break;
          case 2:
               row = 2;
               break;
          case 3:
               row = 2;
               break;
          default:
               break;
     }
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (indexPath.section == 0 ) {
          cell = _stateCell;
          [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(59, 0, 0, 0)];
     }
     else if(indexPath.section == 1)
     {
          if (indexPath.row == 0) {
               cell = _auditTipCell;
              [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(36, 0, 0, 0)];
          }
          else
          {
               cell = _auditCell;
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(125, 0, 0, 0)];
          }
     }
     else if (indexPath.section == 2)
     {
          if (indexPath.row == 0) {
               cell = _queTipCell;
              [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(36, 0, 0, 0)];
          }
          else
          {
               cell = _queCell;
              [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
          }

     }
     else
     {
          if (indexPath.row == 0) {
               cell = _auditNoteTipCell;
            [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(36, 0, 0, 0)];
          }
          else
          {
               cell = _auditNoteCell;
             [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
          }

     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.section == 1) {
          if (indexPath.row == 0) {
//               AuditProgressViewController *vc = [AuditProgressViewController new];
//               vc.backInfo = _backInfo;
//               [self.navigationController pushViewController:vc animated:YES];
          }
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
