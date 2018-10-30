//
//  MineViewController.m
//  B2C
//
//  Created by air on 15/7/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "MineViewController.h"
#import "UIView+NTES.h"
#import "DDExDialogView.h"
#import "DDMyTableViewCell.h"
#import "JYMineHeadTableViewCell.h"
#import "DDSysSettingViewController.h"
#import "DDMyViewModel.h"
//#import <JYLibrary/JYLibrary.h>
//#import <SVProgressHUD.h>
#import "SV_DDLoading.h"
#import "UIScrollView+MJRefresh.h"
#import "CustomRefreshGifHeader.h"
#import "DDTwoBtnTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *titleView;
@property(nonatomic,strong)UIButton *signBtn;

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)DDMyViewModel *viewModel;
@property(nonatomic,assign)BOOL hasInit;
@end

@implementation MineViewController


- (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view.
     [self.view setBackgroundColor:UIColorFromRGB(0xffffff)];
     [self.view addSubview:[UIView new]];
     [self.tableView registerClass:[JYMineHeadTableViewCell class] forCellReuseIdentifier:@"JYMineHeadTableViewCell"];
     [self.tableView registerClass:[DDMyTableViewCell class] forCellReuseIdentifier:@"DDMyTableViewCell"];
     [self.tableView registerClass:[DDTwoBtnTableViewCell class] forCellReuseIdentifier:@"DDTwoBtnTableViewCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"OnlyBottomBtnTableViewCell" bundle:nil] forCellReuseIdentifier:@"OnlyBottomBtnTableViewCell"];
     [self.view addSubview:self.tableView];
//     [self setTable];
     
}

-(DDMyViewModel *)viewModel
{
     if (!_viewModel) {
          _viewModel = [DDMyViewModel new];
     }
     return _viewModel;
}
-(void)setTable
{
     __weak typeof(self) weak_self = self;
     //下拉刷新
     __weak UITableView *tableView = self.tableView;
     tableView.mj_header = [CustomRefreshGifHeader headerWithRefreshingBlock:^{
//          [SV_DDLoading show];
//
//          [weak_self getData];
     }];

     
}
-(void)getData
{
     __weak typeof(self) weak_self = self;
//     [self.viewModel fetchMyData:^(BOOL b, NSString *msg) {
//          [SV_DDLoading dismiss];
//          UITableView * table = weak_self.tableView;
//          if (!b) {
//               [table.mj_header endRefreshing];
//               [weak_self.view makeToast:msg duration:1 position:CSToastPositionCenter];
//               return ;
//          }
//
//          if (table.mj_header.refreshing) {
//               [table.mj_header endRefreshing];
//               [weak_self.tableView reloadData];
//
//          }
//          else
//          {
//               [weak_self.tableView beginUpdates];
//               [weak_self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]   withRowAnimation:UITableViewRowAnimationNone];
//               [weak_self.tableView endUpdates];
//          }
//
//
//          weak_self.hasInit = YES;
//     }];
}

-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
     self.titleView.hidden = NO;
     self.signBtn.hidden = NO;
     self.navigationItem.leftBarButtonItem = nil;
     self.navigationController.navigationBar.translucent = YES;
     
}
-(void)viewDidAppear:(BOOL)animated
{
     [super viewDidAppear:animated];
     if (!self.hasInit) {
          if (!self.tableView.mj_header.refreshing) {
               [self.tableView.mj_header beginRefreshing];
          }
     }
     else
     {
          [self getData];
     }
     
     
}

//-(DDExDialogView *)signTipDialogView
//{
//     if (!_signTipDialogView) {
//          DDSignTipView  *signView = [DDSignTipView new];
//          signView.title = @"";
//          signView.detail = @"";
//          signView.centerY = self.view.height /2.0;
//          signView.centerX = self.view.width /2.0;
//          //        sortView.dataArr = @[@"热度排序",@"时间排序",@"重要排序"];
//          _signTipDialogView = [[DDExDialogView alloc] initWithView:signView];
//          //        _dialogView.isOutSideClickClose = YES;
//          _signTipDialogView.hidden = YES;
//
//
//     }
//     return _signTipDialogView;
//}


-(void)viewWillDisappear:(BOOL)animated
{
     [super viewWillDisappear:animated];
     self.titleView.hidden = YES;
     self.signBtn.hidden = YES;
}
-(UIView *)titleView
{
     if (!_titleView) {
          _titleView = [UIView new];
          _titleView.left = 15;
          _titleView.top = 9;
          _titleView.width = 100;
          _titleView.height = 40;
          UILabel *tlb = [UILabel new];
          tlb.text = @"我的";
          tlb.textColor = UIColorFromRGB(0x3A424D);
          tlb.font = [UIFont boldSystemFontOfSize:26];
          tlb.height = 30;
          tlb.width = 80;
          [_titleView addSubview:tlb];
          
          UIView *vl = [UIView new];
          vl.height = 4;
          vl.width = 35;
          vl.layer.cornerRadius = 2;
          vl.top = tlb.top + tlb.height;
          vl.backgroundColor =UIColorFromRGB(0xFA8E31);
          [_titleView addSubview:vl];
     }
     return _titleView;
}

//-(UIButton *)signBtn
//{
//     if (!_signBtn) {
//          _signBtn = [UIButton new];
//          _signBtn.width = 30;
//          _signBtn.height = 30;
//          _signBtn.top = 16;
//          _signBtn.left = UIScreenWidth - 18 - _signBtn.width;
//          _signBtn.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 0, 0);
//          [_signBtn setImage:[UIImage imageNamed:@"签到统计 copy"] forState:UIControlStateNormal];
//          [_signBtn addTarget:self action:@selector(signHandle:) forControlEvents:UIControlEventTouchUpInside];
//     }
//     return _signBtn;
//}
-(void)signHandle:(UIButton *)btn
{
//     [self sign];
     
}

//-(void)sign
//{
//     __weak typeof(self) weak_self = self;
//     [SV_DDLoading show];
//     [self.viewModel sign:^(BOOL b, NSString *msg) {
//          [SV_DDLoading dismiss];
//          [(DDSignTipView *)weak_self.signTipDialogView.view setTitle:[NSString stringWithFormat:@"%@天",weak_self.viewModel.sign.day?:@"0"]];
//          [(DDSignTipView *)weak_self.signTipDialogView.view setDetail:weak_self.viewModel.sign.message];
//          [self.navigationController.view bringSubviewToFront:self.signTipDialogView];
//          [(DDSignTipView *)weak_self.signTipDialogView.view animateShow];
//     } ];
//}

- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}
#pragma mark - Get
- (NSString *)cellReuseIdentifier{
     return @"cell";
}

-(UITableView *)tableView
{
     if (!_tableView) {
          _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
          _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
          CGFloat contentInsetTop = 0.f;
          _tableView.contentInset = UIEdgeInsetsMake(contentInsetTop, 0, 0, 0);
          _tableView.backgroundColor  = [UIColor clearColor];
          _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
          _tableView.dataSource = self;
          _tableView.delegate   = self;
          _tableView.tableFooterView = [[UIView alloc] init];
          
     }
     return _tableView;
}

-(void)viewDidLayoutSubviews
{
     [super viewDidLayoutSubviews];
     //    self.navigationController.navigationBar
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
              return 180;
          }
          else
          {
               return 55;
          }
          
     }
     else if (indexPath.section == 1)
     {
          return 50;
     }
     else
     {
          return 80;
     }
     return 55.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
     if(indexPath.section == 0)
     {

     }
     else
     if (indexPath.section == 1) {
          if (indexPath.row == 0) {

          }
          else
          if (indexPath.row == 1) {

          }
          else if (indexPath.row == 2)
          {

          }
          else if(indexPath.row == 3)
          {
//               WJ_MyAttentionVC *attentionVC = [[WJ_MyAttentionVC alloc] init];
//               attentionVC.hidesBottomBarWhenPushed = YES;
//               [self.navigationController pushViewController:attentionVC animated:true];
          }
          else if (indexPath.row == 4)
          {
//               DDMyFavViewController *vc = [DDMyFavViewController new];
//               vc.hidesBottomBarWhenPushed = YES;
//               [self.navigationController pushViewController:vc animated:YES];
          }
          else
          {
               DDSysSettingViewController *vc = [DDSysSettingViewController new];
               vc.hidesBottomBarWhenPushed = YES;
               vc.loginoutBlock = self.loginoutBlock;
               [self.navigationController pushViewController:vc animated:YES];
          }
     }
     
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
     return NO;
}




#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     if (section == 0) {
          return 2;
     }
     else if(section == 1)
     {
          return 4;
     }
     return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     __weak typeof(self) weak_self = self;
     UITableViewCell *cell;
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
             
          cell = [tableView dequeueReusableCellWithIdentifier:@"JYMineHeadTableViewCell"];
//          NSDictionary *member = [self.viewModel getHeadDic];
//          [(DDMyIntroTableViewCell*)cell refresh:member];
          }
          else
          {
               cell = [tableView dequeueReusableCellWithIdentifier:@"DDTwoBtnTableViewCell"];
               NSDictionary *member = @{@"aTitle":[NSString stringWithFormat:@"余额￥%@",@"234"],@"aImg":@"",@"bTitle":@"快速充值",@"bImg":@""};
               [(DDTwoBtnTableViewCell*)cell refresh:member];
          }
          

     }
     else  if (indexPath.section == 1)
     {
          cell = [tableView dequeueReusableCellWithIdentifier:@"DDMyTableViewCell"];
          NSDictionary *member;
//          if (indexPath.row == 0)
//          {
//               member = @{@"mark":@"",@"title":@"消息通知",@"img":@"消息通知2"};
//          }
//          else
               if (indexPath.row == 0)
          {
               member = @{@"title":@"我的订单",@"img":@"我的订单"};
          }
          else if (indexPath.row == 1)
          {
               member = @{@"title":@"手机号绑定",@"img":@"手机号绑定"};
          }
          else if(indexPath.row == 2)
          {
               member = @{@"title":@"问题反馈",@"img":@"问题反馈"};
          }
          else //if (indexPath.row == 3)
          {
               member = @{@"title":@"分享",@"img":@"分享"};
          }
//          else
//          {
//               member = @{@"title":@"退出"};
//          }
          
          //self.members[indexPath.row];
          [(DDMyTableViewCell*)cell refresh:member];
     }
     else
     {
          cell = [tableView dequeueReusableCellWithIdentifier:@"OnlyBottomBtnTableViewCell"];
          NSDictionary *member = @{@"title":@"退出"};
          [(OnlyBottomBtnTableViewCell*)cell setCellData:member];
          [(OnlyBottomBtnTableViewCell*)cell fitMineMode];
          cell.separatorInset = UIEdgeInsetsMake(0, 9999999, 0, 0);
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)dealloc
{
//     [_signTipDialogView removeFromWindow];
//     [_dialogView removeFromWindow];
}
@end
