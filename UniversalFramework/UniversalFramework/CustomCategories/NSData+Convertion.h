//
//  NSData+Convertion.h
//  SCWCYClient
//
//  Created by apple on 14-5-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Convertion)

//字节转化为16进制表示的字符串比如 5F3C  -->  "5F3C"
@property(nonatomic, readonly) NSString *hexStr;

//MD5后的字节。
@property(nonatomic, readonly) NSData *md5Data;

@end
