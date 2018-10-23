//
//  AddManagerViewController.m
//  yihui
//
//  Created by wujiayuan on 15/9/27.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "AddManagerViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "BUSystem.h"
@interface AddManagerViewController ()
{
    MyTableView *_mtableView;
    OnlyBottomBtnTableViewCell *_bottomView;
//    NSInteger _allCount;
    NSMutableArray *_dataArr;
}
@end

@implementation AddManagerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mtableView = (MyTableView *)[self.view viewWithTag:100];
    _dataArr = [NSMutableArray array];
   
//    _allCount = [(InviteMemerberDelegateObj *)self.delegate allCount];
    [self addBottomView];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    ((MyTableView *)[self.view viewWithTag:100]).height = __SCREEN_SIZE.height - 64 - 49;
    _bottomView.height = 49;
    _bottomView.width = __SCREEN_SIZE.width;
}



-(void)addBottomView
{
    _bottomView = (OnlyBottomBtnTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"OnlyBottomBtnTableViewCell" owner:nil options:nil] lastObject];
    //    _bottomView.height = 49;
    _bottomView.handleAction = ^( id obj){
        NSString *str = [self.delegate performSelector:@selector(addManager:) withObject:@(_hadAdminCount)];//邀请方法
        if (![str isEqualToString:@""]) {
              TOASTSHOW(str);
        }
    
    };
    [_bottomView setPadding:10];
    [_bottomView setHeightPadding:4];
    [_bottomView setCellData:@{@"title":@"添加管理员"}];
    _bottomView.width = __SCREEN_SIZE.width;
    _bottomView.y = __SCREEN_SIZE.height - 64 - 49;
    [self.view addSubview:_bottomView];
//    _bottomView.btnTitle = @"邀请";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *arr = [NSMutableArray array];
    [_dataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"key"] isEqualToString:@"管理者"]) {
            [arr addObject:@"#"];
        }
        else
        {
            [arr addObject:obj[@"key"]];
        }
    }];
    return arr;
    
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

-(void)refreshView
{
  
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
