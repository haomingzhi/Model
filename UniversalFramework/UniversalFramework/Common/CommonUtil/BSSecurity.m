//
//  BSSecurity.m
//  SCWCYClient
//
//  Created by apple on 14-5-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <Security/Security.h>
#include <CommonCrypto/CommonCrypto.h>
#import "BSSecurity.h"


// (See cssmtype.h and cssmapple.h on the Mac OS X SDK.)

enum {
	CSSM_ALGID_NONE =					0x00000000L,
	CSSM_ALGID_VENDOR_DEFINED =			CSSM_ALGID_NONE + 0x80000000L,
	CSSM_ALGID_AES,
    CSSM_ALGID_3DES
};



@interface BSSecurity (DES)

+(NSData*)dealDesData:(NSData*)plainData context:(CCOperation)encryptOrDecrypt padding:(CCOptions)pkcs7 withKey:(NSData*)key;



@end

@implementation BSSecurity (DES)


+(NSData*)dealDesData:(NSData*)plainData context:(CCOperation)encryptOrDecrypt padding:(CCOptions)pkcs7 withKey:(NSData*)key
{
    if (plainData == nil)
        return nil;
    
    
    NSData *retData = nil;
    size_t movedBytes = 0;
    size_t bufferSize = ([plainData length] + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    uint8_t *buffer = malloc( bufferSize * sizeof(uint8_t));
    memset((void *)buffer, 0x0, bufferSize);
    
    CCCryptorStatus ccStatus = CCCrypt(encryptOrDecrypt,
                                       kCCAlgorithmDES,
                                       pkcs7,
                                       key.bytes,
                                       kCCBlockSizeDES,
                                       "12345678",  //"init Vec", //"init Vec", //iv,
                                       [plainData bytes], //"Your Name", //plainText,
                                       [plainData length],
                                       (void *)buffer,
                                       bufferSize,
                                       &movedBytes);
    
    if (ccStatus == kCCSuccess)
    {
        retData = [NSData dataWithBytes:(const void *)buffer length:(NSUInteger)movedBytes];
    }
    
    free(buffer);
    return retData;
}



@end



@implementation BSSecurity


+(NSData*)rsaEncrypt:(NSData*)publicKey  rawData:(NSData*)rawData
{
    SecKeyRef pubKeyRef = NULL;
    OSStatus ret;
    
    //这里的公钥部分的数据是按BER格式保存，module在前，exponent部分在后，其具体的格式为：
    // 序列类型 | 2部分的总长度 |[ [数值类型 | module的长度 | module的内容] | [数值类型 | exponent的长度 | exponent的内容] ]
    NSData *publicKeyData = publicKey;
    
    
    NSData *publicKeyTag = [@"wcypublickey.com" dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableDictionary *publicKeyDict = [[NSMutableDictionary alloc] init];
    [publicKeyDict setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [publicKeyDict setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicKeyDict setObject:publicKeyTag forKey:(__bridge id)kSecAttrApplicationTag];
    
    
    //从钥匙串中删除已经存在的密码
    SecItemDelete((__bridge CFDictionaryRef)publicKeyDict);
    
    //将密码添加入钥匙串中。
    [publicKeyDict setObject:publicKeyData forKey:(__bridge id)kSecValueData];
    [publicKeyDict setObject:(__bridge id) kSecAttrKeyClassPublic forKey:(__bridge id)kSecAttrKeyClass];
    [publicKeyDict setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    ret = SecItemAdd((__bridge CFDictionaryRef) publicKeyDict, (CFTypeRef *)&pubKeyRef);
    if (ret != 0 || pubKeyRef == NULL)
    {
        return nil;
    }
    
    
    //用生成的公钥加密数据,RSA加密算法对要加密的数字进行分块处理，每一块的长度 = 公钥长度 - 11（这里是对其字节数）
    //而对空出的11个字节采用了随机数的填充方法，所以每次用公钥加密出来的密文都是不一样的。
    NSMutableData *encryptedData = [[NSMutableData alloc] init];
    
    size_t cipherBufferSize = SecKeyGetBlockSize(pubKeyRef);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    memset((void *)cipherBuffer, 0x0, cipherBufferSize);
    
    
    NSData *plainTextBytes = rawData;
    NSInteger blockSize = __ISIOS5 ?  cipherBufferSize - 12 : cipherBufferSize -11;
    int numBlock = (int)ceil([plainTextBytes length] / (double)blockSize);
    for (int i=0; i<numBlock; i++) {
        
        NSInteger bufferSize = MIN(blockSize, [plainTextBytes length] - i * blockSize);
        NSData *buffer = [plainTextBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(pubKeyRef, kSecPaddingPKCS1,
                                        (const uint8_t *)[buffer bytes],
                                        [buffer length],
                                        cipherBuffer,
                                        &cipherBufferSize);
        
        if (status == noErr)
        {
            [encryptedData appendBytes:cipherBuffer length:cipherBufferSize];
            
        }
        else
        {
            break;
        }
        
    }
    
    if (cipherBuffer) {
        free(cipherBuffer);
    }
    
    CFRelease(pubKeyRef);
    
    return encryptedData;

}


+(NSData*)rsaDecrypt:(NSData*)privateKey ripeData:(NSData*)ripeData
{
    return nil;
}



+(NSData*)genDesKey
{
    
    //  return [@"123456789012345678901234" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *key = nil;
    //生成一个DESkey
    uint8_t * symmetricKey  = malloc( kCCKeySizeDES * sizeof(uint8_t) );
    memset((void *)symmetricKey, 0x0, kCCKeySizeDES);
    if (SecRandomCopyBytes(kSecRandomDefault, kCCKeySizeDES, symmetricKey) == 0)
        key = [[NSData alloc] initWithBytes:(const void *)symmetricKey length:kCCKeySizeDES];
    
    free(symmetricKey);
    
    return key;
}




 +(NSData*)desEncrypt:(NSData*)desKey rawData:(NSData*)rawData
 {
    //这里不使用padding，意味着字节流必须是8字节的倍数，后面要补0，如果是使用padding则可以不要考虑自己补齐。。
     
     NSData *rawDataPadding = rawData;
     int padingLen = rawDataPadding.length % 8;
     if (padingLen != 0)
     {
         NSMutableData *data = [[NSMutableData alloc] initWithCapacity:rawData.length + (8 - padingLen)];
         
         [data appendData:rawData];
         
         unsigned char pad[8] = {0,0,0,0,0,0,0,0};
         
         [data appendBytes:pad length:(8 - padingLen)];
         
         rawDataPadding = data;
     }
     
    return [self dealDesData:rawDataPadding context:kCCEncrypt padding: kCCOptionECBMode /*|kCCOptionPKCS7Padding*/ withKey:desKey];
 }

 +(NSData*)desDecrypt:(NSData*)desKey ripeData:(NSData*)ripeData
 {
     
    //这里不使用padding,原始数据解密后要把后面补的0清除，因为我们这里暂时只会转化为字符串，因此在转化为字符串后会忽略后面的0，所以这里暂时不考虑去除
     //尾部的0字节了。
     NSData *retData = [self dealDesData:ripeData context:kCCDecrypt padding:kCCOptionECBMode /*| kCCOptionPKCS7Padding*/ withKey:desKey];
     //从后面遇到非0则取消。
     if (retData == nil)
         return nil;
     
     unsigned char *bytes = (unsigned char*)retData.bytes;
     NSInteger i = retData.length;   //128
     for (; i > 0; i--)
     {
         if (bytes[i - 1] != 0)
             break;
     }
     
     if (i != retData.length)
     {
         return [NSData dataWithBytes:bytes length:i];
     }
     else
         return retData;
     
     
 }



@end

