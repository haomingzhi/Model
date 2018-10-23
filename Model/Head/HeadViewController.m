 //
//  HeadViewController.m
//  chenxiaoer
//
//  Created by air on 16/3/3.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "HeadViewController.h"
#import "FlashTableViewCell.h"
#import "TabViewControllerManager.h"
#import "TipImgAndTitleTableViewCell.h"
#import "ImgAndTitleListTableViewCell.h"
#import "LoginViewController.h"
#import "TitleDetailTableViewCell.h"
#import "BUSystem.h"
#import "IconAndTitleTableViewCell.h"
#import "ThreeBtnTableViewCell.h"
#import "JYCommonTool.h"
#import "FourIconBtnTableViewCell.h"
#import "ImgAndThreeTitleTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
#import "PinpaiTableViewCell.h"
#import "SecKillTableViewCell.h"
#import "ImgTableViewCell.h"
#import "ScrollerTableViewCell.h"
#import "SignViewController.h"
#import "OddsRecViewController.h"
#import "SearchViewController.h"
#import "MsgViewController.h"
#import "SysMsgInfoViewController.h"
#import "GoodsInfoViewController.h"
#import "PublishAnswerViewController.h"
#import "AnswerInfoViewController.h"
#import "ScrollerTableViewCell.h"
#import "JECalourseTableViewCell.h"
#import "OptimizationRecViewController.h"
#import "SignViewController.h"
#import "ShowCodeViewController.h"
#import "ClassifyListViewController.h"
#import "SysMsgViewController.h"

@interface HeadViewController ()<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    UIImageView *_bgImgV;
    JECalourseTableViewCell *_flashCell;

//    TipImgAndTitleTableViewCell *_tipCell;
    ScrollerTableViewCell *_typeCell;
     ImgAndTitleListTableViewCell * _fastFunctionCell;
    NSInteger _requestCount;
    NSMutableArray *_parkArr;
    NSTimer *_timerB;
//    TitleDetailTableViewCell *_pinpaiTipCell;
    TitleDetailTableViewCell *_secKillTipCell;
      TitleDetailTableViewCell *_secKillTipBCell;
    TitleDetailTableViewCell *_freshObjTipCell;
      TitleDetailTableViewCell *_hotTipCell;
      TitleDetailTableViewCell *_sepcTipCell;
      OnlyTitleTableViewCell *_youLikeTipCell;
     ScrollerTableViewCell *_freshCell;

     ImgTableViewCell *_specImgCell;
//     TitleDetailTableViewCell *_specCell;
//     OnlyTitleTableViewCell *_specTitleCell;
    NSInteger _initCount;
//    ThreeBtnTableViewCell *_appointmentCell;
//     ThreeBtnTableViewCell *_classRoomCell;
     UIButton *_navLeftbtn;
     ImgAndThreeTitleTableViewCell *_firstBuyCell;
     BOOL _isFirstBuy;
     UIButton *_topBtn;
     UIButton *btn;
     UITextField *searchTextField;//nav 搜索
     CGFloat _delayTime;
}

@property(nonatomic,strong)UIButton *searchBar;
@property(nonatomic,strong)NSString *bgImg;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
//@property (strong, nonatomic) FourIconBtnTableViewCell *menuACell;
 @property (strong, nonatomic)UIButton *navBtn;
 @property (strong, nonatomic)UIImageView *navImgV;

@end

@implementation HeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     self.edgesForExtendedLayout = UIRectEdgeTop;
//    // Do any additional setup after loading the view from its nib.
//    self.navigationController.view.backgroundColor = kUIColorFromRGB(color_2);
    [self setNavCenter];
     _delayTime = 3.0;
     _isFirstBuy = busiSystem.agent.isFirstOrder;//未设置
    [self setRightNavBtn];
    [self setLeftNavBtn];
    [self initTableView];
//     HUDSHOW(@"加载中");
     [self getData];
     [self getUserInfo];
//     [self addTest];
}

-(void)viewWillAppear:(BOOL)animated
{
     if (busiSystem.agent.isNeedRefreshTabA && busiSystem.agent.isLogin && _isFirstBuy) {
          busiSystem.agent.isNeedRefreshTabA = NO;
          _delayTime = 0.5;
          HUDSHOW(@"加载中");
          [self getSignInfo];
     }
     _isFirstBuy = YES;

}

//- (void)locate{
////     _requestCount++;
//
//
//     // 带逆地理（返;回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
//     [locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
////          _requestCount--;
//          if (error)
//          {
//               NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
////               HUDCRY(@"定位失败", 2);
//               busiSystem.agent.log = @"0";
//               busiSystem.agent.lat = @"0";
//               [self getStoreIdList];
//               return;
//               //               if (error.code == AMapLocationErrorLocateFailed)
//               //               {
//               //                    HUDCRY(error.localizedDescription, 2);
//               //                    return;
//               //               }
//          }
////          if (_requestCount == 0) {
////               HUDDISMISS;
////          }
//
//          if (regeocode)
//          {
//               NSLog(@"reGeocode:%@", regeocode);
//               BUAddress *address = [BUAddress new];
//               address.longitude =  location.coordinate.longitude;//[NSString stringWithFormat:@"%f",location.coordinate.longitude];
//               address.latitude = location.coordinate.latitude;//[NSString stringWithFormat:@"%f",location.coordinate.latitude];
//               address.delCity = regeocode.city;
//               address.delAddress = regeocode.street;
//               btn.customTitleLb.text = regeocode.street?:@"位置";
//               busiSystem.agent.log = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
//               busiSystem.agent.lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
//               [self getStoreIdList];
//          }
//     }];
//}
//
//
//
//-(void)addTopView{
//     UIButton *topBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 30)];
//     topBtn.backgroundColor = kUIColorFromRGB(color_0xfdf2ea);
//     [topBtn addTarget:self action:@selector(handleReturnBack:) forControlEvents:UIControlEventTouchUpInside];
//     [self.view addSubview:topBtn];
////     _tableView.tableHeaderView = topBtn;
//     //     UIImageView *noticeImv = [[UIImageView alloc]initWithFrame:CGRectMake(15, 4, 17, 16)];
//     //     noticeImv.image = [UIImage imageNamed:@"h_notice"];
//     //     [topBtn addSubview:noticeImv];
//
//     _topBtn = topBtn;
//     UIImageView *arrowImv = [[UIImageView alloc]initWithFrame:CGRectMake(__SCREEN_SIZE.width - 15, 9.5, 6, 11)];
//     arrowImv.image = [UIImage imageNamed:@"icon_arrow_orange@2x"];
//     [topBtn addSubview:arrowImv];
//
//     UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15 ,0, arrowImv.x- 15-47, 30)];
//     title.text = [NSString stringWithFormat:@"无法配送至当前地址 %@",@""];
//     title.textColor = kUIColorFromRGB(color_3);
//     title.font = [UIFont systemFontOfSize:12];
//     [topBtn addSubview:title];
//}

-(void)topBtnAction{
     //     NSLog(@"top");
//     OrderServiceIntruduceViewController *vc = [OrderServiceIntruduceViewController createVCWithTitle:@"" withContent:@""];

}

-(void)addTest
{
    UIButton *btn = [UIButton new];
    btn.width = 90;
    btn.height = 30;
    btn.backgroundColor = [UIColor redColor];
    btn.x = 140;
    btn.y = 170;
    [btn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


-(void)testAction{
     
     NSString *payBody = @"app_id=2017030706095238&biz_content=%7b%22body%22%3a%22%e5%93%87%e5%93%88%e5%93%88%22%2c%22out_trade_no%22%3a%22string%22%2c%22product_code%22%3a%22QUICK_MSECURITY_PAY%22%2c%22subject%22%3a%22%e6%b5%8b%e8%af%95%e6%94%af%e4%bb%98%22%2c%22timeout_express%22%3a%2230m%22%2c%22total_amount%22%3a%220.10%22%7d&charset=UTF-8&format=json&method=alipay.trade.app.pay&notify_url=http%3a%2f%2fcxyapi.cxy365.com%2fapi%2fPay%2fAlipayNotify&sign_type=RSA2&timestamp=2018-04-11+16%3a16%3a05&version=1.0&sign=b3nPSdZ8Si%2fmddfnYeBQugSY5LzIyobHc6sTSYGriqmGnS30AR%2bFpiXdrMp%2fpYjFnXiKlQEsk6o8t%2ffPWDW7U43jqOaEZUhCiWWRpeMq%2bGH%2bE4VjgwiHpQZdvQ0DHWtEReRw2LH6z5dSlD%2beOX%2b7pEwBloQXbCXAWvpRoeQkXVTohtS7vrbHQ4%2foZg7KDnjzThGMgNHRT9G98lzByeba4Wrk7Sb5F1AHfvN5vrvdK7Z8TRMLrXduGPZx4QSapSTTBhyGPUR7J%2bDkaaDuKltcWruBPdtwEyZFk2f8blmzXw5mhgHs%2fof6G3Y0623vUWN6T9lYk84zepiXfao%2bLCva%2bg%3d%3d";
     [[CommonAPI managerWithVC:self] toPay:@{@"payBody":payBody,@"method":@(1)} withBlock:^(NSDictionary *dic) {
          if([dic[@"code"] integerValue] == 0)
          {
//               BUGetOrder *getOrder = busiSystem.payManager.order;
//               PaySuccessViewController *vc = [PaySuccessViewController new];
//               vc.payType = getOrder.payType;
//               //                    vc.price = getOrder.money;
//               [self.navigationController pushViewController:vc animated:YES];
//               if (self.handleGoBack) {
//                    self.handleGoBack(@{});
//               }
               
          }
     }];
}

-(void)checkAuth{
    _requestCount++;
    [busiSystem.agent checkAuth:self callback:@selector(checkAuthNotification:)];
}

-(void)checkAuthNotification:(BSNotification *)noti
{
    _requestCount--;
    if (noti.error.code == 0) {
      
        [self getData];
//        [self getBespokeListData];
//        [self getCourseListData];
//        [self getActivity];
//        [self getConfigInfo];
//        [self getInterConfigInfo];
    }
    else
    {
        HUDCRY(noti.error.domain, 2);
        [self removeBgImg];
    }
}

#pragma mark -data

-(void)getData
{
//     [self getSignInfo];
     [self getConfigInfo];
     [self getIndex];
     [self getIndexActivity];
     [self getIndexOptimi];
     
}

-(void)showSignView{
     [self removeBgImg];
     if (busiSystem.agent.isDaySigin == 0 && busiSystem.agent.isLogin) {
          [self performSelector:@selector(createSignView) withObject:self afterDelay:_delayTime];
          
//          [self createSignView];
     }
     
}

-(NSDictionary *)getNowDate{
     NSArray * arrWeek=[NSArray arrayWithObjects:@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday", nil];
     NSArray * arrMonth=[NSArray arrayWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August", @"September", @"October", @"November", @"December", nil];
     NSDate *date = [NSDate date];
     
     NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
     
     NSDateComponents *comps = [[NSDateComponents alloc] init];
     
     NSInteger unitFlags = NSCalendarUnitYear |
     
     NSCalendarUnitMonth |
     
     NSCalendarUnitDay |
     
     NSCalendarUnitWeekday |
     
     NSCalendarUnitHour |
     
     NSCalendarUnitMinute |
     
     NSCalendarUnitSecond;
     
     comps = [calendar components:unitFlags fromDate:date];
     
     NSInteger week = [comps weekday];
     
//     NSInteger year=[comps year];
     
     NSInteger month = [comps month];
     
     NSInteger day = [comps day];
     
     NSString *dateStr  =[NSString stringWithFormat:@"%ld/%@",(long)day,arrMonth[month-1]];
     
     
     
     NSString *weekStr =[NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week-1]];
     return @{@"week":weekStr?:@"",@"date":dateStr?:@""};
}


-(void)getSignInfo{
     _requestCount ++;
     [busiSystem.agent getSignInfo:self callback:@selector(getSignInfoNotification:)];
}


-(void)getSignInfoNotification:(BSNotification*)noti
{
     _requestCount--;
     if (noti.error.code == 0) {
          busiSystem.agent.isDaySigin = busiSystem.agent.signInfo.isDaySigin;

          if (_requestCount == 0) {
               HUDDISMISS;
               if (_tableView.isRefreshing) {
                    //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
                    [self refreshTableHeaderNotification:noti myTableView:_tableView];
                    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
                    _tableView.isRefreshing = NO;
               }else{
                    [self showSignView];
               }
               busiSystem.agent.isNeedRefreshTabA = NO;
          }
     }
     else
     {
          
          HUDCRY(noti.error.domain, 1);
     }
}


-(void)addSign{
     HUDSHOW(@"提交中");
     _requestCount ++;
     [busiSystem.agent addSign:self callback:@selector(addSignNotification:)];
}


-(void)addSignNotification:(BSNotification*)noti
{
     _requestCount--;
     if (noti.error.code == 0) {
          if (_requestCount == 0) {
               HUDDISMISS;
               busiSystem.agent.isNeedRefreshTabA = NO;
          }
          busiSystem.agent.isDaySigin = 1;
          SignViewController *vc = [SignViewController new];
          vc.hidesBottomBarWhenPushed = YES;
          [self.navigationController pushViewController:vc animated:YES];
     }
     else
     {
          
          HUDCRY(noti.error.domain, 1);
     }
}


-(void)getInfoConfig{
     _requestCount ++;
     [busiSystem.agent getInfoConfig:self callback:@selector(getInfoConfigNotification:)];
}


-(void)getInfoConfigNotification:(BSNotification*)noti
{
     _requestCount--;
     if (noti.error.code == 0) {
          if (_requestCount == 0) {
               HUDDISMISS;
               if (_tableView.isRefreshing) {
                    //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
                    [self refreshTableHeaderNotification:noti myTableView:_tableView];
                    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
                    _tableView.isRefreshing = NO;
               }else{
                    [self showSignView];
               }
               busiSystem.agent.isNeedRefreshTabA = NO;
          }
          searchTextField.placeholder = busiSystem.agent.config.keyword?:@"请输入";
     }
     else
     {
          
          HUDCRY(noti.error.domain, 1);
     }
}

-(void)getIndex
{
     _requestCount ++;
     [busiSystem.headManager getIndex:self callback:@selector(getIndexNotification:)];
}


-(void)getIndexNotification:(BSNotification*)noti
{
     _requestCount--;
     if (noti.error.code == 0) {
          
          busiSystem.agent.isDaySigin = busiSystem.headManager.bannerAndQuickMenu.isDaySigin;
          
          if (_requestCount == 0) {
               HUDDISMISS;
               if (_tableView.isRefreshing) {
                    //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
                    [self refreshTableHeaderNotification:noti myTableView:_tableView];
                    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
                    _tableView.isRefreshing = NO;
               }else{
                    [self showSignView];
               }
               busiSystem.agent.isNeedRefreshTabA = NO;
          }
          
          [_flashCell setCellData:[busiSystem.headManager.bannerAndQuickMenu getDic:0]];
          [_flashCell fitHeadMode];
          
          [_typeCell setCellData:[busiSystem.headManager.bannerAndQuickMenu getDic:1]];
          [_typeCell fitShopMode];
          [_tableView reloadData];
          
          
     }
     else
     {

          HUDCRY(noti.error.domain, 1);
     }
}


-(void)getIndexActivity
{
     _requestCount ++;
     [busiSystem.headManager getIndexActivity:self callback:@selector(getIndexActivityNotification:)];
}


-(void)getIndexActivityNotification:(BSNotification*)noti
{
     _requestCount--;
     if (noti.error.code == 0) {
          if (_requestCount == 0) {
               HUDDISMISS;
               if (_tableView.isRefreshing) {
                    //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
                    [self refreshTableHeaderNotification:noti myTableView:_tableView];
                    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
                    _tableView.isRefreshing = NO;
               }else{
                    [self showSignView];
               }
               busiSystem.agent.isNeedRefreshTabA = NO;
          }
          NSMutableArray *arr = [NSMutableArray new];
          [busiSystem.headManager.indexActivityList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               if (idx >= 4) {
                    *stop = YES;
                     
               }
               BUIndexActivity *a = obj;
               NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[a getDic]];
               [dic setObject:@(idx) forKey:@"index"];
               [arr addObject:dic];
          }];
          [_fastFunctionCell setCellData:@{@"arr":arr}];
          [_fastFunctionCell fitHeadModeB];
          [_tableView reloadData];
     }
     else
     {
          
          HUDCRY(noti.error.domain, 1);
     }
}


-(void)getIndexOptimi
{
     _requestCount ++;
     [busiSystem.headManager  getIndexOptimi:self callback:@selector(getIndexOptimiNotification:)];
}


-(void)getIndexOptimiNotification:(BSNotification*)noti
{
     _requestCount--;
     if (noti.error.code == 0) {
          if (_requestCount == 0) {
               HUDDISMISS;
               if (_tableView.isRefreshing) {
                    //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
                    [self refreshTableHeaderNotification:noti myTableView:_tableView];
                    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
                    _tableView.isRefreshing = NO;
               }else{
                    [self showSignView];
               }
               busiSystem.agent.isNeedRefreshTabA = NO;
          }
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.headManager.optimizationList];
          [_tableView reloadData];
     }
     else
     {
          
          HUDCRY(noti.error.domain, 1);
     }
}

-(void)setRightNavBtn
{
     //    [self setNavigateRightButton:btnStr font:[UIFont systemFontOfSize:15] color:[UIColor whiteColor]];
     //    [self setNavigateRightButton:@"nav_msg"];
     
     [self setNavigateRightButton:[UIImage imageNamed:@"nav_message"] observer:self callBack:@selector(handleDidRightButton:)];
}


-(void)handleSearch:(UIButton *)btn
{
     
     SearchViewController *vc = [SearchViewController new];
     vc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:vc animated:YES];
}

-(void)setLeftNavBtn
{
     
    [self setNavigateLeftButton:[UIImage imageNamed:@"nav_sign"] observer:self callBack:@selector(handleReturnBack:)];
}

-(void)handleReturnBack:(id)sender
{
     
     if (!busiSystem.agent.isLogin) {
          [LoginViewController toLogin:self];
          return;
     }
//     if (busiSystem.agent.isDaySigin == 0 ) {
          [self createSignView];
//     }else{
//          SignViewController *vc = [SignViewController new];
//          vc.hidesBottomBarWhenPushed = YES;
//          [self.navigationController pushViewController:vc animated:YES];
//     }
     
    
     
//     if (!busiSystem.agent.isLogin) {
//          [LoginViewController toLogin:self];
//          return;
//     }
//     HeadSelectAddressViewController *vc = [HeadSelectAddressViewController new];
//     vc.hidesBottomBarWhenPushed = YES;
//     [self.navigationController pushViewController:vc animated:YES];
//     [vc setHandleGoBack:^(NSDictionary *dic) {
//          BUAddress *add = dic[@"obj"];
////          [btn setTitle:add.delAddress?:@"" forState:UIControlStateNormal];
//          btn.customTitleLb.text = add.delAddress?:@"";
//     }];
}


-(void)createSignView{
     NSMutableDictionary *dic = [NSMutableDictionary new];
     [dic addEntriesFromDictionary:[self getNowDate]];
     [dic setObject:@(busiSystem.agent.isDaySigin == 1) forKey:@"hasSign"];
     [dic setObject:busiSystem.agent.config.signPicture?:@"" forKey:@"img"];
     ShowCodeViewController *vc = [ShowCodeViewController toCreateVC:dic];
     __weak HeadViewController *weakSelf = self;
     [vc setHandleGoBack:^(NSDictionary *dic) {
          NSInteger index = [dic[@"index"] integerValue];
          //1:退出 2:签到 3:点击背景
          if (index == 2) {
               if (busiSystem.agent.isDaySigin == 0) {
                    [self addSign];
               }else{
                    SignViewController *vc = [SignViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
               }
               
          }
     }];
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

-(void)viewDidLayoutSubviews
{
    if (!self.hasInit) {
        if (!_tableView.isRefreshing) {
            [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    self.hasInit = YES;
   
}


-(void)viewDidDisappear:(BOOL)animated
{
     self.navigationController.navigationBar.translucent = NO;
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView
{
//    _tableView.refreshHeaderView = nil;
     [ScrollerTableViewCell registerTableViewCell:_tableView];
     [ImgTableViewCell registerTableViewCell:_tableView];
     
    __weak HeadViewController *weakSelf = self;
    _flashCell = [JECalourseTableViewCell createTableViewCell];
     [_flashCell setCellData:@{@"arr":@[@{@"img":[BUImageRes new]},@{@"img":[BUImageRes new]},@{@"img":[BUImageRes new]}]}];
    [_flashCell fitHeadMode];
    _flashCell.selecedtItem = ^(NSDictionary *dic){
        NSInteger row = [dic[@"row"] integerValue];
       BUQuickMenu *b =  busiSystem.headManager.bannerAndQuickMenu.slideshow[row];
        [weakSelf tofitflashVC:b];
    };

     _typeCell =  [ScrollerTableViewCell createTableViewCell];
//    BUImageRes *img= [BUImageRes new];
//    img.isCached = YES;
//    img.Image = @"macbook";
//     NSMutableArray *arr = [NSMutableArray new];
//     for (int i = 0; i<14; i++) {
//          [arr addObject:@{@"img":@"macbook",@"title":[NSString stringWithFormat:@"%d笔记本",i]}];
//     }
    [_typeCell setCellData:@{@"arr":@[]}];
     [_typeCell fitShopMode];
     [_typeCell setHandleAction:^(UIButton *btn) {
          NSInteger index = btn.tag - 200;
          BUQuickMenu *q = busiSystem.headManager.bannerAndQuickMenu.nvaig[index];
          [weakSelf tofitflashVC:q];
          
     }];
     
     _fastFunctionCell = [ImgAndTitleListTableViewCell createTableViewCell];
     [_fastFunctionCell setCellData:@{@"arr":@[]}];
     [_fastFunctionCell fitHeadModeB];
     [_fastFunctionCell setHandleAction:^(NSDictionary *dic) {
          NSIndexPath *path = dic[@"row"];
          NSInteger index = path.row;
          //（0 无 1 链接地址 2 指定分类 3 指定优选 4 指定商品）
          BUIndexActivity *q = busiSystem.headManager.indexActivityList[index];
          [weakSelf tofitActVC:q];
     }];



     [SecKillTableViewCell registerTableViewCell:_tableView];
     [ImgTableViewCell registerTableViewCell:_tableView];
     [ImgAndThreeTitleTableViewCell registerTableViewCell:_tableView];

     
     _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
//    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
}



-(void)setNavCenter
{
     UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(85, 0, __SCREEN_SIZE.width-85-50, 30)];
     searchView.backgroundColor = kUIColorFromRGB(color_0xefefef);
     //     searchView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
     //     searchView.layer.borderWidth = 0.5;
     searchView.layer.cornerRadius = searchView.height/2.0;
     searchView.layer.masksToBounds = YES;
     //    searchView.layer.borderWidth = 0.5;
     
     UIImageView *imV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 10, 10)];
     imV.image = [UIImage imageNamed:@"nav_search2"];
     [searchView addSubview:imV];
     
     searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 0,searchView.width-40-10, searchView.height)];
     searchTextField.placeholder = @"请输入";
     searchTextField.font = [UIFont systemFontOfSize:13];
     [searchTextField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
     searchTextField.delegate = self;
     [searchView addSubview:searchTextField];
     
     

     self.navigationItem.titleView =  searchView;
     //     return _searchBar;
}


//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//     [self.view endEditing:YES];
//     SearchViewController *vc = [SearchViewController new];
//     vc.hidesBottomBarWhenPushed = YES;
//     [self.navigationController pushViewController:vc animated:YES];
//}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
     [self.view endEditing:YES];
     SearchViewController *vc = [SearchViewController new];
     vc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:vc animated:YES];
     return NO;
}


-( UIButton *)setNavCenterView
{
     UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 166, 30)];
     //    searchView.layer.borderWidth = 0.5;
     UIButton *searchBar = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 166, 30)];

//     searchBar.backgroundColor = [UIColor yellowColor];
     searchBar.backgroundColor = kUIColorFromRGB(color_0xfdf2ea);
//     [searchBar setSearchFieldBackgroundImage:nil forState:UIControlStateNormal];
     //    [searchBar setse:];
      [searchBar setTitle:@"门店选择" forState: UIControlStateNormal] ;
     [self fitSearchBtn:searchBar];
     [searchView addSubview:searchBar];
     searchBar.layer.cornerRadius = 14;
     searchBar.layer.masksToBounds = YES;
     [searchBar.layer setBorderWidth:1];
     [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
     self.navigationController.navigationBar.shadowImage = [UIImage new];
     self.navigationItem.titleView =  searchView;
     if(__SCREEN_SIZE.width == 320)
     {
          searchView.width = 130;
          searchBar.width = 130;
          searchBar.titleLabel.font = [UIFont systemFontOfSize:12];
     }
     [searchBar addTarget:self action:@selector(checkStore:) forControlEvents:UIControlEventTouchUpInside];
     return searchBar;
     
     
     
}

-(void)fitSearchBtn:(UIButton *)searchBar
{

     [searchBar setTitleColor:kUIColorFromRGB(color_0xec7e3b) forState:UIControlStateNormal];
     [searchBar fitImgAndTitleMode];
     searchBar.customTitleLb.x = 10;
     searchBar.customTitleLb.width = 136;
     searchBar.customTitleLb.height = 30;
     searchBar.customTitleLb.y = 7;
     searchBar.customTitleLb.textColor = kUIColorFromRGB(color_0xec7e3b);
     searchBar.customTitleLb.textAlignment = NSTextAlignmentRight;
     searchBar.customImgV.width = 10;
     searchBar.customImgV.height = 5;
     searchBar.customImgV.y = 12.5;
     [searchBar.customTitleLb sizeToFit];
     searchBar.customTitleLb.x =  searchBar.width/2.0 - (searchBar.customTitleLb.width + searchBar.customImgV.width)/2.0;
     searchBar.customImgV.x = searchBar.customTitleLb.x + searchBar.customTitleLb.width + 7;
     searchBar.customImgV.image = [UIImage imageContentWithFileName:@"h_drop"];
}

-(void)checkStore:(UIButton *)btn
{

//     SingleSelectionViewController *vc = [SingleSelectionViewController toSingleSelectionVC:[BUStroe getNameArr:busiSystem.indexManager.storeList]];
////     vc.curRow = busiSystem.getAreaParkListManager.curRow;
//     [vc setHandleAction:^(NSDictionary *dic){
//          [_searchBar setTitle:dic[@"title"] forState:UIControlStateNormal];
//          [self fitSearchBtn:_searchBar];
//          BUStroe *s =   busiSystem.indexManager.storeList[[dic[@"row"] integerValue]];
//          busiSystem.agent.storeId = s.sId;
//          HUDSHOW(@"加载中");
//          [self getRecProData];
//          if (busiSystem.agent.isLogin) {
//               [self getDefaultAddressData];
//          }
//     }];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{

     return NO;
}

//-(void)viewDidDisappear:(BOOL)animated
//{
//    self.navigationController.navigationBar.translucent = NO;
////        [_timerB invalidate];
//}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//     NSArray *arr = busiSystem.getActiveAndProductListManager.dataArr;

    return 2+_tableView.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
    if(section == 0)
    {
        row = 2;
    }
    else if (section == 1)
    {
        row = 1;
    }
  
    else
    {
         BUOptimization *op = _tableView.dataArr[section-2];
         row = 2 + (op.proList.count>0?1:0);
    }
    
    return row;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//     if (section == 4 + 3 || section == 0) {
//          return nil;
//     }
//     if(section == 2 && !_isFirstBuy)
//     {
//          return nil;
//     }
//     return [self createSectionFootView];;
//}

-(UIView *)createSectionFootView
{
     UIView *v = [UIView new];
     v.height = 10;
     UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 9.5, __SCREEN_SIZE.width, 0.5)];
     line.backgroundColor = kUIColorFromRGB(color_lineColor);
     v.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
     line.tag = 9887;
     [v addSubview:line];
     return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     
     if(section == 1 && busiSystem.headManager.indexActivityList.count == 0)
     {
          return 0.001;
     }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    if (indexPath.section == 0) {
         if (indexPath.row == 0) {
              height = _flashCell.height;//(__SCREEN_SIZE.width-50) * 150/325 +10;
         }
         else
         {
              height = _typeCell.height;
         }
       
    }
    else if(indexPath.section == 1)
    {
          height = _fastFunctionCell.height ;
    }
    else
    {
         if (indexPath.row == 0) {
              height = 64;
         }
         else if (indexPath.row == 1){
              height = (__SCREEN_SIZE.width-30) * 126/330 +10;
         }
         else
         {
              height = 184;
         }
    }

    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
   if(indexPath.section == 0)
   {
      cell = [self createFirstSection:indexPath];
   }
    else if (indexPath.section == 1)
    {
        cell = [self createSecondSection:indexPath];
    }
//    else if (indexPath.section == 2)
//    {
//        cell = [self createThirdSection:indexPath];
//    }
//    else if (indexPath.section == 3)
//    {
//          cell = [self createFourthSection:indexPath];
//    }
//    else if (indexPath.section == 4)
//    {
//         cell = [self createFivethSection:indexPath];
//    }
    else
    {
         cell = [self createOtherSection:indexPath];
    }
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UITableViewCell *)createFirstSection:(NSIndexPath*)indexPath
{
  UITableViewCell *cell;
     if(indexPath.row == 0)
     {
          cell = _flashCell;
//             [_flashCell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(_flashCell.height, 0, 0, 0)];
     }
     else {
          cell = _typeCell;
     }
    return cell;
    
}

-(UITableViewCell *)createSecondSection:(NSIndexPath*)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {

         cell =  _fastFunctionCell;
       
    }
    return cell;
    
}



-(UITableViewCell *)createThirdSection:(NSIndexPath*)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = _freshObjTipCell;

    }
    else  {
         cell = _firstBuyCell;
         if(indexPath.row != 3)
         {
              [(ImgAndThreeTitleTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 15, 0, 15)];
         }
         else
         {
              [(ImgAndThreeTitleTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(118, 0, 0, 0)];
         }
    }

    return cell;
    
}

-(UITableViewCell *)createFourthSection:(NSIndexPath*)indexPath
{
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = _hotTipCell;
          
     }
     else  {
          cell =  _freshCell;
     }
  
     return cell;
     
}


-(UITableViewCell *)createFivethSection:(NSIndexPath*)indexPath
{
     UITableViewCell *cell;
     if (indexPath.row == 0) {
          cell = _sepcTipCell;
          
     }

     else  {
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
//          NSArray *arr = busiSystem.getPopularityProductPageListManager.dataArr;
//       BUGoodsInfo *pg =  arr[indexPath.row - 1];
//          [(ImgAndThreeTitleTableViewCell *)cell setCellData:[pg getDic]];
          [(ImgAndThreeTitleTableViewCell *)cell fitHeadMode];
//          [(ImgAndThreeTitleTableViewCell *)cell setHandleAction:^(id sender) {
//               NSLog(@"人气推荐购买");
//               NSArray *arr = busiSystem.getPopularityProductPageListManager.dataArr;
//               BUGoodsInfo *pg =  arr[indexPath.row - 1];
//               [self addShoppingCart:pg.pId];

//          }];
          if(indexPath.row != 3)
          {
               [(ImgAndThreeTitleTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(cell.height, 15, 0, 15)];
          }
          else
          {
               [(ImgAndThreeTitleTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(118, 0, 0, 0)];
          }
     }
     
     
     return cell;
     
}

-(UITableViewCell *)createOtherSection:(NSIndexPath*)indexPath
{
     UITableViewCell *cell;
     BUOptimization *op = _tableView.dataArr[indexPath.section - 2];
     if (indexPath.row == 0) {
          cell = [ImgAndThreeTitleTableViewCell dequeueReusableCell:_tableView];
          [(ImgAndThreeTitleTableViewCell*)cell setCellData:[op getDic:0]];
          [(ImgAndThreeTitleTableViewCell*)cell fitHeadMode];
          
     }
     else if (indexPath.row == 1){
          cell = [ImgTableViewCell dequeueReusableCell:_tableView];
          [(ImgTableViewCell*)cell setCellData:[op getDic:1]];
          [(ImgTableViewCell*)cell fitHeadMode];
     }
     else  {
          cell =  [SecKillTableViewCell dequeueReusableCell:_tableView];
          NSInteger index = (indexPath.row-2)*2;
          BUHeadGoods *g = op.proList[index];
//          g.row = index;
          BUHeadGoods *gg;
          NSMutableDictionary *dic = [NSMutableDictionary new];
          [dic addEntriesFromDictionary:[g getDicA]];
          if (index + 1 < op.proList.count) {
               gg = op.proList[index + 1];
               [dic addEntriesFromDictionary:[gg getDicB]];
          }
//          NSDictionary *dic =  @{@"aHot":@(YES),@"aTitle":@"iPhone X 全新国行",@"aDetail":@"¥439/月起",@"aimg":@"secKillA",@"bTitle":@"iPhone 8 全新国行",@"bDetail":@"¥439/月起",@"bimg":@"secKillA",@"bHot":@(NO),@"default":@"default"};;
          [(SecKillTableViewCell *)cell setCellData:dic];
          [(SecKillTableViewCell *)cell fitHeadMode];
          //          if(indexPath.row == 3)
          //          {
          //               [(SecKillTableViewCell *)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(184, 0, 0, 0)];
          //          }
          //          else
          //          {
          //               [(SecKillTableViewCell *)cell hiddenCustomSeparatorView];
          //          }
          [(SecKillTableViewCell *)cell setHandleAction:^(NSDictionary *dic){
               NSInteger row = [dic[@"row"] integerValue];
               NSInteger index = [dic[@"index"] integerValue];
               BUHeadGoods *g = op.proList[index + row];
//               UIButton *btn = dic[@"obj"];
               GoodsInfoViewController *vc = [GoodsInfoViewController new];
               vc.hidesBottomBarWhenPushed = YES;
               vc.ID = g.productId;
               [self.navigationController pushViewController:vc animated:YES];
          }];
         
     }
     
     
     return cell;
     
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (indexPath.section >= 2) {
          if (indexPath.row <= 1) {
               OptimizationRecViewController *vc = [OptimizationRecViewController new];
               vc.hidesBottomBarWhenPushed = YES;
               BUOptimization *op  = _tableView.dataArr[indexPath.section-2];
               vc.optimization = op;
               vc.ID = op.optimizationId;
               [self.navigationController pushViewController:vc animated:YES];
          }
     
     }
}



-(void)showLoading
{
      HUDSHOW(@"加载中");
}

-(void)refreshCurentPage
{
    _tableView.isRefreshing = YES;
    [self getData];

}

-(void)getConfigInfo
{
    _requestCount ++;
    [busiSystem.agent getInfoConfig:self callback:@selector(getInfoConfigNotification:)];
}

//-(void)getInterConfigInfo
//{
//    _initCount++;
//    [busiSystem.agent getIntegralConfig:self callback:@selector(getInfoConfigNotification:)];
//}
//
//-(void)getInfoConfigNotification:(BSNotification *)noti
//{
//    _initCount --;
//    if (noti.error.code == 0) {
//        if (_initCount == 0) {
//             [self removeBgImg];
//        }
//       
//    }
//    else
//    {
//        if (_initCount == 0) {
//        HUDCRY(noti.error.domain, 2);
//           [self removeBgImg];
//        }
//    }
//}


-(void)removeBgImg
{
  [UIView animateWithDuration:1 animations:^{
      _bgImgV.alpha = 0;
  } completion:^(BOOL finished) {
       [_bgImgV removeFromSuperview];
  }];
}

-(void)addBgImg
{
    _bgImgV = [UIImageView new];
    NSString *bgImgName = @"";
    if (!_bgImg) {
        if (__IPHONE6PLUS) {
            bgImgName= @"启动页1242x2208";
        }
        else if (__IPHONE6)
        {
            bgImgName= @"启动页750x1334";
        }
        else if (__IPHONE5)
        {
            bgImgName= @"启动页640x1136";
        }
        else{
            bgImgName= @"启动页640x960";
        }
    }
    else
    {
        bgImgName = _bgImg;
    }
    
    _bgImgV.image = [UIImage imageNamed:bgImgName];
    _bgImgV.width = __SCREEN_SIZE.width;
    _bgImgV.height = __SCREEN_SIZE.height;
    [self.tabBarController.view addSubview:_bgImgV];
}

-(void)tofitflashVC:(BUQuickMenu *)q
{
     //（0 无 1 链接地址 2 指定分类 3 指定优选 4 指定商品）
     if (q.type == 1) {
          CommonWebViewViewController *vc = [CommonWebViewViewController setWebViewController:q.name?:@"" withUrl:q.url];
          vc.hidesBottomBarWhenPushed = YES;
          [self.navigationController pushViewController:vc animated:YES];
     }
     else if (q.type == 2){
          ClassifyListViewController *vc = [ClassifyListViewController new];
          vc.hidesBottomBarWhenPushed = YES;
          vc.typetId = q.parmaId;
          vc.parentId = @"";
          vc.title = q.name;
          [self.navigationController pushViewController:vc animated:YES];
     }
     else if (q.type == 3){
          OptimizationRecViewController *vc = [OptimizationRecViewController new];
          vc.hidesBottomBarWhenPushed = YES;
          vc.ID = q.parmaId;
          [self.navigationController pushViewController:vc animated:YES];
     }
     else if (q.type == 4){
          GoodsInfoViewController *vc = [GoodsInfoViewController new];
          vc.hidesBottomBarWhenPushed = YES;
          vc.ID = q.parmaId;
          [self.navigationController pushViewController:vc animated:YES];
     }
}


-(void)tofitActVC:(BUIndexActivity *)q{
     if (q.type == 1) {
          CommonWebViewViewController *vc = [CommonWebViewViewController setWebViewController:q.title?:@"" withUrl:q.url];
          vc.hidesBottomBarWhenPushed = YES;
          [self.navigationController pushViewController:vc animated:YES];
     }
     else if (q.type == 2){
          ClassifyListViewController *vc = [ClassifyListViewController new];
          vc.hidesBottomBarWhenPushed = YES;
          vc.typetId = q.parmaId;
          vc.parentId = @"";
          vc.title = q.title;
          [self.navigationController pushViewController:vc animated:YES];
     }
     else if (q.type == 3){
          OptimizationRecViewController *vc = [OptimizationRecViewController new];
          vc.hidesBottomBarWhenPushed = YES;
          vc.ID = q.parmaId;
          [self.navigationController pushViewController:vc animated:YES];
     }
     else if (q.type == 4){
          GoodsInfoViewController *vc = [GoodsInfoViewController new];
          vc.hidesBottomBarWhenPushed = YES;
          vc.ID = q.parmaId;
          [self.navigationController pushViewController:vc animated:YES];
     }
}

-(void)addShoppingCart:(NSString *)productId{
     if (!busiSystem.agent.isLogin) {
          [LoginViewController toLogin:self];
          return;
     }
     HUDSHOW(@"提交中");
     [busiSystem.orderManager addShoppingCart:productId storeId:busiSystem.agent.storeId withProCount:1 userId:busiSystem.agent.userId?:@"" observer:self callback:@selector(addShoppingCartNotification:)];
}

-(void)addShoppingCartNotification:(BSNotification *)noti{

     if (noti.error.code == 0) {
          HUDSMILE(@"添加成功", 1);
     }else{
          HUDCRY(noti.error.domain, 2);
     }

}
-(void)getUserInfo
{
     [busiSystem.agent getUserInfo:busiSystem.agent.userId observer:nil callback:@selector(getUserInfoNotification:)];
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
