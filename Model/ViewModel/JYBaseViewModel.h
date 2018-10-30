//
//  JYBaseViewModel.h
//  Model
//
//  Created by apple on 2018/10/30.
//  Copyright © 2018 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JYBaseViewModel : NSObject
-(void)fetchDataCompletion:(void (^)(BOOL success, NSArray *data, NSString *message))block;
-(void)fetchDataDetail:(NSDictionary *)parms Completion:(void (^)(BOOL success, NSArray *data, NSString *message))block;
-(void)fetchNextPageDataCompletion:(void (^)(BOOL success, NSArray *data, NSString *message))block;
-(BOOL)hasMore;
-(void)fetchData:(NSDictionary *)parms Completion:(void (^)(BOOL, NSArray *, NSString *))block;
-(void)addData:(NSDictionary *)parms Completion:(void (^)(BOOL success, NSArray *data, NSString *message))block;
-(void)deleteData:(NSDictionary *)parms Completion:(void (^)(BOOL success, NSArray *data, NSString *message))block;
-(void)editData:(NSDictionary *)parms Completion:(void (^)(BOOL success, NSArray *data, NSString *message))block;
@end

NS_ASSUME_NONNULL_END
