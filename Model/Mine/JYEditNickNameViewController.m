//
//  EditNickNameViewController.m
//  compassionpark
//
//  Created by air on 2017/2/3.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "JYEditNickNameViewController.h"
#import "TextFieldTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "BUSystem.h"
@interface JYEditNickNameViewController ()
{
    TextFieldTableViewCell *_nickNameCell;
     OnlyBottomBtnTableViewCell *_submitCell;
}


@end

@implementation JYEditNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改昵称";
       [self setRightNavBtn];
    [self initTableView];
//     [self addBottomView];

}

-(void)addBottomView
{
     _submitCell.width = __SCREEN_SIZE.width;
     _submitCell.y = __SCREEN_SIZE.height - 64 - 44;
     _submitCell.x = 0;
     [self.view addSubview:_submitCell];
}

-(void)viewDidAppear:(BOOL)animated
{
 [_nickNameCell.textTf becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setRightNavBtn
{
    [self setNavigateRightButton:@"保存" font:[UIFont systemFontOfSize:15] color:kUIColorFromRGB(color_5)];
}

-(void)handleDidRightButton:(id)sender
{
//    [self.view endEditing:YES];
//    if(_nickNameCell.textTf.text.length == 0)
//    {
//        HUDCRY(@"您还未设置昵称", 2);
//        return;
//    }
//    HUDSHOW(@"提交中");
     [self submit];
//    [busiSystem.agent updateUserInfo:busiSystem.agent.userId withNickName:_nickNameCell.textTf.text withHeadImg:nil observer:self callback:@selector(changeUserInfoTypeNotification:) ];
}

-(void)changeUserInfoTypeNotification:(BSNotification*)noti
{
    if (noti.error.code == 0) {
        HUDSMILE(@"已修改", 1);
        busiSystem.agent.isNeedRefreshTabD = YES;
        busiSystem.agent.userInfo.nickName = _nickNameCell.textTf.text;
        [self.navigationController popViewControllerAnimated:YES];
       
    }
    else
    {
        HUDCRY(noti.error.domain,2);
    }
}

-(void)initTableView
{
    self.tableView.refreshHeaderView = nil;
     __weak JYEditNickNameViewController *weakSelf = self;
    _tableView.backgroundColor = kUIColorFromRGB(color_0xf5f5f5);
    _nickNameCell = [TextFieldTableViewCell createTableViewCell];
     _nickNameCell.textTf.text = busiSystem.agent.nickName;//_userInfo[@"title"];
     [_nickNameCell fitEidtNickNameMode];
     _nickNameCell.textTf.kbMovingView = self.view;
     
     _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
     [_submitCell setCellData:@{@"title":@"保存"}];
     [_submitCell fitEditNickMode];
     [_submitCell setHandleAction:^(id sender) {
          [weakSelf submit];
     }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    
    
    return row;
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
    CGFloat height = 45;
        return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = _nickNameCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)submit
{
     [self.view endEditing:YES];
     if (_nickNameCell.textTf.text.length == 0) {
          HUDCRY(@"您还未设置昵称", 1);
          return;
     }
     HUDSHOW(@"保存中");
     [busiSystem.agent upUserInfo:busiSystem.agent.userId?:@"" withTypeMsg:@"2" withData:_nickNameCell.textTf.text observer:self callback:@selector(saveUserNotification:)];
//     [busiSystem.agent saveUser:busiSystem.agent.userInfo.headImage.Image?:@"" withNickname:_nickNameCell.textTf.text withUserid:busiSystem.agent.userId observer:self callback:@selector(saveUserNotification:)];
}

-(void)saveUserNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
//          HUDDISMISS;
          HUDSMILE(@"保存成功", 1);
          [self performSelector:@selector(goNext) withObject:nil afterDelay:1];
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }

}

-(void)goNext
{
     HUDSHOW(@"加载中");
     [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshPersonData" object:nil];
     busiSystem.agent.isNeedRefreshTabD = YES;
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
