//
//  CompanySelectViewController.m
//  taihe
//
//  Created by air on 2016/11/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "CompanySelectViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "BUSystem.h"
@interface CompanySelectViewController ()
@property (strong, nonatomic) IBOutlet MyTableView *tableView;

@end

@implementation CompanySelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"选择公司";
    [self initTableView];
    HUDSHOW(@"加载中");
    [self getData];
    
}

-(void)getData
{
    //[busiSystem.getAuthCompanyManager getAuthCompany:_userInfo[@"id"] observer:self callback:@selector(getAuthCompanyNotification:)];
}

-(void)getAuthCompanyNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
       // _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getAuthCompanyManager.data];
        [_tableView reloadData];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView
{
    [OnlyTitleTableViewCell registerTableViewCell:_tableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = _tableView.dataArr.count;
    
    
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSString *str = _tableView.dataArr[indexPath.row];
    OnlyTitleTableViewCell *cell = [OnlyTitleTableViewCell dequeueReusableCell:tableView];
    [cell setCellData:@{@"title":str?:@""}];
//    [cell fitCerCompanyMode];
    [cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *str = _tableView.dataArr[indexPath.row];
    if (_callBack) {
        _callBack(@{@"title":str?:@""});
    }
    [self.navigationController popViewControllerAnimated:YES];
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
