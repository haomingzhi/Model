//
//  SelectStreetViewController.h
//  chenxiaoer
//
//  Created by sunmax on 16/3/15.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface SelectStreetViewController : JYBaseViewController <CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate,AMapSearchDelegate,AMapLocationManagerDelegate,MAMapViewDelegate>
@property (nonatomic,strong)AMapLocationManager *locationManager;
@property (nonatomic,assign)CLLocationCoordinate2D coordinate2D;
@property(nonatomic,strong)void (^callBack)(id o);
@property (nonatomic,assign) BOOL isCheck;
@end
