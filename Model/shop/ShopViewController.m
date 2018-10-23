//
//  ShopViewController.m
//  compassionpark
//
//  Created by air on 2017/1/20.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ShopViewController.h"
#import "SearchShopViewController.h"
#import "ImgTitleAndDetailCollectionViewCell.h"
#import "ShopHeaderCollectionReusableView.h"
//#import "PresentCardListViewController.h"
//#import "GoodsListViewController.h"
//#import "GoodsInfoViewController.h"
#import "ImgAndBtnCollectionViewCell.h"
#import "BUSystem.h"
//#import "FlashTableViewCell.h"
#import "JECalourseTableViewCell.h"
#import "ImgTableViewCell.h"
#import "ScrollerTableViewCell.h"
#import "ShopListViewController.h"
#import "ServerListViewController.h"
#import "CartViewController.h"
#import "LoginViewController.h"
#import "ErrandServerViewController.h"
#import "SearchShopViewController.h"
#import "ClassifyListViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "ZoneChoseViewController.h"


@interface ShopViewController ()<UISearchBarDelegate,CLLocationManagerDelegate,UITextFieldDelegate,UIScrollViewDelegate,AMapLocationManagerDelegate>{

    NSInteger _requestCount;
     UIButton *_cityBtn;
     JECalourseTableViewCell *_flashCell;
     ScrollerTableViewCell *_classifyCell;
     AMapLocationManager *locationManager;
     UILabel *_redDotLb;
}

@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (nonatomic,strong) NSMutableArray *shopTypeList;
@property (nonatomic,strong) NSMutableArray *serviceTypeList;
@property (nonatomic,strong) NSMutableArray *imageList;
@property (nonatomic,strong) ZoneChoseViewController *zoneVC;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self initTableView];
     [self initNav];
     
     
     locationManager = [AMapLocationManager new];
     // 带逆地理信息的一次定位（返回坐标和地址信息）
     [locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
     //   定位超时时间，最低2s，此处设置为10s
     locationManager.locationTimeout = 10;
     //   逆地理请求超时时间，最低2s，此处设置为10s
     locationManager.reGeocodeTimeout = 10;
     
//    HUDSHOW(@"加载中");
//    [self getData];
}


-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
     HUDSHOW(@"加载中");
     [self getData];
}


- (void)locate{
     //     _requestCount++;
     
     
     // 带逆地理（返;回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
     [locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
          _requestCount--;
//          if (_requestCount == 0) {
//               HUDDISMISS;
//          }
          if (error)
          {
               NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
               //               HUDCRY(@"定位失败", 2);
               busiSystem.agent.log = @"0";
               busiSystem.agent.lat = @"0";
               if (busiSystem.indexManager.cityList != 0) {
                    BUOpenCity *city = [busiSystem.indexManager.cityList firstObject];
                    busiSystem.agent.cityId = city.cityId;
                    busiSystem.agent.cityName = city.cityName?:@"";
               }
//               [self getActivityList];
//               [self getCarouselList];
               return;
               //               if (error.code == AMapLocationErrorLocateFailed)
               //               {
               //                    HUDCRY(error.localizedDescription, 2);
               //                    return;
               //               }
          }
          
          
          if (regeocode)
          {
//               NSLog(@"reGeocode:%@", regeocode);
//               BUAddress *address = [BUAddress new];
//               address.longitude =  location.coordinate.longitude;//[NSString stringWithFormat:@"%f",location.coordinate.longitude];
//               address.latitude = location.coordinate.latitude;//[NSString stringWithFormat:@"%f",location.coordinate.latitude];
//               address.delCity = regeocode.city;
//               address.delAddress = regeocode.street;
//               btn.customTitleLb.text = regeocode.street?:@"位置";
               busiSystem.agent.log = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
               busiSystem.agent.lat = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
               __block BOOL hasOpenCity = NO;
               [busiSystem.indexManager.cityList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    BUOpenCity *city = obj;
                    if ([city.cityName isEqualToString:regeocode.city]) {
                         hasOpenCity = YES;
                         busiSystem.agent.cityId = city.cityId;
                         busiSystem.agent.cityName = city.cityName?:@"";
                         *stop = YES;
                    }
                    
               }];
               
               if (busiSystem.indexManager.cityList != 0 && !hasOpenCity) {
                    BUOpenCity *city = [busiSystem.indexManager.cityList firstObject];
                    busiSystem.agent.cityId = city.cityId;
                    busiSystem.agent.cityName = city.cityName?:@"";
               }
//               [self getActivityList];
//               [self getCarouselList];
          }
     }];
}


-(void)initTableView
{
     [ImgTableViewCell registerTableViewCell:_tableView];
     
     __weak ShopViewController *weakSelf= self;
     
     _flashCell = [JECalourseTableViewCell createTableViewCell];
     [_flashCell setCellData:@{@"arr":@[]}];
     [_flashCell fitHeadMode];
//     [_flashCell setSelecedtItem:^(NSDictionary *dic) {
//          NSInteger index = [dic[@"row"] integerValue];
//          if (weakSelf.imageList.count != 0) {
//               BUCarouse *c = weakSelf.imageList[index];
//               CommonWebViewViewController *vc = [CommonWebViewViewController setWebViewController:c.title?:@"" withUrl:c.url];
//               vc.hidesBottomBarWhenPushed = YES;
//               [weakSelf.navigationController pushViewController:vc animated:YES];
//          }
//     }];

//     _hotTitleCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
//     [_hotTitleCell setCellData:@{@"img":@"icon_hot",@"title":@"热门推荐"}];
//     [_hotTitleCell fitBookingModeA];
//
//     _historyTitleCell = [TitleAndDetailAndImageTableViewCell createTableViewCell];
//     [_historyTitleCell setCellData:@{@"img":@"icon_history",@"title":@"历史记录"}];
//     [_historyTitleCell fitBookingMode];
     
     
     _classifyCell = [ScrollerTableViewCell createTableViewCell];
//         BUImageRes *img= [BUImageRes new];
//         img.isCached = YES;
//         img.Image = @"default";
//         [_classifyCell setCellData:@{@"arr":@[@{@"img":img,@"title":@"羽毛球"},@{@"img":img,@"title":@"羽毛球"},@{@"img":img,@"title":@"羽毛球"},@{@"img":img,@"title":@"羽毛球"},@{@"img":img,@"title":@"羽毛球"},@{@"img":img,@"title":@"羽毛球"},@{@"img":img,@"title":@"羽毛球"},@{@"img":img,@"title":@"羽毛球"},@{@"img":img,@"title":@"羽毛球"}]}];
         [_classifyCell fitShopMode];
     [_classifyCell setHandleAction:^(UIButton *btn) {
          NSInteger index = btn.tag - 200;
//          if (index == 0) {
//               ErrandServerViewController *vc = [ErrandServerViewController new];
//               vc.hidesBottomBarWhenPushed = YES;
//               [weakSelf.navigationController pushViewController:vc animated:YES];
//          }
//          else
          if ((index == 15 && _shopTypeList.count>8)|| (index == 7 && _serviceTypeList.count>7)){
               ClassifyListViewController *vc = [ClassifyListViewController new];
               vc.hidesBottomBarWhenPushed = YES;
               [weakSelf.navigationController pushViewController:vc animated:YES];
          }
          else   if (index ==0) {
               ErrandServerViewController *vc = [ErrandServerViewController new];
               vc.hidesBottomBarWhenPushed = YES;
               [weakSelf.navigationController pushViewController:vc animated:YES];
          }
          else if(index<8){
               ServerListViewController *vc = [ServerListViewController new];
               vc.hidesBottomBarWhenPushed = YES;
               vc.type = weakSelf.serviceTypeList[index-1];
               [weakSelf.navigationController pushViewController:vc animated:YES];
          }
          else if (index-8 < _shopTypeList.count)  {

                    ShopListViewController *vc = [ShopListViewController new];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.type = weakSelf.shopTypeList[index-8];
                    [weakSelf.navigationController pushViewController:vc animated:YES];
               
          }
          
          
     }];
     
     
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.x = 0;
     _tableView.y = 0;
     _tableView.height = __SCREEN_SIZE.height - 64 - 48;
     _tableView.width = __SCREEN_SIZE.width;
//     _tableView.refreshHeaderView = nil;
     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


-(void)getData{
     _requestCount ++;
     [busiSystem.shopManager getServiceTypeList:self callback:@selector(getServiceTypeListNotification:)];
     _requestCount ++;
     [busiSystem.shopManager getShopTypeList:self callback:@selector(getShopTypeListNotification:)];
//     _requestCount ++;
//     [busiSystem.indexManager getOpenCityList:self callback:@selector(getOpenCityListNotification:)];
     [self getActivityList];
     [self getCarouselList];
     [self getUserCartCount];
}



-(void)getUserCartCount{
     if (!busiSystem.agent.isLogin) {
          _redDotLb.hidden = YES;
          return;
     }
     _requestCount ++;
     [busiSystem.userManager getUserCartCount:busiSystem.agent.userId observer:self callback:@selector(getUserCartCountNotification:)];
}


-(void)getUserCartCountNotification:(BSNotification *)noti
{
     _requestCount--;
     if (_requestCount == 0) {
          BASENOTIFICATION(noti);
          if (_tableView.isRefreshing) {
               //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
               [self refreshTableHeaderNotification:noti myTableView:_tableView];
               [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
               _tableView.isRefreshing = NO;
          }
     }
     else
     {
          BASENOTIFICATIONWITHCANMISS(noti, NO);
     }
     if (noti.error.code == 0) {
          NSInteger _cartCount = busiSystem.userManager.cartCount;
          if (_cartCount == 0) {
               _redDotLb.hidden = YES;
          }else{
               _redDotLb.hidden = NO;
               _redDotLb.text = [NSString stringWithFormat:@"%ld",(long)_cartCount];
               CGSize size = [_redDotLb.text size:_redDotLb.font constrainedToSize:CGSizeMake(200, 15)];
               _redDotLb.width = size.width +8;
          }
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}

-(void)getOpenCityListNotification:(BSNotification *)noti
{
     
     if (noti.error.code == 0) {
          [self locate];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}

-(void)getCarouselList{
     _requestCount ++;
     [busiSystem.indexManager getCarouselList:0 postion:@"1" observer:self callback:@selector(getCarouselListNotification:)];
}


-(void)getCarouselListNotification:(BSNotification *)noti
{
     _requestCount -- ;
     if (_requestCount == 0) {
          HUDDISMISS;
          if (_tableView.isRefreshing) {
               //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
               [self refreshTableHeaderNotification:noti myTableView:_tableView];
               [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
               _tableView.isRefreshing = NO;
          }
     }
     if (noti.error.code == 0) {
          NSMutableArray *arr = [NSMutableArray new];
          _imageList = [NSMutableArray arrayWithArray:busiSystem.indexManager.carouseList];
          [_imageList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUCarouse *c = obj;
               [arr addObject:@{@"img":c.imagePath?:[BUImageRes new]}];
          }];
          [_flashCell setCellData:@{@"arr":arr}];
          [_flashCell fitHeadMode];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}


-(void)getActivityList{
     _requestCount ++;
     NSString *cityId = [NSString stringWithFormat:@"%ld",(long)busiSystem.agent.cityId];
     cityId = @"0";
     [busiSystem.getActivityManager getActivity:cityId withIsHome:@"0" observer:self callback:@selector(getActivityNotification:)];
}


-(void)getActivityNotification:(BSNotification *)noti
{
     _requestCount -- ;
     if (_requestCount == 0) {
          HUDDISMISS;
          if (_tableView.isRefreshing) {
               //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
               [self refreshTableHeaderNotification:noti myTableView:_tableView];
               [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
               _tableView.isRefreshing = NO;
          }
     }
     if (noti.error.code == 0) {
          _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getActivityManager.dataArr];
          _tableView.hasMore = busiSystem.getActivityManager.pageInfo.hasMore;
          [_tableView reloadData];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}

-(void)getShopTypeListNotification:(BSNotification *)noti
{
     
     if (noti.error.code == 0) {
          if (_requestCount) {
               HUDDISMISS;
               if (_tableView.isRefreshing) {
                    //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
                    [self refreshTableHeaderNotification:noti myTableView:_tableView];
                    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
                    _tableView.isRefreshing = NO;
               }
          }
          _shopTypeList = [NSMutableArray arrayWithArray:busiSystem.shopManager.shopTypeList];
          NSMutableArray *arr  = [NSMutableArray new];
          [arr addObject:@{@"img":@"icon_deliverService",@"title":@"跑腿服务",@"hidden":@(NO)}];
          [_serviceTypeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               if (idx <6) {
                    BUShopType *type = obj;
                    [arr addObject:[type getDic:0]];
               }else if (idx == 6){
                    if (_serviceTypeList.count>7) {
                         [arr addObject:@{@"img":@"icon_type_more",@"title":@"更多"}];
                    }else{
                         BUShopType *type = obj;
                         [arr addObject:[type getDic:0]];
                    }
               }
          }];
          
          if (arr.count <8) {
               for (int i = (int)arr.count; i<8; i++) {
                    [arr addObject:@{@"img":@"",@"title":@"",@"hidden":@(YES)}];
               }
          }
          
          [_shopTypeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               if (idx <7) {
                    BUShopType *type = obj;
                    [arr addObject:[type getDic:0]];
               }else if (idx == 7){
                    if (_shopTypeList.count>8) {
                         [arr addObject:@{@"img":@"icon_type_more",@"title":@"更多"}];
                    }else{
                         BUShopType *type = obj;
                         [arr addObject:[type getDic:0]];
                    }
               }
          }];
          
          [_classifyCell setCellData:@{@"arr":arr}];
          [_classifyCell fitShopMode];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}

-(void)getServiceTypeListNotification:(BSNotification *)noti
{
     
     if (noti.error.code == 0) {
          if (_requestCount) {
               HUDDISMISS;
               if (_tableView.isRefreshing) {
                    //  [_curTableView.refreshHeaderView setState:EGOPullRefreshNormal];
                    [self refreshTableHeaderNotification:noti myTableView:_tableView];
                    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
                    _tableView.isRefreshing = NO;
               }
          }
          _serviceTypeList = [NSMutableArray arrayWithArray:busiSystem.shopManager.serviceTypeList];
          NSMutableArray *arr  = [NSMutableArray new];
          
          [arr addObject:@{@"img":@"icon_deliverService",@"title":@"跑腿服务",@"hidden":@(NO)}];
          [_serviceTypeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               if (idx <6) {
                    BUShopType *type = obj;
                    [arr addObject:[type getDic:0]];
               }else if (idx == 6){
                    if (_serviceTypeList.count>7) {
                         [arr addObject:@{@"img":@"icon_type_more",@"title":@"更多"}];
                    }else{
                         BUShopType *type = obj;
                         [arr addObject:[type getDic:0]];
                    }
               }
          }];
          
          if (arr.count <8) {
               for (int i = (int)arr.count; i<8; i++) {
                    [arr addObject:@{@"img":@"",@"title":@"",@"hidden":@(YES)}];
               }
          }
          
          [_shopTypeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               if (idx <7) {
                    BUShopType *type = obj;
                    [arr addObject:[type getDic:0]];
               }else if (idx == 7){
                    if (_shopTypeList.count>8) {
                         [arr addObject:@{@"img":@"icon_type_more",@"title":@"更多"}];
                    }else{
                         BUShopType *type = obj;
                         [arr addObject:[type getDic:0]];
                    }
               }
          }];
          
          
          
          
          [_classifyCell setCellData:@{@"arr":arr}];
          [_classifyCell fitShopMode];
     }
     else
     {
          HUDCRY( noti.error.domain , 1);
     }
}


-(void)handleDidRightButton:(id)sender{
     CartViewController *vc = [CartViewController new];
     vc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:vc animated:YES];
}

-(void)initNav{
     //    [self setNavigateRightButton:[UIImage imageNamed:@"icon_message"] observer:self callBack:@selector(messageAction)];
     UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 37, 37)];;
     [btn setImage:[UIImage imageNamed:@"nav_cart"] forState:UIControlStateNormal];
     [btn addTarget:self action:@selector(goToCart) forControlEvents:UIControlEventTouchUpInside];
     
     _redDotLb = [[UILabel alloc]initWithFrame:CGRectMake(24, 5, 13, 13)];
     _redDotLb.backgroundColor = kUIColorFromRGB(color_0xf82D45);
     _redDotLb.layer.cornerRadius = _redDotLb.height/2.0;;
     _redDotLb.layer.masksToBounds = YES;
     _redDotLb.textColor = kUIColorFromRGB(color_2);
     _redDotLb.hidden = YES;
     _redDotLb.textAlignment = NSTextAlignmentCenter;
     _redDotLb.font = [UIFont systemFontOfSize:10];
     [btn addSubview:_redDotLb];
     
     [self setNavigateRightView:btn];
//     [self setNavigateRightButton:[UIImage imageNamed:@"nav_cart"] observer:self callBack:@selector(goToCart)];
     [self setNavCenter];
     [self setLeftNav];
}

-(void)goToCart{
     if (!busiSystem.agent.isLogin) {
          [LoginViewController toLogin:self];
          return;
     }
     CartViewController *vc = [CartViewController new];
     vc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:vc animated:YES];
}

-(void)setNavCenter
{
     UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(85, 0, __SCREEN_SIZE.width-85-50, 30)];
     searchView.backgroundColor = kUIColorFromRGB(color_4);
//     searchView.layer.borderColor = kUIColorFromRGB(color_lineColor).CGColor;
//     searchView.layer.borderWidth = 0.5;
     searchView.layer.cornerRadius = searchView.height/2.0;
     searchView.layer.masksToBounds = YES;
     //    searchView.layer.borderWidth = 0.5;
     
     UIImageView *imV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 10, 10)];
     imV.image = [UIImage imageNamed:@"nav_search2"];
     [searchView addSubview:imV];
     
     UITextField *searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(24, 0,searchView.width-34, searchView.height)];
     searchTextField.placeholder = @"请输入商品和服务";
     searchTextField.font = [UIFont systemFontOfSize:13];
     [searchTextField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
     searchTextField.delegate = self;
     [searchView addSubview:searchTextField];
     
     
//     UISearchBar *_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, searchView.width, 34)];
//     _searchBar.placeholder = @"请输入商品和服务";
//     _searchBar.backgroundColor = kUIColorFromRGB(color_4);
////     [_searchBar setSearchFieldBackgroundImage:[[UIImage imageNamed:@"searchBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
//     _searchBar.backgroundImage = [self createImageColor:kUIColorFromRGB(color_4) size:CGSizeMake(_searchBar.width, _searchBar.height)];
//     [searchView addSubview:_searchBar];
//     //    _searchBar.layer.cornerRadius = 15;
//     //    _searchBar.layer.masksToBounds = YES;
//     [_searchBar.layer setBorderWidth:8];
//     [_searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
//     UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
//     [searchField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
//     searchField.keyboardType =
     //    [searchBar setScopeBarBackgroundImage:[UIImage imageNamed:@"testgrad"]];
     //    searchBar.barStyle
     self.navigationItem.titleView =  searchView;
//     return _searchBar;
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
     SearchShopViewController *vc = [SearchShopViewController new];
     vc.hidesBottomBarWhenPushed = YES;
     [self.navigationController pushViewController:vc animated:NO];
     return NO;
}


-(void)setLeftNav{
     
     
     _cityBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, 50, 36)];
     [_cityBtn fitImgAndTitleMode];
     _cityBtn.customTitleLb.text = busiSystem.agent.cityName?:@"位置";
     _cityBtn.customTitleLb.font = [UIFont systemFontOfSize:12];
     _cityBtn.customTitleLb.x =  0;
     _cityBtn.customTitleLb.y = 0;
     _cityBtn.customTitleLb.height = _cityBtn.height;
     _cityBtn.customTitleLb.width = 40;
     _cityBtn.customTitleLb.textAlignment = NSTextAlignmentCenter;
     _cityBtn.customTitleLb.textColor = kUIColorFromRGB(color_3);
     
     _cityBtn.customImgV.image = [UIImage imageNamed:@"icon_arrow_down"];
     _cityBtn.customImgV.x = 40;
     _cityBtn.customImgV.y = _cityBtn.height/2.0 - 3;;
     _cityBtn.customImgV.width = 10;
     _cityBtn.customImgV.height = 6;
     
//     [_cityBtn setImage:[UIImage imageNamed:@"icon_arrow_down"] forState:UIControlStateNormal];
//     [_cityBtn setTitle:@"福州市" forState:UIControlStateNormal];
//     _cityBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//     [_cityBtn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
     [_cityBtn addTarget:self action:@selector(choseCityAction) forControlEvents:UIControlEventTouchUpInside];
     // 重点位置开始
//     _cityBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 35, 0, -35);
//     _cityBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 25);
     
     [self setNavigateLeftView:_cityBtn view1:nil];
     
}


-(void)toZoneVC
{
     __weak ShopViewController *weakSelf = self;
     //    [_menuView fitMyServerApplyMode:YES];
     self.zoneVC = (ZoneChoseViewController*)[ZoneChoseViewController toTypeVC];
     self.zoneVC.dataArr = busiSystem.indexManager.cityList;
     self.zoneVC.cancelAction = ^(){
          //        [weakSelf.menuView fitMyServerApplyMode:NO];
     };
     self.zoneVC.handleAction = ^(NSDictionary *dic){
          [weakSelf.zoneVC.parentDialog dismiss];
          BUOpenCity *city = dic[@"title"];
          //        CGSize size = [pk.name size:weakSelf.navBtn.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
          //        size.width += 20;
          busiSystem.agent.cityName = city.cityName;
          busiSystem.agent.cityId = city.cityId;
         _cityBtn.customTitleLb.text = busiSystem.agent.cityName?:@"位置";
     };
}

-(void)choseCityAction{
     NSLog(@"chose city");
//     CityChoiceViewController *vc = [CityChoiceViewController new];
//     [self.navigationController pushViewController:vc animated:YES];
//     [vc setHandleGoBack:^(NSDictionary *dic){
//          [_cityBtn setTitle:dic[@"name"] forState:UIControlStateNormal];
//          busiSystem.agent.cityName = dic[@"name"];
//          busiSystem.agent.log = nil;
//          busiSystem.agent.lat = nil;
//          HUDSHOW(@"加载中");
//          _requestCount ++;
//          [self getHotData];
//     }];
     [self toZoneVC];
}




-(void)addSearchBar{
//    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(15, 10,__SCREEN_SIZE.width-30, 33)];
//    searchBar.placeholder = @"搜索商品";
////    searchBar.backgroundColor = kUIColorFromRGB(color_4);
//    [searchBar setSearchFieldBackgroundImage:[[UIImage imageNamed:@"searchBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
//    searchBar.delegate = self;
//    searchBar.barTintColor = kUIColorFromRGB(color_4);
//    searchBar.backgroundColor=[UIColor clearColor];
//    searchBar.layer.borderWidth = 1;
//    searchBar.layer.borderColor = kUIColorFromRGB(color_4).CGColor;
//    [self.view addSubview:searchBar];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10,__SCREEN_SIZE.width-30, 33)];
    [btn setTitle:@"搜索商品" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    btn.backgroundColor = kUIColorFromRGB(color_4);
    [btn setTitleColor:kUIColorFromRGB(color_5) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.view.backgroundColor = kUIColorFromRGB(color_9);
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}




#pragma mark - tableView

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
     if (indexPath.section == 0) {
          cell = indexPath.row == 0 ?_flashCell:_classifyCell;
     }else{
          cell = [ImgTableViewCell dequeueReusableCell:tableView];
          BUActivity *act = _tableView.dataArr[indexPath.section -1];
          [(ImgTableViewCell *)cell setCellData:@{@"img":act.imagePath?:@"defaultBanner",@"default":@"defaultBanner",@"type":@(act.type)}];
          [(ImgTableViewCell *)cell fitshopMode];
          
     }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1+_tableView.dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 1;
     if (section == 0) {
          row  = 2;
     }


    return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

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
              height = __SCREEN_SIZE.width * 306/720.0;
         }else{
              height = 180;
         }
        
    }

    else
    {
        height =  __SCREEN_SIZE.width * 290/720.0;
    }
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     if (indexPath.section>0) {
          BUActivity *act = _tableView.dataArr[indexPath.section -1];
          CommonWebViewViewController *vc = [CommonWebViewViewController setWebViewController:act.name?:@"" withUrl:act.url];
          vc.hidesBottomBarWhenPushed = YES;
          [self.navigationController pushViewController:vc animated:YES];
     }
}

-(void)refreshCurentPage{
     _tableView.isRefreshing = YES;
     [self getData];
}

@end
