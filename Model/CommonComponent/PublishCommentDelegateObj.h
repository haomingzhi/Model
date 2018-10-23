//
//  PublishCommentDelegateObj.h
//  yihui
//
//  Created by wujiayuan on 15/9/23.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "BaseTableViewDelegateObj.h"

@interface PublishCommentDelegateObj : BaseTableViewDelegateObj
@property(nonatomic,strong) void (^callBack)(id obj);
@end
