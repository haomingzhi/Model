//
//  NoticeInfoViewController.m
//  taihe
//
//  Created by air on 2016/11/16.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "NoticeInfoViewController.h"

#import "BUSystem.h"

@interface NoticeInfoViewController ()
{
  
}


//@property (strong, nonatomic)BUGetNotice *notice;
@end

@implementation NoticeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"公告详情";

    [self getData];
    [self initTableView];
    self.view.backgroundColor = kUIColorFromRGB(color_9);
}





-(void)getData
{
//    [busiSystem.getNoticeManager getNotice:busiSystem.agent.sapid withStcid:_userInfo observer:self callback:@selector(getNoticeNotification:)];
}

-(void)getNoticeNotification:(BSNotification*)noti
{
    if(noti.error.code == 0)
    {
//             HUDDISMISS;
//        _notice = busiSystem.getNoticeManager.notice;
        [_tableView reloadData];
    }
    else
    {
//        HUDCRY(noti.error.domain, 2);
    }

}
-(void)initTableView
{
    _tableView.refreshFooterView = nil;
    _tableView.refreshHeaderView = nil;
    _flashCell = [FlashTableViewCell createTableViewCell];
    __weak NoticeInfoViewController *weakSelf = self;
    
    
    _tableView.backgroundColor = kUIColorFromRGB(color_9);
    
    _titleCell = [OnlyTitleTableViewCell createTableViewCell];
    
    _infoCell = [TitleDetailTableViewCell createTableViewCell];
    
    _contentCell = [OnlyTitleTableViewCell createTableViewCell];
}

-(void)setRightNavBtn
{
    //    [self setNavigateRightButton:btnStr font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor]];
    [self setNavigateRightButton:@"nav_share"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 3;
    
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 90;
     if(indexPath.row == 0)
    {
//        [_titleCell fitNoticeInfoMode];
        height = _titleCell.height;
    }
    else if (indexPath.row == 1)
    {
        height = 24;
    }
    else
    {
//         [_contentCell fitNoticeInfoModeB];
        height = _contentCell.height;
    }

    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(indexPath.row == 0)
    {
        cell = _titleCell;
        [_titleCell setCellData:@{@"title":_userInfo[@"title"]}];
        [_titleCell fitNoticeInfoMode];
    }
    else if (indexPath.row == 1)
    {
        cell = _infoCell;
        [_infoCell setCellData:@{@"title":[NSString stringWithFormat:@""],@"detail":_userInfo[@"time"]}];
        [_infoCell fitNoticeInfoMode];
    }
    else
    {
        cell = _contentCell;
        [_contentCell setCellData:@{@"title":_userInfo[@"content"]}];
        [_contentCell fitNoticeInfoModeB];
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
