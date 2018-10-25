//
//  CityChoiceViewController.m
//  ulife
//
//  Created by sunmax on 16/1/7.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "CityChoiceViewController.h"
#import "ChineseString.h"
#import "BUSystem.h"
#import "DKView.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "TabViewControllerManager.h"
//#import "BUSerArea.h"
#import "BUArea.h"
#import "NoOpenCityViewController.h"

@interface CityChoiceViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,CLLocationManagerDelegate>
{
    __weak IBOutlet UITableView *_myTableView;
    DKView *dKv;
    NSArray * _cityArr;
    __weak IBOutlet UIButton *_cityNameBtn;
    __weak IBOutlet UILabel *cityName;
    __weak IBOutlet UISearchBar *_searchBar;
    UISearchDisplayController *searchDisplayController;
    NSMutableArray *dataArray;
    NSMutableArray *searchResults;
    NSMutableArray *_threeCity;
    BUAreaManager * _Area;
    __weak IBOutlet UIActivityIndicatorView *_activity;
    CLLocationManager *_locationManager;
    __weak IBOutlet UIButton *_HotCityOne;
    __weak IBOutlet UIButton *_HotCityFile;
    __weak IBOutlet UIButton *_HotCityThree;
    __weak IBOutlet UIButton *_HotCityTwo;
    NSString * _cityName;//选中的城市名
}
@property(nonatomic,strong)NSMutableArray *indexArray;//索引数组
@property(nonatomic,strong)NSMutableArray *indexArray1;//索引数组
@property(nonatomic,strong)NSMutableArray *letterResultArr;//获取本地所有数据
@property(nonatomic,strong)NSMutableArray *informationmArr;//存放人名
@end

@implementation CityChoiceViewController
NSMutableArray *addressBookTemp;
- (void)viewDidLoad {
    [super viewDidLoad];
    _Area =[BUAreaManager new];
    [_activity startAnimating]; // 开始旋转
    cityName.hidden=YES;
    _cityNameBtn.hidden =YES;
    [_activity setHidesWhenStopped:YES]; //当旋转结束时隐藏
    _myTableView.delegate =self;
    _myTableView.dataSource =self;
    self.navigationController.navigationBarHidden=NO;
    [self locate];
    [self hotCityButtonUI];
//    if (busiSystem.agent.cityName.length ==0){
//        [dKv locate];
//    }
   // [busiSystem.serAreaManager getSerAreaInfoWithObserver:self callback:@selector(getSerAreaInfoWithCityNofification:)];
//    HUDSHOW(@"加载中");
//    [busiSystem.agent getBespokeCity:self callback:@selector(getSerAreaInfoWithCityNofification:)];
    _threeCity =[NSMutableArray new];
    self.title =@"选择城市";
    dataArray =[NSMutableArray new];
    addressBookTemp = [NSMutableArray array];
    _informationmArr = [NSMutableArray new];
    _indexArray1 = [NSMutableArray new];
    _myTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self initBtn];
    // Do any additional setup after loading the view from its nib.
//    _myTableView.backgroundColor = kUIColorFromRGB(color_9);
    
    self.view.backgroundColor = kUIColorFromRGB(color_9);
    _myTableView.backgroundColor = kUIColorFromRGB(color_9);
    _myTableView.sectionIndexColor = kUIColorFromRGB(color_5);
    [self.navigationController.view setBackgroundColor:kUIColorFromRGB(color_4)];
    

}

-(void)initBtn
{
    _HotCityOne.layer.cornerRadius = 4;
    _HotCityOne.layer.masksToBounds = YES;
    _HotCityOne.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    _HotCityOne.backgroundColor = kUIColorFromRGB(color_4);
    
    _HotCityTwo.layer.cornerRadius = 4;
    _HotCityTwo.layer.masksToBounds = YES;
    _HotCityTwo.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    _HotCityTwo.backgroundColor = kUIColorFromRGB(color_4);
    
    _HotCityThree.layer.cornerRadius = 4;
    _HotCityThree.layer.masksToBounds = YES;
    _HotCityThree.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    _HotCityThree.backgroundColor = kUIColorFromRGB(color_4);
    
    _HotCityFile.layer.cornerRadius = 4;
    _HotCityFile.layer.masksToBounds = YES;
    _HotCityFile.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    _HotCityFile.backgroundColor = kUIColorFromRGB(color_4);
    
    _cityNameBtn.layer.borderColor = kUIColorFromRGB(color_5).CGColor;
    _cityNameBtn.backgroundColor = kUIColorFromRGB(color_4);
    
//    _cityNameBtn.layer.cornerRadius = 4;
//    _cityNameBtn.layer.masksToBounds = YES;
}

-(void)getSerAreaInfoWithCityNofification:(BSNotification*)noti
{
    BASENOTIFICATION(noti);
    NSMutableArray *mArr =[NSMutableArray new];
    for (int i=0; i<busiSystem.agent.cityArr.count; i++)
    {
        BUBespokeCity *area =busiSystem.agent.cityArr[i];
        [mArr addObject:area];
        [dataArray addObject:area.name];
    }
    _cityArr =mArr;
    NSArray *stringsToSort= mArr;
    self.indexArray = [ChineseString IndexArray:stringsToSort];
    self.letterResultArr = [ChineseString LetterSortArray:stringsToSort];
    [self tableView:_myTableView sectionForSectionIndexTitle:@"Z" atIndex:26];
    [self addSearchBar];
    [_myTableView reloadData];
}

-(void)getSerAreaInfoWithCitysNofification:(BSNotification*)noti
{
    BASENOTIFICATION(noti);
    
  /*  if (busiSystem.serAreaManager._isSerArea ==YES) {
        if (_istabBarController) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshNavLeftBtn" object:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NOdatasViewController *noDt =[NOdatasViewController new];
        noDt.title =_cityName;
        noDt.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:noDt animated:YES];
        return;
    }*/
    
}

#pragma mark --- locate(定位)
- (void)locate{
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        //定位初始化
        _locationManager=[[CLLocationManager alloc] init];
        _locationManager.delegate=self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=10;
        if (IS_IOS8) {
            [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
        }
        //        [_locationManager startUpdatingLocation];//开启定位
        //        [_locationManager startUpdatingLocation];//开启定位
    }else {
        //提示用户无法进行定位操作
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    // 开始定位
    [_locationManager startUpdatingLocation];
}

#pragma mark location delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //NSLog(@%@,placemark.name);//具体位置
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             NSLog(@"定位完成:%@",city);
             //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
             [manager stopUpdatingLocation];
             [_activity stopAnimating]; // 结束旋转
             CGSize size =[self detailSizeTitle:city size:17 flo:self.view.frame.size.width];
//             _cityNameBtn.titleLabel.text =city;
             [_cityNameBtn setTitle:city forState:0];
             cityName.text =city;
             _cityNameBtn.width =size.width+15;
             [_cityNameBtn corner:kUIColorFromRGB(color_5) radius:4];
             _cityNameBtn.hidden=NO;
                          //             cityName = city;
         }else if (error == nil && [array count] == 0)
         {
             HUDCRY(@"定位失败", 2);
             CGSize size =[self detailSizeTitle:@"定位失败" size:17 flo:self.view.frame.size.width];
//             cityName.text =@"定位失败";
             [_cityNameBtn setTitle:@"定位失败" forState:0];
//             _cityNameBtn.titleLabel.text =;
             _cityNameBtn.width =size.width+15;
             [_cityNameBtn corner:kUIColorFromRGB(color_5) radius:4];
             _cityNameBtn.hidden=NO;
             [_activity stopAnimating]; // 结束旋转
             NSLog(@"No results were returned.");
         }else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
             HUDCRY(@"定位失败", 2);
             CGSize size =[self detailSizeTitle:@"定位失败" size:17 flo:self.view.frame.size.width];
//             cityName.text =@"定位失败";
             [_cityNameBtn setTitle:@"定位失败" forState:0];
             _cityNameBtn.width =size.width+15;
             [_cityNameBtn corner:kUIColorFromRGB(color_5) radius:4];
             _cityNameBtn.hidden=NO;
         }
     }];
}

-(NSString *)cityName:(NSString *)cityName
{
    NSString *city;
    return city;
}

#pragma mark - View
-(void)hotCityButtonUI
{
    for (int i=0; i<4; i++) {
        UIButton *btn =[self.view viewWithTag:300+i];
        CGSize size =[self detailSizeTitle:btn.titleLabel.text size:17 flo:self.view.frame.size.width];
//        btn.titleLabel.text =city;
//        cityName.text =city;
        btn.width =size.width;
        btn.x=86+btn.width*i+i*5;
        
        [btn corner:[UIColor colorWithWhite:0.906 alpha:1.000] radius:1];
    }
}

-(void)addSearchBar
{
    _searchBar.delegate = self;
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    searchDisplayController.searchResultsTableView.backgroundColor = kUIColorFromRGB(color_4);
    
}


-(void)addDKviewCityArr:(NSArray *)cityArr
{
    dKv=[[DKView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height)cityArr:cityArr];
    dKv.tag =100;
    __weak DKView *dk =dKv;
    __weak NSMutableArray *mArr =_threeCity;
    dKv.switchCity =^(){
        dk.hidden=YES;
    };
    dKv.citycChoiceView.hidden =YES;
    __weak BaseTableViewController *tCV =self;
    dKv.data =^(DKFilterModel* data,NSMutableArray *mArr1){
        //选中的城市
        NSLog(@"%@",data.clickedButtonText);
    };
    if (_istabBarController==YES) {
        [self.tabBarController.view addSubview:dKv];
    }
    else{
        [self.view addSubview:dKv];
    }
    
}

#pragma mark --Action
- (IBAction)hotCityButtonAction:(UIButton *)sender {
    NSString * str1 =sender.titleLabel.text;
    if (sender.tag ==299) {
        if ([sender.titleLabel.text isEqualToString:@"定位失败"]) {
            return;
        }
        else{
            _cityName =str1;
            for (BUBespokeCity *city in busiSystem.agent.cityArr) {
                if ([city.name containsString:_cityName]) {
                    if (self.handleGoBack) {
                        self.handleGoBack(@{@"id":city.aid,@"name":city.name});
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                    return;
                }
            }
            NoOpenCityViewController *vc = [NoOpenCityViewController new];
            vc.title = _cityName;
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
    }else{
        _cityName =str1;
        for (BUBespokeCity *city in busiSystem.agent.cityArr) {
            if ([city.name containsString:_cityName]) {
                if (self.handleGoBack) {
                    self.handleGoBack(@{@"id":city.aid,@"name":city.name});
                }
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
        }
        NoOpenCityViewController *vc = [NoOpenCityViewController new];
        vc.title = _cityName;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    _cityName =str1;
  //  [busiSystem.serAreaManager getSerAreaInfoWithCity:str1 observer:self callback:@selector(getSerAreaInfoWithCitysNofification:)];
}



- (IBAction)loButtonAction:(id)sender {
    if (cityName.hidden==NO) {
        NSLog(@"1");
        NSMutableArray *mArr =[NSMutableArray new];
        [_threeCity removeAllObjects];
        _cityName = [(UIButton *)sender currentTitle];
        for (BUBespokeCity *city in busiSystem.agent.cityArr) {
            if ([city.name containsString:_cityName]) {
                if (self.handleGoBack) {
                    self.handleGoBack(@{@"id":city.aid,@"name":city.name});
                }
                return;
            }
        }
        NoOpenCityViewController *vc = [NoOpenCityViewController new];
        vc.title = _cityName;
        [self.navigationController pushViewController:vc animated:YES];
//        NSString *str1 =[cityName.text substringToIndex:cityName.text.length-1];//截取掉下标2之前的字符串
//        for (int i=0; i<_cityArr.count; i++){
//            BUAreaManager * area =[BUAreaManager new];
//            area.currentCity =_cityArr[i];
//            if ([area.currentCity.cityName isEqualToString:cityName.text]){
//                //            NSString *str =[NSString stringWithFormat:@"%@市",area.currentCity.cityName];
//                [mArr addObject:area.currentCity.cityName];
//                [_threeCity addObject:area.currentCity];
//                if ([area.currentCity.region_type isEqualToString:@"2"]){
//                    for (int j=0; j<area.currentCity.countys.count; j++) {
//                        BUAreaManager *area1 =[BUAreaManager new];
//                        area1.currentCity =area.currentCity.countys[j];
//                        [mArr addObject:area1.currentCity.cityName];
//                        [_threeCity addObject:area1.currentCity];
//                    }
//                    [self addDKviewCityArr:mArr];
//                    [_searchBar resignFirstResponder];
//                    return;
//                }
//                else
//                {
//#pragma mark -- 跳转无服务界面
//                    [busiSystem.agent hasBusiness:area.currentCity.cityId observer:self callback:@selector(hasBusinessNotification:)];
//                    _Area =area;
//                    return;
//                }
//            }
//            else if ([area.currentCity.cityName isEqualToString:str1])
//            {
//                if ([area.currentCity.cityName isEqualToString:str1]){
//                    //            NSString *str =[NSString stringWithFormat:@"%@市",area.currentCity.cityName];
//                    [mArr addObject:area.currentCity.cityName];
//                    [_threeCity addObject:area.currentCity];
//                    if ([area.currentCity.region_type isEqualToString:@"2"]){
//                        for (int j=0; j<area.currentCity.countys.count; j++) {
//                            BUAreaManager *area1 =[BUAreaManager new];
//                            area1.currentCity =area.currentCity.countys[j];
//                            [mArr addObject:area1.currentCity.cityName];
//                            [_threeCity addObject:area1.currentCity];
//                        }
//                        [self addDKviewCityArr:mArr];
//                        [_searchBar resignFirstResponder];
//                        return;
//                    }
//                    else
//                    {
//#pragma mark -- 跳转无服务界面
//                        [busiSystem.agent hasBusiness:area.currentCity.cityId observer:self callback:@selector(hasBusinessNotification:)];
//                        _Area =area;
//                        return;
//                    }
//                }
//            }
//        }
    }
}


#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchResults = [[NSMutableArray alloc]init];
    if (_searchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:_searchBar.text]) {
        for (int i=0; i<dataArray.count; i++) {
            if ([ChineseInclude isIncludeChineseInString:dataArray[i]]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:dataArray[i]];
                NSRange titleResult=[tempPinYinStr rangeOfString:_searchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:dataArray[i]];
                }
//                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:dataArray[i]];
//                NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:_searchBar.text options:NSCaseInsensitiveSearch];
//                if (titleHeadResult.length>0) {
//                    [searchResults addObject:dataArray[i]];
//                }
            }
            else {
                NSRange titleResult=[dataArray[i] rangeOfString:_searchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:dataArray[i]];
                }
            }
        }
    } else if (_searchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:_searchBar.text]) {
        for (NSString *tempStr in dataArray) {
            NSRange titleResult=[tempStr rangeOfString:_searchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [searchResults addObject:tempStr];
            }
        }
    }
}

#pragma mark - UITableViewDataSource

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
     if (tableView == self.searchDisplayController.searchResultsTableView)
     {
         return @[];
     }
    return self.indexArray;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSString *key = [self.indexArray objectAtIndex:section];
//    return key;
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 1;
    }
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return searchResults.count;
    }
    else {
        NSArray *arr =_letterResultArr[section];
        return arr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSString * str =searchResults[indexPath.row];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
        
//        NSString *str1= self.searchDisplayController.searchBar.text;
//        NSString *temp = nil;
//        for(int i =0; i < ([str length]-[str1 length]==0?1:[str length]-[str1 length]); i++)
//        {
//            temp = [str substringWithRange:NSMakeRange(i, str1.length)];
//            if ([temp isEqualToString:str1]) {
//                [AttributedStr addAttribute:NSForegroundColorAttributeName
//                 
//                                      value:[UIColor orangeColor]
//                 
//                                      range:NSMakeRange(i, str1.length)];
        cell.textLabel.attributedText = AttributedStr;
        cell.separatorInset =UIEdgeInsetsMake(0, 13, 0, 13);
//                return cell;
//            }
//        }
    }
    else {
        cell.textLabel.text = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.separatorInset =UIEdgeInsetsMake(0, 13, 0, 13);
        cell.contentView.backgroundColor = kUIColorFromRGB(color_4);
        cell.backgroundColor = kUIColorFromRGB(color_4);
    }
    
    cell.contentView.backgroundColor = kUIColorFromRGB(color_4);
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"%@   %ld",title,(long)index);
//    UILabel *lab = [[UILabel alloc] init];
//    for (int i=0; i<26; i++)
//    {
//        lab = (UILabel *)[self.view viewWithTag:i+100];
//        if (lab.text ==title)
//        {
//            return i;
//        }
//    }
//    NSInteger countIndex = 0;
//    for (int j=0; j<_indexArray1.count; j++)
//    {
//        if (title==_indexArray1[j])
//        {
//            countIndex =j;
//        }
//    }
//    NSInteger countIndex1 = 0;
//    for (int j=0; j<countIndex; j++)
//    {
//        for (int i=0; i<_indexArray.count; i++)
//        {
//            if (_indexArray1[j] == _indexArray[i])
//            {
//                countIndex1 =i;
//            }
//        }
//    }
    for (int i=0; i<_indexArray.count; i++) {
        if ([title isEqualToString:_indexArray[i]]) {
            return i;
        }
    }
    return 0;
//    return countIndex1+1;
}


- (BOOL)index:(NSString *)title
{
    
    return NO;
}
#pragma mark -
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 0;
    }
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, 15)];
    view.backgroundColor =self.view.backgroundColor;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, __SCREEN_SIZE.width, 15)];
    lab.tag =100+section;
    lab.backgroundColor = self.view.backgroundColor;
    lab.text = [self.indexArray objectAtIndex:section];
    lab.font =[UIFont systemFontOfSize:12];
    lab.textColor = [UIColor grayColor];
    [view addSubview:lab];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    for (int i=0; i<_cityArr.count; i++) {
        BUBespokeCity *area =_cityArr[i];
        if ([area.name isEqualToString:cell.textLabel.text]) {
            _cityName =area.name;
            if (self.handleGoBack) {
                self.handleGoBack(@{@"id":area.aid?:@"",@"name":area.name?:@""});
            }
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
    NoOpenCityViewController *vc = [NoOpenCityViewController new];
    vc.title = cell.textLabel.text;
    [self.navigationController pushViewController:vc animated:YES];
    return;
//    NSLog(@"---->%@",[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]);
//    NSString * cityName1;
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        cityName1 =searchResults[indexPath.row];
//    }
//    else{
//        cityName1 =[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
//    }
//    NSMutableArray *mArr =[NSMutableArray new];
//    [_threeCity removeAllObjects];
//    busiSystem.agent.LocationCityName =[self cityName:cityName1];
    
//    for (int i=0; i<_cityArr.count; i++){
//        BUAreaManager * area =[BUAreaManager new];
//        area.currentCity =_cityArr[i];
//        if ([area.currentCity.cityName isEqualToString:cityName1]){
//            [mArr addObject:area.currentCity.cityName];
//            [_threeCity addObject:area.currentCity];
//            if ([area.currentCity.region_type isEqualToString:@"2"]){
//                for (int j=0; j<area.currentCity.countys.count; j++) {
//                    BUAreaManager *area1 =[BUAreaManager new];
//                    area1.currentCity =area.currentCity.countys[j];
//                    [mArr addObject:area1.currentCity.cityName];
//                    [_threeCity addObject:area1.currentCity];
//                }
//                 [self addDKviewCityArr:mArr];
//                [_searchBar resignFirstResponder];
//                return;
//            }
//            else
//            {
//#pragma mark -- 跳转无服务界面
//                [busiSystem.agent hasBusiness:area.currentCity.cityId observer:self callback:@selector(hasBusinessNotification:)];
//                _Area =area;
//            }
//        }
//    }
}

-(void)hasBusinessNotification:(BSNotification *)noti
{ ISTOLOGIN;
//    BASENOTIFICATION(noti);
    if (noti.error.code ==0) {\
        HUDDISMISS;\
    }\
    else {
//        [self pushNoDataVC:_Area.currentCity.cityName];
        return;
    }
   
//    busiSystem.agent.Area =[_Area.currentCity.cityId integerValue];
//    busiSystem.agent.cityName =_Area.currentCity.cityName;
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"RefreshDiscover" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    [[NSUserDefaults standardUserDefaults]setObject:busiSystem.agent.cityName forKey:@"cityName"];
    [[NSUserDefaults standardUserDefaults]setObject:@(busiSystem.agent.Area) forKey:@"cityID"];
    [[NSUserDefaults standardUserDefaults]  synchronize];
      [self.navigationController popViewControllerAnimated:YES];
    if (_istabBarController==NO) {
         self.view.window.rootViewController =[TabViewControllerManager mainUI];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)pushNoDataVC:(NSString *)cityName
{
//    NOdatasViewController *noDt =[NOdatasViewController new];
//    noDt.title =cityName;
//    [self.navigationController pushViewController:noDt animated:YES];
}

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
