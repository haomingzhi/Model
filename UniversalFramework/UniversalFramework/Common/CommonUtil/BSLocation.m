//
//  BSLocation.m
//  JiXie
//  提供位置信息
//  Created by ORANLLC_IOS1 on 15/6/18.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BSLocation.h"


@interface BSLocation()<CLLocationManagerDelegate,MKMapViewDelegate>
@end

@implementation BSLocation
{
    CLLocationManager *myLocationManager;
    id myObserver;
    SEL myCallback;
    MKMapView *mapView;
}

-(id) init
{
    self = [super init];
    if (self) {
        mapView = [[MKMapView alloc] init];
        mapView.delegate = self;
        //定位初始化
        myLocationManager=[[CLLocationManager alloc] init];
        myLocationManager.delegate=self;
//        myLocationManager = [[CLLocationManager alloc]init];
//        myLocationManager.delegate = self;
    }
    return self;
}
#if 1
-(BOOL)getLocation:(id) observer callback:(SEL) callback
{
    if([CLLocationManager locationServicesEnabled])
    {
        myObserver = observer;
        myCallback = callback;
        //选择定位的方式为最优的状态，他又四种方式在文档中能查到
        myLocationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //发生事件的最小距离间隔
        myLocationManager.distanceFilter = kCLDistanceFilterNone;
        // 判断是否 iOS 8
        if([myLocationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [myLocationManager performSelector:@selector(requestAlwaysAuthorization) withObject:nil];
        }
        if (__IOS8) {
            [myLocationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
        }
        [myLocationManager startUpdatingLocation];
        return YES;
    }
//    else HUDCRY(@"定位失败，未开启定位服务", 2);
    return NO;
}
#else
-(BOOL)getLocation: (id) observer callback:(SEL) callback
{
    if([CLLocationManager locationServicesEnabled])
    {
        myObserver = observer;
        myCallback = callback;
        if (__IOS8) {
            [myLocationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
        }
        [myLocationManager startUpdatingLocation];
        [mapView setShowsUserLocation:YES];
        return YES;
    }
    return NO;
}
#endif
//MapView委托方法，当定位自身时调用
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D coord = [userLocation coordinate];
    NSLog(@"经度:%f,纬度:%f",coord.latitude,coord.longitude);
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    switch (status) {
            
        case kCLAuthorizationStatusNotDetermined:
            
            if([manager respondsToSelector:@selector(requestAlwaysAuthorization)]){
                
                [manager requestWhenInUseAuthorization];
                
            }
            
            break;
            
        case kCLAuthorizationStatusDenied:
            [BSUtility showDialog:@"请在设置-隐私-定位服务中开启定位功能！"];
            
            break;
            
        case kCLAuthorizationStatusRestricted:
            [BSUtility showDialog:@"定位服务无法使用！"];
            
        default:
            
            break;
            
    }
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
//    static count =0;
//    //判断是不是属于国内范围
//    CLLocationCoordinate2D coord = ((CLLocation *)locations[0]).coordinate;
////    if (![BSWGS84TOGCJ02 isLocationOutOfChina:coord]) {
////        //转换后的coord
////        coord = [BSWGS84TOGCJ02 transformFromWGSToGCJ:coord];
////    }
//    
//    NSLog(@"Latitude = %lf", coord.latitude);
//    NSLog(@"Longitude = %lf", coord.longitude);
//    NSString *longitude = [NSString stringWithFormat:@"%lf",coord.longitude];
//    NSString *latitude = [NSString stringWithFormat:@"%lf",coord.latitude];
//    if (count >10) {
//        [myLocationManager stopUpdatingLocation];
//        count =0;
//    }
//    count++;
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    _coordinate = currentLocation.coordinate;
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
             NSString *subLocality = placemark.subLocality;
             NSString *city = placemark.locality;
             NSString *administrativeArea = placemark.administrativeArea;
//             if (!subLocality) {
//                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
//                 subLocality = placemark.administrativeArea;
//             }
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
//             if (!administrativeArea) {
//                 administrativeArea =placemark.administrativeArea;
//             }
             //             cityName = city;
//             NSLog(@"定位完成:%@",subLocality);
             [myObserver performSelectorOnMainThread:myCallback  withObject:[BSNotification notificationWith:NULL
                                                                                                   extraInfo:@{@"subLocality":subLocality,@"city":city,@"administrativeArea":administrativeArea}
                                                                                                       error:[NSError errorWithDomain:@"" code:0 userInfo:nil]] waitUntilDone:FALSE];
             //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
             [manager stopUpdatingLocation];
         }else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];
}

-(NSString *) getLocationDescript:(NSString *)latitude longitude:(NSString *)longitude
{
    __block NSString *locationString;
    CLLocationCoordinate2D coordinate;
    coordinate.latitude =  [latitude doubleValue];
    coordinate.longitude = [longitude doubleValue];
    CLLocation *newLocation=[[CLLocation alloc]initWithLatitude:coordinate.latitude longitude: coordinate.longitude];
    CLGeocoder *geocoder=[[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks,
                                       NSError *error)
     {
         CLPlacemark *placemark=[placemarks objectAtIndex:0];
         locationString = [NSString stringWithFormat:@"我我的:%@\n country:%@\n postalCode:%@\n ISOcountryCode:%@\n ocean:%@\n inlandWater:%@\n locality:%@\n subLocality:%@ \n administrativeArea:%@\n subAdministrativeArea:%@\n thoroughfare:%@\n subThoroughfare:%@\n",
                           placemark.name,
                           placemark.country,
                           placemark.postalCode,
                           placemark.ISOcountryCode,
                           placemark.ocean,
                           placemark.inlandWater,
                           placemark.administrativeArea,
                           placemark.subAdministrativeArea,
                           placemark.locality,
                           placemark.subLocality,
                           placemark.thoroughfare,
                           placemark.subThoroughfare];
         NSLog(@"位置:%@",locationString);
     }];
    return locationString;
}

@end
