//
//  GovCenterInfoViewController.m
//  taihe
//
//  Created by air on 2016/11/16.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "GovCenterInfoViewController.h"
#import "BUSystem.h"
@interface GovCenterInfoViewController ()
@property(nonatomic,strong)BUGetExecutiveCenter *center;
@end

@implementation GovCenterInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"政务详情";
}

-(void)initData
{
    if ([self.userInfo isKindOfClass:[BUGetExecutiveCenter class]]) {
        _center = self.userInfo;
    }
    else
    {
        HUDSHOW(@"加载中");
        [self getData];
    }
}

-(void)getData
{
    [busiSystem.getExecutiveCenterManager getExecutiveCenter:busiSystem.agent.sapid withSecid:self.userInfo observer:self callback:@selector(getExecutiveCenterNotification:) ];
}

-(void)getExecutiveCenterNotification:(BSNotification*)noti
{
    if(noti.error.code == 0)
    {
             HUDDISMISS;
        _center = busiSystem.getExecutiveCenterManager.sysExecutiveCenter;
        [self.tableView reloadData];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
    
}

-(void)setRightNavBtn
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = self.flashCell;
        [self.flashCell setCellData:@{@"arr":[_center getImgArr]?:[NSMutableArray new]}];
    }
    else if(indexPath.row == 1)
    {
        cell = self.titleCell;
        [self.titleCell setCellData:@{@"title":_center.title?:@""}];
         [self.titleCell fitNoticeInfoMode];
    }
    else if (indexPath.row == 2)
    {
        cell = self.infoCell;
        [self.infoCell setCellData:@{@"title":[NSString stringWithFormat:@""],@"detail":[NSString stringWithFormat:@"发布时间 %@",[_center.createTime substringToIndex:10]]}];
        [self.infoCell fitGovInfoMode];
    }
    else
    {
        cell = self.contentCell;
        [self.contentCell setCellData:@{@"title":_center.content?:@""}];
         [self.contentCell fitNoticeInfoModeB];
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
