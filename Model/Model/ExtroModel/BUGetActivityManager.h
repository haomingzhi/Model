//
//  BUGetActivityManager.h
//  compassionpark
//
//  Created by Steve on 2017/4/11.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BULCManager.h"
#import "BUImageRes.h"

@interface BUActivity : BUBase
@property(strong,nonatomic) NSString *content;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *actId;
@property(strong,nonatomic) BUImageRes *imagePath;
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic) NSString  *cityId;
@property(strong,nonatomic) NSString  *url;
@property(assign,nonatomic) NSInteger  type;
-(NSDictionary *)getDic;
@end



@interface BUGetActivityManager : BULCManager

//活动列表
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)BUPageInfo *pageInfo;
-(BOOL)getActivityNextPage:(id)observer callback:(SEL)callback;
-(BOOL)getActivityNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getActivity:(NSString *)cityId  withIsHome:(NSString *)isHome observer:(id)observer callback:(SEL)callback;
-(BOOL)getActivity:(NSString *)cityId withIsHome:(NSString *)isHome observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;


//活动详情
@property (nonatomic,strong) BUActivity *activity;
-(BOOL)getActivityDetail:(NSString *)aid observer:(id)observer callback:(SEL)callback;
-(BOOL)getActivityDetail:(NSString *)aid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//活动商品
@property (nonatomic,strong) NSArray *goodsArr;
-(BOOL)getActivityGoodsList:(NSString *)aid observer:(id)observer callback:(SEL)callback;
-(BOOL)getActivityGoodsList:(NSString *)aid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
@end
