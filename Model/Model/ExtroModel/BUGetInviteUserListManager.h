//
//  BUGetInviteUserListManager.h
//  compassionpark
//
//  Created by air on 2017/4/13.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"

@interface BUGetInviteUser : BUBase
@property(strong,nonatomic) NSString *operTime;
@property(strong,nonatomic) NSString *stateName;
@property(strong,nonatomic) NSString *userId;
@property(strong,nonatomic) NSString *tel;
-(NSDictionary *)getDic;
@end
@interface BUGetInviteUserListManager : BUBasePageDataManager
@property(strong,nonatomic)NSArray *getInviteUserArr;
-(BOOL)getInviteUserListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getInviteUserListNextPage:(id)observer callback:(SEL)callback;
-(BOOL)getInviteUserList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getInviteUserList:(id)observer callback:(SEL)callback;
@end
