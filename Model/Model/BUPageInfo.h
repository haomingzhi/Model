//
//  BUPageInfo.h
//  B2C
//
//  Created by air on 15/7/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUPageInfo : BUBase
@property(nonatomic,strong)NSString *keywords;
@property(nonatomic)NSString * uid;
@property(nonatomic,strong)NSString *sort;
@property(nonatomic,strong)NSString *lng;
@property(nonatomic,strong)NSString *lat;
@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSString * subType;
@property(nonatomic,strong)NSString * endDate;
@property(nonatomic,strong)NSString * startDate;
@property(nonatomic,strong)NSString * orderType;
@property(nonatomic,strong)NSString * state;
@property(nonatomic,strong)NSString * goodsTypeId;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * isTop;
@property(nonatomic,strong)NSString * isRecommend;
@property(nonatomic,strong)NSString * orderByType;
@property(nonatomic,strong)NSString * isEvaluate;
@property(nonatomic,strong)NSString * isBack;

@property(nonatomic,strong)NSString * key;
@property(nonatomic,strong)NSString * orderBy;
@property(nonatomic,strong)NSString * typeId;
@property(nonatomic,strong)NSString * cityId;
@property(nonatomic,strong)NSString *productId;
@property(nonatomic)NSInteger page;
@property(nonatomic)NSInteger pageall;
@property(nonatomic,readonly) BOOL  hasMore;
@end
