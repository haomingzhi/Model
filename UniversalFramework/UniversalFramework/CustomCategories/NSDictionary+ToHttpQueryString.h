//
//  NSDictionary+ToHttpQueryString.h
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/8/10.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ToHttpQueryString)

-(NSString *) toQueryString;
-(NSString *) toContentString;
@end
