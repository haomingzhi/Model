//
//  DDMyViewModel.m
//  Model
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018 ORANLLC_IOS1. All rights reserved.
//

#import "DDMyViewModel.h"

@implementation DDMyViewModel
-(void)fetchDataCompletion:(void (^)(BOOL success, NSArray *data, NSString *message))block
{}

-(void)fetchDataDetail:(NSDictionary *)parms Completion:(void (^)(BOOL success, NSArray *data, NSString *message))block
{}

-(void)fetchNextPageDataCompletion:(void (^)(BOOL success, NSArray *data, NSString *message))block
{}

-(BOOL)hasMore
{
     return NO;
}

-(void)fetchData:(NSDictionary *)parms Completion:(void (^)(BOOL, NSArray *, NSString *))block
{
     
}
-(void)addData:(NSDictionary *)parms Completion:(void (^)(BOOL success, NSArray *data, NSString *message))block
{
     
}
-(void)deleteData:(NSDictionary *)parms Completion:(void (^)(BOOL success, NSArray *data, NSString *message))block
{
     
}

-(void)editData:(NSDictionary *)parms Completion:(void (^)(BOOL success, NSArray *data, NSString *message))block
{
     
}
@end
