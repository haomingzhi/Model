//
//  BUGetMyCouponManager.h
//  rentingshop
//
//  Created by air on 2018/3/30.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"




@interface BUGetMyCoupon : BUBase
@property(strong,nonatomic) NSString *effectime;
@property(nonatomic) NSInteger totalCount;
@property(nonatomic) NSInteger status;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *code;
@property(strong,nonatomic) NSString *couponId;
@property(nonatomic) NSInteger limitget;
@property(nonatomic) NSInteger exceedType;
@property(strong,nonatomic) NSString *exceedTime;
@property(strong,nonatomic) NSString *operTime;
@property(nonatomic) NSInteger day;
@property(nonatomic) NSInteger isReceive;
@property(nonatomic) NSInteger type;
@property(nonatomic) NSInteger exceedDay;
@property(strong,nonatomic) NSString *scopeName;
@property(nonatomic) NSInteger getThreshold;
@property(nonatomic) NSInteger scope;
@property(strong,nonatomic) NSString *adminId;
@property(strong,nonatomic) NSString *starTime;
@property(nonatomic) NSInteger price;
@property(strong,nonatomic) NSString *remark;
@property(nonatomic) NSInteger threshold;
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic)NSIndexPath *indexPath;
-(NSDictionary *)getDic:(NSInteger)index;
@end

@interface BUGetMyCouponManager : BUBasePageDataManager
@property(nonatomic)NSString *typeCou;
-(BOOL)getMyCoupon:(id)observer callback:(SEL)callback;
-(BOOL)getMyCoupon:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
@property(strong,nonatomic)NSArray *getMyCouponArr;
-(BOOL)getMyCoupon:(NSString*)type observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getMyCoupon:(NSString*)type observer:(id)observer callback:(SEL)callback;
-(BOOL)getMyCouponNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getMyCouponNextPage:(id)observer callback:(SEL)callback ;
@end
