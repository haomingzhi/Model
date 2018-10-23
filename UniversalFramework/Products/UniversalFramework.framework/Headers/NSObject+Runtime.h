//
//  NSObject+Runtime.h
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/6/17.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)

-(NSArray *) getPropertyList;
-(BOOL) isExists:(NSString *)key;
-(NSString *)getpropertyType:(NSString *)propertyName;
-(NSString *) propertyMap:(NSString *) propertyName;
@end
