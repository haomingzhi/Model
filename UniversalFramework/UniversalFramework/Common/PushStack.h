//
//  PushStack.h
//  cpvs
//
//  Created by 耶通 on 14-12-3.
//  Copyright (c) 2014年 com.nd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushStack : NSObject
@property(nonatomic,strong) void (^pushBlock)(NSDictionary *dataDic);
-(void)addPushInfo:(NSDictionary *)dic;
//+(void)deletePushInfo:(NSString *)pushid;
+(id)sharePushStack;
@end
