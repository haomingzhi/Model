//
//  BUAddress.m
//  chenxiaoer
//
//  Created by sunmax on 16/3/22.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "BUMapAddress.h"

@implementation BUMapAddress

-(NSDictionary *)getDataDic:(NSString *)tag
{
    BOOL isD = NO;
    if ([_isdefault isEqualToString:@"1"]) {
        isD = YES;
    }
    return @{@"nameImg":[self getImg:@"user@2x"],@"phoneImg":[self getImg:@"PhoneNumber@2x"],@"addressImg":[self getImg:@"positioning@2x"],@"address":_address?:@"",@"phone":_rectell?:@"",@"name":_recipient?:@"",@"mark":@(isD),@"addressId":_adressid?:@""};
}

-(UIImage *)getImg:(NSString *)str
{
    UIImage *img = [UIImage imageContentWithFileName:str];
    return img;
}
@end
