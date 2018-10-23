//
//  BSSecurity.h
//  SCWCYClient
//
//  Created by apple on 14-5-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSSecurity : NSObject


+(NSData*)rsaEncrypt:(NSData*)publicKey  rawData:(NSData*)rawData;
+(NSData*)rsaDecrypt:(NSData*)privateKey ripeData:(NSData*)ripeData;

//DES
+(NSData*)genDesKey;
+(NSData*)desEncrypt:(NSData*)desKey rawData:(NSData*)rawData;
+(NSData*)desDecrypt:(NSData*)desKey ripeData:(NSData*)ripeData;


@end
