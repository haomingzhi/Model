//
//  BUGetCommentListManager.h
//  compassionpark
//
//  Created by air on 2017/3/27.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "BUBasePageDataManager.h"
#import "BUImageRes.h"

@interface BUGetComment : BUBase
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic) NSArray *picList;
@property(strong,nonatomic) BUImageRes *userImg;
@property(strong,nonatomic) NSString *context;
@property(strong,nonatomic) NSString *userName;
-(NSDictionary *)getDic:(NSInteger)index;
@end
@interface BUGetCommentListManager : BUBasePageDataManager
@property(nonatomic,strong)NSArray *getCommentList;

-(BOOL)getCommentList:(NSString*) userId productId:(NSString*) productId   observer:(id)observer callback:(SEL)callback;
-(BOOL)getCommentList:(NSString*) userId productId:(NSString*) productId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getCommentListNextPage:(id)observer callback:(SEL)callback ;
-(BOOL)getCommentListNextPage:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)addComment:(NSString*) type withOrderid:(NSString*) orderId  withCommentList:(NSArray *)commentList observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)addComment:(NSString*) type withOrderid:(NSString*) orderId  withCommentList:(NSArray *)commentList observer:(id)observer callback:(SEL)callback;
-(BOOL)getCommentbyOrderId:(NSString*) sid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getCommentbyOrderId:(NSString*) sid observer:(id)observer callback:(SEL)callback;

-(BOOL)getComment:(NSString*) sid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getComment:(NSString*) sid observer:(id)observer callback:(SEL)callback;
@end
