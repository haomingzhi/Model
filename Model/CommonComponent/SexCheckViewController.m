//
//  SexCheckViewController.m
//  rentingshop
//
//  Created by air on 2018/3/26.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "SexCheckViewController.h"
#import "TitleAndImageTableViewCell.h"
#import "BUSystem.h"
@interface SexCheckViewController ()
{
     TitleAndImageTableViewCell *_nanCell;
     TitleAndImageTableViewCell *_nvCell;
     TitleAndImageTableViewCell *_bmCell;
}
@property (weak, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation SexCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"修改性别";
     [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     _nanCell = [TitleAndImageTableViewCell createTableViewCell];
     [_nanCell setCellData:@{@"title":@"男",@"img":@"checkGou",@"isCheck":@NO}];
     [_nanCell fitSexCheckMode];

     _nvCell = [TitleAndImageTableViewCell createTableViewCell];
     [_nvCell setCellData:@{@"title":@"女",@"img":@"checkGou",@"isCheck":@NO}];
     [_nvCell fitSexCheckMode];

     _bmCell = [TitleAndImageTableViewCell createTableViewCell];
     [_bmCell setCellData:@{@"title":@"保密",@"img":@"checkGou",@"isCheck":@NO}];
     [_bmCell fitSexCheckMode];
     if (_check == 0) {
          [_nanCell setCellData:@{@"title":@"男",@"img":@"checkGou",@"isCheck":@YES}];
          [_nanCell fitSexCheckMode];
     }
     else if (_check == 1)
     {
          [_nvCell setCellData:@{@"title":@"女",@"img":@"checkGou",@"isCheck":@YES}];
          [_nvCell fitSexCheckMode];
     }
     else
     {
          [_bmCell setCellData:@{@"title":@"保密",@"img":@"checkGou",@"isCheck":@YES}];
          [_bmCell fitSexCheckMode];
     }
     self.tableView.refreshHeaderView = nil;
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

     return 14;
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
     CGFloat height = 46;
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 1;
     switch (section) {
          case 0:
               row = 3;
               break;
          case 1:
               row = 7;
               break;
          default:
               break;
     }
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = _nanCell;
          [_nanCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
     }
     else  if (indexPath.row == 1) {
          cell = _nvCell;
          [_nvCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(46, 0, 0, 0)];
     }
     else
     {
          cell = _bmCell;
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (_callBack) {
          NSString *sex = @"0";
          if (indexPath.row == 0) {
               sex = @"2";
          }
          else if (indexPath.row == 1)
          {
               sex = @"1";
          }
          [self upSexData:sex];
          _callBack(@{@"row":@(indexPath.row)});
     }
     [self.navigationController popViewControllerAnimated:YES];
}

-(void)upSexData:(NSString *)sex
{
     HUDSHOW(@"保存中");
     [busiSystem.agent upUserInfo:busiSystem.agent.userId?:@"" withTypeMsg:@"3" withData:sex observer:self callback:@selector(saveUserNotification:)];

}

-(void)saveUserNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          //          HUDDISMISS;
          HUDSMILE(@"保存成功", 1);
          [self performSelector:@selector(goNext) withObject:nil afterDelay:1];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }

}

-(void)goNext
{
     HUDSHOW(@"加载中");
     [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshPersonData" object:nil];
     busiSystem.agent.isNeedRefreshTabD = YES;
     [self.navigationController popViewControllerAnimated:YES];

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
