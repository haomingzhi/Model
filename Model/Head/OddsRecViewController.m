//
//  OddsRecViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/2.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "OddsRecViewController.h"
#import "ImgTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
//#import "CartViewController.h"
#import "GoodsInfoViewController.h"
#import "JYShareManager.h"
@interface OddsRecViewController ()
{
     ImgTableViewCell *_imgCell;
     OnlyTitleTableViewCell *_tipCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation OddsRecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"特惠推荐";
     [self setRightNavBtn];
     [self initTableView];
}

-(void)setRightNavBtn
{
     //    [self setNavigateRightButton:btnStr font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor]];
     //    [self setNavigateRightButton:@"nav_msg"];
     
     UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
     
     UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
     btn1.frame = CGRectMake(0, 3, 22, 22);
     btn1.tag = 200;
     btn1.titleLabel.font = [UIFont systemFontOfSize:14];
     [btn1 setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
     [btn1 setImage:[UIImage imageContentWithFileName:@"icon_share_nav"] forState:UIControlStateNormal];
     
     [btn1 addTarget:self action:@selector(handleShare:) forControlEvents:UIControlEventTouchUpInside];
     
     UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
     btn2.frame = CGRectMake(37, 3, 22, 22);
     btn2.tag = 300;
     btn2.titleLabel.font = [UIFont systemFontOfSize:14];
     [btn2 setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
     [btn2 setImage:[UIImage imageContentWithFileName:@"nav_buyCar"] forState:UIControlStateNormal];
     
     [ v addSubview:btn1];
     [v addSubview:btn2];
          [btn2 addTarget:self action:@selector(handleBuyCar:) forControlEvents:UIControlEventTouchUpInside];
     
     [self setNavigateRightView:v];
}

-(void)handleBuyCar:(UIButton *)btn
{
//     CartViewController *vc = [CartViewController new];
//     vc.hidesBottomBarWhenPushed  = YES;
//     [self.navigationController pushViewController:vc animated:YES];
}

-(void)handleShare:(UIButton *)btn
{
//     NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"shareLogo@2x" ofType:@"png"];
//     
//     NSString *url = busiSystem.agent.config.shareUrl;
//     [[JYShareManager manager] showSheetView:self withShareTitle:@"尚享生活" withShareContent:@"尚享生活,每天与你相遇" withShareImgUrl:imagePath withUrl:url];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView
{
     _tableView.refreshHeaderView = nil;
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];
     _imgCell = [ImgTableViewCell createTableViewCell];
     [_imgCell setCellData:@{@"img":@"specImg"}];
     [_imgCell fitOddsRecMode];
     _tipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_tipCell setCellData:@{@"title":@"今日特惠"}];
     [_tipCell fitOddsRecMode];
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
     if (section == 0) {
          return 10;
     }
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
          height = 120/360.0 * __SCREEN_SIZE.width;
     }
     else
     {
          if (indexPath.row == 0) {
               height = 35;
          }
          else
          {
               height = 109;
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
     if (indexPath.section == 0) {
          cell = _imgCell;
     }
     else
     {
          if (indexPath.row == 0) {
               cell = _tipCell;
          }
          else
          {
               cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
               [(ImgAndThreeTitleTableViewCell*)cell setCellData:@{@"title":@"日式色织水洗棉床笠",@"source":@"纺织品经历印染织造",@"time":@"¥99",@"img":@"secKillA"}];
               [(ImgAndThreeTitleTableViewCell*)cell fitOddsRecMode];
               [(ImgAndThreeTitleTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(109, 15, 0, 15)];
          }
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
