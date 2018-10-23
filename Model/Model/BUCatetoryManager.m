//
//  BUSortCatetoryManager.m
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/5/27.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BUCatetoryManager.h"
#import "BUCategory.h"


@implementation BUCatetoryManager

-(id) init
{
    self = [super init];
    if (self) {
        self.deserializationMap = @{@"type_list":@"BUCategory,CategoryList",@"list":@"BUCategory,CategoryList"};
        self.currentIndex = NSNotFound;
    }
    return self;
}

-(void) loadFromDb
{

}

-(NSArray *) getCategoryNames
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (BUCategory *sc in self.CategoryList) {
        [result addObject:sc.CategoryName];
    }
    return result;
}

-(BOOL)getCategoryList:(BSCATETORYTYPE) caType observer:(id)observer callback:(SEL)callback        //获取二级类目
{
    NSString *requestUrl = @"";
    switch (caType) {
        case BSCATETORYTYPE_News:
            requestUrl = BU_BUSINESS_ZxPostType;
            break;
        case BSCATETORYTYPE_SIKI:
            requestUrl = BU_BUSINESS_getSingleTypeList;
            break;
        case BSCATETORYTYPE_DealSell:
            requestUrl = BU_BUSINESS_getSellTypeList;
            break;
        case BSCATETORYTYPE_DealBuy:
            requestUrl = BU_BUSINESS_getBuyTypeList;
            break;
        case BSCATETORYTYPE_DealBuyer:
            requestUrl = BU_BUSINESS_getProductTypeList;
            break;
        default:
            break;
    }
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN,requestUrl]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(getCategoryListOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSError *)getCategoryListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    [((BSJSON *)[jsonObj objectForKey:@"data"]) deserialization:self];
    return SuccessedError;
}


@end
