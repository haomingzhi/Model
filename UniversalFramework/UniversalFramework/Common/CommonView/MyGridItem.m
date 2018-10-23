//
//  MyGridItem.m
//  MiniClient
//
//  Created by oybq on 13-4-17.
//  Copyright (c) 2013年 Wuxi Smart Sencing Star. All rights reserved.
//

#import "MyGridItem.h"
#import <QuartzCore/QuartzCore.h>



@implementation MyGridItem

-(id)init
{
    self = [super init];
    if (self != nil) {
        
        _style = ButtonTitleStyleDefault;
        _isEditable = NO;
        _isRemovable = NO;
        _padding = 3;
    }
    
    return self;
}

@end
