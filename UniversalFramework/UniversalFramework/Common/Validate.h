//
//  Validate.h
//  MeiliWan
//
//  Created by Air on 15-4-21.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validate : NSObject
+(BOOL)isValidateEmail:(NSString *)email;
+ (BOOL) validateMobile:(NSString *)mobile;
@end
