//
//  BSLocation.h
//  JiXie
//  定位：1.工程增加MapKit.framework，2.CoreLocation.framework 3.在plist中增加两个设置：NSLocationWhenInUseUsageDescription(YES),NSLocationAlwaysUsageDescription(YES)
//  Created by ORANLLC_IOS1 on 15/6/18.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface BSLocation : NSObject
@property(nonatomic) NSInteger onece;
@property(nonatomic)  CLLocationCoordinate2D coordinate;
-(BOOL)getLocation: (id) observer callback:(SEL) callback;
-(NSString *) getLocationDescript:(NSString *)latitude longitude:(NSString *)longitude;
@end
