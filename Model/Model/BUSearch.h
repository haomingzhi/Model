//
//  BUSearch.h
//  ulife
//
//  Created by sunmax on 16/1/12.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface UserList : BUBase

@property (nonatomic, strong)NSString *UserName;
@property (nonatomic, assign)NSInteger UserId;

@end

@interface BUSearch : BUBase
@property (nonatomic, strong)NSArray *UserList;
@property (nonatomic, strong)UserList * uList;
//请求我发布的资讯列表
-(BOOL) searchUser:(NSString *)name Observer:(id) observer callback:(SEL) callback;
@end
