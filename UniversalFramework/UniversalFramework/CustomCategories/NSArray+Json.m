//
//  NSArray+Json.m
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/9/24.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "NSArray+Json.h"

@implementation NSArray (Json)

-(NSString *) fieldValue:(id) val fieldName: (NSString *) fieldName
{
    if([val isKindOfClass:[NSNumber class]])
    {
        NSNumber *num = (NSNumber*)val;
        const char *ctype = num.objCType;
        if (*ctype == 'd') {
            return [NSString stringWithFormat:@"%f",num.floatValue];
        }
        else {
            
            NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
            return [numberFormatter stringFromNumber: val];
        }
    }
    else
        return val;
}


-(NSString *) toJson:(NSArray *) fieldNames
{
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendString:@"["];
    
    for (int i = 0; i < self.count; i++)
    {
        if (i != 0)
            [result appendString:@","];
        if (fieldNames.count >1)
            [result appendString:@"{"];
        for (int j =0; j < fieldNames.count; j++) {
            if (j !=0) {
                [result appendString:@","];
            }
            if (fieldNames.count >1) {
                [result appendFormat:@"\"%@\":", fieldNames[j]];
            }
            
            id fieldValueObj = [[self objectAtIndex:i] valueForKey:fieldNames[j]];
            [result appendFormat:@"\"%@\"", [self fieldValue:fieldValueObj fieldName:fieldNames[j]] ];
        }
        if (fieldNames.count >1)
            [result appendString:@"}"];
    }
    
    [result appendString:@"]"];
    return result;
}

@end
