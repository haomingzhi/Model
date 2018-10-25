//
//  SysMsgInfoViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/4.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SysMsgInfoViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
@interface SysMsgInfoViewController ()
{
     TitleDetailTableViewCell *_titleCell;
     OnlyTitleTableViewCell *_contentCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation SysMsgInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"消息详情";
     [self initTableView];
//     if (!_msg) {
//          HUDSHOW(@"加载中");
//          [self getData];
//     }
}

-(void)getData
{
//     [busiSystem.sysManager.messageListManager getMessageInfo:_msgId observer:self callback:@selector(getMessageInfoNotification:)];
}

-(void)getMessageInfoNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
//          _msg = busiSystem.sysManager.messageListManager.getMessage.lastObject;
//          [_titleCell setCellData:@{@"title":_msg.mTitle?:@"",@"detail":_msg.createTime?:@""}];
//          [_titleCell fitSysMsgInfoMode];


//          [_contentCell setCellData:@{@"title":_msg.mContent?:@""}];
//           [_contentCell fitSysMsgInfoMode];
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
     self.tableView.refreshHeaderView = nil;
     _titleCell = [TitleDetailTableViewCell createTableViewCell];
//     [_titleCell setCellData:@{@"title":@"秒杀专区暂时下线公告",@"detail":@"2017年10月5日 10：00"}];
//     [_titleCell fitSysMsgInfoMode];
//     [_titleCell setCellData:@{@"title":_msg.title?:@"",@"detail":_msg.createTime?:@""}];
     [_titleCell fitSysMsgInfoMode];

     _contentCell = [OnlyTitleTableViewCell createTableViewCell];
//     [_contentCell setCellData:@{@"title":@"尊敬的用户，为了给您带来更好的体验，秒杀专区业务将于20 17年4月26日22：00-2017年4月27日09:00期间进行看看吧！ 尊敬的用户，为了给您带来更好的体验，秒杀专区业务将于20 17年4月26日22：00-2017年4月27日09:00期间进行看看吧！ 尊敬的用户，为了给您带来更好的体验，秒杀专区业务将于20 17年4月26日22：00-2017年4月27日09:00期间进行看看吧！ 尊敬的用户，为了给您带来更好的体验，秒杀专区业务将于20 17年4月26日22：00-2017年4月27日09:00期间进行看看吧！"}];
//     [_contentCell fitSysMsgInfoMode];
//     [_contentCell setCellData:@{@"title":_msg.content?:@""}];
     [_contentCell fitSysMsgInfoMode];
     _tableView.backgroundColor = kUIColorFromRGB(color_2);
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
          height = 55;
     }
     else
     {
          height = _contentCell.height + 10;
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 2;
     
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = _titleCell;
          [_titleCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(55, 15, 0, 15)];
     }
     else
     {
          cell = _contentCell;
//          [_contentCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(_contentCell.height+10, 0, 0, 0)];
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
