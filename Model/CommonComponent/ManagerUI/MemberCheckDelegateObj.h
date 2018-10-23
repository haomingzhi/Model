//
//  MemberCheckDelegateObj.h
//  yihui
//
//  Created by air on 15/9/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BaseTableViewDelegateObj.h"

@interface MemberCheckDelegateObj : BaseTableViewDelegateObj
@property(nonatomic,strong) NSMutableArray *selectedArr;
@property(nonatomic,strong) NSString *changeMark;
@property(nonatomic) NSInteger allCount;
-(id)inviteJoinCircle;
//@property(nonatomic,strong) void (^callBack)();
@property(nonatomic,strong) void (^callBack)(id obj,SEL sel);                   //提交以后
@property(nonatomic,strong) void (^getDataCallBack)(id obj,SEL sel);            //load的时候调用
@property(nonatomic,strong) void (^checkCallBack)(NSArray *aArr,id obj,SEL sel);//提交数据ing
@end
