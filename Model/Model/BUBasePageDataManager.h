//
//  BUBasePageDataManager.h
//  deliciousfood
//
//  Created by air on 2017/2/27.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BULCManager.h"
#import "BUPageInfo.h"
@interface BUBasePageDataManager : BULCManager
@property(nonatomic,strong)BUPageInfo *pageInfo;
@property(nonatomic,strong)NSArray *dataArr;
-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getData:(NSDictionary *)dic  observer:(id)observer callback:(SEL)callback;
-(BOOL)getDataNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getDataNextPage:(id)observer callback:(SEL)callback ;
@end
