//
//  BUArea.h
//  ZhongGengGroup
//  地域信息
//  Created by luolc's macBook air on 15/4/12.

#import "ChineseString.h"

@class BUCity;
@class BUCounty;
//省份
@interface BUprovince : BUBase
@property (nonatomic) NSString *region_id;
@property (nonatomic) NSString *parent_id;
@property (nonatomic) NSString *region_name;
@property (nonatomic) NSMutableArray *child;
@property (nonatomic) NSString *region_type;

-(BOOL) updateCitys:(id)observer callback:(SEL)callback;
-(BUCity *) getCityByName:(NSString *)cityname;
@end

//城市
@interface BUCity : BUBase

@property (nonatomic)NSString *region_id;
@property (nonatomic)NSString *region_name;
@property (nonatomic)NSString *parent_id;
@property (nonatomic)NSMutableArray *child;
@property (nonatomic)NSString *region_type;
@property (nonatomic)ChineseString *chineseString;

-(BUCounty *) getCountyByName:(NSString *) countyName;

-(BOOL) updateCountys:(id)observer callback:(SEL)callback;

@end

//区县
@interface BUCounty : BUBase
@property (nonatomic) NSString *region_type;
@property (nonatomic) NSString *region_name;
@property (nonatomic)NSString *region_id;
@property (nonatomic)NSString *parent_id;

@end



@interface BUAreaManager :BUManager

@property (nonatomic) NSMutableArray *areas;

@property (nonatomic) BUprovince *currentProvince;

@property (nonatomic) BUCity *currentCity;

@property (nonatomic) BUCounty *currentCounty;

-(BOOL) updateAreaList:(id)observer callback:(SEL)callback;

-(BUprovince *) getProvinceByName:(NSString *) provinceName;


@end
