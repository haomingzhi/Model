//
//  BUDBAdapter.m
//  MiniClient
//
//  Created by Apple on 14-7-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "BUDBAdapter.h"

@implementation BUDBAdapter


-(id)initWithDb:(BSDatabase*)db withTableName:(NSString *)tableName;
{
    self = [super init];
    if (self) {
        self.db = db;
        self.tableName = tableName;
    }
    return self;
}

-(BOOL)deleteById:(NSString *)ident
{
    return TRUE;

}

-(BOOL)deleteAll
{
    return [self execsql:@"delete from ?" Parameters:@[self.tableName]];
}

-(BOOL)execsql:(NSString *)sql Parameters:(NSArray *)parameters
{
    BSRecordset *sqlExecutor = [BSRecordset recordsetWithSql:self.db withSql:sql];
    if (sqlExecutor != NULL) {
        for (int i =0; i < parameters.count; i++) {
            [ sqlExecutor setString:[parameters objectAtIndex:i] col:i ];
        }
        return [sqlExecutor execute];
    }
    else {
        NSLog(@"BSRecordset= null sql = %@",sql);

    }
    return FALSE;
    
}

//insert table (column) values (values)
-(BOOL)insert:(NSString*)sql Parameters:(NSArray*)parameters
{
    BSRecordset *sqlExecutor = [BSRecordset recordsetWithSql:self.db withSql:sql];
    if (sqlExecutor != NULL) {
       // for (int i =0; i < parameters.count; i++) {
         //   [sqlExecutor setString:[parameters objectAtIndex:i] col:i];
        //}
        return [sqlExecutor executeWithArrayParams:parameters];
    }
    else {
        NSLog(@"BSRecordset= null sql = %@",sql);
    }
    
    return NO;
}
-(BOOL)update:(NSString*)sql Parameters:(NSArray *)parameters
{
    BSRecordset *sqlExecutor = [BSRecordset recordsetWithSql:self.db withSql:sql];
    if (sqlExecutor != NULL) {
        // for (int i =0; i < parameters.count; i++) {
        //   [sqlExecutor setString:[parameters objectAtIndex:i] col:i];
        //}
        return [sqlExecutor executeWithArrayParams:parameters];
    }
    else {
        NSLog(@"BSRecordset= null sql = %@",sql);
    }
    
    return NO;
}
-(BOOL)insert:(id)entity
{
    return TRUE;
}
-(BOOL)insertBatch:(NSArray *)entityList
{
    if (entityList != NULL && entityList.count >0)
    {
        [self.db beginTransaction];
        for (int i =0; i < entityList.count; i++) {
            [self insert:[entityList objectAtIndex:i]];
        }
        [self.db commit];
    }
    return true;
}
-(NSArray *)Load
{
    return NULL;
}
-(id)LoadById:(NSString *)ident
{
    return NULL;
}

-(NSString *)formatSelectSql:(NSString*)tableName Columns:(NSArray*)columns Condition:(NSString *) condition
{
    NSMutableString *columnStr=[[NSMutableString alloc]initWithString:@"Select "];
    for (int i =0; i < columns.count; i++) {
        [columnStr appendString:[columns objectAtIndex:i] ];
        if (i != columns.count -1) {
            [columnStr appendString:@","];
        }
    }
    if (condition != NULL && condition.length >0) {
        [columnStr appendString:[NSString stringWithFormat:@" From %@ where %@",tableName,condition]];
    }
    else
        [columnStr appendString:[NSString stringWithFormat:@" From %@",tableName]];
    
    return columnStr;
}

-(NSString *)formatSelectSql:(NSString *) tableName Columns:(NSArray*)columns
{
    return [self formatSelectSql:tableName Columns:columns Condition:@""];
}

+(NSString *)getInsertFormat:(NSString *) tableName ColumnCount:(int)count
{
    NSMutableString * format = [NSMutableString stringWithFormat: @"insert into %@ ",tableName];
    [format appendString:@"(%@) values ("];
    for (int i =0; i < count; i++) {
        [format appendString: i == count -1 ? @"?)" : @"?,"];
    }
    return format;
}
@end
