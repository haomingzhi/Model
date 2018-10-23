//
//  CheckVersion.h
//  cpvs
//
//  Created by 耶通 on 14-5-15.
//  Copyright (c) 2014年 com.nd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Check : NSObject<UIAlertViewDelegate>
//+(BOOL) OnCheckVersion:(NSMutableArray *)data;
//+(BOOL)OnCheckNet:(NSString *) hostname;
+(BOOL) isInTelphoneBook:(NSString *) telStr;
+(BOOL) isIphoneUserInterface;
//+(BOOL)checkInhouseVersion:(NSMutableDictionary *)data;
@end
