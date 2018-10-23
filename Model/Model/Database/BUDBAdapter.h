//
//  BUDBAdapter.h
//  MiniClient
//
//  Created by Apple on 14-7-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BUDBAdapter : NSObject
@property (nonatomic)BSDatabase* db;
@property (nonatomic)NSString *tableName;
-(id)initWithDb:(BSDatabase*)db withTableName:(NSString *)tableName;
-(BOOL)execsql:(NSString *)sql Parameters:(NSArray *)parameters;
-(BOOL)deleteById:(NSString *)ident;
-(BOOL)deleteAll;
-(BOOL)insert:(id)entity;
-(BOOL)insertBatch:(NSArray *)entityList;
-(BOOL)insert:(NSString*)sql Parameters:(NSArray*)parameters;
-(BOOL)update:(NSString*)sql Parameters:(NSArray *)parameters;
-(NSArray *)Load;
-(id)LoadById:(NSString *)ident;

-(NSString *)formatSelectSql:(NSString*)tableName Columns:(NSArray*)columns Condition:(NSString *) condition;

-(NSString *)formatSelectSql:(NSString *) tableName Columns:(NSArray*)columns;

+(NSString *)getInsertFormat:(NSString *) tableName ColumnCount:(int)count;

@end