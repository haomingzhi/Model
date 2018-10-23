//
//  NSString+Convertion.h
//  SCWCYClient
//
//  Created by apple on 14-5-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Convertion)

//字符串表示的字节转化为字节数据 "ABCD12" --->ABCD12
@property(nonatomic,readonly) NSData* hexData;

//将当前字符串转化为UTF-8字节数据后再MD5后在转化为16进制字符串
@property(nonatomic, readonly) NSString* md5String;

@property(nonatomic,readonly) NSData * utf8DataPadding;

//去除前后空格后的字符串
@property(nonatomic, readonly) NSString *trimString;
/**
 *  删除指定字符集
 *
 *  @param specifity 要过滤的字符集
 *
 *  @return 过滤后字符串
 */
-(NSString *)trimSpecifity:(NSString *)specifity;

//每隔多少位插入一个特定的串
-(NSString*)insertString:(NSString*)string space:(NSInteger)space;


//按特定的格式转换字符串。字符串中的每个字符会分别代替格式中的X
//比如字符串为aabbccdd   格式串为XXX-XXX 则最终的内容为aab-bccdd
//注意fmt中的所有X都会被字符代替其他就是不会。
-(NSString*)formatWithFormatString:(NSString*)fmt;

/**
 *  把%12%23=》0x120x23
 *
 *  @return 内码
 */
-(NSData*) networkDataToNSData;

-(CGSize) size:(UIFont *)font constrainedToSize:(CGSize) constrainedToSize;

@end
