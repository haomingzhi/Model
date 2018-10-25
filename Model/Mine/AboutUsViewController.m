//
//  AboutUsViewController.m
//  ulife
//
//  Created by sunmax on 15/12/10.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AboutUsTableViewCell.h"
#import "SetUpTableViewCell.h"
#import "UserAgreementViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "BUSystem.h"
@interface AboutUsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
     __weak IBOutlet UITableView *_myTableView;
     OnlyTitleTableViewCell *_aCell;
     OnlyTitleTableViewCell *_bCell;
}
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     self.title =@"关于我们";
     //    self.view.backgroundColor =kUIColorFromRGB(color_9);
     [self addTableView];
     //  HUDSHOW(@"加载中");
     // [self getData];
     //    [busiSystem.appBasicDocument aboutUsObserver:self callback:@selector(aboutUsNotification:)];
     // Do any additional setup after loading the view from its nib.
}

-(void)getData
{
     [busiSystem.agent getAbout:self callback:@selector(getAboutNotification:)];
}

-(void)getAboutNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
          [_myTableView reloadData];
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}

//- (void)aboutUsNotification:(BSNotification *) noti
//{
//      BASENOTIFICATION(noti);
//    [_myTableView reloadData];
//}
#pragma mark --- View
- (void)addTableView
{
     [_myTableView registerNib:[UINib nibWithNibName:@"SetUpTableViewCell" bundle:nil] forCellReuseIdentifier:@"SetUpTableViewCell"];
     [_myTableView registerNib:[UINib nibWithNibName:@"AboutUsTableViewCell" bundle:nil] forCellReuseIdentifier:@"AboutUsTableViewCell"];
     _myTableView.delegate =self;
     _myTableView.dataSource =self;
     _myTableView.showsVerticalScrollIndicator =NO;
     //设置tableView不能滚动
     [_myTableView setScrollEnabled:NO];
     [self setExtraCellLineHidden:_myTableView];
     _myTableView.height = __SCREEN_SIZE.height * 1.5;
     //    _myTableView.backgroundColor = kUIColorFromRGB(color_9);
     _aCell = [OnlyTitleTableViewCell createTableViewCell];
     [_aCell setCellData:@{@"title":@"客服热线：400-0000-000 \n客服邮箱：service@site.com \n当前版本：v 4.0.0"}];
     [_aCell fitAboutUsModeA];
     _bCell = [OnlyTitleTableViewCell createTableViewCell];
     [_bCell setCellData:@{@"title":@"《桔子商城用户协议》 \nCopyRight @ 优品汇 2015 - 2017"}];
     [_bCell fitAboutUsModeB];
}

#pragma mark --- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return section==0?3:1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     //    return indexPath.section ==0?200:44;
     if (indexPath.row == 0) {
          return 200;
     }
     else if (indexPath.row == 1)
     {
          return 187;
     }
     else
     {
          return 100;
     }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     UIView *v = [UIView new];
     //    v.backgroundColor = kUIColorFromRGB(color_9);
     return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return section==0?0:10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell * cell;
     if (indexPath.section ==0) {
          switch (indexPath.row) {
               case 0:
               {
                    AboutUsTableViewCell *aUcell =[tableView dequeueReusableCellWithIdentifier:@"AboutUsTableViewCell"];
                    [aUcell setCellLogo];
                    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                    // 当前应用软件版本  比如：1.0.1
                    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
                    [aUcell setCellEdition:appCurVersion];
                    //                aUcell.separatorInset =UIEdgeInsetsMake(0, 13, 0, 13);
                    //                      [aUcell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(200, 15, 0, 15)];
                    cell =aUcell;
               }
                    break;
               case 1:
               {

                    // [aUcell showCustomSeparatorView:kUIColorFromRGB(color_3) withInsets:UIEdgeInsetsMake(200, 0, 0, 0)];
                    cell = _aCell;
      
                    [_aCell setCellData:@{@"title":busiSystem.agent.config.aboutUS}];
                    [_aCell fitHtmlMode];
               }
                    break;
               case 2:
               {

                    // [aUcell showCustomSeparatorView:kUIColorFromRGB(color_3) withInsets:UIEdgeInsetsMake(200, 0, 0, 0)];
                    cell = _bCell;
                    [_bCell setCellData:@{@"title":@""}];
                    [_bCell fitAboutUsModeB];
               }
                    break;
               default:
                    break;
          }
     }
     //    else
     //    {
     //        SetUpTableViewCell *setUpCell =[tableView dequeueReusableCellWithIdentifier:@"SetUpTableViewCell"];
     //        [setUpCell setCell:@"桔子商城用户协议"];
     //        setUpCell.cellName.y=(44-setUpCell.cellName.height)/2;
     //        cell =setUpCell;
     //          //  [setUpCell showCustomSeparatorView:kUIColorFromRGB(color_3) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
     //    }
     //    cell.backgroundColor = kUIColorFromRGB(color_4);
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//     indexPath.section ==1?[tableView deselectRowAtIndexPath:indexPath animated:NO]:nil;
//     if(indexPath.section == 1)
//     {
//          UserAgreementViewController *vc = [UserAgreementViewController new];
//          [self.navigationController pushViewController:vc animated:YES];
//     }
}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
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

