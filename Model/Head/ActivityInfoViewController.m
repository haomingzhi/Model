//
//  ActivityInfoViewController.m
//  taihe
//
//  Created by air on 2016/11/16.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ActivityInfoViewController.h"
#import "FlashTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "OnlyBottomBtnTableViewCell.h"
#import "TitleDetailTableViewCell.h"
#import "ImgTitleAndDetailTableViewCell.h"
#import "ZLPhotoPickerViewController.h"
#import "ZLPhotoPickerBrowserViewController.h"
#import "ZLPhotoPickerBrowserPhoto.h"
#import "ZLPhotoAssets.h"
#import "BUSystem.h"
#import "LoginViewController.h"
#import "PersonMainViewController.h"
#import "JYShareManager.h"
@interface ActivityInfoViewController ()
{
    FlashTableViewCell *_flashCell;
    OnlyBottomBtnTableViewCell *_submitCell;
    OnlyTitleTableViewCell *_demoCell;
    ImgTitleAndDetailTableViewCell *_infoCell;
    OnlyTitleTableViewCell *_titleCell;
    TitleDetailTableViewCell *_actDateCell;
    TitleDetailTableViewCell *_actTimeCell;
    TitleDetailTableViewCell *_regTimeCell;
    TitleDetailTableViewCell *_actPlaceCell;
    TitleDetailTableViewCell *_contactCell;
    TitleDetailTableViewCell *_countCell;
    TitleDetailTableViewCell *_stateCell;
    OnlyTitleTableViewCell *_tipCell;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic) BUGetActivity *act;
@end

@implementation ActivityInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"活动详情";
    [self setRightNavBtn];
    _tipCell = [OnlyTitleTableViewCell createTableViewCell];

    [self initData];
    [self initTableView];
    [self addBottomView];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = kUIColorFromRGB(color_2);
      self.navigationController.navigationBar.shadowImage = nil;
//    CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
//    //   if (_tableView.contentOffset.y >= _tableView.contentInset.top && _tableView.contentOffset.y <= _tableView.contentInset.top + 3) {
//    [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,1) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
}
-(void)initData
{
    if ([self.userInfo isKindOfClass:[BUGetActivity class]]) {
        _act = _userInfo;
        [_tipCell setCellData:@{@"title":_act.auditFailCause?:@""}];
        [_tipCell fitCerFailTipMode];
        [_tableView reloadData];
    }
    else
    {
        HUDSHOW(@"加载中");
        [self getData];
    }
}

-(void)getData
{
    [busiSystem.getActivityManager getActivity:busiSystem.agent.sapid withSacid:_userInfo observer:self callback:@selector(getActivityNotification:)];
}

-(void)getActivityNotification:(BSNotification*)noti
{
 if(noti.error.code == 0)
 {
     HUDDISMISS;
     _act = busiSystem.getActivityManager.activity;
     [_tipCell setCellData:@{@"title":_act.auditFailCause?:@""}];
     [_tipCell fitCerFailTipMode];
     [_tableView reloadData];
        [self addBottomView];
 }
    else
    {
     HUDCRY(noti.error.domain, 1);
    }
}

-(void)setRightNavBtn
{
    //    [self setNavigateRightButton:btnStr font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor]];
    [self setNavigateRightButton:@"nav_share"];
}

-(void)handleDidRightButton:(id)sender
{
    [self getShareData];
}

-(void)getShareData
{
    [busiSystem.agent getShare:busiSystem.agent.sapid withEntityid:_act.sacId withType:@"0" observer:self callback:@selector(getShareNotification:)];
}

-(void)getShareNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
        [self showShareView:busiSystem.agent.shareData];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}
-(void)toJoinTip
{
    if(!busiSystem.agent.isLogin)
    {
        [LoginViewController toLogin:self];
    }
    [[CommonAPI managerWithVC:self] showAlert:@selector(join:) withTitle:nil withMessage:@"确定要报名该活动?" withObj:@{}];
    
}

-(void)join:(NSDictionary*)dic
{
    if ([dic[@"code"] integerValue] == 0) {
        [self submit];
    }
}

-(void)submit
{
    HUDSHOW(@"报名中");
    [busiSystem.getActivityManager joinActivity:_act.sacId withTel:busiSystem.agent.tel observer:self callback:@selector(joinActivityNotification:)];
}

-(void)joinActivityNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
//        HUDDISMISS;
        HUDSMILE(@"报名成功!", 1);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshActivityList" object:nil];
//        [_submitCell removeFromSuperview];
    }
    else
    {
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)deleteAct
{
    [[CommonAPI managerWithVC:self] showAlert:@selector(toDeleteAct:) withTitle:nil withMessage:@"确定要撤销该活动吗?" withObj:@{}];
    

}

-(void)toDeleteAct:(NSDictionary *)dic
{
    if([dic[@"code"] integerValue] == 0)
    {
        HUDSHOW(@"删除中");
        [busiSystem.getActivityManager revokeActivity:_act.sacId withSapId:busiSystem.agent.sapid withSusId:nil observer:self callback:@selector(revokeActivityNotification:) ];
    }
}

-(void)revokeActivityNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDSMILE(@"撤销申请已提交成功，请等待后台审核。", 2);
        [self performSelector:@selector(toNextVC) withObject:nil afterDelay:2];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshActivityList" object:nil];
    }
    else
    {
        HUDSMILE(noti.error.domain, 1);
    }
}

-(void)toNextVC
{
   
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addBottomView
{
    __weak ActivityInfoViewController *weakSelf = self;
    _submitCell.width = __SCREEN_SIZE.width;
    _submitCell.y = __SCREEN_SIZE.height - 64 - 43;
    if ([_act.publisherTell isEqualToString:busiSystem.agent.tel]) {
        if(_act.acState != 4)
        {
            [_submitCell setCellData:@{@"title":@"撤销"}];
            [self.view addSubview:_submitCell];
            if (_act.isRevoke == 0) {
                [_submitCell setBtnBackgroundColor:kUIColorFromRGB(color_3)];
                [_submitCell setBtnEnabled:YES];
            }
            else
            {
                [_submitCell setBtnBackgroundColor:kUIColorFromRGB(color_0xb0b0b0)];
                [_submitCell setBtnEnabled:NO];
            }
            [_submitCell setHandleAction:^(id o) {
                [weakSelf deleteAct];
            }];
            [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 44, 0)];
        }
        else
        {
            [_submitCell removeFromSuperview];
             [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
    }
    else
    {
        if (_mode == 1) {
            [_submitCell setCellData:@{@"title":@"撤销"}];
            [self.view addSubview:_submitCell];
            if (_act.isRevoke == 0) {
                 [_submitCell setBtnBackgroundColor:kUIColorFromRGB(color_3)];
                [_submitCell setBtnEnabled:YES];
            }
            else
            {
            [_submitCell setBtnBackgroundColor:kUIColorFromRGB(color_0xb0b0b0)];
                  [_submitCell setBtnEnabled:NO];
            }
            [_submitCell setHandleAction:^(id o) {
                [weakSelf deleteAct];
            }];
            [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 44, 0)];
        }
        else
        if(_act.acState == 1)
        {
              [_submitCell setCellData:@{@"title":@"我要报名"}];
            [_submitCell setHandleAction:^(id o) {
                [weakSelf toJoinTip];
            }];
             [self.view addSubview:_submitCell];
             [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 44, 0)];
        }
        else
        {
            [_submitCell removeFromSuperview];
             [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
    }
}

-(void)initTableView
{
    _tableView.refreshFooterView = nil;
    _tableView.refreshHeaderView = nil;
    
  
    _infoCell = [ImgTitleAndDetailTableViewCell createTableViewCell];
    
    [_infoCell fitActivityInfoMode:NO];
    
    _flashCell = [FlashTableViewCell createTableViewCell];
//     [_flashCell setCellData:@{@"arr":@[]}];
      [_flashCell fitHeadMode];
    _titleCell = [OnlyTitleTableViewCell createTableViewCell];
    [_titleCell fitActInfoMode];
    
    _actDateCell = [TitleDetailTableViewCell createTableViewCell];
    
       _actTimeCell = [TitleDetailTableViewCell createTableViewCell];
    _actTimeCell.height = 20;
       _regTimeCell = [TitleDetailTableViewCell createTableViewCell];
    
       _actPlaceCell = [TitleDetailTableViewCell createTableViewCell];
    
       _contactCell = [TitleDetailTableViewCell createTableViewCell];
    
       _countCell = [TitleDetailTableViewCell createTableViewCell];
    
       _stateCell = [TitleDetailTableViewCell createTableViewCell];
    
    _demoCell = [OnlyTitleTableViewCell createTableViewCell];
    
    _submitCell = [OnlyBottomBtnTableViewCell createTableViewCell];
    [_submitCell fitActInfoMode];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    if(section == 1)
        row = 10;
    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 0)
       return 10;
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if(section == 1 && _act.auditState == 2)
    {
        _tipCell.backgroundColor = kUIColorFromRGB(color_4);
        UIView *line = [_tipCell viewWithTag:3221];
        if (!line) {
            line = [UIView new];
            line.tag = 3221;
        }
        
        line.y = 109.5;
        line.height = 0.5;
        line.backgroundColor = kUIColorFromRGB(color_lineColor);
        line.width = __SCREEN_SIZE.width;
        [_tipCell addSubview:line];
        
        return _tipCell;
    }
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section != 0) {
        return nil;
    }
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 10)];
    v.backgroundColor = kUIColorFromRGB(color_4);
    UIView *vl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 0.5)];
    vl.backgroundColor = kUIColorFromRGB(color_lineColor);
    UIView *vl2 = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
    vl2.backgroundColor = kUIColorFromRGB(color_lineColor);
    [v addSubview:vl2];
    [v addSubview:vl];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 && _act.auditState == 2) {
        return 110;
    }
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    if (indexPath.section == 0) {
        height = 50;
    }
    else
    {
        if (indexPath.row == 0) {
            height = __SCREEN_SIZE.width * 400/720.0;
        }
        else if(indexPath.row == 2)
        {
            
            height = 28;
        }
        else if (indexPath.row == 3)
        {
             [_actTimeCell fitActInfoMode];
            height = _actTimeCell.height;
        }
        else if (indexPath.row == 4)
        {
             [_regTimeCell fitActInfoMode];
            height = _regTimeCell.height;
        }
        else if (indexPath.row == 5)
        {
             [_actPlaceCell fitActInfoMode];
            height = _actPlaceCell.height;
        }
        else if (indexPath.row == 6)
        {
             [_contactCell fitActInfoMode];
            height = _contactCell.height;
        }
        else if (indexPath.row == 7)
        {
             [_countCell fitActInfoMode];
            height = _countCell.height;
        }
        else if (indexPath.row == 8)
        {
            if (_act.acState == 1 ||_act.acState == 3) {
                [_stateCell fitActInfoModeB];
            }
            else
            {
                [_stateCell fitActInfoMode];
            }
            height = _stateCell.height;
        }
        else if (indexPath.row == 1)
        {
            [_titleCell fitActInfoMode];
            height = _titleCell.height;
        }
        else
        {
             [_demoCell fitActInfoModeB];
            height = _demoCell.height;
        }
    }
    
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = _infoCell;
        [_infoCell setCellData:[_act getInfoDic:11]];
        [_infoCell fitActivityInfoMode:_act.pushType == 1 &&_act.publisherState == 2];
    }
    else
    {
        if (indexPath.row == 0) {
            cell = _flashCell;
              [_flashCell setCellData:[_act getInfoDic:0]];
        }
        else if(indexPath.row == 1)
        {
            cell = _titleCell;
              [_titleCell setCellData:[_act getInfoDic:1]];
               [_titleCell fitActInfoMode];
        }
        else if (indexPath.row == 2)
        {
            cell = _actDateCell;
              [_actDateCell setCellData:[_act getInfoDic:2]];
            [_actDateCell fitActInfoMode];
        }
        else if (indexPath.row == 3)
        {
            cell = _actTimeCell;
              [_actTimeCell setCellData:[_act getInfoDic:3]];
            [_actTimeCell fitActInfoMode];
        }
        else if (indexPath.row == 4)
        {
            cell = _regTimeCell;
              [_regTimeCell setCellData:[_act getInfoDic:4]];
            [_regTimeCell fitActInfoMode];
        }
        else if (indexPath.row == 5)
        {
            cell = _actPlaceCell;
              [_actPlaceCell setCellData:[_act getInfoDic:5]];
            [_actPlaceCell fitActInfoMode];
        }
        else if (indexPath.row == 6)
        {
            cell = _contactCell;
              [_contactCell setCellData:[_act getInfoDic:6]];
            [_contactCell fitActInfoMode];
        }
        else if (indexPath.row == 7)
        {
            cell = _countCell;
              [_countCell setCellData:[_act getInfoDic:7]];
            [_countCell fitActInfoMode];
        }
        else if (indexPath.row == 8)
        {
            cell = _stateCell;
              [_stateCell setCellData:[_act getInfoDic:8]];
            if (_act.acState == 1 ||_act.acState == 3) {
                [_stateCell fitActInfoModeB];
            }
            else
            {
                [_stateCell fitActInfoMode];
            }
            
        }
        else
        {
            cell = _demoCell;
              [_demoCell setCellData:[_act getInfoDic:9]];
            [_demoCell fitActInfoModeB];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ if (_act.pushType == 1 &&![_act.publisherTell isEqualToString:busiSystem.agent.tel]&&_mode != 1) {
    if(indexPath.section == 0)
    {
        PersonMainViewController *vc = [PersonMainViewController new];
        vc.userInfo = @{@"tel":_act.publisherTell?:@""};
        [self.navigationController pushViewController:vc animated:YES];
    }
}
}

- (void) setupPhotoBrowser:(NSDictionary *)dic{
    // 图片游览器
    ZLPhotoPickerBrowserViewController *pickerBrowser  = [[ZLPhotoPickerBrowserViewController alloc] init];
    // 数据源/delegate
    //    pickerBrowser.delegate = self;
    // 数据源可以不传，传photos数组 photos<里面是ZLPhotoPickerBrowserPhoto>
    pickerBrowser.photos = [self addZLPhotoPickerBrowserPhotoArr:dic[@"arr"] withImgVArr:dic[@"imgArr"]];
    // 是否可以删除照片
    //    pickerBrowser.editing = YES;
    // 当前选中的值
    pickerBrowser.currentIndexPath = [NSIndexPath indexPathForRow:[dic[@"row"] integerValue] inSection:0];
    // 展示控制器
    [pickerBrowser showPickerVc:self];
    //    [self.navigationController pushViewController:pickerBrowser animated:NO ];
}

- (NSMutableArray *)addZLPhotoPickerBrowserPhotoArr:(NSArray *)arr withImgVArr:(NSArray *)imgArr;
{
    NSMutableArray * mArr =[NSMutableArray new];
    for (int i=0; i<arr.count; i++)
    {
        ZLPhotoPickerBrowserPhoto *photo =[ZLPhotoPickerBrowserPhoto new];
        BUImageRes *im = arr[i];
        UIImage *d;
        UIImage *ii;
        if ([im isKindOfClass:[UIImage class]]) {
            d = (UIImage *)im;
            ii = (UIImage *)im;
            photo.thumbImage = d;
            photo.photoImage = ii;
        }
        else
        {
            if(im.isCached)
            {
                d= [UIImage imageWithContentsOfFile:im.cacheThumbFile];
                ii = [UIImage imageWithContentsOfFile:im.cacheFile];
                photo.thumbImage = d;
                photo.photoImage = ii;
            }
            else
            {
                photo.thumbImage = [UIImage imageContentWithFileName:@"defaultServer"];
                photo.photoImage = [UIImage imageContentWithFileName:@"defaultServer"];
            }
        }
        photo.aspectRatioImage = ii;
        photo.toView = imgArr[i];
        [mArr addObject:photo];
    }
    return mArr;
}

//-(void)getShareData
//{
//    
//    [busiSystem.getShareManager getShare:self callback:@selector(getShareNotification:)];
//}
//
//-(void)getShareNotification:(BSNotification *)noti
//{
//    JYBASENOTIFICATIONWITHCANMISS(noti, NO);
//    
//    BUGetShare *share = busiSystem.getShareManager.share;
//    [share.imgUrl download:self callback:@selector(imgNotification:) extraInfo:nil];
//    
//}

//-(void)imgNotification:(BSNotification *)noti
//{
//    JYBASENOTIFICATION(noti);
//    BUGetShare *share = busiSystem.getShareManager.share;
//    [[JYShareManager manager] showSheetView:self withShareTitle:share.shareTitle withShareContent:share.shareText withShareImgUrl:share.imgUrl.cacheFile?:@""  withUrl:share.goUrl];
//}

-(void)showShareView:(NSString*)dt
{
  NSString *path = [[NSBundle mainBundle] pathForResource:@"taihelogo@2x" ofType:@"png"];
    NSLog(@"pppcc:%@",path);
    [[JYShareManager manager] showSheetView:self withShareTitle:@"分享了来自\"泰禾云海\"的活动" withShareContent:_act.title?:@"" withShareImgUrl:path  withUrl:dt];
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
