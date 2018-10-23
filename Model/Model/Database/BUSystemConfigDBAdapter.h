//
//  BUSystemConfigDBAdapter.h
//  MiniClient
//
//  Created by Apple on 14-7-24.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "BUDBAdapter.h"

@interface BUSystemConfigDBAdapter : BUDBAdapter
-(id)initWithDb:(BSDatabase*)db;
-(BOOL)updateValue:(NSString *)key Value:(NSString*)value;
-(BOOL)insert:(NSString *)key Value:(NSString *)value;
@end
