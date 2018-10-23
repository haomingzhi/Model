//
//  NSMutableArray+Sort.h
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/10/19.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Sort)

/**
 *  数组排序
 *
 *  @param fieldName 字段名
 *  @param sortType  排序类型，1=》从小到大，2=》从大到小
 *
 */
-(void) sort:(NSString *) fieldName sortType:(NSInteger)sortType;

@end
