//
//  BSLocationCity.m
//  ulife
//
//  Created by sunmax on 15/12/9.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BSLocationCity.h"
@interface BSLocationCity()<CLLocationManagerDelegate>
@end

@implementation BSLocationCity
{
    CLLocationManager *_locationManager;
    NSString *_cityName;
}

-(id)init
{
    self = [super init];
    if (self) {
        [self locate];
//        if ([self locate]) {
//            // 开始定位
////            [self setstartUpdatingLocation];
//        }else
//        {
//            NSLog(@"定位不成功 ,请确认开启定位");
//        }
        
    }
    return self;

}

- (void)locate{
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        //定位初始化
        _locationManager=[[CLLocationManager alloc] init];
        _locationManager.delegate=self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=10;
        if (__IOS8) {
            [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
        }
//        return YES;
    }else {
        //提示用户无法进行定位操作
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
//        return NO;
    }
}

#pragma mark location delegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

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
             //             cityName = city;
             NSLog(@"定位完成:%@",city);
             _cityName =city;
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

- (void)setstartUpdatingLocation
{
    // 开始定位
    [_locationManager startUpdatingLocation];
}

- (NSString *)cityname
{
//    [self setstartUpdatingLocation];
    return _cityName;
}



@end
