//
//  BUImageRes.m
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/6/2.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BUImageRes.h"
#import "BUSystem.h"

@implementation BUImageRes

-(id) init
{
    self = [super init];
    if (self) {
         self.deserializationMap = @{@"imagePath":@"Image",@"image":@"Image",@"businessCard":@"Image",@"logo":@"Image",@"HeadImg":@"Image",@"Path":@"Image",@"InfoImage":@"Image",@"shareQRCode":@"Image",@"headImage":@"Image",@"identitycationImage":@"Image",@"adpDemoImg":@"Image",@"proImagePic":@"Image",@"pClassImg":@"Image",@"proImagePic":@"Image",@"pDefImg":@"Image",@"aImg":@"Image",@"proImagePic":@"Image",@"saImg":@"Image",@"pClassImg":@"Image",@"avatar":@"Image",@"logoUrl":@"Image",@"stationImage":@"Image",@"goodsImage":@"Image",@"userHead":@"Image",@"userImage":@"Image",@"qrCode":@"Image",@"stationImage":@"Image",@"img":@"Image",@"goodsDefaultPic":@"Image",@"signPicture":@"Image",@"userImg":@"Image"};
    }
    return self;
}

-(void)setImage:(NSString *)Image
{
    _Image = Image;
    [self paramInit:BU_BUSINESS_DOMAINIP relativeURL:_Image type:BURESTYPE_IMAGE];
}


-(NSString *)description
{
    return self.relativeURL;
}
-(NSDictionary *)getDic
{
    return @{@"img":_Image?:@""};
}
@end
