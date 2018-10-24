//
//  MineViewController.m
//  B2C
//
//  Created by air on 15/7/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "MineViewController.h"
#import "BUSystem.h"
#import "LoginViewController.h"
#import "MineInfoViewController.h"
#import "BSLocationCity.h"
#import "SetUpViewController.h"
#import "SysMsgViewController.h"
#import "MIneTableViewCell.h"
#import "PersonInfoViewController.h"
#import "MineHeadTableViewCell.h"
#import "IconTitleAndImgTableViewCell.h"
#import "PersonCenterViewController.h"
#import "FourIconBtnTableViewCell.h"
#import "TitleAndTextBtnTableViewCell.h"
#import "ThreeBtnTableViewCell.h"
#import "FiveBtnTableViewCell.h"
#import "BuyOutServerViewController.h"
#import "TitleDetailTableViewCell.h"
#import "SeverCenterViewController.h"
#import "MySecHandViewController.h"
#import "RecycleRecordViewController.h"
#import "MyFavViewController.h"
#import "MyInviteViewController.h"
#import "ZhiMaAuthViewController.h"
#import "SelectAddressViewController.h"
#import "MyOrderViewController.h"
#import "MyCouponViewController.h"
#import "MsgViewController.h"
#import "JYShareManager.h"
#import "SelledSeverViewController.h"
#import "BindPhoneViewController.h"
#import "MyEvaViewController.h"
#import "NoCashApproveViewController.h"
#import "ReletServerViewController.h"
@interface MineViewController ()
{
    UIImage *_navLineImg;
    BOOL _hasMsg;
}
@property (strong, nonatomic)UIButton *navBtn;
@property (strong, nonatomic)UIImageView *navImgV;
@end

@implementation MineViewController
{
//    NSArray * _imgArry;//图片数组
//    NSArray * _textArry;//文字
    BSLocation * _location;
    UILabel * _redDot;//消息红点
//    HeadPortraitTableViewCell *_headCell;
     ThreeBtnTableViewCell *_menuCell;
       NSMutableArray *_customArr;
    MineHeadTableViewCell *_mineHeadCell;
    FourIconBtnTableViewCell *_myServerMenuCell;
    FiveBtnTableViewCell *_menuACell;
     FiveBtnTableViewCell *_menuBCell;
//      FiveBtnTableViewCell *_menuCCell;
//    TitleAndTextBtnTableViewCell *_orderMenuTipCell;
     TitleDetailTableViewCell *_orderTipCell;
     TitleDetailTableViewCell *_myServerTipCell;
     TitleDetailTableViewCell *_otherTipCell;
     NSString *_zmUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//     self.edgesForExtendedLayout = UIRectEdgeTop;
//    self.title = @"";
//    self.view.backgroundColor =kUIColorFromRGB(color_F3F3F3);
      self.navigationController.view.backgroundColor = kUIColorFromRGB(color_2);
    [self initTableView];
 _tableViewMine.y = - 64;
if( __IPHONEX)

     _tableViewMine.y = - 88;

    [self initTitleLb];
    _customArr = [NSMutableArray new];
    if (busiSystem.agent.isLogin) {
        HUDSHOW(@"加载中");
        [self getUserInfoIndex];
         [self setLeftNavBtn];
         [self setRightNavBtn];
    }
//    _textArry =@[@"个人中心",@"我发布的资讯",@"使用说明",@"设置"];
//    _imgArry =@[@"Rinformation---Assistor@2x",@"Instructions---Assistor@2x",@"setUp---Assistor@2x"];

    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(redDot) name:@"redDot" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUserInfo) name:@"refreshUserInfo" object:nil];
     [_tableViewMine isShowHeaderView:NO];
    self.navigationController.view.backgroundColor = kUIColorFromRGB(color_2);
     [self getSysInfo];
//#ifdef __IPHONE_11_0
//     if ([_tableViewMine respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
//          _tableViewMine.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//     }
//#endif
}

-(void)getSysInfo
{
     [busiSystem.agent getInfoConfig:self callback:nil];
}
-(void)refreshUserInfo
{
     [self getUserInfo];
    [self getUserInfoIndex];
//     [self getSysInfo];
}

-(void)initTitleLb
{
    self.navigationItem.titleView = nil;
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    self.hasInit = YES;
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//         return UIStatusBarStyleLightContent;
////     return UIStatusBarStyleDefault;
//}

-(void)getUserInfoIndex
{

     [busiSystem.agent getMyIndex:busiSystem.agent.userId observer:self callback:@selector(getUserInfoNotification:)];
}

-(void)getUserInfoNotification:(BSNotification *)noti
{
    if (_tableViewMine.isRefreshing) {
        //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
        [self refreshTableHeaderNotification:noti myTableView:_tableViewMine];
        [_tableViewMine setContentOffset:CGPointMake(0, 0) animated:YES];
        _tableViewMine.isRefreshing = NO;
    }
    if (noti.error.code == 0) {
        HUDDISMISS;
       
         NSString *name = busiSystem.agent.nickName?:@"";//[busiSystem.agent.userInfo.nikeName stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        //busiSystem.agent.userInfo.type == 2 ? NO:YES;
         if ([name isEqualToString:@""]) {
              name = busiSystem.agent.tel?:@"";
         }

//         busiSystem.agent.userInfo.integral = 100;
         [(JYAbstractTableViewCell *)_mineHeadCell setCellData:@{@"isHiddenR":@YES,@"isHiddenVip":@(YES),@"title":name,@"default":@"defaultHead",@"img":busiSystem.agent.img?:[NSNull new],@"vip":@"",@"vipJF":@""}];
   
        [(MineHeadTableViewCell*)_mineHeadCell fitMineMode]; 
         BUGetMyIndex *userIndex = busiSystem.agent.getMyIndex;
         busiSystem.agent.isCredit = busiSystem.agent.getMyIndex.isCertifi;
//         busiSystem.agent.creditMoney = busiSystem.agent.getMyIndex.

         [_menuACell setCellData:@{@"aTitle":@"待付款",@"aimg":@"myMoney",@"anum":@([userIndex.payment integerValue]),@"bTitle":@"发货中",@"bimg":@"sending",@"bnum":@([userIndex.delivery integerValue]),@"cTitle":@"租赁中",@"cimg":@"zulingzhong",@"cnum":@([userIndex.lease integerValue]),@"dTitle":@"到期退还",@"dimg":@"tuihuan",@"dnum":@([userIndex.refund integerValue]),@"eTitle":@"待评价",@"eimg":@"waitEva",@"enum":@([userIndex.evaluate integerValue])}];
         [_menuACell fitMineModeA];


         [_myServerMenuCell setCellData:@{@"oneTitle":@"买断",@"aimg":@"maiduan",@"twoTitle":@"续租",@"bimg":@"xuzu",@"threeTitle":@"售后",@"cimg":@"shouhou",@"fourTitle":@"客服",@"dimg":@"kefu",@"anum":@([userIndex.buyout integerValue]),@"bnum":@([userIndex.renewal integerValue]),@"cnum":@([userIndex.after integerValue])}];
         [_myServerMenuCell fitMineMode];

 
         [_menuBCell setCellData:@{@"aTitle":@"免押金认证",@"aimg":@"yajinrenzheng",@"bTitle":@"优惠券",@"bimg":@"youhuijuan",@"cTitle":@"收藏夹",@"cimg":@"fav",@"dTitle":@"地址管理",@"dimg":@"adrManager",@"eTitle":@"邀请好友",@"eimg":@"inviteFri",@"anum":@(userIndex.isCertifi == 0?1:0),@"bnum":@([userIndex.coupons integerValue]),@"cnum":@([userIndex.collection integerValue]),@"dnum":@(0),@"enum":@(0)}];
         [_menuBCell fitMineModeB];
//if(userIndex.isCertifi == 0)
//{
//     [busiSystem.payManager getPublicAppAuthorize:busiSystem.agent.userId?:@"" observer:self callback:@selector(getPublicAppAuthorizeNotification:)];
//}

         [_tableViewMine reloadData];
//         [self navRightBtnaddDot:userIndex.hasMsg];
//         if(!busiSystem.agent.userInfo.mobile||[busiSystem.agent.userInfo.mobile isEqualToString:@""])
//         {
//              BindPhoneViewController *vc = [BindPhoneViewController new];
//              [self.navigationController pushViewController:vc animated:YES];
//         }
    }
   else
   {
       HUDCRY(noti.error.domain, 1);
        busiSystem.agent.isNeedRefreshTabD = YES;
   }
}

-(void)getPublicAppAuthorizeNotification:(BSNotification *)noti
{
     if (noti.error.code == 0) {
          HUDDISMISS;
          _zmUrl = busiSystem.payManager.zmUrl;
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}


-(void)viewWillAppear:(BOOL)animated
{
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
     CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
     if( _tableViewMine.contentOffset.y >0)
     {
          CGFloat i = _tableViewMine.contentOffset.y/40.0;
          if (i > 1) {
               i = 1;
          }
          [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,0) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
     }
     else
     {
          [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,0) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
     }
//    _navLineImg = self.navigationController.navigationBar.shadowImage;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//      self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    if (busiSystem.agent.isNeedRefreshTabD) {
        if (busiSystem.agent.isLogin) {
             HUDSHOW(@"加载中");
              [_tableViewMine isShowHeaderView:YES];
             [self getUserInfoIndex];
             [_tableViewMine reloadData];
             [self setLeftNavBtn];
             [self setRightNavBtn];
        }
        else
        {
            _hasMsg = NO;
            [(JYAbstractTableViewCell *)_mineHeadCell setCellData:@{@"isHiddenR":@YES,@"isHiddenVip":@(YES),@"title": @"登录/注册",@"default":@"defaultHead",@"img":@"defaultHead",@"vip":@"",@"vipJF":@""}];
            [(MineHeadTableViewCell*)_mineHeadCell fitMineMode];

//             BUGetUserIndex *userIndex = busiSystem.agent.getUserIndex;

              [_menuACell setCellData:@{@"aTitle":@"待付款",@"aimg":@"myMoney",@"anum":@(0),@"bTitle":@"发货中",@"bimg":@"sending",@"bnum":@(0),@"cTitle":@"租赁中",@"cimg":@"zulingzhong",@"cnum":@(0),@"dTitle":@"到期退还",@"dimg":@"tuihuan",@"dnum":@(0),@"eTitle":@"待评价",@"eimg":@"waitEva",@"enum":@(0)}];
             [_menuACell fitMineModeA];


             [_myServerMenuCell setCellData:@{@"oneTitle":@"买断",@"aimg":@"maiduan",@"twoTitle":@"续租",@"bimg":@"xuzu",@"threeTitle":@"售后",@"cimg":@"shouhou",@"fourTitle":@"客服",@"dimg":@"kefu"}];
             [_myServerMenuCell fitMineMode];


             [_menuBCell setCellData:@{@"aTitle":@"免押金认证",@"aimg":@"yajinrenzheng",@"bTitle":@"优惠券",@"bimg":@"youhuijuan",@"cTitle":@"收藏夹",@"cimg":@"fav",@"dTitle":@"地址管理",@"dimg":@"adrManager",@"eTitle":@"邀请好友",@"eimg":@"inviteFri"}];
             [_menuBCell fitMineModeA];
               [_tableViewMine isShowHeaderView:NO];
             [_tableViewMine reloadData];
             self.navigationItem.rightBarButtonItems = nil;
             self.navigationItem.leftBarButtonItems = nil;
        }
        busiSystem.agent.isNeedRefreshTabD = NO;
     
    }
    else
    {
         [_tableViewMine reloadData];
      
    }
    [self navRightBtnaddDot:busiSystem.agent.userInfo.msgCount];
//#ifdef __IPHONE_11_0
//     if ([_tableViewMine respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
//          _tableViewMine.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//     }
//#endif
}


-(void)reloadDatas
{

}

-(void)redDot
{
//    _redDot.hidden =[busiSystem.newsInfoManager.HasMessage isEqualToString:@"1"]?NO:YES;
}

#pragma mark --- Action
- (void)rightButtonAction:(UIButton *)sender
{
//    NoticeViewController * noticeVC =[[NoticeViewController alloc] init];
//    noticeVC.hidesBottomBarWhenPushed =YES;
//    [self.navigationController pushViewController:noticeVC animated:YES];
}

#pragma mark --- View
- (void)initTableView
{
    __weak MineViewController *weakSelf = self;
    _mineHeadCell = (MineHeadTableViewCell*)[MineHeadTableViewCell createTableViewCell];
        BOOL b = YES;
     [(JYAbstractTableViewCell *)_mineHeadCell setCellData:@{@"isHiddenR":@YES,@"isHiddenVip":@(b),@"title":@"登录/注册",@"default":@"defaultHead",@"img":busiSystem.agent.userInfo.headImage?:[NSNull new],@"time":@"",@"vip":@"",@"vipJF":@""}];
     [(MineHeadTableViewCell*)_mineHeadCell fitMineMode];
     [(JYAbstractTableViewCell *)_mineHeadCell setHandleAction:^(NSDictionary *ddic) {
          UIButton *btn = ddic[@"obj"];
          if (!busiSystem.agent.isLogin) {
               [LoginViewController toLogin:weakSelf];
               return;
          }
          if (btn.tag == 9111) {
               //            [UpPersonInfoViewController toFitVC:weakSelf];

               return ;
          }

          PersonCenterViewController *vc = [PersonCenterViewController new];
          vc.hidesBottomBarWhenPushed = YES;
          [weakSelf.navigationController pushViewController:vc animated:YES];
          
     }];
     

     _orderTipCell = [TitleDetailTableViewCell createTableViewCell];
     [_orderTipCell setCellData:@{@"title":@"我的租赁",@"detail":@"查看全部"}];
       [_orderTipCell fitMineMode];

     _menuACell = [FiveBtnTableViewCell createTableViewCell];
  [_menuACell setCellData:@{@"aTitle":@"待付款",@"aimg":@"myMoney",@"bTitle":@"发货中",@"bimg":@"sending",@"cTitle":@"租赁中",@"cimg":@"zulingzhong",@"dTitle":@"到期退还",@"dimg":@"tuihuan",@"eTitle":@"待评价",@"eimg":@"waitEva"}];
     [_menuACell fitMineModeA];
     [_menuACell setHandleAction:^(NSDictionary *dic){
          UIButton *btn = dic[@"obj"] ;
          NSInteger row = btn.tag - 100;
          [weakSelf toFitVC:row withIndex:0];
     }];

     _myServerTipCell = [TitleDetailTableViewCell createTableViewCell];
     [_myServerTipCell setCellData:@{@"title":@"我的服务",@"detail":@""}];
     [_myServerTipCell fitMineModeB];


     _myServerMenuCell = [FourIconBtnTableViewCell createTableViewCell];
     [_myServerMenuCell setCellData:@{@"oneTitle":@"买断",@"aimg":@"maiduan",@"twoTitle":@"续租",@"bimg":@"xuzu",@"threeTitle":@"售后",@"cimg":@"shouhou",@"fourTitle":@"客服",@"dimg":@"kefu"}];
     [_myServerMenuCell fitMineMode];

     [_myServerMenuCell setHandleAction:^(NSDictionary *dic){
          UIButton *btn = dic[@"obj"] ;
          NSInteger row = btn.tag - 100;
          [weakSelf toFitBVC:row];
     }];

     _otherTipCell = [TitleDetailTableViewCell createTableViewCell];
     [_otherTipCell setCellData:@{@"title":@"其他",@"detail":@""}];
     [_otherTipCell fitMineModeB];


     _menuBCell = [FiveBtnTableViewCell createTableViewCell];
     [_menuBCell setCellData:@{@"aTitle":@"免押金认证",@"aimg":@"yajinrenzheng",@"bTitle":@"优惠券",@"bimg":@"youhuijuan",@"cTitle":@"收藏夹",@"cimg":@"fav",@"dTitle":@"地址管理",@"dimg":@"adrManager",@"eTitle":@"邀请好友",@"eimg":@"inviteFri"}];
     [_menuBCell fitMineModeA];
     [_menuBCell setHandleAction:^(NSDictionary *dic){
          UIButton *btn = dic[@"obj"] ;
          NSInteger row = btn.tag - 100;
          [weakSelf toFitVC:row withIndex:1];
     }];

//    _tableViewMine.refreshHeaderView = nil;
//    [_tableViewMine registerNib:[UINib nibWithNibName:@"MineHeadTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineHeadTableViewCell"];
//    [_tableViewMine registerNib:[UINib nibWithNibName:@"IconTitleAndImgTableViewCell" bundle:nil] forCellReuseIdentifier:@"IconTitleAndImgTableViewCell"];
    [_tableViewMine registerNib:[UINib nibWithNibName:@"BlankTableViewCell" bundle:nil] forCellReuseIdentifier:@"BlankTableViewCell"];
    _tableViewMine.delegate =self;
    _tableViewMine.dataSource =self;
    _tableViewMine.showsVerticalScrollIndicator =NO;
    _tableViewMine.backgroundColor = kUIColorFromRGB(color_2);
       [self setExtraCellLineHidden:_tableViewMine];
    //    [self refreshTableHeaderNotification:noti myTableView:_tableView];
   
 
}
-(void)toFitBVC:(NSInteger )row
{
        if (!busiSystem.agent.isLogin) {
            [LoginViewController toLogin:self];
            return;
        }
    switch (row) {
        case 0:
        {
             BuyOutServerViewController * vc = [BuyOutServerViewController new];
             vc.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
             ReletServerViewController * vc = [ReletServerViewController new];
             vc.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:vc animated:YES];
        }

            break;

        case 2:
         {
              SelledSeverViewController * vc = [SelledSeverViewController new];
              vc.hidesBottomBarWhenPushed = YES;
              [self.navigationController pushViewController:vc animated:YES];

        }
            break;
         case 3:
         {
              SeverCenterViewController *vc = [SeverCenterViewController new];
              vc.hidesBottomBarWhenPushed = YES;
              [self.navigationController pushViewController:vc animated:YES];

         }
              break;
        default:
            break;
    }
}
-(void)toFitVC:(NSInteger )row withIndex:(NSInteger)index
{
    if (!busiSystem.agent.isLogin) {
        [LoginViewController toLogin:self];
        return;
    }
    if (index == 0) {
        switch (row) {
            case 0:
            {
                MyOrderViewController *vc = [MyOrderViewController new];
                  vc.userInfo = @{@"index":@1};
                vc.hidesBottomBarWhenPushed = YES;
                  [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                MyOrderViewController *vc = [MyOrderViewController new];
                 vc.userInfo = @{@"index":@2};
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                 MyOrderViewController *vc = [MyOrderViewController new];
                   vc.userInfo = @{@"index":@3};
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];

            }
                break;
             case 3:
             {
                  MyOrderViewController *vc = [MyOrderViewController new];
                  vc.userInfo = @{@"index":@4};
                  vc.hidesBottomBarWhenPushed = YES;
                  [self.navigationController pushViewController:vc animated:YES];


             }
                  break;
             case 4:
             {
//                  if(!busiSystem.agent.getUserIndex.isCourier)
//                  {
//                       HUDCRY(@"你不是跑腿师傅", 2);
//                       return;
//                  }
                  MyEvaViewController *vc = [MyEvaViewController new];
                  vc.hidesBottomBarWhenPushed = YES;
                  [self.navigationController pushViewController:vc animated:YES];
             }
                  break;
            default:
                break;
        }

    }
     else
     {

          switch (row) {
               case 0:
               {
                    if (busiSystem.agent.getMyIndex.isCertifi == 0) {
//                         if(_zmUrl )
//                         {
//                         [[ZMSdkManager manager] doVerify:_zmUrl];
//                         }
//                         else
//                         {
//                              HUDCRY(@"数据请求中", 1);
//                         }
                         ZhiMaAuthViewController *vc = [ZhiMaAuthViewController new];
                         vc.hidesBottomBarWhenPushed = YES;
                         [self.navigationController pushViewController:vc animated:YES];
                    }
                    else
                    {
                         NoCashApproveViewController *vc = [NoCashApproveViewController new];
                         vc.hidesBottomBarWhenPushed = YES;
                         [self.navigationController pushViewController:vc animated:YES];
                    }
               }
                    break;
               case 1:
               {
                    MyCouponViewController *vc = [[MyCouponViewController alloc] initWithNibName:@"MyCouponViewController" bundle:nil];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
               }
                    break;
               case 2:
               {
                    MyFavViewController *vc = [MyFavViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];

               }
                    break;
               case 3:
               {

                    SelectAddressViewController *vc = [SelectAddressViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];

               }
                    break;
               case 4:
               {

//                    CommonWebViewViewController *vc = [CommonWebViewViewController setWebViewController:@"" withUrl:@"www.baidu.com"];
//                    vc.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:vc animated:YES];
                    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"shareLogo@2x" ofType:@"png"];
                    //
                    NSString *url = [NSString stringWithFormat:@"%@/Html/Invitation.html",BU_BUSINESS_SHAREIP];//busiSystem.agent.config.shareUrl;
 [[JYShareManager manager] showSheetView:self withShareTitle:@"立刻" withShareContent:@"上立刻，生活无尽可能" withShareImgUrl:imagePath withUrl:url];
               }
                    break;
               default:
                    break;
          }
     }

}

-(void)viewDidLayoutSubviews
{
//    if (!self.hasInit) {
//        if (!_tableViewMine.isRefreshing) {
//            [_tableViewMine setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//        }
//        self.hasInit = YES;
//
//    }
      if(__IOS11)
     _tableViewMine.height = __SCREEN_SIZE.height - 49;
     else
     {
        _tableViewMine.height = __SCREEN_SIZE.height - 49;
     }

}



-(void)setLeftNavBtn
{

    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 26, 29);
    btn2.tag = 200;
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn2 setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
    btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn2 setImage:[UIImage imageContentWithFileName:@"nav_setting"] forState:UIControlStateNormal];
    
    [btn2 addTarget:self action:@selector(handleSettingBack:) forControlEvents:UIControlEventTouchUpInside];
    //
//    _navImgV = imgv;

    [self setNavigateLeftView:btn2 view1:nil];
    //    [self setNavigateLeftButton:btnStr font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor]];
}

-(void)kefuHandle:(UIButton *)btn
{
    if (!busiSystem.agent.isLogin) {
        [LoginViewController toLogin:self];
        return;
    }
//    [HuanxinKefuManager kefuHandle:self];
}

//-(void)handleReturnBack:(id)sender
//{
//    UIButton *btn = sender;
//     sett *vc = [MsgViewController new];
//     vc.hidesBottomBarWhenPushed = YES;
//     [self.navigationController pushViewController:vc animated:YES];
//}

-(void)setRightNavBtn
{
    //    [self setNavigateRightButton:btnStr font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor]];
//    [self setNavigateRightButton:@"nav_msg"];
     
     UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];


     UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
     btn2.frame = CGRectMake(30,0, 30, 30);
     btn2.tag = 300;
     btn2.titleLabel.font = [UIFont systemFontOfSize:14];
     [btn2 setTitleColor:kUIColorFromRGB(color_3) forState:UIControlStateNormal];
     btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
     [btn2 setImage:[UIImage imageContentWithFileName:@"nav_bell"] forState:UIControlStateNormal];
     
//     [ v addSubview:btn1];
     [v addSubview:btn2];
     [btn2 addTarget:self action:@selector(handleDidRightButton:) forControlEvents:UIControlEventTouchUpInside];
     
     [self setNavigateRightView:v];
}

-(void)handleBell:(UIButton *)btn
{
//     CartViewController *vc = [CartViewController new];
//     vc.hidesBottomBarWhenPushed  = YES;
//     [self.navigationController pushViewController:vc animated:YES];
     if (!busiSystem.agent.isLogin) {
          [LoginViewController toLogin:self];
          return;
     }
     MsgViewController *vc = [MsgViewController new];
     vc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:vc animated:YES];
}

-(void)handleSettingBack:(id)btn
{
     SetUpViewController *vc = [SetUpViewController new];
     vc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:vc animated:YES];
}

-(void)handleDidRightButton:(id)sender
{
        if (!busiSystem.agent.isLogin) {
            [LoginViewController toLogin:self];
            return;
        }
        SysMsgViewController *vc = [SysMsgViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --UITableViewDataSource
//每组条数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return 2;
    }

    else if (section == 2)
    {
         return 2;
    }
     else
     {
          return 2;
     }
    return 2;
}

-(NSString *) getSuffix:(NSIndexPath *) indexPath
{
    return @"";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (  section == 3) {
        return  nil;
    }
    UIView *v = [self createSectionFootView];
//    v.backgroundColor = kUIColorFromRGB(color_9);
    return v;
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

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if (indexPath.section ==0){
        cell =[self createFirstSection:indexPath];
//        return _headCell;
    }
    else if (indexPath.section == 1){
        cell =[self createSecondeSection:indexPath];
    }
    else  if (indexPath.section == 2){
         cell =[self createThirdSection:indexPath];
    }

    else
    {
        cell = [self createFourthSection:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(UITableViewCell *)createFirstSection:(NSIndexPath *)indexPath
{

    UITableViewCell *cell;
    
//    if (indexPath.row == 0) {
        cell = _mineHeadCell;
//    }
//    else {
//         cell = _menuCell;
//        [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 0, 0, 0)];
//    }

    return cell;
}

-(UITableViewCell *)createSecondeSection:(NSIndexPath *)indexPath
{
     UITableViewCell *cell;

     if (indexPath.row == 0) {
          cell = _orderTipCell;
            [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(40, 15, 0, 15)];
     }
     else {
          cell = _menuACell;
//          [(JYAbstractTableViewCell *)cell showSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(100, 0, 0, 0)];
     }

     return cell;
}

-(UITableViewCell *)createThirdSection:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = _myServerTipCell;

          [(IconTitleAndImgTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(40,15, 0,15)];
     }
     else  if (indexPath.row == 1) {
          cell = _myServerMenuCell;
//          [(JYAbstractTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(100, 0, 0, 0)];
     }


    return cell;
}

-(UITableViewCell *)createFourthSection:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
 if (indexPath.row == 0) {
      cell = _otherTipCell;
        [(IconTitleAndImgTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(45, 15, 0, 15)];
     }

    else
    {
         cell = _menuBCell;
    }

    return cell;
}


#pragma mark --UITableViewDelegate
//委托解决行高问题
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
          return indexPath.row ==0 ? (150/360.0 * __SCREEN_SIZE.width) : 60;
    }
    else
    {
         if (indexPath.row == 0) {
              return 40;
         }
         else
        return 100;
    }
//    else
//    {
//        return 45;
//    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
 
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
     if(indexPath.section == 1)
     {
        if (indexPath.row == 0)
          {
               if (!busiSystem.agent.isLogin) {
                    [LoginViewController toLogin:self];
                    return;
               }
               MyOrderViewController *vc = [MyOrderViewController new];
               vc.hidesBottomBarWhenPushed = YES;
               [self.navigationController pushViewController:vc animated:YES];
          }

     }
//
//     else
//     if (indexPath.section == 2) {
//          if (indexPath.row == 1) {
//               if (!busiSystem.agent.isLogin) {
//                    [LoginViewController toLogin:self];
//                    return;
//               }
//           
//          }
//          else
//          {
//               if (!busiSystem.agent.isLogin) {
//                    [LoginViewController toLogin:self];
//                    return;
//               }
//               SelectAddressViewController *vc = [SelectAddressViewController new];
//               vc.hidesBottomBarWhenPushed = YES;
//               [self.navigationController pushViewController:vc animated:YES];
//          }
//     }
//     else
//     if (indexPath.section == 3)
//     {
//           if(indexPath.row == 0)
//          {
//               if (!busiSystem.agent.isLogin) {
//                    [LoginViewController toLogin:self];
//                    return;
//               }
//               HUDSHOW(@"加载中");
//               MyInviteViewController *vc = [MyInviteViewController new];
//               vc.hidesBottomBarWhenPushed = YES;
//               [self.navigationController pushViewController:vc animated:YES];
//          }
//          else
//               if (indexPath.row == 1) {
//                    [BSUtility callPhone:busiSystem.agent.config.service?:@"" view:self.view];
//               }
//          else
//          {
//               SetUpViewController *vc = [SetUpViewController new];
//               vc.hidesBottomBarWhenPushed = YES;
//               [self.navigationController pushViewController:vc animated:YES];
//          }
//     }

}
- (void) scrollViewDidScroll:(UIScrollView *)sender {
         CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
    if( sender.contentOffset.y >0)
    {
         CGFloat i = sender.contentOffset.y/40.0;
         if (i > 1) {
              i = 1;
         }
       [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,0) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    }
     else
     {
        [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,0) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
     }
     
}

-(void)viewWillDisappear:(BOOL)animated
{
      CGSize navBarSize = CGSizeMake(__SCREEN_SIZE.width, __NAVBAR_HEIGHT + __STATUSBAR_HEIGHT);
 [self.navigationController.navigationBar  setBackgroundImage:[UIImage imageWithColor:kUIColorFromRGBWithAlpha(color_2,0) withBounds:CGRectMake(0, 0, navBarSize.width,navBarSize.height)] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
-(void)addRedDotForMsgTip
{
    _hasMsg = YES;
    [_tableViewMine reloadData];
}

-(void)removeRedDotForMsgTip
{
    _hasMsg = NO;
    [_tableViewMine reloadData];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark --page
-(void)refreshCurentPage
{
   
    if (busiSystem.agent.isLogin) {
         _tableViewMine.isRefreshing = YES;
        [self getUserInfoIndex];
    }

}

#pragma mark --Notification
-(void) displayUserInfo
{

}

-(void)getUserInfo
{
     [busiSystem.agent getUserInfo:busiSystem.agent.userId observer:nil callback:@selector(getUserInfoNotification:)];
}


//-(void)toWitchView:(id)data type:(NSInteger)type
//{
//    //创建一个消息对象
//    NSNotification * notice = [NSNotification notificationWithName:@"RefreshDiscover" object:nil userInfo:nil];
//    //发送消息
//    [[NSNotificationCenter defaultCenter]postNotification:notice];
//    if (type ==1) {
////        DiscoverViewController *dVC =[[DiscoverViewController alloc] init];
////        dVC.isMyInformation =YES;
////        dVC.hidesBottomBarWhenPushed =YES;
////        [self.navigationController pushViewController:dVC animated:YES];
//    }
//    else{
//        NoticeViewController * noticeVC =[[NoticeViewController alloc] init];
//        noticeVC.hidesBottomBarWhenPushed =YES;
//        [self.navigationController pushViewController:noticeVC animated:YES];
//    }
//}

@end
