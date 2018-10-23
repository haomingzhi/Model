//
//  BUIndexManager.h
//  supermarket
//
//  Created by Steve on 2017/11/6.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BULCManager.h"
#import "BUImageRes.h"
//#import "BUActionAdvertManager.h"
#import "BUGetSysMessageListManager.h"

@interface BUCarouse : BUBase
@property(strong,nonatomic) NSString *carouselId;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) BUImageRes *imagePath;
@property(strong,nonatomic) NSString *url;
+(NSDictionary *)getArrDicWithThisArr:(NSArray*)arr;
@end

@interface BUOpenCity : BUBase
@property(nonatomic) NSInteger cityId;
@property(strong,nonatomic) NSString *cityName;
@property(nonatomic) NSInteger isDefault;
@end

@interface BUStroe : BUBase
@property(strong,nonatomic) NSString *sId;
@property(strong,nonatomic) NSString *sName;
@property(strong,nonatomic) NSString *sNo;
@property(nonatomic) NSInteger distance;
+(NSArray *)getNameArr:(NSArray *)arr;
@end


@interface BUProduct : BUBase
@property(strong,nonatomic) NSString *pId;
@property(nonatomic) CGFloat marketPrice;
@property(nonatomic) NSInteger proSort;
@property(strong,nonatomic) BUImageRes *proImagePic;
@property(strong,nonatomic) NSString *proName;
@property(strong,nonatomic) NSString *proTitle;
@property(nonatomic) CGFloat proPrice;
+(NSDictionary *)getArrDic:(NSArray *)arr;
-(NSDictionary*)getDic;
@end
//@interface BUActionAdvert : BUBase
//@property(nonatomic) NSInteger saSort;
//@property(strong,nonatomic) NSArray *productList;
//@property(strong,nonatomic) BUImageRes *saImg;
//@property(strong,nonatomic) NSString *saId;
//@property(strong,nonatomic) NSString *saTitle;
//@property(strong,nonatomic) NSString *subtopics;
//@property(strong,nonatomic) NSString *saRemark;
//+(NSDictionary*)getArrDic:(NSArray *)arr;
//@end


@interface BUHotSearchKeyWord : BUBase
@property(strong,nonatomic) NSString *proName;
@property(nonatomic) NSInteger proSort;
@end


@interface BUAdImage : BUBase
@property(strong,nonatomic) NSString *adpDesc;
@property(strong,nonatomic) NSString *apId;
@property(strong,nonatomic) NSString *adpNo;
@property(strong,nonatomic) BUImageRes *adpDemoImg;
@property(strong,nonatomic) NSString *adpName;
@end

@interface BURecommendType : BUBase
@property(strong,nonatomic) BUImageRes *pClassImg;
@property(nonatomic) NSInteger pClassSort;
@property(strong,nonatomic) NSString *pcId;
@property(strong,nonatomic) NSString *pClassName;
+(NSDictionary*)getArrDic:(NSArray *)arr;
@end

@interface BUReason : BUBase
@property(strong,nonatomic) NSString *rid;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *parentId;
@end

@interface BUIndexManager : BULCManager
@property (nonatomic,strong) BUAdImage *adImage;
@property (nonatomic,strong) BUProduct *recommendProduct;
@property (nonatomic,strong) NSArray *hotSearchKeyWords;
@property (nonatomic,strong) NSArray *storeList;
@property (nonatomic,strong) NSArray *recommendTypeList;
@property (nonatomic,strong)BUGetSysMessageListManager *getSysMessageListManager;
@property (nonatomic,strong) NSArray *reasonList;
//-(BOOL)getImageByType:(NSInteger )typeId  observer:(id)observer callback:(SEL)callback;
//-(BOOL)getImageByType:(NSInteger)typeId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
//
//-(BOOL)getStoreList:(NSString*) log withLat:(NSString*) lat observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
//-(BOOL)getStoreList:(NSString*) log withLat:(NSString*) lat observer:(id)observer callback:(SEL)callback;
//
//-(BOOL)getRecommendProduct:(NSString*) storeId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
//-(BOOL)getRecommendProduct:(NSString*) storeId observer:(id)observer callback:(SEL)callback;
//
//-(BOOL)getHotSearchKeyWord:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
//-(BOOL)getHotSearchKeyWord:(id)observer callback:(SEL)callback;
//
//-(BOOL)getRecommendTypeList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
//-(BOOL)getRecommendTypeList:(id)observer callback:(SEL)callback;

//获取开通城市
@property (nonatomic,strong) NSArray *cityList;
-(BOOL)getOpenCityList:(id)observer callback:(SEL)callback;
-(BOOL)getOpenCityList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//获取轮播图
@property (nonatomic,strong) NSArray *carouseList;
-(BOOL)getCarouselList:(NSInteger) cityId postion:(NSString *)postion observer:(id)observer callback:(SEL)callback;
-(BOOL)getCarouselList:(NSUInteger) cityId postion:(NSString *)postion observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getReasonList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getReasonList:(id)observer callback:(SEL)callback;
@end
