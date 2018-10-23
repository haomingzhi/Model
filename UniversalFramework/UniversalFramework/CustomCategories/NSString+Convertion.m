//
//  NSString+HexData.m
//  SCWCYClient
//
//  Created by apple on 14-5-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "NSString+Convertion.h"
#import "NSData+Convertion.h"

@implementation NSString (Convertion)

-(NSData*)hexData
{
    if (self == nil)
        return nil;
    if(self.length ==0)
        return nil;
    //字符串必须是16进制描述也就是必须是0-9,A-F,这里不做检查，我们假设他是按照要求来的。
    if (self.length %2 == 1)
        return nil;    //必须是偶数,且长度必须大于

    NSInteger len = self.length / 2;
    unsigned char *result = malloc(len);
    unsigned char *t = result;
    if (result == NULL)
        return nil;
    
    for (NSInteger i = 0; i < self.length; i+=2)
    {
        int h = [self characterAtIndex:i] - 48;
        int l = [self characterAtIndex:i+1] - 48;
        
        if (h >= 17 && h <= 22)
            h -= 7;   //大写A-F
        else if (h >= 49 && h <= 54)
            h -= 39;  //小写a-f
        else if (h >= 0 && h <=9)
            h -= 0;
        else
        {
            free(result);  //不正确格式
            return nil;
        }
            
        
        if (l >= 17 && l <= 22)
            l -= 7;
        else if (l >= 49 && l <= 54)
            l -= 39;
        else if (l >= 0 && l <= 9)
            l -= 0;
        else
        {
            free(result);
            return nil;
        }
        
        
        *t = ((h << 4) & 0xF0) + (l & 0x0F);
        
        t = t+1;
    }
    
    
    return [NSData dataWithBytesNoCopy:result length:len];
}

-(NSString*)md5String
{
   return [self dataUsingEncoding:NSUTF8StringEncoding].md5Data.hexStr;
}

-(NSData *)utf8DataPadding
{
    NSData *result = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (result.length % 8 ==0) {
        return result;
    }
    NSInteger len = result.length + 8 -(result.length % 8);
    char tmpBuffer[len];
    memset(tmpBuffer, 0x00, len);
    memcpy(tmpBuffer, result.bytes, result.length);
    return [NSData dataWithBytes:tmpBuffer length:len];
}
-(NSString*)trimString
{
   return [self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \t"]];
    
}

/**
 *  删除指定字符集
 *
 *  @param specifity 要过滤的字符集
 *
 *  @return 过滤后字符串
 */
-(NSString *)trimSpecifity:(NSString *)specifity
{
    NSArray *subStrings = [self componentsSeparatedByCharactersInSet:
                    
                    [NSCharacterSet characterSetWithCharactersInString:specifity]];
    NSString *filtered =[subStrings componentsJoinedByString:@""];
    return filtered;
}

-(NSString*)insertString:(NSString*)string space:(NSInteger)space
{
    NSMutableString *returnString = [NSMutableString stringWithString:self];
    NSInteger n = 0;
    for (NSInteger i = space; i < (int)(self.length); i += space)
    {
        [returnString insertString:string atIndex:i + n];
        n++;
    }
    
    return returnString;
}

-(NSString*)formatWithFormatString:(NSString*)fmt
{
    if (fmt.length == 0)
        return self;
    
    if (self.length == 0)
        return self;
    
    NSMutableData *data = [[NSMutableData alloc] init];
    int j = 0;
    for (int i = 0; i < self.length; i++)
    {
        unichar ch = [self characterAtIndex:i];
        if (j < fmt.length)
        {
            unichar fmtchr = [fmt characterAtIndex:j];
            if (fmtchr == 0x0058)  //'X'
            {
                [data appendBytes:&ch length:sizeof(ch)];
            }
            else
            {
                [data appendBytes:&fmtchr length:sizeof(fmtchr)];
                i--;
            }
        }
        else
            [data appendBytes:&ch length:sizeof(ch)];
        
        j++;
        
    }
    
    return [[NSString alloc] initWithCharacters:data.bytes length:data.length/sizeof(unichar)];
}
-(NSData*) networkDataToNSData
{
    if (self.length %3 ==0) {
        NSInteger rawBufferLength = self.length /3;
        unsigned char rawData[rawBufferLength];
        //memset(rawBufferLength, 0x00, rawBufferLength);
        for (NSInteger i = 0; i < [self length]; i += 3) {
            
            NSString *hex = [self substringWithRange:NSMakeRange(i+1, 2)];
            UInt32 decimalValue = 0;
            sscanf([hex UTF8String], "%x", &decimalValue);
            rawData[i/3] = decimalValue;
        }
        return [NSData dataWithBytes:rawData length:rawBufferLength];
    }
    return NULL;
}

-(CGSize) size:(UIFont *)font constrainedToSize:(CGSize) constrainedToSize
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    // 计算文本的大小
    CGSize s = [self boundingRectWithSize:constrainedToSize // 用于计算文本绘制时占据的矩形块
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                                 attributes:attribute        // 文字的属性
                                                    context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return s;
}



@end
