//
//  BUAbout.h
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/6/30.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//


#import "BUImageRes.h"

@interface BUAbout : BUBase

@property(strong,nonatomic) BUImageRes *logo;   //图标
@property(nonatomic) NSString *introduce;       //简介
@property(nonatomic) NSString *weixin;          //微信
@property(nonatomic) NSString *weibo;           //微博
@property(strong,nonatomic) NSString *contact;  //联系方式

-(BOOL) getAboutInfo:(id) observer callback:(SEL) callback;

@end
