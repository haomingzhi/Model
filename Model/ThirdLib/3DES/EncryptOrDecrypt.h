//
//  EncryptOrDecrypt.h
//  cpvs
//
//  Created by 耶通 on 14-8-19.
//  Copyright (c) 2014年 com.nd. All rights reserved.
//
#define DESKEY @"fdas67^&23fDreE2&YHE2d%#"
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import "GTMBase64.h"
@interface EncryptOrDecrypt : NSObject
+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation;
+(NSData *)AES256ParmEncryptWithKey:(NSString *)key Encrypttext:(NSData *)text;   //加密
+(NSData *)AES256ParmDecryptWithKey:(NSString *)key Decrypttext:(NSData *)text;   //解密
+(NSString *) aes256_encrypt:(NSString *)key Encrypttext:(NSString *)text;
+(NSString *) aes256_decrypt:(NSString *)key Decrypttext:(NSString *)text;
+(NSString *)AES128Decrypt:(NSString *)encryptText;
+(NSString *)AES128Encrypt:(NSString *)plainText;
@end
