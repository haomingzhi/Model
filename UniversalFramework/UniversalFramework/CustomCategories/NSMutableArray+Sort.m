//
//  NSMutableArray+Sort.m
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/10/19.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "NSMutableArray+Sort.h"

@implementation NSMutableArray (Sort)

-(void) sort:(NSString *) fieldName sortType:(NSInteger)sortType
{
    [self sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult sortResult;
        id v1 = [obj1 valueForKey:fieldName];
        id v2 = [obj2 valueForKey:fieldName];
        sortResult =  [v1 compare:v2];
        return sortResult ==1 ? sortResult : (sortResult == NSOrderedAscending ? NSOrderedDescending :(sortResult == NSOrderedDescending ? NSOrderedAscending : NSOrderedSame));
    }];
}


@end
