//
//  BSWGS84TOGCJ02.h
//  JiXie
//  将WGS-84转为GCJ-02(火星坐标):原来国内地图使用的坐标系统是GCJ-02而ios sdk中所用到的是国际标准的坐标系统WGS-84。
//  Created by ORANLLC_IOS1 on 15/6/18.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface BSWGS84TOGCJ02 : NSObject
//判断是否已经超出中国范围
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;
//转GCJ-02
+(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;
@end
