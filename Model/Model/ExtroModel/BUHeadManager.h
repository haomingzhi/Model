//
//  BUHeadManager.h
//  taihe
//
//  Created by air on 2016/11/16.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "BULCManager.h"
#import "BUImageRes.h"
#import "BUGetSearchListManager.h"

@interface BUBanners : BUBase
@property(strong,nonatomic) NSString *aubtopics;
@property(strong,nonatomic) NSString *aUrl;
@property(nonatomic) NSInteger aType;
@property(strong,nonatomic) NSString *createUID;
@property(strong,nonatomic) NSString *modifyTime;
@property(strong,nonatomic) NSString *aPosition;
@property(strong,nonatomic) NSString *aStartTime;
@property(strong,nonatomic) NSString *aaTitle;
@property(strong,nonatomic) NSString *modifyUID;
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic) BUImageRes *aImg;
@property(nonatomic) NSInteger aJumpType;
@property(nonatomic) NSInteger aSort;
@property(strong,nonatomic) NSString *aEndTime;
@property(nonatomic) NSInteger aSourType;
@property(strong,nonatomic) NSString *aId;
@property(strong,nonatomic) NSString *aRemark;
@property(nonatomic) NSInteger status;
@property(strong,nonatomic) NSString *aNo;
-(NSDictionary *)getDic;
+(NSDictionary *)getDicArrWith:(NSArray *)arr;
@end



@interface BUServices : BUBase<NSCoding>
@property(strong,nonatomic) NSString *sstId;
@property(strong,nonatomic) NSString *susId;
@property(strong,nonatomic) BUImageRes *imagePath;
@property(strong,nonatomic) NSString *sapId;
@property(nonatomic) NSInteger no;
@property(strong,nonatomic) NSString *name;
@property(nonatomic) NSInteger state;
-(NSDictionary *)getDic;
-(NSDictionary *)getDicWithDel;
@end


@interface  BUBannerAndQuickMenu: BUBase
@property(strong,nonatomic) NSArray *nvaig;
@property(strong,nonatomic) NSArray *slideshow;
@property(assign,nonatomic) NSInteger isDaySigin;
-(NSDictionary *)getDic:(NSInteger)index;
@end


@interface BUQuickMenu : BUBase
@property(strong,nonatomic) NSString *note;
@property(strong,nonatomic) BUImageRes *img;
@property(strong,nonatomic) NSString *parmaId;
@property(strong,nonatomic) NSString *name;
@property(nonatomic) NSInteger type;//（0 无 1 链接地址 2 指定分类 3 指定优选 4 指定商品）
@property(strong,nonatomic) NSString *url;
@end


@interface BUIndexActivity : BUBase
@property(strong,nonatomic) NSString *note;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *activityId;
@property(strong,nonatomic) BUImageRes *img;
@property(strong,nonatomic) NSString *parmaId;
@property(strong,nonatomic) NSString *url;
@property(nonatomic,assign) NSInteger type;
-(NSDictionary *)getDic;
@end


@interface BUOptimization : BUBase
@property(strong,nonatomic) NSString *optimizationId;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) BUImageRes *img;
@property(strong,nonatomic) NSString *subtitle;
@property(strong,nonatomic) NSArray *proList;
-(NSDictionary *)getDic:(NSInteger)index;
@end

@interface BUHeadGoods : BUBase
@property(nonatomic) NSInteger hotSort;
@property(strong,nonatomic) NSString *operTime;
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *attributes;
@property(strong,nonatomic) NSString *subtitle;
@property(nonatomic) NSInteger costMoney;
@property(strong,nonatomic) NSString *productInnerTextId;
@property(nonatomic) CGFloat leaseMoney;
@property(nonatomic) NSInteger recommendSort;
@property(nonatomic) NSInteger warningCount;
@property(strong,nonatomic) NSString *no;
@property(nonatomic) NSInteger tradeCount;
@property(strong,nonatomic) NSString *leases;
@property(strong,nonatomic) NSString *name;
@property(nonatomic) NSInteger priceType;
@property(nonatomic) NSInteger status;
@property(nonatomic) NSInteger insuranceMoney;
@property(nonatomic) BOOL isHot;
@property(strong,nonatomic) NSString *twoProductTypeId;
@property(nonatomic) NSInteger leaseType;
@property(nonatomic) NSInteger fourteenDayPrice;
@property(strong,nonatomic) NSString *oneProductTypeId;
@property(nonatomic) NSInteger thirtyDayPrice;
@property(strong,nonatomic) NSString *adminId;
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic) BUImageRes *img;
@property(nonatomic) NSInteger trueTradeCount;
@property(nonatomic) NSInteger colorType;
@property(nonatomic) NSInteger sevenDayPrice;
@property(strong,nonatomic) NSString *productLeaseId;
@property(strong,nonatomic) NSString *productPromises;
@property(strong,nonatomic) NSString *productId;
@property(strong,nonatomic) NSString *note;
@property(nonatomic) BOOL isRecommend;
-(NSDictionary *)getDic;
-(NSDictionary *)getDicA;
-(NSDictionary *)getDicB;
@end

@interface BUClassify : BUBase
@property(strong,nonatomic) NSArray *secList;
@property(strong,nonatomic) NSString *typetId;
@property(strong,nonatomic) BUImageRes *img;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *unit;
@property(strong,nonatomic) NSString *note;
-(NSDictionary *)getDic;
@end

@interface BUClassifyInfo : BUBase
@property(strong,nonatomic) NSString *typetId;
@property(strong,nonatomic) BUImageRes *img;
@property(strong,nonatomic) NSString *parentId;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *unit;
@property(strong,nonatomic) NSString *note;
-(NSDictionary *)getDic;
@end


@interface BUHeadManager : BULCManager
@property(nonatomic,strong)NSArray *banners;
@property(nonatomic,strong)NSArray *notices;
@property(nonatomic,strong)NSArray *services;
@property(nonatomic,strong)NSArray *serviceTypes;
//搜索
@property (nonatomic,strong) BUGetSearchListManager *getSearchListManager;


@property(nonatomic)NSInteger action;
-(BOOL)getInitialization:(NSString *)sapid  observer:(id)observer callback:(SEL)callback;
-(BOOL)getInitialization:(NSString *)sapid  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)getServicesType:(NSString *)sapid  observer:(id)observer callback:(SEL)callback ;
-(BOOL)getServicesType:(NSString *)sapid  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)submitUsService:(NSArray *)service observer:(id)observer callback:(SEL)callback;
-(BOOL)submitUsService:(NSArray *)service observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInf;


-(BOOL)carousel:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)carousel:(id)observer callback:(SEL)callback;

//new
//获取轮播图 快捷菜单
@property (nonatomic,strong) BUBannerAndQuickMenu *bannerAndQuickMenu;
-(BOOL)getIndex:(id)observer callback:(SEL)callback;
-(BOOL)getIndex:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
//获取专题活动列表
@property (nonatomic,strong) NSArray *indexActivityList;
-(BOOL)getIndexActivity:(id)observer callback:(SEL)callback;
-(BOOL)getIndexActivity:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
//获取优选列表
@property (nonatomic,strong) NSArray *optimizationList;
-(BOOL)getIndexOptimi:(id)observer callback:(SEL)callback;
-(BOOL)getIndexOptimi:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//获取分类明细
@property (nonatomic,strong) NSArray *getProTypeList;
-(BOOL)getProType:(NSString *)search  observer:(id)observer callback:(SEL)callback;
-(BOOL)getProType:(NSString *)search  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//获取分类商品列表
@property (nonatomic,strong) NSArray *getTypeInfoList;
-(BOOL)getTypeInfo:(NSString *)typetId withParentId:(NSString *)parentId  observer:(id)observer callback:(SEL)callback;
-(BOOL)getTypeInfo:(NSString *)typetId withParentId:(NSString *)parentId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//获取优选信息
@property (nonatomic,strong) BUOptimization *optimization;
-(BOOL)getOptimiInfo:(NSString *)optimizationId  observer:(id)observer callback:(SEL)callback;
-(BOOL)getOptimiInfo:(NSString *)optimizationId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
@end
