//
//  BSWeakObject.h
//  MiniClient
//
//  Created by apple on 14-8-12.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
  弱引用对象。可以在这个对象里面保存一个弱引用的真实对象。
 */
@interface BSWeakObject : NSObject


@property(nonatomic, weak,readonly) id obj;    //这里弱引用。

-(id)initWithObject:(id)obj;


@end
