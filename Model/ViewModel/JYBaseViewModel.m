//
//  JYBaseViewModel.m
//  Model
//
//  Created by apple on 2018/10/30.
//  Copyright © 2018 ORANLLC_IOS1. All rights reserved.
//

#import "JYBaseViewModel.h"

@implementation JYBaseViewModel
-(void)fetchDataCompletion:(void (^)(BOOL success, NSArray *data, NSString *message))block
{
     NSLog(@"%@",@"未实现方法");
}

-(void)fetchDataDetail:(NSDictionary *)parms Completion:(void (^)(BOOL success, NSArray *data, NSString *message))block
{
     NSLog(@"%@",@"未实现方法");
}

-(void)fetchNextPageDataCompletion:(void (^)(BOOL success, NSArray *data, NSString *message))block
{
     NSLog(@"%@",@"未实现方法");
}

-(BOOL)hasMore
{
     return NO;
}
-(void)fetchData:(NSDictionary *)parms Completion:(void (^)(BOOL, NSArray *, NSString *))block
{
    NSLog(@"%@",@"未实现方法");
}
-(void)addData:(NSDictionary *)parms Completion:(void (^)(BOOL success, NSArray *data, NSString *message))block
{
   NSLog(@"%@",@"未实现方法");
}
-(void)deleteData:(NSDictionary *)parms Completion:(void (^)(BOOL success, NSArray *data, NSString *message))block
{
     NSLog(@"%@",@"未实现方法");
}

-(void)editData:(NSDictionary *)parms Completion:(void (^)(BOOL success, NSArray *data, NSString *message))block
{
   NSLog(@"%@",@"未实现方法");
}
@end
