//
//  PersonMainViewController.m
//  taihe
//
//  Created by air on 2016/11/9.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "PersonMainViewController.h"
#import "MineHeadTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "BUSystem.h"
@interface PersonMainViewController ()
{
  MineHeadTableViewCell *_mineHeadCell;
    TitleDetailTableViewCell *_tipCell;
}

@property(nonatomic,strong) IBOutlet MyTableView *tableView;
@property(nonatomic,strong)BUUserInfo *user;
@end

@implementation PersonMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.5ccaa9cb5f945fbefc31ab48a749b9dff527153b
     self.edgesForExtendedLayout = UIRectEdgeTop;
    [self initTableView];
    HUDSHOW(@"加载中");
    [self getData];
}

-(void)getData
{
    [busiSystem.agent getOtherUserInfo:_userInfo[@"tel"] observer:self callback:@selector(getOtherUserInfoNotification:)];
}

-(void)getOtherUserInfoNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
       // _user = busiSystem.agent.otherUserInfo;
        [_tableView reloadData];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.shadowImage = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
 
    CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
    //   if (_tableView.contentOffset.y >= _tableView.contentInset.top && _tableView.contentOffset.y <= _tableView.contentInset.top + 3) {
    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,0) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.translucent = YES;
    //    }
    //       self.navigationController.navigationBar.alpha = 0.5;
    self.navigationController.navigationBar.shadowImage = [UIImage new];

    [_tableView reloadData];
}


-(void)initTableView
{
    self.tableView.refreshHeaderView = nil;
    self.tableView.refreshFooterView = nil;
    _mineHeadCell = (MineHeadTableViewCell*)[MineHeadTableViewCell createTableViewCell];
    [(JYAbstractTableViewCell *)_mineHeadCell setCellData:@{@"title":@"登册",@"default":@"defaultHead",@"img": [NSNull new]}];
    [(MineHeadTableViewCell*)_mineHeadCell fitMineModeB];
    
    [TitleDetailTableViewCell registerTableViewCell:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tipCell = [TitleDetailTableViewCell createTableViewCell];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _user.userAcinfo.count + 2;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 35;
    if(indexPath.row ==0)
    {
        height = (500/720.0 * __SCREEN_SIZE.width);
    
    }
    else if (indexPath.row == 1)
    {
        height = 35;
    }
    else{
        height = 60;
    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
 
        cell =[self createFirstSection:indexPath];
        //        return _headCell;
     
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UITableViewCell *)createFirstSection:(NSIndexPath *)indexPath
{
//    __weak MineViewController *weakSelf = self;
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = _mineHeadCell;
        NSString *sm = _user.sex == 0?@"M":@"F";
        if (busiSystem.agent.userInfo.sex == -1) {
            sm = @"";
        }
        [(JYAbstractTableViewCell *)_mineHeadCell setCellData:@{@"title":_user.nikeName?:@"",@"default":@"defaultHead",@"img":_user.headImage?:[NSNull new],@"sex":sm}];
          [(MineHeadTableViewCell*)_mineHeadCell fitMineModeB];
        [(JYAbstractTableViewCell *)_mineHeadCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake((500/720.0 * __SCREEN_SIZE.width), 0, 0, 0)];
    }
    else   if (indexPath.row == 1)
    {
        cell = _tipCell;
        [_tipCell setCellData:@{@"title":@"TA的动态"}];
        [_tipCell fitPersonMainModeB];
          [_tipCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
    }
    else
    {
        cell = [TitleDetailTableViewCell dequeueReusableCell:_tableView];
//        _user.userAcinfo
        [(TitleDetailTableViewCell*)cell setCellData:[_user getUserAcinfoDic:indexPath.row - 2]];
            [(TitleDetailTableViewCell *)cell fitPersonMainMode];
            [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(void)viewDidLayoutSubviews
{
    if (!self.hasInit) {
        if (!_tableView.isRefreshing) {
            [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        
        
    }
}

-(void)handleReturnBack:(id)sender
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    [super handleReturnBack:sender];
}

//-(void)viewWillDisappear:(BOOL)animated
//{
//   
//}

-(void)viewDidAppear:(BOOL)animated
{
    self.hasInit = YES;
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
