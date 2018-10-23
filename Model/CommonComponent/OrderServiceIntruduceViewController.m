//
//  OrderServiceIntruduceViewController.m
//  oranllcshoping
//
//  Created by Steve on 2017/7/24.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "OrderServiceIntruduceViewController.h"
#import "TitleAndDetailAndImageTableViewCell.h"

@interface OrderServiceIntruduceViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation OrderServiceIntruduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fitCellMode{
     _titleLb.textColor = kUIColorFromRGB(color_1);
     _titleLb.width = __SCREEN_SIZE.width;
//     _titleLb.layer.borderWidth = 0.5;
//     _titleLb.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     
     _deleteBtn.layer.cornerRadius = _deleteBtn.height/2.0;
     _deleteBtn.layer.shadowColor = kUIColorFromRGB(color_0xf74056).CGColor;
     _deleteBtn.layer.shadowOffset = CGSizeMake(0, 0);
     _deleteBtn.layer.shadowRadius = 8;
     _deleteBtn.layer.shadowOpacity = 0.43;
     
     [TitleAndDetailAndImageTableViewCell registerTableViewCell:_tableView];
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.bounces = NO;
     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     _tableView.backgroundColor = kUIColorFromRGB(color_2);
     [_tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     NSInteger count = 1;
     return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
     NSInteger count = 0;
     
     count = _tableView.dataArr.count;
     
     return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     TitleAndDetailAndImageTableViewCell *cell;
     cell = [TitleAndDetailAndImageTableViewCell dequeueReusableCell:tableView];
     NSDictionary *dic = _tableView.dataArr[indexPath.row];
     [cell setCellData:dic];
     [cell fitServerMode];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}







#pragma mark --UITableViewDelegate

//设置section头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 50;
     TitleAndDetailAndImageTableViewCell *cell;
     cell = [TitleAndDetailAndImageTableViewCell dequeueReusableCell:tableView];
     NSDictionary *dic = _tableView.dataArr[indexPath.row];
     [cell setCellData:dic];
     [cell fitServerMode];
     height = cell.height;
     return height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     return 0.01;
}

static  OrderServiceIntruduceViewController *dealvc;
+(OrderServiceIntruduceViewController *)createVC:(NSDictionary *)dic
{
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          dealvc = [[OrderServiceIntruduceViewController alloc] init];
     });
     
     //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
     MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];
     dealvc.view.width = __SCREEN_SIZE.width;
      dealvc.view.height = 354+TABBARNONEHEIGHT;
     if (!dic[@"title"]) {
          dealvc.titleLb.text = dic[@"title"];
     }
     dealvc.tableView.dataArr = dic[@"arr"];
     [dealvc fitCellMode];
     myDialog.mydelegate = dealvc;
     myDialog.bgColor = kUIColorFromRGBWithAlpha(color_12, 0.5);
     myDialog.isDownAnimate = NO;
     [myDialog showAtPosition:CGPointMake(0,__SCREEN_SIZE.height - dealvc.view.height) animated:NO];
     myDialog.dismissOnTouchOutside = NO;
     
     
     return dealvc;
     
}

- (IBAction)deleteAction:(UIButton *)sender {
     [self.parentDialog dismiss];
}
@end
