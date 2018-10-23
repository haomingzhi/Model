//
//  NoCashApproveViewController.m
//  rentingshop
//
//  Created by air on 2018/3/20.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "NoCashApproveViewController.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "BUSystem.h"
@interface NoCashApproveViewController ()
{
     ImgAndThreeTitleTableViewCell *_infoCell;
     TitleDetailTableViewCell *_zhiMaCell;

     TitleDetailTableViewCell *_nameCell;
     TitleDetailTableViewCell *_IDCell;
}
@property (weak, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation NoCashApproveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//       self.edgesForExtendedLayout = UIRectEdgeTop;
     self.title = @"认证中心";
     [self initTableView];
//     self.navigationController.view.backgroundColor = kUIColorFromRGB(color_2);
     self.title = @"";
//     self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
//     _tableView.y = - 22;
//
//     if( __IPHONEX)
//
//          _tableView.y = 0;
//     #ifdef __IPHONE_11_0
//          if ([_tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
//               _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//          }
//     #endif
     if (@available(iOS 11.0, *)) {
          _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
     } else {
          self.automaticallyAdjustsScrollViewInsets = NO;
     }
     [self setNavRight];
     [self setTitleView];
     HUDSHOW(@"加载中");
     [self getData];
}
-(void)getData
{
     [busiSystem.myPathManager userCertification:busiSystem.agent.userId?:@"" observer:self callback:@selector(userCertificationNotification:)];
}

-(void)userCertificationNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          BUUserCertification *u = busiSystem.myPathManager.userCertification;
          [_infoCell setCellData:@{@"title":@"剩余免押金额度(元)",@"time":[NSString stringWithFormat:@"%@",u.remMoney],@"source":[NSString stringWithFormat:@"总额度%@元",u.creditMoney],@"img":@"noCashApprove"}];
          [_infoCell fitNoCashApproveMode];


          [_zhiMaCell setCellData:@{@"title":@"芝麻分",@"detail":[NSString stringWithFormat:@"%@分",u.credit]}];
          [_zhiMaCell fitNoCashApproveModeB];


          [_nameCell setCellData:@{@"title":@"姓名",@"detail":[NSString stringWithFormat:@"%@",u.trueName]}];
          [_nameCell fitNoCashApproveMode];


          [_IDCell setCellData:@{@"title":@"身份证号",@"detail":[NSString stringWithFormat:@"%@",u.idCard]}];
          [_IDCell fitNoCashApproveMode];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}

-(void)setTitleView
{
     UILabel *tl = [UILabel new];
     tl.font = [UIFont systemFontOfSize:18];
     tl.textColor = kUIColorFromRGB(color_2);
     tl.textAlignment = NSTextAlignmentCenter;
     tl.width = 100;
     tl.height = 30;
     tl.y = 30;
     tl.x = __SCREEN_SIZE.width/2.0 - tl.width/2.0;
     tl.text = @"认证中心";
     [self.view addSubview:tl];
}
-(void)setNavRight
{
     UIButton *tl = [UIButton new];

     tl.width = 40;
     tl.height = 40;
     tl.y = 26;
     tl.x = 0;
     [tl setImage:[UIImage imageContentWithFileName:@"nav_back2"] forState:UIControlStateNormal];
     [self.view addSubview:tl];
     [tl addTarget:self action:@selector(handleReturnBack:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBar.hidden = YES;
     self.navigationController.navigationBar.translucent = YES;
//     CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
//     if( _tableView.contentOffset.y >0)
//     {
//          CGFloat i = _tableView.contentOffset.y/40.0;
//          if (i > 1) {
//               i = 1;
//          }
//          [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,0) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
//     }
//     else
//     {
//          [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,0) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
////     }
//     //    _navLineImg = self.navigationController.navigationBar.shadowImage;
////     self.navigationController.navigationBar.translucent = YES;
//     self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//           self.navigationController.navigationBar.barTintColor = kUIColorFromRGBWithAlpha(color_1,0);
}
//
-(void)viewWillDisappear:(BOOL)animated
{

    self.navigationController.navigationBar.hidden = NO;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
   _infoCell = [ImgAndThreeTitleTableViewCell createTableViewCell];
     [_infoCell setCellData:@{@"title":@"剩余免押金额度(元)",@"time":@"0",@"source":@"总额度0元",@"img":@"noCashApprove"}];
     [_infoCell fitNoCashApproveMode];

    _zhiMaCell = [TitleDetailTableViewCell createTableViewCell];
     [_zhiMaCell setCellData:@{@"title":@"芝麻分",@"detail":@"0分"}];
     [_zhiMaCell fitNoCashApproveModeB];

     _nameCell = [TitleDetailTableViewCell createTableViewCell];
     [_nameCell setCellData:@{@"title":@"姓名",@"detail":@""}];
     [_nameCell fitNoCashApproveMode];

     _IDCell = [TitleDetailTableViewCell createTableViewCell];
     [_IDCell setCellData:@{@"title":@"身份证号",@"detail":@""}];
     [_IDCell fitNoCashApproveMode];
     self.tableView.refreshHeaderView = nil;
     _tableView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
     self.view.backgroundColor =  kUIColorFromRGB(color_f8f8f8);
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
     return 14;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     return [self createSectionFootView:section];
}

-(UIView *)createSectionFootView:(NSInteger)section
{
     UIView *v = [self.tableView viewWithTag:9887 + section];
     if (!v) {
          v = [UIView new];
          v.tag = 9887 + section;
     }
     v.height = 14;
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     v.backgroundColor = kUIColorFromRGB(color_f8f8f8);

//     [v addSubview:line];

     return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 45;
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               height = 160 + NAVBARHEIGHT;
          }
          else
          {
               height = 45;
          }
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 1;
     switch (section) {
          case 0:
               row = 2;
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
               cell = _infoCell;
          }
          else
          {
               cell = _zhiMaCell;
          }
     }
     else
     {
          if (indexPath.row == 0) {
               cell = _nameCell;
               [_nameCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
          else
          {
               cell = _IDCell;
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
