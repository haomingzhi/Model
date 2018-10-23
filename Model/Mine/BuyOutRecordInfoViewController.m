//
//  BuyOutRecordInfoViewController.m
//  rentingshop
//
//  Created by air on 2018/4/4.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "BuyOutRecordInfoViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "PayOrderViewController.h"
@interface BuyOutRecordInfoViewController ()
{
     TitleDetailTableViewCell *_moneyInfoCell;
     OnlyBottomBtnTableViewCell *_payCell;
}

@end

@implementation BuyOutRecordInfoViewController
-(id)init
{
     self = [super initWithNibName:@"RecordInfoViewController" bundle:nil];
     return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     _moneyInfoCell = [TitleDetailTableViewCell createTableViewCell];
     _payCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [self.queTipCell setCellData:@{@"title":@"买断信息"}];
     [self.queTipCell fitRecordInfoModeB];
     __weak BuyOutRecordInfoViewController *weakSelf = self;
     [_payCell setHandleAction:^(id sender) {
          [weakSelf payMoney];
     }];
}


-(void)payMoney
{
     BUSubmitOrder *od = [BUSubmitOrder new];
     od.orderId = self.backInfo.orderId;
     od.payMoney = [self.backInfo.buyoutMoney floatValue] ;
     PayOrderViewController *vc = [PayOrderViewController new];
     vc.order = od;
     vc.mode = 0;
    
     vc.orderType = @"3";
     vc.typeId = self.backInfo.afterId;
     [vc setHandleGoBack:^(id userData) {
          busiSystem.agent.isNeedRefreshTabD = YES;
     }];
     [self.navigationController pushViewController:vc animated:YES];
}

-(void)getData
{
     [busiSystem.myPathManager buyouInfo:busiSystem.agent.userId withBuyoutid:self.orderBackID?:@"" observer:self callback:@selector(buyouInfoNotificaton:)];
}

-(void)buyouInfoNotificaton:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          self.backInfo = busiSystem.myPathManager.buyoutInfo;
          [self.auditCell setCellData:[self.backInfo getDic2:0]];
          [self.auditCell fitRecordInfoMode];
//          [self.queCell setCellData:@{@"title":self.backInfo.content?:@""}];
//          [self.queCell fitRecordInfoModeC];
          [_moneyInfoCell setCellData:@{@"title":@"买断金额",@"detail":[NSString stringWithFormat:@"%@元",self.backInfo.buyoutMoney?:@"0"]}];
          [_moneyInfoCell fitBuyoutInfoMode];
          [_payCell setCellData:@{@"title":@"立即付款"}];
          [_payCell fitBuyoutMode];
if(self.backInfo.state != 1)
{
     [_payCell getBtn].hidden = YES;
}
          [self.auditNoteCell setCellData:@{@"title":self.backInfo.note?:@""}];
          [self.auditNoteCell fitRecordInfoModeC];
          //          BUTimeList *t = _backInfo.timeList.firstObject;
          NSString *title = [NSString stringWithFormat:@"审核进度：%@",self.backInfo.stateName?: @""];
          [self.auditTipCell setCellData:@{@"title":title}];
          [self.auditTipCell fitRecordInfoModeA];
          [self.stateCell setCellData:[self.backInfo getDic:1]];
          [self.stateCell fitRecordInfoMode];
          [self.tableView reloadData];
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
               if (indexPath.row == 1) {
                    height = 40;
               }
          else
          {
               height = 40;
          }

     }
     else
     {
          if (indexPath.row == 0) {
               height = 36;
          }
          else
          {
               height = self.auditNoteCell.height;
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
               row = 3;
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
          cell = self.stateCell;
          [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(59, 0, 0, 0)];
     }
     else if(indexPath.section == 1)
     {
          if (indexPath.row == 0) {
               cell = self.auditTipCell;
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(36, 0, 0, 0)];
          }
          else
          {
               cell = self.auditCell;
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(125, 0, 0, 0)];
          }
     }
     else if (indexPath.section == 2)
     {
          if (indexPath.row == 0) {
               cell = self.queTipCell;
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(36, 0, 0, 0)];
          }
          else if (indexPath.row == 1)
          {
               cell = _moneyInfoCell;
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
          }
          else
          {
               cell = _payCell;
          }

     }
     else
     {
          if (indexPath.row == 0) {
               cell = self.auditNoteTipCell;
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(36, 0, 0, 0)];
          }
          else
          {
               cell = self.auditNoteCell;
               [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
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
