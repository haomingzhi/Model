//
//  ZMSdkManager.h
//  rentingshop
//
//  Created by air on 2018/4/9.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMSdkManager : NSObject
+(instancetype)manager;
-(void)doVerify:(NSString* )url;
@end
