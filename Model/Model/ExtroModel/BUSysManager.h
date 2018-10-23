//
//  BUSysManager.h
//  supermarket
//
//  Created by air on 2017/11/30.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BULCManager.h"
////#import "BUGetMessageListManager.h"
//#import "BUGetSysHelpTypeListManager.h"
//#import "BUGetSysHelpTypeMsgListManager.h"
@interface BUGetSysInfo : BUBase
@property(strong,nonatomic) NSString *version;
@property(strong,nonatomic) NSString *userMent;
@property(strong,nonatomic) NSString *mail;
@property(strong,nonatomic) NSString *tell;
@property(strong,nonatomic) BUImageRes *logo;
@end

@interface BUInviteInfo : BUBase
@property(strong,nonatomic) NSString *cId;
@property(nonatomic) NSInteger inviteUser;
@property(strong,nonatomic) NSString *userID;
@property(nonatomic) NSInteger rewardsCount;
@property(nonatomic) CGFloat cPrice;
@property(strong,nonatomic) NSString *inviteUrl;
@end
@interface BUSysManager : BULCManager
//@property(strong,nonatomic)BUGetMessageListManager *messageListManager;
//@property(strong,nonatomic)BUGetSysHelpTypeListManager *sysHelpTypeListManager;
//@property(strong,nonatomic)BUGetSysHelpTypeMsgListManager *sysHelpTypeMsgListManager;
@property(strong,nonatomic)BUInviteInfo *inviteInfo;
@property(strong,nonatomic)BUGetSysInfo *getSysInfo;
-(BOOL)getSysInfo:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getSysInfo:(id)observer callback:(SEL)callback;

-(BOOL)getInviteInfo:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getInviteInfo:(NSString*) userId observer:(id)observer callback:(SEL)callback;
@end
