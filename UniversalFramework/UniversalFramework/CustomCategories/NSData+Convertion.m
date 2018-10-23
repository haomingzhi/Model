//
//  NSData+Convertion.m
//  SCWCYClient
//
//  Created by apple on 14-5-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSData+Convertion.h"


@implementation NSData (Convertion)

-(NSString*)hexStr
{
    if (self == nil)
        return nil;
    
    char *result = malloc(self.length * 2 + 1);
    if (result == NULL)
        return nil;
    
    char *t = result;
    *t = '\0';
    unsigned char *buffer = (unsigned char*)self.bytes;
    NSInteger len = self.length;
    for (int i = 0; i < len; i++)
    {
        sprintf(t, "%02X", buffer[i]);
        t += 2;
    }
    
    NSString *str = [NSString stringWithCString:result encoding:NSASCIIStringEncoding];
    free(result);
    return str;
}

-(NSData*)md5Data
{
    if(self == nil || self.length == 0)
        return nil;
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, self.length, outputBuffer);
    
    return [NSData dataWithBytes:outputBuffer length:CC_MD5_DIGEST_LENGTH];
}


@end
