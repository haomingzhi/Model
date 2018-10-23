//
//  BUMsgList.h
//  ulife
//
//  Created by sunmax on 16/1/6.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "BUImageRes.h"
@interface BUMsgList : BUBase
@property(nonatomic,strong)NSString *UserName;
@property(nonatomic,strong)NSString *InfoContent;
@property(nonatomic,strong)NSString *AddTime;
@property(nonatomic,strong)NSString *IsPublish;
@property(nonatomic,strong)NSString *Uid;
@property(nonatomic,strong)NSString *InformationId;
@property(nonatomic,strong)NSString *Area;
@property(nonatomic,strong)NSString *Status;
@property(nonatomic,strong)BUImageRes *HeadImg;
@property(nonatomic,strong)NSArray *Images;
@end
