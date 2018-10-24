//
//  ZhiMaAuthViewController.m
//  rentingshop
//
//  Created by air on 2018/4/26.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "ZhiMaAuthViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "BUSystem.h"
#import "ZMSdkManager.h"
#import "ImgTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
@interface ZhiMaAuthViewController ()
{
     ImgTableViewCell *_imgVCell;
     OnlyTitleTableViewCell *_tipCell;
     TextFieldTableViewCell *_nameCell;
     TextFieldTableViewCell *_IDCell;
          TextFieldTableViewCell *_phoneCell;
     OnlyBottomBtnTableViewCell *_submitCell;
     OnlyTitleTableViewCell *_authTipCell;
}
@property (weak, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation ZhiMaAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"芝麻信用授权";
    [self initTableView];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zhiMaGoBack) name:@"zhiMaGoBack" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     __weak ZhiMaAuthViewController *weakSelf = self;
     _tableView.backgroundColor = kUIColorFromRGB(color_F2F2F2);
     self.tableView.refreshHeaderView = nil;
     _imgVCell = [ImgTableViewCell createTableViewCell];
     [_imgVCell setCellData:@{@"img":@"ZMlogo"}];
     [_imgVCell fitZhiMaAuthMode];

     _tipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_tipCell setCellData:@{@"title":@"请输入您的支付宝实名认证信息"}];
 [_tipCell fitZhiMaAuthMode];

     _nameCell = [TextFieldTableViewCell createTableViewCell];
     [_nameCell setCellData:@{@"placeholder":@"请输入您的姓名",@"detail":@""}];
     [_nameCell fitZhiMaAuthMode];
     _nameCell.textTf.kbMovingView = self.view;

     _IDCell = [TextFieldTableViewCell createTableViewCell];
     [_IDCell setCellData:@{@"placeholder":@"身份证号",@"detail":@""}];
     [_IDCell fitZhiMaAuthMode];
   _IDCell.textTf.kbMovingView = self.view;
     _phoneCell = [TextFieldTableViewCell createTableViewCell];
     [_phoneCell setCellData:@{@"placeholder":@"由您身份证申请的手机号码",@"detail":@""}];
     [_phoneCell fitZhiMaAuthMode];
   _phoneCell.textTf.kbMovingView = self.view;
     _submitCell =  [OnlyBottomBtnTableViewCell createTableViewCell];
     [_submitCell setCellData:@{@"title":@"确认授权"}];
     [_submitCell fitZhiMaAuthMode];
     [_submitCell setHandleAction:^(id sender) {
          [weakSelf submit];
     }];

     _authTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_authTipCell setCellData:@{@"title":@"授权说明\n1.授权芝麻信用后，您在体验产品时，可根据您的芝麻信息用等级减免产品押金。\n2.免押金只免除免押金范围内的押金，不免租金费用，不可提现。\n3.用户身份信息只用于免押认证，不会向第三方透露。"}];
     [_authTipCell fitZhiMaAuthModeB];

}

-(void)submit
{
     [self.view endEditing:YES];
     if(_nameCell.textTf.text.length == 0)
     {
          HUDCRY(@"请输入您的姓名", 2);
          return;
     }
     if (_IDCell.textTf.text.length == 0)
     {
           HUDCRY(@"请输入您的身份证号", 2);
          return;
     }
//     if (_phoneCell.textTf.text.length == 0)
//     {
//           HUDCRY(@"请输入您的身份证申请的手机号码", 2);
//          return;
//     }
     HUDSHOW(@"加载中");
      [busiSystem.payManager getPublicAppAuthorize:busiSystem.agent.userId?:@"" withUserTrueName:_nameCell.textTf.text withIDCard:_IDCell.textTf.text observer:self callback:@selector(getPublicAppAuthorizeNotification:)];

}
-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)zhiMaGoBack
{
     [self.navigationController popViewControllerAnimated:YES];
}
-(void)getPublicAppAuthorizeNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
//          [self.navigationController popViewControllerAnimated:NO];
          if(busiSystem.payManager.zmUrl )
          {
               [[ZMSdkManager manager] doVerify:busiSystem.payManager.zmUrl];
          }

     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
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
          if (indexPath.row == 0) {
               height = 123;
          }
          else if(indexPath.row == 1)
          {
height = 28;
          }
          else if(indexPath.row == 2)
          {
               height = 52;
          }
          else if(indexPath.row == 3)
          {
height = 52;
          }
          else
          {
height = 52;
          }
     }
     else
     {
          if (indexPath.row == 0) {
           height = 71;
          }
          else
          {
           height = 140;
          }

     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 1;
     switch (section) {
          case 0:
               row = 4;
               break;
          case 1:
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
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               cell = _imgVCell;
          }
          else if(indexPath.row == 1)
          {
 cell = _tipCell;
               [_tipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(28, 33, 0, 33)];
          }
          else if(indexPath.row == 2)
          {
cell = _nameCell;
  [_nameCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(52, 33, 0, 33)];
          }
          else if(indexPath.row == 3)
          {
              cell = _IDCell;
                 [_IDCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(52, 33, 0, 33)];
          }
          else
          {
          cell = _phoneCell;
                 [_phoneCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(52, 33, 0, 33)];
          }
     }
     else
     {
          if (indexPath.row == 0) {
     cell = _submitCell;
          }
          else
          {
               cell = _authTipCell;
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
