//
//  SubmitSuccessViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/26.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SubmitSuccessViewController.h"
#import "ThreeBtnTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "RecordInfoViewController.h"
@interface SubmitSuccessViewController ()
{
     ThreeBtnTableViewCell *_successCell;
     OnlyTitleTableViewCell *_tipCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation SubmitSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"提交成功";
    [self initTableView];
     [self setNavigateRightButton:@"完成" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_2)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleDidRightButton:(id)sender
{
     UIViewController *vc =  self.navigationController.viewControllers[1];
     [self.navigationController popToViewController:vc animated:YES];
}

-(void)initTableView
{
     
     __weak SubmitSuccessViewController *weakSelf = self;
     _tableView.refreshHeaderView = nil;
     _successCell = [ThreeBtnTableViewCell createTableViewCell];
     [_successCell setCellData:@{@"oneTitle":@"售后申请提交成功",@"twoTitle":@"查看记录",@"threeTitle":@"回到首页",@"aimg":@"icon_submit_success"}];
     [_successCell fitSubmitSuccessMode];
     
     [_successCell setHandleAction:^(NSDictionary *dic){
          UIButton *btn = dic[@"sender"];
          NSInteger index = btn.tag - 101;
          if (index == 1) {
               RecordInfoViewController *vc = [RecordInfoViewController new];
               vc.orderBackID = self.orderBackID;//busiSystem.getAfterSaleListManager.afterSaleDetail.recordId;
               [weakSelf.navigationController pushViewController:vc animated:YES];
          }else if (index == 2)
          {
               weakSelf.tabBarController.selectedIndex = 0;
               [weakSelf.navigationController popToRootViewControllerAnimated:YES];
               
          }
          
     }];
     
     _tipCell = [OnlyTitleTableViewCell createTableViewCell];
     [_tipCell setCellData:@{@"title":@""}];
//     [_tipCell setCellData:@{@"title":@"温馨提示：\n • 商品寄回地址将在审核通过后以短信形式告知，或在申 请记录中查询。\n • 提交服务单后，售后专员可能与您电话沟通，请保持手 机畅通。\n • 退货处理成功后退款金额将原路返回到您的支持账户中"}];
     [_tipCell fitSubmitSuccessMode];
     _tableView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
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
          height = 223;
     }
     else
     {
          height = 106;
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
          cell = _successCell;
          [_successCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(223, 0, 0, 0)];
     }
     else
     {
          cell = _tipCell;
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
