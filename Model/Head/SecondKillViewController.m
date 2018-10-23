//
//  SecondKillViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/4.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SecondKillViewController.h"
#import "ImgTableViewCell.h"
#import "ScrollerTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "GoodsInfoViewController.h"
#import "JYShareManager.h"
@interface SecondKillViewController ()
{
     ImgTableViewCell *_imgCell;
     ScrollerTableViewCell *_scrCell;
     OnlyTitleTableViewCell *_timeTipCell;
     
}

@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation SecondKillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"秒杀专区";
     [self initTableView];
     [self setNavigateRightButton:@"icon_share_nav"];
}
-(void)handleDidRightButton:(id)sender
{
     NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"shareLogo@2x" ofType:@"png"];
     
     NSString *url = busiSystem.agent.config.shareUrl;
     [[JYShareManager manager] showSheetView:self withShareTitle:@"尚享生活" withShareContent:@"尚享生活,每天与你相遇" withShareImgUrl:imagePath withUrl:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     self.tableView.refreshHeaderView = nil;
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     _imgCell = [ImgTableViewCell createTableViewCell];
     [_imgCell setCellData:@{@"img":@"act_default"}];
     [_imgCell fitOddsRecMode];

     _scrCell = [ScrollerTableViewCell createTableViewCell];
     [_scrCell setCellData:@{@"arr":@[@{@"title":@"10:00",@"detail":@"已开抢"},@{@"title":@"10:00",@"detail":@"已开抢"},@{@"title":@"10:00",@"detail":@"已开抢"},@{@"title":@"10:00",@"detail":@"已开抢"},@{@"title":@"10:00",@"detail":@"已开抢"},@{@"title":@"10:00",@"detail":@"已开抢"},@{@"title":@"10:00",@"detail":@"已开抢"}]}];
     [_scrCell fitSecondKillMode];
     
     _timeTipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_timeTipCell setCellData:@{@"title":@"距本场结束剩余 00:20:05"}];
     [_timeTipCell fitSecKillMode];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return  6;
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
     return 10;
}
-(UIView *)createSectionFootView:(UIColor *)bgColor
{
     UIView *v = [UIView new];
     v.height = 10;
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     v.backgroundColor = bgColor;//kUIColorFromRGB(color_0xf0f0f0);
     line.tag = 9887;
     [v addSubview:line];
     return v;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     if (section == 0) {
          return [self createSectionFootView:kUIColorFromRGB(color_0xf0f0f0)];
     }
    return [self createSectionFootView:kUIColorFromRGB(color_2)];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 44;
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               height = 120/360.0 * __SCREEN_SIZE.width;
          }
          else if (indexPath.row == 1)
          {
               height = 52;
          }
          else
          {
               height = 29;
          }
     }
     else
     {
          height = 115;
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 1;
     switch (section) {
          case 0:
               row = 3;
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
               cell = _imgCell;
               
          }
          else if (indexPath.row == 1)
          {
               cell = _scrCell;
          }
          else
          {
               cell = _timeTipCell;
               [_timeTipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(29, 0, 0, 0)];
          }
     }
     else
     {
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
          [(ImgAndThreeTitleTableViewCell*)cell setCellData:@{@"title":@"日式色织水洗棉床笠",@"source":@"纺织品经历印染织造",@"time":@"¥99",@"img":@"secKillA",@"count":@"仅剩100件"}];
          [(ImgAndThreeTitleTableViewCell*)cell fitSeconKillMode];
          [(ImgAndThreeTitleTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(115, 0, 0, 0)];
     }

     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.section == 1) {
          GoodsInfoViewController *vc = [GoodsInfoViewController new];
          [self.navigationController pushViewController:vc animated:YES];
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
