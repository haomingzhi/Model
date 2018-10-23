//
//  InviteMemerberDelegateObj.h
//  yihui
//
//  Created by air on 15/9/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BaseTableViewDelegateObj.h"

@interface InviteMemerberDelegateObj : BaseTableViewDelegateObj
//@property(nonatomic,strong) NSMutableArray *selectedArr;
@property(nonatomic,strong) NSMutableArray *inputSelectedDataArr;
@property(nonatomic,strong) NSMutableArray *selectedDataArr;
@property(nonatomic,strong) NSString *changeMark;
@property(nonatomic) NSInteger allCount;
@property(nonatomic,strong) NSString *title;
-(id)inviteJoinCircle;
@property(nonatomic,strong) void (^callBack)();
@property(nonatomic,strong) void (^getDataCallBack)(SEL sel,id obj);
@property(nonatomic,strong) void (^inviteCallBack)(NSArray *sArr,SEL sel,id obj);
-(void)initArrData:(NSArray *)arr;
@end
