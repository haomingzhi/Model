//
//  MyInviteViewController.m
//  compassionpark
//
//  Created by air on 2017/3/16.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "MyInviteViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "ImgTitleAndDetailTableViewCell.h"
#import "ImgTableViewCell.h"
#import "TwoTabsTableViewCell.h"
#import "ShareFriendViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "JYShareManager.h"
#import "JYCommonTool.h"
#import "BUSystem.h"
//#import "AwardDetailViewController.h"
//#import "InviteRuleViewController.h"
//#import "ExpertInfoViewController.h"

@interface MyInviteViewController ()
{
    OnlyBottomBtnTableViewCell *_btnCell;
    OnlyTitleTableViewCell *_rankTipCell;
//    ImgTitleAndDetailTableViewCell *_inviteCell;
    ShareFriendViewController *_shareVC;
     OnlyTitleTableViewCell *_inviteCell;
}
@property ( nonatomic)NSInteger curTab;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic)TwoTabsTableViewCell *tabsCell;
@end

@implementation MyInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的邀请";
    [self initTableView];
      [self setNavigateRightButton:@"icon_share_nav"];
//    [self initData:0];
//     HUDSHOW(@"加载中");
//     [self getData];
}

-(void)viewDidAppear:(BOOL)animated
{
  HUDDISMISS;
}

-(void)handleDidRightButton:(id)sender
{
//     InviteRuleViewController *vc = [InviteRuleViewController new];
//     [self.navigationController pushViewController:vc animated:YES];
//     __weak ShareFriendViewController *vc = [ShareFriendViewController toShareVC];
//     [vc setCallBack:^(NSDictionary *dic) {
//          NSInteger tag =  [dic[@"tag"] integerValue] - 100;
//          [self toShare:tag];
//          [vc.parentDialog dismiss];
//
//     }];
     NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"shareLogo@2x" ofType:@"png"];
     
     NSString *url = busiSystem.agent.config.shareUrl;
     [[JYShareManager manager] showSheetView:self withShareTitle:@"尚享生活" withShareContent:@"尚享生活,每天与你相遇" withShareImgUrl:imagePath withUrl:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView{
     self.tableView.refreshHeaderView = nil;
    __weak MyInviteViewController *weakSelf  = self;
    _btnCell = [OnlyBottomBtnTableViewCell createTableViewCell];
    [_btnCell setCellData:@{@"title":@"立即邀请"}];
    [_btnCell fitInvGetGiftMode];
    [_btnCell setHandleAction:^(id p) {
         NSString *imagePath = busiSystem.agent.config.logoUrl.Image;
         if(!imagePath || [imagePath isEqualToString:@""])
         {
              imagePath = @"logo2";
         }

         NSString *url = busiSystem.agent.config.shareUrl;
         [[JYShareManager manager] showSheetView:weakSelf withShareTitle:@"" withShareContent:@"" withShareImgUrl:imagePath withUrl:url];

    }];
    

    
    _tabsCell = [TwoTabsTableViewCell createTableViewCell];
    [_tabsCell setCellData:@{@"tab1":@"成功邀请",@"tab2":@"累计邀请",@"aimg":@"invRec",@"bimg":@"award",@"aDetail":@"10人",@"bDetail":@"10000.0元"}];
    [_tabsCell fitInvGetGiftMode];
//    _tabsCell.tabOneCallBack = ^(id o){
//        weakSelf.curTab = 0;
//        [weakSelf.tabsCell setCellData:@{@"tab1":@"活动规则",@"tab2":@"邀请记录",@"select":@(0)}];
//        [weakSelf initData:0];
//        //        [weakSelf.contentVC selectCurIndex:0];
//        
//        //        weakSelf.writeBtn.hidden = YES;
//    };
//    _tabsCell.tabTwoCallBack = ^(id o){
//        weakSelf.curTab = 1;
//        [weakSelf.tabsCell setCellData:@{@"tab1":@"活动规则",@"tab2":@"邀请记录",@"select":@(1)}];
//        if (!busiSystem.getInviteUserListManager.getInviteUserArr) {
//            [weakSelf showLoading];
//            [weakSelf getData];
//        }
//       else
//       {
//           [weakSelf initData:1];
//       }
//
//        
//    };

     _inviteCell = [ImgTitleAndDetailTableViewCell createTableViewCell];
     [_inviteCell setCellData:@{@"img":@"invteMark",@"title":@"邀请即得",@"detail":@"¥ 100 优惠券"}];
     [_inviteCell fitInvGetGiftMode];
     
     _rankTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_rankTipCell setCellData:@{@"title":@"分享排行榜"}];
     [_rankTipCell fitInvGetGiftMode];
     
    [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
    _tableView.backgroundColor = kUIColorFromRGB(color_2);

     _inviteCell = [OnlyTitleTableViewCell createTableViewCell];
     [_inviteCell setCellData:@{@"title": [JYCommonTool unescape:busiSystem.agent.config.inviteContent]?:@""}];

      [_inviteCell fitHtmlMode];
     [_tableView reloadData];
    
}

-(void)toShare:(NSInteger )index
{
     NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"shareLogo@2x" ofType:@"png"];
     
     NSString *url = busiSystem.agent.config.shareUrl;
     [[JYShareManager manager] showSheetView:self withShareTitle:@"尚享生活" withShareContent:@"尚享生活,每天与你相遇" withShareImgUrl:imagePath withUrl:url];
}

-(void)showLoading
{
    HUDSHOW(@"加载中");
}
-(void)getData
{
//    [busiSystem.getInviteUserListManager getInviteUserList:self callback:@selector(getDataNotification:)];
//     [busiSystem.sysManager getInviteInfo:busiSystem.agent.userId observer:self callback:@selector(getDataNotification:)];
}

-(void)getDataNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
//         BUInviteInfo *iv = busiSystem.sysManager.inviteInfo;
//         [_tabsCell setCellData:@{@"tab1":@"成功邀请",@"tab2":@"累计奖励",@"aimg":@"invRec",@"bimg":@"award",@"aDetail":[NSString stringWithFormat:@"%ld人",iv.inviteUser],@"bDetail":[NSString stringWithFormat:@"%ld元",iv.rewardsCount]}];
//         [_tabsCell fitInvGetGiftMode];
//
//         [_inviteCell setCellData:@{@"img":@"invteMark",@"title":@"邀请即得",@"detail":[NSString stringWithFormat:@"¥%.0f 优惠券",iv.cPrice]}];
         [_inviteCell fitInvGetGiftMode];
    }
    else
    {
        HUDCRY(noti.error.domain, 2);
    }
}

-(void)initData:(NSInteger)index
{
//    NSMutableArray *arrs = [NSMutableArray array];
    
    NSMutableArray *aar = [NSMutableArray array];
    if (index == 0) {
        [aar addObjectsFromArray:@[@{@"title":busiSystem.agent.integralConfig.recommendExplain}]];
        _tableView.hasMore = NO;
    }
    else
    {
        
//        [aar addObjectsFromArray:busiSystem.getInviteUserListManager.getInviteUserArr];
//        _tableView.hasMore = busiSystem.getInviteUserListManager.pageInfo.hasMore;
    }
//    [aar addObject:@{}];
   
    //    NSMutableArray *arr = [NSMutableArray array];
    //    [arr addObject:@{}];
    //    NSMutableArray *arr2 = [NSMutableArray array];
    //    [arr2 addObject:@{}];
    
    //    [arrs addObject:@{@(0):arr,@1:arr2}];
    _tableView.dataArr = aar;
    
    [_tableView reloadData];
}

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) {
//        return 2;
//    }else if (section == 1) {
//         return 1;
//    }
//     else
//     {
//          return 5;
//     }
     return 1;//_tableView.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
     cell = _inviteCell;
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0)
//        {
//            cell = _inviteCell;
//        }
//        else
//        {
//            cell = _btnCell;
//             [_btnCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(76, 0, 0, 0)];
//        }
//    }
//     else if (indexPath.section == 1)
//     {
//          cell = _tabsCell;
//            [_tabsCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(41, 0, 0, 0)];
//     }
//    else
//    {
//         if (indexPath.row == 0) {
//              cell = _rankTipCell;
//         }
//         else
//         {
//              cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
//              [(ImgAndThreeTitleTableViewCell*)cell setCellData:@{@"title":@"星爷",@"img":@"rank_headDefault",@"source":@"156****9898",@"time":@"2000.00",@"row":@(indexPath.row)}];
//              [(ImgAndThreeTitleTableViewCell*)cell fitInvGetGiftMode];
//                [(ImgAndThreeTitleTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
//         }
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = _inviteCell.height+ 10;
//    if(indexPath.section == 0)
//    {
//        if (indexPath.row == 0)
//        {
//            height = 165;
//        }
//        else
//        {
//            height = 76;
//        }
//    }
//     else    if(indexPath.section == 1)
//     {
//          height = 41;
//     }
//    else {
//         if (indexPath.row == 0) {
//              height = 44;
//         }
//         else
//         height = 45;
//    }
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//     if (section == 1) {
          return 0.001;
//     }
//    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    return 0.001;
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
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
//     if (section == 1 ) {
          return nil;
//     }
//    return [self createSectionFootView];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
 
    return nil;
}

-(UIView *)nodataFooterView
{
    UIView *v = [self.view viewWithTag:8733];
    if (!v) {
        v = [UIView new];
        v.tag = 8733;
    }
    v.height = 220;
    v.width = __SCREEN_SIZE.width;
    v.backgroundColor = kUIColorFromRGB(color_9);
    
    [[JYNoDataManager manager] addNodataView:v withTip:@"暂无信息" withImg:@"icon_noData" withCount:_tableView.dataArr.count withTag:[NSString stringWithFormat:@"invitCerac%d",0]];
    
    return v;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.section == 1) {
//          AwardDetailViewController *vc = [AwardDetailViewController new];
//          [self.navigationController pushViewController:vc animated:YES];
     }
     else if (indexPath.section == 2)
     {
          if (indexPath.row > 0) {
//               ExpertInfoViewController *vc = [ExpertInfoViewController new];
//               [self.navigationController pushViewController:vc animated:YES];
          }
     }
}

-(void)loadNextPage
{
//    [busiSystem.getInviteUserListManager getInviteUserListNextPage:self callback:@selector(getDataNotification:)];
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
