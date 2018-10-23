//
//  BUDustbinManager.h
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/12.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BULCManager.h"
#import "BUImageRes.h"


@interface BURecycleOrder : BUBase
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *stationName;
@property(nonatomic) CGFloat weight;
@property(strong,nonatomic) NSString *stateName;
@property(strong,nonatomic) NSString *orderNo;
@property(strong,nonatomic) NSString *userId;
@property(strong,nonatomic) NSString *stationAddress;
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic) NSString *recordId;
@property(strong,nonatomic) NSString *dustbinType;
@property(strong,nonatomic) NSString *deviceNo;
@property(nonatomic) NSInteger integral;
@property(strong,nonatomic) NSString *remark;
@property(strong,nonatomic) BUImageRes *stationImage;
@end

@interface BURecyclingStat : BUBase
@property(nonatomic) NSInteger userIntegral;
@property(strong,nonatomic) NSArray *day7_List;
@property(strong,nonatomic) NSArray *day1_List;
@property(nonatomic) CGFloat day3_Total;
@property(nonatomic) CGFloat day7_Total;
@property(nonatomic) CGFloat day1_Total;
@property(strong,nonatomic) NSArray *day3_List;
@end

@interface BUIntegral: BUBase
@property(strong,nonatomic) NSString *typeId;
@property(strong,nonatomic) NSString *typeName;
@property(nonatomic) NSInteger integral;
@property(strong,nonatomic) BUImageRes *imagePath;
-(NSDictionary *)getDic;
@end

@interface BUCan: BUBase
@property(strong,nonatomic) NSString *dustbinId;
@property(nonatomic) NSInteger volume;
@property(nonatomic) NSInteger fullCount;
@property(nonatomic) NSInteger totalWeight;
@property(strong,nonatomic) NSString *stationId;
@property(strong,nonatomic) NSString *dustbinTypeId;
@property(nonatomic) NSInteger state;
@property(nonatomic) CGFloat proportion;
@property(nonatomic) NSInteger restValume;
@property(nonatomic) CGFloat currentVolume;
@property(strong,nonatomic) NSString *canId;
@property(strong,nonatomic) NSString *dustbinType;
@property(nonatomic) NSInteger sn;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) BUImageRes *imagePath;
@end

@interface BUDustbin : BUBase
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *dustbinId;
@property(strong,nonatomic) NSString *dustbinType;
@property(nonatomic) NSInteger fullCount;
@property(nonatomic) NSInteger totalWeight;
@property(strong,nonatomic) NSString *stationName;
@property(nonatomic) NSInteger currentVolume;
@property(nonatomic) NSInteger maxVolume;
@property(strong,nonatomic) NSArray *canList;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *stationId;
@end

@interface BUGetStationInfo : BUBase
@property(strong,nonatomic) NSString *principal;
@property(strong,nonatomic) NSString *stationId;
@property(nonatomic) NSInteger fullCount;
@property(nonatomic) NSInteger totalWeight;
@property(nonatomic) NSInteger maxVolume;
@property(strong,nonatomic) NSArray *integralList;
@property(strong,nonatomic) NSArray *canList;
@property(strong,nonatomic) NSString *longitude;
@property(nonatomic) NSInteger proportion;
@property(strong,nonatomic) NSString *latitude;
@property(nonatomic) NSInteger currentVolume;
@property(strong,nonatomic) NSString *address;
@property(strong,nonatomic) NSString *dustbinType;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) BUImageRes *imagePath;
@property(strong,nonatomic) NSString *telephone;
-(NSDictionary*)getDic;
@end


@interface BUDustbinType : BUBase
@property(strong,nonatomic) NSString *typeId;
@property(strong,nonatomic) NSString *typeName;
@property(nonatomic) NSInteger integral;
@property(strong,nonatomic) BUImageRes *imagePath;
@property(nonatomic,assign) CGFloat weight;
@end

@interface BUDustbinManager : BULCManager
@property(nonatomic,strong)BUGetStationInfo *stationInfo;
@property(nonatomic,strong)NSArray *dustbinType;
-(BOOL)getDustbinTypeList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getDustbinTypeList:(id)observer callback:(SEL)callback;
-(BOOL)getStationInfo:(NSString*) sid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getStationInfo:(NSString*) sid observer:(id)observer callback:(SEL)callback;

@property (nonatomic,strong) NSArray *stationList;
-(BOOL)getStationList:(NSString*) key cityId:(NSString *)cityId observer:(id)observer callback:(SEL)callback;
-(BOOL)getStationList:(NSString*)key cityId:(NSString *)cityId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;


@property (nonatomic,strong) BURecyclingStat *recyclingStat;
-(BOOL)getRecyclingStat:(NSString*)userId observer:(id)observer callback:(SEL)callback;
-(BOOL)getRecyclingStat:(NSString*)userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

@property (nonatomic,strong) BUImageRes *qrCode;
-(BOOL)getQrCode:(NSString*)userId observer:(id)observer callback:(SEL)callback;
-(BOOL)getQrCode:(NSString*)userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

@property (nonatomic,strong) BURecycleOrder *recycleOrder;
-(BOOL)getRecyclingOrder:(NSString*)userId startTime:(NSString *)startTime observer:(id)observer callback:(SEL)callback;
-(BOOL)getRecyclingOrder:(NSString*)userId  startTime:(NSString *)startTime  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
@end
