//
//  NSObject+Runtime.m
//  JiXie
//
//  Created by ORANLLC_IOS1 on 15/6/17.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>


#pragma mark - associated objects names

static const char * kClassPropertiesKey;


@implementation NSObject (Runtime)




-(void)__setup__
{
    //if first instance of this model, generate the property list
    if (!objc_getAssociatedObject(self.class, &kClassPropertiesKey)) {
        [self __inspectProperties];
    }
    
}

//inspects the class, get's a list of the class properties
-(void)__inspectProperties
{
    static NSDictionary* primitivesNames;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        primitivesNames  = @{@"f":@"float", @"i":@"int", @"d":@"double", @"l":@"long", @"c":@"BOOL", @"s":@"short", @"q":@"long",
                             //and some famos aliases of primitive types
                             // BOOL is now "B" on iOS __LP64 builds
                             @"I":@"NSInteger", @"Q":@"NSUInteger", @"B":@"BOOL",
                             
                             @"@?":@"Block"};
    });
    
    
    //JMLog(@"Inspect class: %@", [self class]);
    
    NSMutableDictionary* propertyIndex = [NSMutableDictionary dictionary];
    
    //temp variables for the loops
    Class class = [self class];
    NSScanner* scanner = nil;
    NSString* propertyType = nil;
    
    // 向上遍历到BUBase
    
    while (class && (![NSStringFromClass(class) isEqualToString:@"BUBase"] && ![NSStringFromClass(class) isEqualToString:@"BaseTableViewCell"]&& ![NSStringFromClass(class) isEqualToString:@"UICollectionViewCell"]  )) {
        //JMLog(@"inspecting: %@", NSStringFromClass(class));
        
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
        
        //loop over the class properties
        for (unsigned int i = 0; i < propertyCount; i++) {
            
            ClassProperty* p = [[ClassProperty alloc] init];
            
            //get property name
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            p.name = @(propertyName);
            
            //JMLog(@"property: %@", p.name);
            
            //get property attributes
            const char *attrs = property_getAttributes(property);
            NSString* propertyAttributes = @(attrs);
            NSArray* attributeItems = [propertyAttributes componentsSeparatedByString:@","];
            
            //ignore read-only properties
            if ([attributeItems containsObject:@"R"]) {
                continue; //to next property
            }
            
            //check for 64b BOOLs
            if ([propertyAttributes hasPrefix:@"Tc,"]) {
                //mask BOOLs as structs so they can have custom convertors
                p.propertyType = @"BOOL";
            }
            
            scanner = [NSScanner scannerWithString: propertyAttributes];
            
            //JMLog(@"attr: %@", [NSString stringWithCString:attrs encoding:NSUTF8StringEncoding]);
            [scanner scanUpToString:@"T" intoString: nil];
            [scanner scanString:@"T" intoString:nil];
            
            //check if the property is an instance of a class
            if ([scanner scanString:@"@\"" intoString: &propertyType]) {
                
                [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"<"]
                                        intoString:&propertyType];
                
                //JMLog(@"type: %@", propertyClassName);
                p.propertyType = propertyType;
                p.isMutable = ([propertyType rangeOfString:@"Mutable"].location != NSNotFound);
                
                //read through the property protocols
                while ([scanner scanString:@"<" intoString:NULL]) {
                    
                    NSString* protocolName = nil;
                    
                    [scanner scanUpToString:@">" intoString: &protocolName];
                    
                    if ([protocolName isEqualToString:@"Optional"]) {
                        p.isOptional = YES;
                    }
                    else {
                        p.protocol = protocolName;
                    }
                    
                    [scanner scanString:@">" intoString:NULL];
                }
                
            }
            //check if the property is a structure
            else if ([scanner scanString:@"{" intoString: &propertyType]) {
                [scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet]
                                    intoString:&propertyType];
                p.propertyType = propertyType;
                
            }
            //the property must be a primitive
            else {
                
                //the property contains a primitive data type
                [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@","]
                                        intoString:&propertyType];
                
                //get the full name of the primitive type
                propertyType = primitivesNames[propertyType];
                p.propertyType = propertyType;
            }
            
            
            //add the property object to the temp index
            if (p && ![propertyIndex objectForKey:p.name]) {
                [propertyIndex setValue:p forKey:p.name];
            }
        }
        
        free(properties);
        
        //ascend to the super of the class
        //(will do that until it reaches the root class - JSONModel)
        class = [class superclass];
    }
    
    //finally store the property index in the static property index
    objc_setAssociatedObject(
                             self.class,
                             &kClassPropertiesKey,
                             [propertyIndex copy],
                             OBJC_ASSOCIATION_RETAIN // This is atomic
                             );
}

-(NSDictionary *) getClassProperties
{
    //fetch the associated object
    NSDictionary* classProperties = objc_getAssociatedObject(self.class, &kClassPropertiesKey);
    if (classProperties) return classProperties;
    
    //if here, the class needs to inspect itself
    [self __setup__];
    
    //return the property list
    classProperties = objc_getAssociatedObject(self.class, &kClassPropertiesKey);
    return classProperties;
}

-(NSArray *) getPropertyKeyList
{
    return [self getClassProperties].allKeys;
}

-(NSArray *) getPropertyList
{
    return [self getClassProperties].allValues;
}

//model.propertyName 在view中映射，如果成功，返回对应的名字，如果失败返回""或null
-(NSString *) propertyMap:(NSString *) propertyName
{
    NSArray * plist = [self getPropertyList];
    for (ClassProperty *pItem in plist) {
        if ([[pItem.name lowercaseString] hasPrefix:[propertyName lowercaseString]] || [[pItem.name lowercaseString] hasSuffix:[propertyName lowercaseString]] )//前缀相同，或者后缀相同，表示匹配成功
        {
            return pItem.name;
        }
    }
    return @"";
}

-(ClassProperty *) getclassProperty:(NSString *)propertyName
{
    NSDictionary *plist = [self getClassProperties];
    return plist[propertyName];
}

-(BOOL) isExists:(NSString *)key
{
    return [self getclassProperty:key] != NULL;
}

//返回属性类型入：NSString* 返回 NSString
-(NSString *)getpropertyType:(NSString *)propertyName
{
    NSDictionary *classProperties = [self getClassProperties];
    ClassProperty *p = classProperties[propertyName];
    return [p.propertyType isEqual:NSStringFromClass([NSArray class])]  && p.protocol ? p.protocol : p.propertyType;
}


//取得属性-值，键值对
-(NSDictionary *) propertyKeyValues
{
    return  [self propertyKeyValues:[self getPropertyKeyList]];
}
-(NSDictionary *) propertyKeyValues:(NSArray *) propertys
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    for (NSString * propertyName in propertys) {
        [result setObject:[self valueForKey:propertyName] forKey:propertyName];
    }
    return result;
}

@end


