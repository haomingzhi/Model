//
//  NSDictionary+ToHttpQueryString.m
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/8/10.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "NSDictionary+ToHttpQueryString.h"

@implementation NSDictionary (ToHttpQueryString)

-(NSString *) toQueryString
{
    NSMutableString *result =  [[NSMutableString alloc] init];
    
    //先不考虑包含特殊字符的情况
    for (NSInteger i = 0; i < self.allKeys.count; i++)
    {
        NSString *strKey = [self.allKeys objectAtIndex:i];
        NSObject *objVal = [self.allValues objectAtIndex:i];
        
        if (i != 0)
            [result appendString:@"&"];
        
        [result appendFormat:@"%@=", strKey];
        
        //添加value
        if ([objVal isKindOfClass:[NSString class]])
        {
            [result appendFormat:@"%@", [((NSString*)objVal) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ]];
        }
        else if ([objVal isKindOfClass:[NSNumber class]])
        {
            //如果是boolean型则特殊处理。。。
            NSNumber *num = (NSNumber*)objVal;
            const char *ctype = num.objCType;
            if (*ctype == 'B')
                [result appendFormat:@"%@", num.boolValue ? @"true" : @"false"];
            else
                [result appendFormat:@"%@",objVal];
        }
//        else if ([objVal isKindOfClass:[BSJSON class]])
//        {
//            [result appendString:[((BSJSON*)objVal) serializationHelper]];
//        }
        else if ([objVal isKindOfClass:[NSNull class]])
        {
            [result appendString:@""];
        }
        else if ([objVal isKindOfClass:[NSArray class]])
        {
            [result appendString:@"["];
            NSArray *arr = (NSArray*)objVal;
            
            for (int j = 0; j < arr.count; j++)
            {
                if (j != 0)
                    [result appendString:@","];
                [result appendFormat:@"\"%@\"", [[arr objectAtIndex:j] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            }
            
            [result appendString:@"]"];
            
        }
        else
        {
            //崩溃！！
            NSAssert(0, @"error");
        }
    }
    NSLog(@"%@",result);
    return result;
}

-(NSString *) toContentString
{
    NSMutableString *result =  [[NSMutableString alloc] init];
    
    //先不考虑包含特殊字符的情况
    for (NSInteger i = 0; i < self.allKeys.count; i++)
    {
        NSString *strKey = [self.allKeys objectAtIndex:i];
        NSObject *objVal = [self.allValues objectAtIndex:i];
        
        if (i != 0)
            [result appendString:@"&"];
        
        [result appendFormat:@"%@=", strKey];
        
        //添加value
        if ([objVal isKindOfClass:[NSString class]])
        {
            [result appendFormat:@"%@", (NSString*)objVal];
        }
        else if ([objVal isKindOfClass:[NSNumber class]])
        {
            //如果是boolean型则特殊处理。。。
            NSNumber *num = (NSNumber*)objVal;
            const char *ctype = num.objCType;
            if (*ctype == 'B')
                [result appendFormat:@"%@", num.boolValue ? @"true" : @"false"];
            else
                [result appendFormat:@"%@",objVal];
        }
        //        else if ([objVal isKindOfClass:[BSJSON class]])
        //        {
        //            [result appendString:[((BSJSON*)objVal) serializationHelper]];
        //        }
        else if ([objVal isKindOfClass:[NSNull class]])
        {
            [result appendString:@""];
        }
        else if ([objVal isKindOfClass:[NSArray class]])
        {
            [result appendString:@"["];
            NSArray *arr = (NSArray*)objVal;
            
            for (int j = 0; j < arr.count; j++)
            {
                if (j != 0)
                    [result appendString:@","];
                [result appendFormat:@"\"%@\"", [arr objectAtIndex:j] ];
            }
            
            [result appendString:@"]"];
            
        }
        else
        {
            //崩溃！！
            NSAssert(0, @"error");
        }
    }
    NSLog(@"%@",result);
    return result;
}
@end
