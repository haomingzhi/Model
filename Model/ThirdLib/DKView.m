//
//  DKView.m
//  chier
//
//  Created by sunmax on 15/12/25.
//  Copyright © 2015年 sunmax. All rights reserved.
//

#import "DKView.h"
#import "BUSystem.h"
#import "CityChoiceViewController.h"
@implementation DKView
{
    CLLocationManager *_locationManager;
    NSString * _city;
    NSMutableArray *_threeCity;
    BOOL _isShi;
}

-(instancetype)initWithFrame:(CGRect)frame cityArr:(NSArray *)cityArr
{
    if (self =[super initWithFrame:frame]) {
        _threeCity =[NSMutableArray new];
        _filterData=cityArr;
        [self addBackgroundView];
        [self addDKFilterView];
        [self addCitycChoice];
        _citycChoiceView.cityName.text =[NSString stringWithFormat:@"当前城市：%@",busiSystem.agent.cityName];;
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame city:(NSString *)city
{
    if (self =[super initWithFrame:frame]) {
        busiSystem.agent.LocationCityName =[self cityName:city];
        _threeCity =[NSMutableArray new];
        _filterData=[self currentCountyArrCity:busiSystem.agent.LocationCityName];
//        if (_filterData.count==0) {
//            _isShi=YES;
//            _filterData=[self currentCountyArrCity:city];
//        }
        [self addBackgroundView];
        [self addDKFilterView];
        [self addCitycChoice];
        _citycChoiceView.cityName.text =[NSString stringWithFormat:@"当前城市：%@",busiSystem.agent.cityName];;
    }
    return self;
}

-(NSString *)cityName:(NSString *)cityName
{
    NSString *city;
//    for (int i=0; i<busiSystem.areaManager.areas.count; i++)
//    {
//        BUAreaManager *area =[BUAreaManager new];
//        area.currentProvince =busiSystem.areaManager.areas[i];
//        for (int i=0; i<area.currentProvince.citys.count; i++)
//        {
//            area.currentCity =area.currentProvince.citys[i];
//            if ([area.currentCity.cityName isEqualToString:cityName])
//            {
//                return area.currentCity.cityName;
//            }
//            else
//            {
//                //                    area.currentCity.cityName = [NSString stringWithFormat:@"%@",area.currentCity.cityName];
//                for (int j=0; j<area.currentCity.countys.count; j++)
//                {
//                    BUAreaManager *area1 =[BUAreaManager new];
//                    area1.currentCity =area.currentCity.countys[j];
//                    if ([area1.currentCity.cityName isEqualToString:cityName])
//                    {
//                        return area.currentCity.cityName;
//                    }
//                }
//            }
//        }
//    }
    return city;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
//        _filterData=filterData;
        _threeCity =[NSMutableArray new];
//        HUDSHOW(@"正在定位...");
        [self locate];
        }
    return self;
}

- (void)addCitycChoice
{
    __weak  DKView *  view =self;
    if (_citycChoiceView) {
        return;
    }
    NSArray *arrView=[[NSBundle  mainBundle]loadNibNamed:@"CitycChoiceView" owner:nil options:nil];
    _citycChoiceView=arrView[0];
    _citycChoiceView.frame = CGRectMake(0, _filterView.y+_filterView.height, __SCREEN_SIZE.width, 50);
    _citycChoiceView.switchCity =^(){
        view.hidden=YES;
        view.switchCity();
//        [view removeFromSuperview];
    };
    [self addSubview:_citycChoiceView];
//    HUDDISMISS;
}

- (void)addDKFilterView
{
    if (self.filterView) {
        return;
    }
    self.filterView = [[DKFilterView alloc] initWithFrame:CGRectMake(0,(self.height-210)/2, self.width, 210)];
    self.filterView.delegate = self;
    DKFilterModel *radioModel = [[DKFilterModel alloc] initElement:_filterData ofType:DK_SELECTION_SINGLE];
    radioModel.style = DKFilterViewDefault;
    [self.filterView setFilterModels:@[radioModel]];
    [self addSubview:self.filterView];
}

- (void)addBackgroundView
{
    if (_backgroundView) {
        return;
    }
    _backgroundView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width +48,  self.frame.size.height)];
    _backgroundView.backgroundColor =[UIColor colorWithWhite:0.000 alpha:0.530];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_backgroundView addGestureRecognizer:tap];
    [self addSubview:_backgroundView];
}

#pragma mark --- Action
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    self.hidden=YES;
}

#pragma delegate
- (void)didClickAtModel:(DKFilterModel *)data{
    _data(data,_threeCity);
    self.hidden=YES;
}

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
             if (_filterData.count ==0)
             {
                 _filterData =[self currentCountyArrCity:city];
             }
             [self addBackgroundView];
             [self addDKFilterView];
             [self addCitycChoice];
             busiSystem.agent.cityName =city;
             _citycChoiceView.cityName.text =[NSString stringWithFormat:@"当前城市：%@",city];
//             HUDDISMISS;
             //             cityName = city;
         }else if (error == nil && [array count] == 0)
         {
//             HUDCRY(@"定位失败", 2);
             [self removeFromSuperview];
             NSLog(@"No results were returned.");
         }else if (error != nil)
         {
             if (i!=0) {
                 return ;
             }
             NSLog(@"An error occurred = %@", error);
             i++;
//             HUDCRY(@"定位失败", 2);
             [self removeFromSuperview];
             _switchCity();
         }
     }];
}
static int i=0;

-(NSArray *)currentCountyArrCity:(NSString *)city
{
    if (_isShi==NO) {
        city =[city stringByReplacingOccurrencesOfString:@"市" withString:@""];
    }
    else{
        _isShi =NO;
    }
    NSMutableArray *mArr =[NSMutableArray new];
//    for (int i=0; i<busiSystem.areaManager.areas.count; i++)
//    {
//        BUAreaManager *area =[BUAreaManager new];
//        area.currentProvince =busiSystem.areaManager.areas[i];
//        for (int i=0; i<area.currentProvince.citys.count; i++)
//        {
//            area.currentCity =area.currentProvince.citys[i];
//            if ([area.currentCity.cityName isEqualToString:city]) {
//                NSString *str =[NSString stringWithFormat:@"%@",area.currentCity.cityName];
//                [mArr addObject:str];
//                [_threeCity addObject:area.currentCity];
//                for (int j=0; j<area.currentCity.countys.count; j++)
//                {
//                    BUAreaManager *area1 =[BUAreaManager new];
//                    area1.currentCity =area.currentCity.countys[j];
//                    [mArr addObject:area1.currentCity.cityName];
//                    [_threeCity addObject:area1.currentCity];
//                }
//            }
//        }
//    }
    return mArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
