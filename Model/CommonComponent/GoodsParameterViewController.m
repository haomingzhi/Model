//
//  GoodsParameterViewController.m
//  oranllcshoping
//
//  Created by Steve on 2017/8/8.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "GoodsParameterViewController.h"
#import "TitleDetailTableViewCell.h"

@interface GoodsParameterViewController ()

@end

@implementation GoodsParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView{
     
     
     [TitleDetailTableViewCell registerTableViewCell:_tableView];
     
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.height = 40*3;
     _tableView.x = 0;
     _tableView.y = 40;
     _tableView.refreshHeaderView = nil;
     _tableView.bounces = NO;
}


#pragma mark tableView datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return  _tableView.dataArr.count;
     
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     TitleDetailTableViewCell *cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
     [cell setCellData:_tableView.dataArr[indexPath.row]];
     [cell fitGoodsParameterMode];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

#pragma mark tableView delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     return 0.001;
}

-(void)fitMode{
     _titleLb.width = __SCREEN_SIZE.width;
     
     self.view.height = 40*(_tableView.dataArr.count +1);
     _tableView.height = 40*_tableView.dataArr.count;
     _tableView.width = __SCREEN_SIZE.width;
     
     [_tableView reloadData];
     
}


- (IBAction)deleteBtnAction:(UIButton *)sender {
     [self.parentDialog dismiss];
}


static  GoodsParameterViewController *dealvc;
+(GoodsParameterViewController *)createVC:(NSDictionary *)dataDic
{
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          dealvc = [[GoodsParameterViewController alloc] init];
     });
     
     //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
     MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];
     dealvc.tableView.dataArr = dataDic[@"arr"];
     dealvc.titleLb.text = dataDic[@"title"];
     [dealvc fitMode];
     myDialog.mydelegate = dealvc;
     myDialog.bgColor = kUIColorFromRGBWithAlpha(color_12, 0.5);
     myDialog.isDownAnimate = NO;    
//     [myDialog show];
     [myDialog showAtPosition:CGPointMake(0,__SCREEN_SIZE.height - 40*(dealvc.tableView.dataArr.count +1)) animated:NO];
     myDialog.dismissOnTouchOutside = YES;
     
     
     return dealvc;
     
}


@end
