//
//  BSJSON.m
//  SCWCYClient
//
//  Created by apple on 14-5-26.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "BSJSON.h"
#import <objc/runtime.h>

@interface BSJSON ()

@property(nonatomic) NSMutableArray *keys;
@property(nonatomic) NSMutableArray *vals;


//序列化帮助
-(NSString*)serializationHelper;


//键的索引，如果没有则添加
-(NSInteger)keyIndex:(id<NSCopying>)aKey;


@end

@implementation BSJSON

#pragma mark -- Overwritte Method

-(instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        _keys = [[NSMutableArray alloc] init];
        _vals = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(NSString*)description
{
    return [self serializationHelper];
}



#pragma mark -- Public Method

//初始化根据字符串
-(instancetype)initWithString:(NSString*)aString
{
    self = [self init];
    if (self != nil)
    {
        
        //检测{ 表示开始 检查key 保存到_keys中，然后到:以后，如果是" 开头则是字符串，如果是true,false则是boolean,如果是
        //{则是新的json，那么查找到匹配的}并截取放入到一个新的对象中，如果是[则表示是数组，查找到对应的]并把中间部分组合并处理
        //否则就是数字。
        
    }
    
    return self;

}

-(instancetype)initWithDictionary:(NSDictionary*)dict
{
    self = [self init];
    if (self != nil)
    {
        //遍历字典保存到数组中
        for (NSString *key in dict)
        {
            [_keys addObject:key];
            NSObject *objVal = [dict objectForKey:key];
            if ([objVal isKindOfClass:[NSDictionary class]])
            {
                [_vals addObject:[[BSJSON alloc] initWithDictionary:(NSDictionary*)objVal]];
            }
            else if ([objVal isKindOfClass:[NSArray class]])
            {
                //数组里面必须是字典。。。否则无法解释
                NSMutableArray *arrObj = [[NSMutableArray alloc] init];
                
                
                for (NSDictionary *subDict in (NSArray*)objVal)
                {
                    if (subDict != NULL && [subDict isKindOfClass:[NSArray class]]) {
                        [arrObj addObject: [[[NSArray alloc] init] arrayByAddingObjectsFromArray:(NSArray *)subDict]  ];
                    }
                    else if ([subDict isKindOfClass:[NSString class]] || [subDict isKindOfClass:[NSNumber class]])
                    {
                        [arrObj addObject:(NSString *)subDict];
                    }
                    else
                        [arrObj addObject:[[BSJSON alloc] initWithDictionary:subDict]];
                }
                
                [_vals addObject:arrObj];
                
            }
            else
                [_vals addObject:objVal];
        }
        
        
        
    }
    
    return self;
}

-(instancetype)initWithData:(NSData*)aData encoding:(NSStringEncoding)encoding
{
    //这里要去除末尾0
    
    NSDictionary *dict =  [NSJSONSerialization JSONObjectWithData:aData options:0 error:nil];
    if (dict == nil)
    {
        self = nil;
        return self;
    }
    if ([dict isKindOfClass:[NSArray class]]) {
        return (NSArray *)dict;
    }
    return [self initWithDictionary:dict];
}

//避免由于anObject == null 导致的崩溃
-(BSJSON*)setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject == NULL ) {
        NSLog(@"%@ == null",aKey);
        return  self;
    }
    //只支持NSString,NSNumber(int, float, double, boolean), BSJSON
    NSInteger idx = [self keyIndex:aKey];
    [_vals replaceObjectAtIndex:idx withObject:anObject];
    
    return self;
    
}

-(BSJSON*)setInt:(NSInteger)anInt forKey:(id<NSCopying>)aKey
{
    return [self setObject:[NSString stringWithFormat:@"%ld",anInt] forKey:aKey];
}

-(BSJSON*)setFloat:(CGFloat)anFloat forKey:(id<NSCopying>)aKey
{
    return [self setObject:[NSString stringWithFormat:@"%f",anFloat] forKey:aKey];
}

-(BSJSON*)setDouble:(double)anDouble forKey:(id<NSCopying>)aKey
{
    return [self setObject:[NSString stringWithFormat:@"%f",anDouble] forKey:aKey];
}

-(BSJSON*)setBoolean:(BOOL)anBool forKey:(id<NSCopying>)aKey
{
    return [self setObject:[NSString stringWithFormat:@"%d",anBool] forKey:aKey];
}

-(NSInteger) indexOfkey:(NSString *)key
{
    return [_keys indexOfObject:key];
}

-(id)objectForKey:(id<NSCopying>)aKey
{
    NSInteger idx = [_keys indexOfObject:aKey];
    if (idx ==  NSNotFound)
        return nil;
    else {
        return [self objectForIndex:idx];
    }
}

-(id)objectForIndex:(NSInteger) index
{
    if (index < _vals.count) {
        id val= [_vals objectAtIndex:index];
        if([val isKindOfClass:[NSNumber class]])
        {
            NSNumber *num = (NSNumber*)val;
            const char *ctype = num.objCType;
            if (*ctype == 'd') {
                return [NSString stringWithFormat:@"%f",num.floatValue];
            }
            else {
                
                NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
                return [numberFormatter stringFromNumber: val];
            }
        }
        else
            return val;
    }
    return NULL;
}

-(NSInteger) count
{
    return _vals.count;
}

-(NSString*)stringForKey:(id<NSCopying>)aKey
{
    return [[self objectForKey:aKey] description];
}


-(NSData*)serialization:(NSStringEncoding)encoding
{
    return [[self serializationHelper] dataUsingEncoding:encoding];
}


-(NSString*)serializationHelper
{
    NSMutableString *result =  [[NSMutableString alloc] init];
    
    [result appendString:@"{"];
    
    //先不考虑包含特殊字符的情况
    for (NSInteger i = 0; i < _keys.count; i++)
    {
        NSString *strKey = [_keys objectAtIndex:i];
        NSObject *objVal = [_vals objectAtIndex:i];
        
        if (i != 0)
            [result appendString:@","];
        
        [result appendFormat:@"\"%@\":", strKey];
        
        //添加value
        if ([objVal isKindOfClass:[NSString class]])
        {
            [result appendFormat:@"\"%@\"", (NSString*)objVal];
        }
        else if ([objVal isKindOfClass:[NSNumber class]])
        {
            //如果是boolean型则特殊处理。。。
            NSNumber *num = (NSNumber*)objVal;
            const char *ctype = num.objCType;
            if (*ctype == 'B')
                [result appendFormat:@"%@", num.boolValue ? @"true" : @"false"];
            else
                [result appendFormat:@"%@",objVal];
        }
        else if ([objVal isKindOfClass:[BSJSON class]])
        {
            [result appendString:[((BSJSON*)objVal) serializationHelper]];
        }
        else if ([objVal isKindOfClass:[NSNull class]])
        {
            [result appendString:@"null"];
        }
        else if ([objVal isKindOfClass:[NSArray class]])
        {
            [result appendString:@"["];
            NSArray *arr = (NSArray*)objVal;
            
            for (int j = 0; j < arr.count; j++)
            {
                if (j != 0)
                    [result appendString:@","];
                id obj = [arr objectAtIndex:j];
                if ([obj respondsToSelector:@selector(toJson)])
                {
                    [result appendFormat:@"%@", [obj performSelector:@selector(toJson) withObject:NULL ]];
                }else  if ([obj isKindOfClass:[NSString class]])
                {
                    [result appendFormat:@"\"%@\"", (NSString*)obj];
                }
                else
                [result appendFormat:@"%@", [arr objectAtIndex:j]];
            }
            
            [result appendString:@"]"];
            
        }
        else
        {
            //崩溃！！
            NSAssert(0, @"error");
        }
    }
    
    [result appendString:@"}"];
    NSLog(@"%@",result);
    return result;
}


-(SEL) findCustomTransformer:(NSString *) sourceClass targetValueType:(NSString *) targetValueType
{
    //BUResFromNSString:
    NSString* selectorName = [NSString stringWithFormat:@"%@From%@:",
                              targetValueType, //target name
                              sourceClass]; //source name
    SEL selector = NSSelectorFromString(selectorName);
    
    //check for custom transformer
    BOOL foundCustomTransformer = NO;
    if ([BSJSONValueTransformer respondsToSelector:selector]) {
        foundCustomTransformer = YES;
    } else {
        //try for hidden custom transformer
        selectorName = [NSString stringWithFormat:@"__%@",selectorName];
        selector = NSSelectorFromString(selectorName);
        if ([BSJSONValueTransformer respondsToSelector:selector]) {
            foundCustomTransformer = YES;
        }
    }
    return foundCustomTransformer ? selector : NULL;
}
-(id)deserializationArray:(NSArray *)jsonArray obj:(id)obj clssName:(Class )class
{
    for (int i=0; i <jsonArray.count; i++) {
        id item = [[class alloc] init];
        if ([jsonArray[i] isKindOfClass:[BSJSON class]]) {
            [((BSJSON *) jsonArray[i]) deserialization:item];
        }
        else {//字符串
            if ([NSStringFromClass(class) isEqualToString:@"BUImageRes"]) {
                [item setValue: jsonArray[i] forKey:@"Image"];
            }
            else if ([NSStringFromClass(class) isEqualToString:@"NSString"])
            {
                item = jsonArray[i];
            }
        }
        [((NSMutableArray *)obj ) addObject:item];
    }
    return obj;
}





//把json反序列化到obj中
-(id) deserialization:(id)obj
{
    return [self deserializationSpecifityMap:obj map:NULL];
}

-(NSString *)keyMapSpecify:(NSString *) key obj:(id)obj map:(NSDictionary *) map
{
    if (map) {
        key = map[key] == NULL ? key : map[key];
        if ([key componentsSeparatedByString:@","].count >1) {
            return [key componentsSeparatedByString:@","][1];
        }
        return key;
    }
    return key;
}


-(NSString *)keyMap:(NSString *) key obj:(id)obj
{
    NSDictionary *map ;
    if ([obj isKindOfClass:NSClassFromString(@"BUBase")])
        map =  (NSDictionary *)[obj valueForKey:@"deserializationMap"];
    return [self keyMapSpecify:key obj:obj map:map];
}

-(NSString *) classMapSpecify:(NSString *) key obj:(id)obj map:(NSDictionary *) map
{
    NSString *className = key;
    if (map) {
        className = map[key] == NULL ? key : map[key];
    }
    return [className componentsSeparatedByString:@","].count >1 ? className :  [NSString stringWithFormat:@"%@,%@",className,[self getpropertyType:className]];
}


-(NSString *)classMap:(NSString *) key obj:(id)obj
{
    NSDictionary *map;
    if ([obj isKindOfClass:NSClassFromString(@"BUBase")]) {
        map =  (NSDictionary *)[obj valueForKey:@"deserializationMap"];
    }
    return [self classMapSpecify:key obj:obj map:map];
}


//把json反序列化到obj中
-(id) deserializationSpecifityMap:(id)obj map:(NSDictionary *) map
{
    if ([self isKindOfClass:[NSArray class]]) {
        NSLog(@"请调用-(id)deserializationArray:(id)obj clssName:(Class )class %@",@"");
        return NULL;
    }
    else {
        if ([obj isKindOfClass:NSClassFromString(@"BUBase")]) {
            map =  map ? map : (NSDictionary *)[obj valueForKey:@"deserializationMap"];
        }
        for (int i =0; i < _vals.count; i++) {
            NSString *key = _keys[i];
            if (![self isExists:obj key:key] && ![self isExists:obj key:[self keyMapSpecify:key obj:obj map:map ]]) {//判断对象中是否有这个属性，如果没有这个属性跳过
                continue;
            }
            id value = [self objectForIndex:i];
            if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
            {
                key = [self keyMapSpecify:key obj:obj map:map];
                //====类型转义===//BUResFromNSString
                SEL valueTransformer = [self findCustomTransformer:@"NSString" targetValueType:[obj getpropertyType:key]];
                if (valueTransformer) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    //transform the value
                    id transformedValue = [BSJSONValueTransformer performSelector:valueTransformer withObject:value];
#pragma clang diagnostic pop
                    
                    if (![transformedValue isEqual:[obj valueForKey:key]]) {
                        [obj setValue:transformedValue forKey: key];
                    }
                    continue;
                }
                //========//
                if ([value isKindOfClass:[NSString class]] )
                {
                    NSString *className = [obj getpropertyType:key];
                    if (!className) continue;//屏蔽只读属性
                    if (map != NULL && [map.allKeys indexOfObject:className] != NSNotFound) {//根据类型映射，主要解决BUImageRes
                        id propertyValue = [[NSClassFromString(className) alloc] init];
                        [propertyValue setValue:value forKey:[self keyMap:key obj:propertyValue]];
                        [obj setValue:propertyValue forKey:key];
                        continue;
                    }
                    else
                    {
                        if ([className isEqualToString:@"int"] || [className isEqualToString:@"short"] || [className isEqualToString:@"long"] || [className isEqualToString:@"BOOL"] || [className isEqual:@"NSInteger"]) {
                            [obj setValue:[NSNumber numberWithInteger:[value integerValue]]  forKey:key];
                        }
                        else if ([className isEqualToString:@"float"] || [className isEqualToString:@"double"] )
                        {
                            [obj setValue:[NSNumber numberWithDouble:[value doubleValue]]  forKey:key];
                        }
                        else
                            [obj setValue:value forKey:key];
                    }
                }
                else
                [obj setValue:value forKey:key];
            }
            else {//复杂类型（json，nsarray
                NSString * className = [self classMapSpecify:key obj:obj map:map];
                if ([className componentsSeparatedByString:@","].count >1) {
                    key = [className componentsSeparatedByString:@","][1];
                    className = [className componentsSeparatedByString:@","][0];
                }
                if ([value isKindOfClass:[BSJSON class]]) {//子对象
                    
                    id subObj= [[NSClassFromString(className) alloc] init];
                    if ([obj isExists:key]) {
                        [obj setValue:[(BSJSON *)value deserialization:subObj ] forKey:key];
                    }
                    else if ([obj isExists:key.lowercaseString])
                    {
                        [obj setValue:[(BSJSON *)value deserialization:subObj ] forKey:key.lowercaseString];
                    }
                }
                else {
                    if ([value isKindOfClass:[NSArray class]]) {
                        if (className == NULL) {
                            NSLog(@"出错啦，数组[%@]映射类未定义",key);
                            continue;
                        }
                        id arrayObj = [obj valueForKey:key];
                        if (arrayObj == NULL) {
                            arrayObj = [[NSMutableArray alloc] init];
                        }
                        [self deserializationArray:(NSArray *) value obj:arrayObj clssName:NSClassFromString (className)];
                        [obj setValue:arrayObj forKey:key];
                    }
                }
            }  
        }
    }
    return obj;
}


#pragma mark -- Private Method

-(BOOL) isExists:(id) obj key:(NSString *)key
{
//    static NSUInteger objHash;
//    static NSMutableArray *propertyList;
//    static dispatch_once_t done;
//    done = objHash == [obj hash] ? -1 : 0;
//    if (objHash != [obj hash]) {
//        
//    
//    //dispatch_once(&done, ^{ //单例，done ==0的时候执行单例初始化
//        objHash = [obj hash];
//        unsigned int outCount, i;
//        propertyList = [[NSMutableArray alloc] init];
//        objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
//        for (i=0; i<outCount; i++)
//        {
//            objc_property_t property = properties[i];
//            NSString * propertyName = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
//            //NSLog(@"%@",[NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding]);
//            [propertyList addObject:propertyName];
//        }
//    }
//    //});
    return [[obj getPropertyKeyList] indexOfObject:key] != NSNotFound;
}

-(void) setObjectValueForKey:(id) obj value:(id) value forKey:(NSString *) key
{
    if ([self isExists:obj key:key]) {
        [obj setValue:value forKey:key];
    }
}

-(NSInteger)keyIndex:(id<NSCopying>)aKey
{
    NSInteger idx = [_keys indexOfObject:aKey];
    if (idx ==  NSNotFound)
    {
        [_keys addObject:aKey];
        [_vals addObject:[NSNull null]];
        idx  = _keys.count - 1;
    }

    return idx;
    
}
@end
