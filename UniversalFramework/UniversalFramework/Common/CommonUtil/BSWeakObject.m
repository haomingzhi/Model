//
//  BSWeakObject.m
//  MiniClient
//
//  Created by apple on 14-8-12.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "BSWeakObject.h"

@implementation BSWeakObject

-(id)initWithObject:(id)obj
{
    self = [self init];
    if (self != nil)
    {
        _obj = obj;
    }
    return self;
}

@end
