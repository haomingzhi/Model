//
//  SelectStreetViewController.m
//  chenxiaoer
//
//  Created by sunmax on 16/3/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "SelectStreetViewController.h"
#import "SelectStreetTableViewCell.h"
#import "BUSystem.h"
#import "CityChoiceViewController.h"
#import "BUMapAddress.h"

@interface SelectStreetViewController ()
{
    MAMapView * _mapView;
    __weak IBOutlet UIButton *_positioningBtn;
    __weak IBOutlet UITableView *_myTableView;
    __weak IBOutlet UISearchBar *_mySearchBar;
     AMapSearchAPI *_search;
    NSArray * _poiList;//附近信息
    NSMutableArray * _searchList;//搜索结果
    BOOL _locationSuccess;//定位是否成功
    UISearchDisplayController *searchDisplayController;
    CLLocationCoordinate2D coordinate;//定位经纬度
    NSString * lat;//选中的经纬度
    NSString * lon;
    BUMapAddress *address;
    NSString * myCity;
    BOOL _selectSearch;
    UIButton *_cityBtn;
    BOOL _searchBtnClick;//searchbar 按搜索按钮
    NSInteger _geoState; //0:编码 1:反编码
    BOOL _isSelectCell;//选择具体地址 点击cell
     AMapReGeocodeSearchResponse *_reGeocodeSearchResponse;//反编码搜索结果
}
//@property (nonatomic, strong) mase *searcher;
@end

@implementation SelectStreetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"地图定位";
    _selectSearch = YES;
    address =[BUMapAddress new];
    address.area = @"";//busiSystem.adressManager.address.area;
    [self setNavigateRightButton:@"完成" font:[UIFont systemFontOfSize:14] color:kUIColorFromRGB(color_3)];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
     AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
     
     regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
     regeo.requireExtension            = YES;
    
     _search = [[AMapSearchAPI alloc] init];
     _search.delegate = self;
      [self initView];
      [self addSearchBar];
     
     
     _locationManager = [AMapLocationManager new];
     // 带逆地理信息的一次定位（返回坐标和地址信息）
     [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
     //   定位超时时间，最低2s，此处设置为10s
     self.locationManager.locationTimeout =5;
     //   逆地理请求超时时间，最低2s，此处设置为10s
     self.locationManager.reGeocodeTimeout = 5;
     HUDSHOW(@"定位中");
    [self locate];
     
    
     
    
}




- (void)locate{
     
    
     
     // 带逆地理（返;回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
     [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
     
          if (error)
          {
               NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
               
//               if (error.code == AMapLocationErrorLocateFailed)
//               {
                    HUDCRY(error.localizedDescription, 2);
                    return;
//               }
          }
          
          HUDDISMISS;
          _locationSuccess = YES;
          if (regeocode)
          {
               NSLog(@"reGeocode:%@", regeocode);
               _mapView.centerCoordinate = location.coordinate;
               coordinate = location.coordinate;
               NSLog(@"location:%@", location);
               [self ReGoecodeSearch:coordinate];
               address.Lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
               address.lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
               address.city = regeocode.city;
               address.province = regeocode.province;
               address.district = regeocode.district;
               address.street = regeocode.street;
               address.address = regeocode.formattedAddress;
          }
     }];
}


#pragma mark  map delegate

-(void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
     if (_locationSuccess) {
          [self ReGoecodeSearch:mapView.centerCoordinate];
     }
     
}


-(void)ReGoecodeSearch:(CLLocationCoordinate2D)coor{
     AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
     
     regeo.location                    = [AMapGeoPoint locationWithLatitude:coor.latitude longitude:coor.longitude];
     regeo.requireExtension            = YES;
     [_search AMapReGoecodeSearch:regeo];
}

#pragma mark  /* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
     if (response.regeocode != nil)
     {
          //解析response获取地址描述，具体解析见 Demo
          _reGeocodeSearchResponse = response;
          address.province = response.regeocode.addressComponent.province;
          address.city = response.regeocode.addressComponent.city;
          address.area = response.regeocode.addressComponent.district;
          _poiList = [NSMutableArray arrayWithArray:response.regeocode.pois];
          [_myTableView reloadData];
     }
}

/* 逆地理编码解析失败. */

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
     NSLog(@"Error: %@", error);
     HUDCRY(error.domain, 2);
}

-(void)addSearchBar
{
    _mySearchBar.width = __SCREEN_SIZE.width;
     _mySearchBar.height = 56;
//    _mySearchBar.scopeBarBackgroundImage = [UIImage imageNamed:@""];
//    [self.view bringSubviewToFront:_mySearchBar];
    
    //    _mySearchBar.backgroundColor = [UIColor clearColor];
//    UITextField *searchField=[_mySearchBar valueForKey:@"_searchField"];
//    
//    searchField.backgroundColor = [UIColor clearColor];
//    //    searchField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:@"ic_map_topbar_search"]];
//    //    searchField.background = [UIImage imageNamed:@"ic_map_topbar_search"];
//    //    改变searcher的textcolor
//    searchField.borderStyle = UITextBorderStyleRoundedRect;
//    //        searchField.background = [UIImage imageNamed:@"ic_top"];
//    searchField.layer.cornerRadius = 4.0;
//    searchField.leftViewMode=UITextFieldViewModeNever;
//    searchField.textColor= kUIColorFromRGB(color_1);
    
//    _cityBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
//    [_cityBtn setImage:[UIImage imageNamed:@"icon_address_map"] forState:UIControlStateNormal];
//    [_cityBtn setTitle:@"福州市>" forState:UIControlStateNormal];
//    [_cityBtn setTitleColor:kUIColorFromRGB(color_1) forState:UIControlStateNormal];
//    _cityBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    _cityBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
//    _cityBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
//    [_cityBtn addTarget:self action:@selector(choseCityAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_cityBtn];
    
    _mySearchBar.delegate = self;
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:_mySearchBar contentsController:self];
//    UIView *segment =[_mySearchBar.subviews objectAtIndex:0];
//    [segment removeFromSuperview];
//    _mySearchBar.backgroundColor =[UIColor whiteColor];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
}

-(void)choseCityAction:(UIButton *)sender{
    __weak SelectStreetViewController *weakSelf = self;
    CityChoiceViewController *vc = [CityChoiceViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    [vc setHandleGoBack:^(NSDictionary *dic){
        // name aid
        
        _selectSearch = YES;
        [_cityBtn setTitle:[NSString stringWithFormat:@"%@>",dic[@"name"]] forState:UIControlStateNormal];
        [weakSelf geoSearch:dic[@"name"]];
        address.area = dic[@"name"];
        address.address =dic[@"name"];
    }];
    
}

-(void)geoSearch:(NSString *)cityName{
//    _geocodesearch =[[BMKGeoCodeSearch alloc]init];
//    _geocodesearch.delegate = self;
//    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
//    geoCodeSearchOption.city= cityName;
//    geoCodeSearchOption.address =cityName;
//    _geoState =0;
//    BOOL flag = [_geocodesearch geoCode:geoCodeSearchOption];
//    if(flag)
//    {
//        NSLog(@"geo检索发送成功");
//    }
//    else
//    {
//        NSLog(@"geo检索发送失败");
//    }

}


#pragma UISearchDisplayDelegate

//-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
//    if (!_searchBtnClick) {
//        _mySearchBar.x =100;
//        _mySearchBar.width = __SCREEN_SIZE.width - 100;
//        _cityBtn.hidden = NO;
//    }
//    _searchBtnClick = NO;
//}
//
//
//-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    _mySearchBar.x =0;
//    _mySearchBar.width = __SCREEN_SIZE.width;
//    _cityBtn.hidden = YES;
//    return YES;
//}
//
//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
//    _searchBtnClick = YES;
//}
//
//-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//    _mySearchBar.x =100;
//    _mySearchBar.width = __SCREEN_SIZE.width - 100;
//    _cityBtn.hidden = NO;
//}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {
        return;
    }
     AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
     
     request.keywords            = searchText;
     request.city                = address.city;
     request.requireExtension    = YES;
     request.offset  = 50;
     /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
     request.cityLimit           = YES;
     request.requireSubPOIs      = NO;
     [_search AMapPOIKeywordsSearch:request];
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
     if (response.pois.count == 0)
     {
          return;
     }
     
     _searchList = [NSMutableArray arrayWithArray:response.pois];
     [self.searchDisplayController.searchResultsTableView reloadData];
     
     
}



-(void)viewWillAppear:(BOOL)animated {
//    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放

}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

-(void)viewWillDisappear:(BOOL)animated {
//    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

#pragma mark --- locationDelegate
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
//    CLLocation *currentLocation = [locations lastObject];
//    CLLocationCoordinate2D coor = currentLocation.coordinate;
//    //转换 google地图、soso地图、aliyun地图、mapabc地图和amap地图所用坐标至百度坐标
//    NSDictionary* testdic = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_COMMON);
//    //转换GPS坐标至百度坐标(加密后的坐标)
//    testdic = BMKConvertBaiduCoorFrom(coor,BMK_COORDTYPE_GPS);
//    NSLog(@"x=%@,y=%@",[testdic objectForKey:@"x"],[testdic objectForKey:@"y"]);
//    //解密加密后的坐标字典
//    baiduCoor = BMKCoorDictionaryDecode(testdic);//转换后的百度坐标
//    if (_locationSuccess==NO) {
//        
//        _coordinate2D =baiduCoor;
//        [self geoGo];
//        [_locationManager stopUpdatingLocation];
//    }
//}

#pragma mark --- Method
//- (void)geoGo//反编译地理位置
//{
//
//    QMSReverseGeoCodeSearchOption *regeocoder = [[QMSReverseGeoCodeSearchOption alloc] init];
//    NSString *location = [NSString stringWithFormat:@"%f,%f",_mapView.centerCoordinate.latitude,_mapView.centerCoordinate.longitude];
//
//    [regeocoder setLocation:location];
//    //返回坐标点附近poi列表
//    [regeocoder setGet_poi:YES];
//    //设置坐标所属坐标系，以返回正确地址，默认为腾讯所用坐标系
////    [regeocoder setCoord_type:QMSReverseGeoCodeCoordinateTencentGoogleGaodeType];
//    QMSSearchOperation *operation =  [self.searcher searchWithReverseGeoCodeSearchOption:regeocoder];
//    [operation start];
//
//}

//逆地理解析(坐标位置描述)结果回调接口
//- (void)searchWithReverseGeoCodeSearchOption:(QMSReverseGeoCodeSearchOption *)reverseGeoCodeSearchOption didReceiveResult:(QMSReverseGeoCodeSearchResult *)reverseGeoCodeSearchResult{
//    if (reverseGeoCodeSearchResult.address != nil) {
//        _poiList = [NSArray arrayWithArray:reverseGeoCodeSearchResult.poisArray];
//        _reverseGeoCodeSearchResult = reverseGeoCodeSearchResult;
//        [_myTableView reloadData];
//        NSLog(@"geo succcess %lu",(unsigned long)_poiList.count);
//    }
//
//}

////地址解析(地址转坐标)结果回调接口
//- (void)searchWithGeoCodeSearchOption:(QMSGeoCodeSearchOption *)geoCodeSearchOption
//                     didReceiveResult:(QMSGeoCodeSearchResult *)geoCodeSearchResult{
//
//}


#pragma mark --- View
- (void)initView
{
     ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
     [AMapServices sharedServices].enableHTTPS = YES;
//    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 56, __SCREEN_SIZE.width,(__SCREEN_SIZE.height-64 )/2.0+64)];//
      _mapView = [[MAMapView alloc]initWithFrame:self.view.frame];
     _mapView.y = 56;
     _mapView.height = (__SCREEN_SIZE.height-64 )/2.0+64;
    //地图平移，默认YES
    _mapView.scrollEnabled = YES;
    //地图缩放，默认YES
    _mapView.zoomEnabled = YES;
    //比例尺是否显示，ƒF默认YES
//    _mapView.showsScale = YES;
    _mapView.delegate = self;
//    _mapView.keepCenterEnabled = YES;
//    _mapView.visibleMapRect = QMapRectMake(0, 0, _mapView.width, _mapView.height);
    [_mapView setZoomLevel:14];
    [self.view addSubview:_mapView];
     
  
     
     ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
     _mapView.showsUserLocation = YES;
     _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 20)];
    imgView.image =[UIImage imageNamed:@"redLocate"];
    imgView.center = CGPointMake(_mapView.center.x, _mapView.center.y-32);
    [self.view addSubview:imgView];
    
     
     
  
    
    //    self.view = _mapView;
    _positioningBtn.frame =CGRectMake(__SCREEN_SIZE.width -_positioningBtn.width-20,(__SCREEN_SIZE.height-64 )/2.0-40, _positioningBtn.width, _positioningBtn.width);
    [_mapView addSubview:_positioningBtn];
     
     if (__SCREEN_SIZE.width ==  320) {
         
          _myTableView.frame =CGRectMake(0, _mapView.height+_mapView.y-64, __SCREEN_SIZE.width, self.view.frame.size.height -_mapView.height-44-64-56);
           _mapView.height = 400;
          
     }else{
          _myTableView.frame =CGRectMake(0, _mapView.height+_mapView.y-64, __SCREEN_SIZE.width, self.view.frame.size.height -_mapView.height-56);
     }
     
    _myTableView.delegate =self;
    _myTableView.dataSource =self;
    _myTableView.width = __SCREEN_SIZE.width;
    [_myTableView registerNib:[UINib nibWithNibName:@"SelectStreetTableViewCell" bundle:nil] forCellReuseIdentifier:@"SelectStreetTableViewCell"];
//    [self setExtraCellLineHidden:_myTableView];
}
#pragma mark --Action
//右边按钮事件
-(void)handleDidRightButton:(id)sender
{
//    address.lat =lat;
//    address.lon =lon;
//    busiSystem.adressManager.address.city =address.city;
//    busiSystem.adressManager.address.area =address.area;
//    busiSystem.adressManager.address.adress =address.adress;
//    busiSystem.adressManager.address.Lon =address.Lon;
//    busiSystem.adressManager.address.lat =address.lat;
//    busiSystem.adressManager.address =address;
     
     if (address.Lon.length == 0) {
          HUDCRY(@"请选择地址", 2);
          return;
     }
     
//     if (_isCheck) {
//          [self validateAddress];
//          return;
//     }
//
     
    [self.navigationController popViewControllerAnimated:YES];
    if (self.handleGoBack) {
        self.handleGoBack(@{@"address":address?:[BUMapAddress new]});
    }
    NSLog(@"1");
}


-(void)validateAddress{
//     HUDSHOW(@"加载中");
//     NSString *log = [NSString stringWithFormat:@"%f",address.longitude];
//     NSString *lat = [NSString stringWithFormat:@"%f",address.latitude];
//     [busiSystem.userManager validateAddress:busiSystem.agent.storeId log:address.Lon lat:address.lat observer:self callback:@selector(validateAddressNotification:) extraInfo:@{@"obj":address?:[BUMapAddress new]}];
}


-(void)validateAddressNotification:(BSNotification *)noti
{
     
     if (noti.error.code == 0) {
          HUDDISMISS;
          [self.navigationController popViewControllerAnimated:YES];
          if (self.handleGoBack) {
//               self.handleGoBack(@{@"address":address?:[BUAddress new]});
          }
     }
     else
     {
          HUDCRY(noti.error.domain, 2);
     }
}

//定位事件
- (IBAction)positioningButtonAction:(id)sender {
    
    _locationSuccess = YES;
    if (coordinate.latitude !=0) {
        _mapView.centerCoordinate = coordinate;
        return;
    }
    // 开始定位
    [self locate];
}

#pragma mark --- TableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
//        return busiSystem.citySearch.result.count;
        return _searchList.count;
    }
    return _poiList.count+1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (tableView == self.searchDisplayController.searchResultsTableView)
//    {
//        return 0;
//    }
//    return 44;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        NSString * str;
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if (_searchList.count==0) {
            str =@"";
        }
        else{
            AMapPOI *p =_searchList[indexPath.row];
            str =p.name;
        }
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
        cell.textLabel.attributedText = AttributedStr;
        cell.separatorInset =UIEdgeInsetsMake(0, 13, 0, 13);
        return cell;
    }
    else{
        SelectStreetTableViewCell *sCell =[tableView dequeueReusableCellWithIdentifier:@"SelectStreetTableViewCell"];
        sCell.separatorInset =UIEdgeInsetsMake(0, 13, 0, 13);
        if (indexPath.row==0) {
//            if (_selectSearch ==YES) {
//                [sCell setCell:_bmkR.address street:@""];
//                _selectSearch =NO;
//            }
//            else{
                [sCell setCell:address.street street:@""];
//            }
    //        sCell.separatorInset =UIEdgeInsetsMake(0, -13, 0, -13);
            sCell.street.hidden=YES;
            sCell.geograhicalNames.y =(sCell.height-sCell.geograhicalNames.height)/2;
            sCell.img.hidden=NO;
            return sCell;
        }
        else{
            AMapPOI *poiInfo =_poiList[indexPath.row-1];
            sCell.img.hidden=YES;
            sCell.street.hidden =NO;
            sCell.geograhicalNames.y =2;
            [sCell setCell:poiInfo.name street:poiInfo.address];
            return sCell;
        }
    //    BMKPoiSearchType *poi =[BMKPoiSearchType new];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        _selectSearch = YES;
        AMapPOI *poiInfo =_searchList[indexPath.row];
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(poiInfo.location.latitude, poiInfo.location.longitude);
        [_myTableView reloadData];
        [self.searchDisplayController setActive:NO animated:YES];
    }
    else{
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        if (indexPath.row==0) {
            return;
        }
        else{
            AMapPOI *poiInfo =_poiList[indexPath.row-1];
            _isSelectCell = YES;
            _mapView.centerCoordinate = CLLocationCoordinate2DMake(poiInfo.location.latitude, poiInfo.location.longitude);
//             address.province = poiInfo.province;
//           address.city = poiInfo.city;
//              address.area = poiInfo.district;
            address.address = poiInfo.address;
             address.street = poiInfo.address;
            address.lat =[NSString stringWithFormat:@"%f",poiInfo.location.latitude];
            address.Lon =[NSString stringWithFormat:@"%f",poiInfo.location.longitude];
            lat =[NSString stringWithFormat:@"%f",poiInfo.location.latitude];
            lon =[NSString stringWithFormat:@"%f",poiInfo.location.longitude];
            [_myTableView reloadData];
        }
    }
    
//    busiSystem.adressManager.address.lat =lat;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

#pragma mark --- GeoDelegate
/*
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
//    if (_geoState == 1) {//反编码
//        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
//        [_mapView removeAnnotations:array];
//        array = [NSArray arrayWithArray:_mapView.overlays];
//        [_mapView removeOverlays:array];
//        if (error == 0) {
//            //        _poiList =result.poiList;
//            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
//            item.coordinate = result.location;
//            item.title = result.address;
//            _mapView.centerCoordinate = result.location;
//            //        [_mapView addAnnotation:item];
//            //        if (_locationSuccess==NO) {
//            //            _locationSuccess=YES;
//            //            _mapView.centerCoordinate = result.location;
//            //        }
//            [_myTableView reloadData];
//            
//
//        }
//
//    }else{//编码 0
        if (error == BMK_SEARCH_NO_ERROR) {
            //在此处理正常结果
            _mapView.centerCoordinate = result.location;
            
        }
        else {
            NSLog(@"抱歉，未找到结果");
        }
//    }
    
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    myCity =result.addressDetail.city;
    [_mapView removeOverlays:array];
    if (error == 0) {
        if (_selectSearch ==YES) {
            _bmkR =result;
            address.city =result.addressDetail.city;
            address.area =result.address;
            address.province = result.addressDetail.province;
            address.district = result.addressDetail.district;
            address.lat =[NSString stringWithFormat:@"%f",result.location.latitude];
            address.Lon =[NSString stringWithFormat:@"%f",result.location.longitude];
            _selectSearch = NO;
        }
        _poiList =result.poiList;
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        //        [_mapView addAnnotation:item];
        if (_locationSuccess==NO) {
            _locationSuccess=YES;
            _mapView.centerCoordinate = result.location;
        }
        [_myTableView reloadData];
        [_cityBtn setTitle:[NSString stringWithFormat:@"%@>",result.addressDetail.city] forState:UIControlStateNormal];
    }
}
*/
#pragma mark --- MapViewDelegate

//-(void)mapView:(QMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//    _mapView.frame = CGRectMake(0, 44, __SCREEN_SIZE.width,(__SCREEN_SIZE.height-64 )/2.0);
//    NSString* showmeg = [NSString stringWithFormat:@"地图区域发生了变化(x=%d,y=%d,\r\nwidth=%d,height=%d).\r\nZoomLevel=%d;",(int)_mapView.visibleMapRect.origin.x,(int)_mapView.visibleMapRect.origin.y,(int)_mapView.visibleMapRect.size.width,(int)_mapView.visibleMapRect.size.height,(int)_mapView.zoomLevel];
//    NSLog(@"%@",showmeg);
//    _coordinate2D = _mapView.centerCoordinate;
//    if (!_isSelectCell) {
//        _selectSearch = YES;
//        
//    }else{
//        _isSelectCell = NO;
//    }
//   [self geoGo];
//}


////根据anntation生成对应的View
//- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
//{
//    NSString *AnnotationViewID = @"annotationViewID";
//    //根据指定标识查找一个可被复用的标注View，一般在delegate中使用，用此函数来代替新申请一个View
//    BMKAnnotationView *annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
//    if (annotationView == nil) {
//        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
//        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
//        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
//    }
//    
//    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
//    annotationView.annotation = annotation;
//    annotationView.canShowCallout = TRUE;
//    return annotationView;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
