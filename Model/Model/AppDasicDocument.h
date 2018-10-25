//
//  AppDasicDocument.h
//  ulife
//
//  Created by sunmax on 15/12/31.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
//#import "BUInstruction.h"
//#import "BUNoticeList.h"
@interface AppDasicDocument : BUBase
@property(nonatomic,strong)NSArray *instructionList;
@property(strong,nonatomic) NSString *Content;//版本说明
@property(strong,nonatomic) NSString *Banben;//版本
//@property(nonatomic,strong) BUInstruction *notice;

//使用说明详情
-(BOOL)instruction:(NSString*)InsId  Uid:(NSString*)Uid  observer:(id)observer callback:(SEL)callback;

//使用说明
-(BOOL)instructionUid:(NSString*)Uid  observer:(id)observer callback:(SEL)callback;

//意见反馈
-(BOOL)writeBack:(NSString*)Content  observer:(id)observer callback:(SEL)callback;

//关于我们
-(BOOL)aboutUsObserver:(id)observer callback:(SEL)callback;
@end
