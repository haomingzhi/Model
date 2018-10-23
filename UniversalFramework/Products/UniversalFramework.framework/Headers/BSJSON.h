//
//  BSJSON.h
//  SCWCYClient
//
//  Created by apple on 14-5-26.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

//简单的JSON解析器，一般是小型的数组，暂时不支持数组，字典。只支持NSString, int, float,double,boolean,BSJSON, Array<BSJSON>
@interface BSJSON : NSObject


//根据数据初始化BSJSON对象。。
-(instancetype)initWithData:(NSData*)aData encoding:(NSStringEncoding)encoding;


-(BSJSON*)setObject:(id)anObject forKey:(id<NSCopying>)aKey;
-(BSJSON*)setInt:(NSInteger)anInt forKey:(id<NSCopying>)aKey;
-(BSJSON*)setFloat:(CGFloat)anFloat forKey:(id<NSCopying>)aKey;
-(BSJSON*)setDouble:(double)anDouble forKey:(id<NSCopying>)aKey;
-(BSJSON*)setBoolean:(BOOL)anBool forKey:(id<NSCopying>)aKey;


-(NSInteger) count;
//取值
-(id)objectForKey:(id<NSCopying>)aKey;
-(id)objectForIndex:(NSInteger) index;

//序列化
-(NSData*)serialization:(NSStringEncoding)encoding;

-(NSString*)serializationHelper;

-(NSInteger) indexOfkey:(NSString *)key;
//把json反序列化到obj中
-(id) deserialization:(id)obj;

@end
