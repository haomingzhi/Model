//
//  BUSystemConfigDBAdapter.m
//  MiniClient
//
//  Created by Apple on 14-7-24.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "BUSystemConfigDBAdapter.h"

static NSString *DB_TABLE = @"SYSCFGINFO";
static NSString *KEY_ID = @"_ID";
static NSString *KEY_KEY = @"file_name";     //商品ID
static NSString *KEY_VALUE = @"file_path";   //商品类型
static NSString *KEY_TAG = @"file_tag";

@implementation BUSystemConfigDBAdapter

-(id)initWithDb:(BSDatabase*)db
{
    self =[super initWithDb:db withTableName:DB_TABLE];
    return self;
}

-(BOOL)deleteById:(NSString *)ident
{
    NSString *sql = [NSString stringWithFormat:@"delete from %@ WHERE %@=?",DB_TABLE,KEY_ID];
    return [self execsql:sql Parameters:@[ident]];
}

-(BOOL)insert:(NSString *)key Value:(NSString *)value
{
    NSDictionary *keyValues = [self getKeyValues:key Value:value];
    
    NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@) values (?,?)",DB_TABLE,[keyValues.allKeys componentsJoinedByString:@","]];
    return [self insert:sql Parameters:[keyValues allValues]];
}

-(BOOL)insert:(id)entity
{
    return false;
}
-(id)LoadById:(NSString *)ident
{
    NSArray *columNames = @[KEY_KEY,KEY_VALUE];
    NSString *sql = [self formatSelectSql:DB_TABLE Columns:columNames Condition:[NSString stringWithFormat:@"%@=?",KEY_KEY]];
    BSRecordset *recordSet = [BSRecordset recordsetWithSql:self.db withSql:sql];
    if (recordSet != NULL) {
        [recordSet setString:ident col:0];
        if (![recordSet isEof])
        {
            return [recordSet stringValueByName:KEY_VALUE];
        }
    }
    return @"";
}
-(NSArray *)Load
{
    NSString *sql = [self formatSelectSql:DB_TABLE Columns:@[KEY_KEY]];
    NSMutableArray *result = [[NSMutableArray alloc]init];
    NSMutableDictionary *keyValues = [[NSMutableDictionary alloc]init];
    BSRecordset *recordSet = [BSRecordset recordsetWithSql:self.db withSql:sql];
    while (recordSet != NULL && ![recordSet isEof])
    {
        NSString * value = [self LoadById:[recordSet stringValue:0]];
        [keyValues setObject:value forKey:[recordSet stringValue:0]];
        
    }
    [result addObject:keyValues];
    return result;
}

-(BOOL)updateValue:(NSString *)key Value:(NSString*)value
{
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@ where %@=? ",DB_TABLE,[self formatUpdateSql:@[KEY_VALUE]],KEY_KEY];
    return [self update:sql Parameters:@[value,key]];
}

#pragma mark --private
-(NSDictionary*)getKeyValues:(NSString *)key Value:(NSString *)value
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc]init];
    [result setObject:[BSUtility nullToEmpty:key] forKey:KEY_KEY];
    [result setObject:[BSUtility nullToEmpty:value] forKey:KEY_VALUE];
    return result;
}

-(NSString*)formatUpdateSql:(NSArray *)columns
{
    NSMutableString *result = [[NSMutableString alloc]init];
    for (int i =0; i < columns.count; i++) {
        [result appendString:[NSString stringWithFormat:@"%@=?",[columns objectAtIndex:i]]];
        if (i != columns.count -1) {
            [result appendString:@","];
        }
    }
    return result;
}

@end
