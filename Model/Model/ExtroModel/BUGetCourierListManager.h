//
//  BUGetCourierListManager.h
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/12.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"
#import "BUImageRes.h"



//@interface BUCourier : BUBase
//@property(strong,nonatomic) NSString *realName;
//@property(strong,nonatomic) NSString *serviceArea;
//@property(strong,nonatomic) NSString *courierId;
//@property(strong,nonatomic) NSString *distance;
//@property(strong,nonatomic) NSString *longitude;
//@property(strong,nonatomic) BUImageRes *imagePath;
//@property(strong,nonatomic) NSString *latitude;
//@property(nonatomic) long serviceCount;
//@end

@interface BUGetCourierListManager : BUBasePageDataManager
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback;
-(BOOL)getListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getList:(NSString*)key  longitude:(NSString *)longitude  latitude:(NSString *)latitude cityId:(NSString *)cityId  observer:(id)observer callback:(SEL)callback;
-(BOOL)getList:(NSString*)key longitude:(NSString *)longitude  latitude:(NSString *)latitude cityId:(NSString *)cityId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
@end
