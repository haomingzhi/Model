//
//  PersonCenterViewController.m
//  oranllcshoping
//
//  Created by air on 2017/7/24.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "TitleDetailTableViewCell.h"
#import "TitleAndDetailWithImgTableViewCell.h"
#import "PersonInfoViewController.h"
#import "ModifiersPwdViewController.h"
#import "ForgetPwdNextViewController.h"
#import "JYEditNickNameViewController.h"
#import "ForgetPwdViewController.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "BindPhoneViewController.h"
#import "BUSystem.h"
#import "JYPhotoClipViewController.h"
#import "SexCheckViewController.h"
//#import "ExpertInfoViewController.h"
@interface PersonCenterViewController ()
{

     TitleDetailTableViewCell *_personInfoCell;
     TitleDetailTableViewCell *_pwdCell;

     OnlyBottomBtnTableViewCell *_submitCell;
     BOOL _isPostRefresh;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic) TitleAndDetailWithImgTableViewCell *mainCell;
@property (strong, nonatomic) UIImage *img;
@property (strong, nonatomic)TitleDetailTableViewCell *phoneCell;
@property (strong, nonatomic)TitleDetailTableViewCell *sexCell;
@property (strong, nonatomic)TitleDetailTableViewCell *nameCell;
@property (strong, nonatomic)TitleDetailTableViewCell *IDCell;
@property (strong, nonatomic) BUImageRes *imgRes;
@property ( nonatomic)NSInteger sex;
@end

@implementation PersonCenterViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view from its nib.
     self.title = @"个人信息";
     [self initTableView];
//     HUDSHOW(@"加载中");
     [self getUserInfo];
     //     [self addBottomView];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshPersonData) name:@"refreshPersonData" object:nil];
}

-(void)refreshPersonData
{
     //     HUDSHOW(@"加载中");
     _isPostRefresh = YES;
     [self getUserInfo];
}
-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)addBottomView
{
     _submitCell.width = __SCREEN_SIZE.width;
     _submitCell.y = __SCREEN_SIZE.height - 64 - 44;
     _submitCell.x = 0;
     [self.view addSubview:_submitCell];
}

-(void)viewDidLayoutSubviews
{
     _tableView.height = __SCREEN_SIZE.height - 64;
     _tableView.width = __SCREEN_SIZE.width;
}
//-(void)viewWillAppear:(BOOL)animated
//{
//
//}

-(void)getUserInfo
{
     [busiSystem.agent getUserInfo:busiSystem.agent.userId observer:self callback:@selector(getUserInfoNotification:)];
}

-(void)getUserInfoNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          //          if (!_isPostRefresh) {
//          HUDDISMISS;
          //          }
          //          _isPostRefresh = NO;
          //          BUUserInfo *userInfo = busiSystem.agent.userInfo;
          [_mainCell setCellData:@{@"title":@"头像",@"detail":@"",@"img":busiSystem.agent.img?: @"defaultHead2",@"default":@"defaultHead2"}];
          [_mainCell fitPersonCenterMode];

          [_personInfoCell setCellData:@{@"title":@"昵称",@"detail":busiSystem.agent.nickName?: @""}];
          [_personInfoCell fitPersonCenterMode];
          //          busiSystem.agent.userInfo.mobile = nil;
          [_phoneCell setCellData:@{@"title":@"手机号码",@"detail":busiSystem.agent.tel?:@""}];
          [_phoneCell fitPersonCenterModeB];
          NSString *ss = @"保密";
          _sex = 2;
          if(busiSystem.agent.sex == 1)
          {
               ss = @"女";
               _sex = 1;
          }
          else if (busiSystem.agent.sex == 2)
          {
               ss = @"男";
               _sex = 0;
          }
          [_sexCell setCellData:@{@"title":@"性别",@"detail":ss}];
          [_sexCell fitPersonCenterMode];

          [_nameCell setCellData:@{@"title":@"姓名",@"detail":busiSystem.agent.trueName?:@""}];
          [_nameCell fitPersonCenterMode];

          [_IDCell setCellData:@{@"title":@"身份证号",@"detail":busiSystem.agent.idCard?:@""}];
          [_IDCell fitPersonCenterMode];
          if(!busiSystem.agent.tel||[busiSystem.agent.tel isEqualToString:@""])
          {
               [_phoneCell fitPersonCenterMode];
          }else
          {
               [_phoneCell fitPersonCenterModeB];
          }
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}
- (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
     // Dispose of any resources that can be recreated.
}

-(void)initTableView
{
     _tableView.refreshHeaderView = nil;
     __weak PersonCenterViewController *weakSelf = self;
     _mainCell = [TitleAndDetailWithImgTableViewCell createTableViewCell];
     [_mainCell setCellData:@{@"title":@"头像",@"detail":@"",@"img":@"defaultHead2"}];
     [_mainCell fitPersonCenterMode];
     [_mainCell initAddPhotoManager:1 withImgArr:[NSMutableArray arrayWithArray:@[]] withVC:self withTableView:self.tableView];
     [_mainCell.addPhotoManager setCheckDoneCallBack:^(NSDictionary *dic){
          NSArray *arr = dic[@"arr"];
          weakSelf.img = arr.lastObject;
          JYPhotoClipViewController *vc = [[JYPhotoClipViewController alloc] initWithNibName:@"JYPhotoClipViewController" bundle:nil];
          //        _imgArr =@[self.imageUserLogo.image];
          vc.dataArr = arr;
          vc.callBack = ^(NSArray *arr){
               //            [self.navigationController popToViewController:self animated:YES];
               //            [_imgArr removeAllObjects];
               //            [_imgArr addObjectsFromArray:arr];
               //            [_tableView reloadData];
               //               weakSelf.imageUserLogo.image= arr[0];
               if (arr.count > 0) {

                    [weakSelf.mainCell setCellData:@{@"title":@"头像",@"default":@"defaultHead2",@"img":arr[0]}];
                    [weakSelf upHeadImg:arr.lastObject];
                    [weakSelf.mainCell fitPersonCenterMode];

               }
               else
               {
                    [weakSelf.mainCell setCellData:@{@"title":@"头像",@"detail":@"",@"img":busiSystem.agent.img?: @"defaultHead2",@"default":@"defaultHead2"}];
                    [weakSelf.mainCell fitPersonCenterMode];
               }

               [weakSelf.tableView reloadData];
               //            [self.navigationController popViewControllerAnimated:YES];
               [weakSelf.navigationController popToViewController:weakSelf animated:YES];

               //            [_tableView reloadData];
          };
          [weakSelf.navigationController pushViewController:vc animated:YES];

          //         UIImage *image1 =  [JYCommonTool getSubImage:weakSelf.img mCGRect:CGRectMake(0, 0, 300, 300) centerBool:YES];
          //          [weakSelf saveHeadImg:weakSelf.img];
          //          _needSave = YES;

     }];


     //     [_mainCell setHandleAction:^(id o) {
     //
     //
     //     }];

     _personInfoCell = [TitleDetailTableViewCell createTableViewCell];
     [_personInfoCell setCellData:@{@"title":@"昵称"}];
     [_personInfoCell fitPersonCenterMode];

     _pwdCell = [TitleDetailTableViewCell createTableViewCell];
     [_pwdCell setCellData:@{@"title":@"修改密码"}];
     [_pwdCell fitPersonCenterMode];

     _phoneCell = [TitleDetailTableViewCell createTableViewCell];
     [_phoneCell setCellData:@{@"title":@"手机号码",@"detail":@""}];
     [_phoneCell fitPersonCenterModeB];

     _sexCell  = [TitleDetailTableViewCell createTableViewCell];
     [_sexCell setCellData:@{@"title":@"性别",@"detail":@"男"}];
     [_sexCell fitPersonCenterMode];

     _nameCell  = [TitleDetailTableViewCell createTableViewCell];
     [_nameCell setCellData:@{@"title":@"姓名",@"detail":@"张三"}];
     [_nameCell fitPersonCenterMode];

     _IDCell  = [TitleDetailTableViewCell createTableViewCell];
     [_IDCell setCellData:@{@"title":@"身份证号",@"detail":@"350100152525211918"}];
     [_IDCell fitPersonCenterMode];


     _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_submitCell setCellData:@{@"title":@"确定"}];
     [_submitCell fitEditNickMode];

     [_submitCell setHandleAction:^(id sender) {
          [weakSelf submit];
     }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return  3;
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
     return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     if (section == 2) {
          return nil;
     }
     return [self createSectionFootView];
}

-(UIView *)createSectionFootView
{
     UIView *v = [UIView new];
     v.height = 10;
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     v.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     line.tag = 9887;
     //     [v addSubview:line];
     return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CGFloat height = 45;
     if (indexPath.section == 0 && indexPath.row == 0) {
          height = 60;
     }
     return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSInteger row = 1;
     switch (section) {
          case 0:
               row = 3;
               break;
          case 1:
               row = 2;
               break;
          case 2:
               row = 2;
               break;
          default:
               break;
     }
     return row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               cell = _mainCell;
               [_mainCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(60, 0, 0, 0)];
          }

          else if (indexPath.row == 1) {
               cell = _personInfoCell;
               [_personInfoCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
          else
          {
               cell = _sexCell;
          }
     }
     else if (indexPath.section == 1)
     {

          if (indexPath.row == 0) {
               cell = _nameCell;
               [_nameCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
          else
          {
               cell = _IDCell;
          }
     }
     else
     {
          if (indexPath.row == 0)
          {
               cell = _phoneCell;
               [_phoneCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
          else
          {
               cell = _pwdCell;
               //               [_pwdCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 0, 0, 0)];
          }
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               //               PersonInfoViewController *vc = [PersonInfoViewController new];
               //               [self.navigationController pushViewController:vc animated:YES];
               [self.view endEditing:YES];
               [self.mainCell toPhoto];
          }
          else if (indexPath.row == 1)
          {
               JYEditNickNameViewController *vc = [JYEditNickNameViewController new];
               [self.navigationController pushViewController:vc animated:YES];

          }
          else
          {
               SexCheckViewController  *vc = [SexCheckViewController new];
               vc.check = self.sex;
               [vc setCallBack:^(NSDictionary *dic) {
                    NSString *str = @"男";
                    NSInteger r = [dic[@"row"] integerValue];
                    self.sex = r;
                    if (r == 1) {
                         str = @"女";
                    }
                    else if(r == 2)
                    {
                         str = @"保密";
                    }
                    [_sexCell setCellData:@{@"title":@"性别",@"detail":str}];
                    [_sexCell fitPersonCenterMode];
               }];
               [self.navigationController pushViewController:vc animated:YES];
          }
     }
     else
          if (indexPath.section == 1)
          {

          }

          else
          {

               if(indexPath.row == 1)
               {
                    ForgetPwdViewController  *vc = [ForgetPwdViewController new];
                    vc.type = 2;
                    [self.navigationController pushViewController:vc animated:YES];
               }
               else
               {

               }

          }
}

-(void)upHeadImg:(UIImage*)img
{
//     HUDSHOW(@"加载中");
     [busiSystem.agent chageLogo:img observer:self callback:@selector(chageLogoNotificaiton:)];
}

-(void)chageLogoNotificaiton:(BSNotification*)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
          _imgRes = busiSystem.agent.img;
          //          busiSystem.agent.img = _imgRes;
          busiSystem.agent.isNeedRefreshTabD = YES;
     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }
}

-(void)submit
{
     [self.view endEditing:YES];

//     HUDSHOW(@"保存中");
     [busiSystem.agent saveUser:busiSystem.agent.userInfo.headImage.Image?:@"" withNickname:busiSystem.agent.userInfo.nickName?:@"" withUserid:busiSystem.agent.userId observer:self callback:@selector(saveUserNotification:)];
}

-(void)saveUserNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
          //          HUDDISMISS;
//          HUDSMILE(@"保存成功", 1);
          busiSystem.agent.isNeedRefreshTabD = YES;
          [self performSelector:@selector(goNext) withObject:nil afterDelay:1];
          //          [self getUserInfo];

     }
     else
     {

//          HUDCRY(noti.error.domain, 1);
     }

}

-(void)goNext
{
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
