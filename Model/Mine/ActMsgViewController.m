//
//  ActMsgViewController.m
//  oranllcshoping
//
//  Created by air on 2017/8/1.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ActMsgViewController.h"
#import "TitleDetailTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "ImgTableViewCell.h"

@interface ActMsgViewController ()
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation ActMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"活动消息";
     [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
     _tableView.refreshHeaderView = nil;
     [OnlyTitleTableViewCell registerTableViewCell:_tableView];
     [TitleDetailTableViewCell registerTableViewCell:_tableView];
     [ImgTableViewCell registerTableViewCell:_tableView];
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
          height = 30;
     }
     else if (indexPath.row == 1)
     {
          height = 32;
     }
     else if (indexPath.row == 2)
     {
          height = 105/330.0 * (__SCREEN_SIZE.width - 30);
     }
     else if (indexPath.row == 3)
     {
          height = 45;
     }
     else
     {
          height = 30;
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 5;
     
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
          [(OnlyTitleTableViewCell *)cell setCellData:@{@"title":@"今天 10:00"}];
          [(OnlyTitleTableViewCell *)cell fitActMsgModeA];
          [(OnlyTitleTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
     }
     else if (indexPath.row == 1)
     {
          cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
          [(TitleDetailTableViewCell *)cell setCellData:@{@"title":@"你的地球日优惠福利来啦",@"detail":@"进行中"}];
          [(TitleDetailTableViewCell *)cell fitActMsgMode];
     }
     else if (indexPath.row == 2)
     {
          cell = [ImgTableViewCell dequeueReusableCell:_tableView];
          [(ImgTableViewCell *)cell setCellData:@{@"img":@"specImg"}];
           [(ImgTableViewCell *)cell fitActMsgMode];
         
     }
     else if (indexPath.row == 3)
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
          [(OnlyTitleTableViewCell *)cell setCellData:@{@"title":@"部分绿色环保商品限时免单，饮食、居家类目等满减。福利天天有 高直减160元，赶紧来看看吧！"}];
          [(OnlyTitleTableViewCell *)cell fitActMsgMode];
          [(OnlyTitleTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
     }
     else
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
          [(OnlyTitleTableViewCell *)cell setCellData:@{@"title":@"查看详情"}];
           [(OnlyTitleTableViewCell *)cell fitActMsgModeB];
          [(OnlyTitleTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(30, 0, 0, 0)];
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
