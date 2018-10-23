//
//  BUAddress.h
//  chenxiaoer
//
//  Created by sunmax on 16/3/22.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface BUMapAddress : BUBase
@property (nonatomic,strong)NSString *adressid;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *userid;
@property (nonatomic,strong)NSString *city;
@property (nonatomic,strong)NSString *area;
@property (nonatomic,strong)NSString *province;
@property (nonatomic,strong)NSString *district;
@property (nonatomic,strong)NSString *street;
@property (nonatomic,strong)NSString *lat;
@property (nonatomic,strong)NSString *Lon;
@property (nonatomic,strong)NSString *isdefault;
@property (nonatomic,strong)NSString *recipient;
@property (nonatomic,strong)NSString *rectell;
-(NSDictionary *)getDataDic:(NSString *)tag;
@end
