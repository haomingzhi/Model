//
//  MenuSelectionViewController.m
//  deliciousfood
//
//  Created by Steve on 2017/2/17.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "MenuSelectionViewController.h"
#import "OnlyTitleTableViewCell.h"

@interface MenuSelectionViewController ()

@end

@implementation MenuSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTableView];
//    _curIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView{
    
    
    [OnlyTitleTableViewCell registerTableViewCell:_tableView];
    
    _tableView.x=0;
    _tableView.y = 0;
    _tableView.width = __SCREEN_SIZE.width;
    _tableView.refreshHeaderView = nil;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.separatorColor = kUIColorFromRGB(color_3);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark - tableView

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OnlyTitleTableViewCell *cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
    if (_curIndexPath.row == indexPath.row) {
        [cell setCellData:@{@"title":_tableView.dataArr[indexPath.row],@"textColor":kUIColorFromRGB(color_3)}];
    }else{
        [cell setCellData:@{@"title":_tableView.dataArr[indexPath.row],@"textColor":kUIColorFromRGB(color_5)}];
    }
    [cell showSeparatorView:kUIColorFromRGB(color_3) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
    [cell fitMenuSelectionMode];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _tableView.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _curIndexPath = indexPath;
    [self.parentDialog dismiss];
    if (self.callBack) {
        self.callBack(@{@"index":@(indexPath.row)});
    }
}

static  MenuSelectionViewController *dealvc;
+(MenuSelectionViewController *)toMenuSelectionVC:(NSArray*)dataArr withIndex:(NSInteger)index
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dealvc = [[MenuSelectionViewController alloc] init];
    });
    
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:dealvc];
    dealvc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    dealvc.tableView.dataArr = [dataArr mutableCopy];
    dealvc.view.height = 40*dataArr.count;
    dealvc.tableView.height = dealvc.view.height;
    dealvc.curIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [dealvc.tableView reloadData];
    myDialog.mydelegate = dealvc;
    myDialog.bgColor = [UIColor clearColor];
    myDialog.isDownAnimate = NO;
    [myDialog showAtPosition:CGPointMake(0,44+64) animated:NO];
    myDialog.dismissOnTouchOutside = YES;
    
    
    return dealvc;
    
}



@end
