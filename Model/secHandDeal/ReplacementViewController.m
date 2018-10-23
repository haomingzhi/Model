//
//  ReplacementViewController.m
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/6.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ReplacementViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "TitleAndImageTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "ImgTableViewCell.h"
#import "ReplacementConfirmViewController.h"
#import "BUSystem.h"
#import "PublishSecHandDealViewController.h"
#import "JYCommonTool.h"
#import "LoginViewController.h"
@interface ReplacementViewController ()
{
     OnlyTitleTableViewCell *_titleCell;
     TitleDetailTableViewCell *_timeCell;
     TitleAndImageTableViewCell *_posCell;
     OnlyTitleTableViewCell *_contentCell;
         OnlyBottomBtnTableViewCell *_submitCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic)NSString *titleName;
@property (strong, nonatomic)NSString *owerName;
@property (strong, nonatomic)NSString *tellPhone;
@property (strong, nonatomic)NSString *time;
@property (strong, nonatomic)NSString *jifen;
@property (strong, nonatomic)NSString *pos;
@property (strong, nonatomic)NSString *content;
@end

@implementation ReplacementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.title = @"置换详情";

     [self setRightNavBtn];
     [self initData];
     [self initTableView];
     if (_secondHandGoods) {
          [self initData];
     }
     else
     {
          HUDSHOW(@"加载中");
          [self getData];
     }
}

-(void)getData
{
     [busiSystem.secondhandManager getSecondhandGoods:_ID observer:self callback:@selector(getSecondhandGoodsNotification:)];
}

-(void)getSecondhandGoodsNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          _secondHandGoods = busiSystem.secondhandManager.secGoods;
          [self initData];
          [self showData];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}

-(void)viewWillAppear:(BOOL)animated
{
     [self showData];
}


-(void)showData
{
     [_titleCell setCellData:@{@"title":_owerName?: @"",@"detail":_tellPhone?:@""}];
     [_titleCell fitReplacementMode];

     [_timeCell setCellData:@{@"title":_titleName?:@"",@"detail":[NSString stringWithFormat:@"积分:%@",_jifen?: @""]}];
     [_timeCell fitReplacementMode];

     [_posCell setCellData:@{@"title":_pos?: @"",@"img":@"nav_pos",@"detail":_time?:@""}];
     [_posCell fitReplacementMode];

     [_contentCell setCellData:@{@"title": [JYCommonTool unescape:_content]?:@""}];
     [_contentCell fitReplacementModeB];
     [_tableView reloadData];
     [self addBottomView];
}
-(void)initData
{
     if (_secondHandGoods.showTime&& ![_secondHandGoods.showTime isEqualToString:@""]) {
           _time = [_secondHandGoods.showTime substringWithRange:NSMakeRange(0, MIN(10, _secondHandGoods.showTime.length))];
     }
    
     _content = _secondHandGoods.content;
     _titleName = _secondHandGoods.name;
     _tellPhone = _secondHandGoods.ownerTelephone;
     _owerName = _secondHandGoods.ownerName;
     _pos = _secondHandGoods.address;
     _jifen = [NSString stringWithFormat:@"%ld",_secondHandGoods.integral];
}
-(void)addBottomView
{
       if ([busiSystem.agent.userId isEqualToString:_secondHandGoods.userId]) {
            return;
       }
     _submitCell.width = __SCREEN_SIZE.width;
     _submitCell.y = __SCREEN_SIZE.height - NAVBARHEIGHT - TABBARHEIGHT + 5;
     _submitCell.x = 0;
     [self.view addSubview:_submitCell];
}

-(void)viewDidLayoutSubviews
{
      NSInteger idd = NAVBARHEIGHT;
     if ([busiSystem.agent.userId isEqualToString:_secondHandGoods.userId]) {
          _tableView.height = __SCREEN_SIZE.height - idd;
          _tableView.width = __SCREEN_SIZE.width;
     }
     else
     {
     _tableView.height = __SCREEN_SIZE.height - idd - TABBARHEIGHT;
     _tableView.width = __SCREEN_SIZE.width;
     }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setRightNavBtn
{
     if ([busiSystem.agent.userId isEqualToString:_secondHandGoods.userId]) {
           [self setNavigateRightButton:@"编辑" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_5)];
     }

}

-(void)handleDidRightButton:(id)sender
{
     [self.view endEditing:YES];
     if (!busiSystem.agent.isLogin) {
          [LoginViewController toLogin:self];
          return;
     }
     PublishSecHandDealViewController *vc = [PublishSecHandDealViewController new];
     vc.mySec = _secondHandGoods;
     [self.navigationController pushViewController:vc animated:YES];
}
-(void)initTableView
{
    __weak ReplacementViewController *weakSelf = self;
    self.tableView.refreshHeaderView = nil;
     _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_submitCell setCellData:@{@"title":@"置换"}];
     [_submitCell fitEditNickMode];


    [_submitCell setHandleAction:^(id sender) {
         if (!busiSystem.agent.isLogin) {
              [LoginViewController toLogin:weakSelf];
              return;
         }
        ReplacementConfirmViewController *vc = [ReplacementConfirmViewController new];
         vc.secondHandGoods = weakSelf.secondHandGoods;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];

     _titleCell = [OnlyTitleTableViewCell createTableViewCell];
     [_titleCell setCellData:@{@"title":_titleName?: @""}];
     [_titleCell fitReplacementMode];
     _timeCell = [TitleDetailTableViewCell createTableViewCell];
     [_timeCell setCellData:@{@"title":_time?:@"",@"detail":[NSString stringWithFormat:@"积分:%@",_jifen?: @""]}];
     [_timeCell fitReplacementMode];
     _posCell = [TitleAndImageTableViewCell createTableViewCell];
     [_posCell setCellData:@{@"title":_pos?: @"",@"img":@"nav_pos"}];
     [_posCell fitReplacementMode];
     _contentCell = [OnlyTitleTableViewCell createTableViewCell];
     [_contentCell setCellData:@{@"title": [JYCommonTool unescape:_content]?:@""}];
[_contentCell fitReplacementModeB];
     [ImgTableViewCell registerTableViewCell:_tableView];
     _tableView.backgroundColor = kUIColorFromRGB(color_2);
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
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
     if (indexPath.row == 0) {
          height = 26;
     }
     else
          if (indexPath.row == 1) {
               height = 28;
          }
          else
               if (indexPath.row == 2) {
                    height = 38;
               }
               else
     if (indexPath.row == 3) {
          height = 58;
     }
     else
     {
//            BUImageRes *img = _secondHandGoods.imageList[indexPath.row - 4];
          height =  (__SCREEN_SIZE.width -30) * (890/660.0);
     }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = _secondHandGoods.imageList.count + 4;

    return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
     if(indexPath.row == 0)
     {
          cell = _titleCell;
     }
     else if (indexPath.row == 1)
     {
          cell = _timeCell;
     }
     else if (indexPath.row == 2)
     {
          cell = _posCell;
          [_posCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(38, 0, 0, 0)];
     }
     else if (indexPath.row == 3)
     {
          cell = _contentCell;
     }
     else
     {
        BUImageRes *img = _secondHandGoods.imageList[indexPath.row - 4];
          cell = [ImgTableViewCell dequeueReusableCell:_tableView];
          [(ImgTableViewCell*)cell setCellData:@{@"img":img?:@"",@"default":@"defaultBanner2"} ];
          [ (ImgTableViewCell *)cell initAddPhotoManager:1 withImgArr:nil withVC:self withTableView:_tableView];
          [(ImgTableViewCell*)cell fitReplacementMode];
          img.height = cell.height;
 
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
