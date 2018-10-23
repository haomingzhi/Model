//
//  BSSqlite.h
//  SCWCYClient
//
//  Created by apple on 14-5-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *定义数据库操作类
 */

@interface BSDatabase : NSObject
{
	void* _db;
}


@property(nonatomic, readonly) long long lastInsertRowId;  //最后一次插入操作的rowid
@property(nonatomic, readonly) int lastModifyCount;        //最后一次操作影响的记录数


//设置SQLITE3的线程访问控制。1:为单线程，2为多线程单数据库打开和语句打开不进行控制，3为序列化操作，支持多线程，默认为2
+(void)setThreadStrategy:(NSInteger)strategy;


//内部调用open,如果打开失败则返回nil
-(BSDatabase*)initWithPath:(NSString*)strPath;

+(BSDatabase*)dbWithPath:(NSString*)strPath;


-(BOOL) open:(NSString*)strPath;
-(void) close;
-(BOOL) isOpen;

//事务处理，在进行多表更新时必须启用事务
-(BOOL) beginTransaction;
-(BOOL) commit;
-(BOOL) rollback;


@end


@interface BSRecordset : NSObject
{
	void *_stmt;
}

@property(nonatomic, readonly) BSDatabase *db;
@property(nonatomic, readonly) int error;
@property(nonatomic, readonly) int columnCount;   //列的数量

//重设,对于查询操作如果需要换条件查询则调用Reset进行重新设置
-(BOOL)reset;

//判断是否打开
-(BOOL)isOpen;
//主要用于查询的遍历.
-(BOOL)isEof;
//对于更新，插入，删除语句调用Open后,设置绑定变量后,调用执行操作
//bClear: 表示执行后是否清除已经绑定的变量
// Open(...)
// SetString(...);
// ...
// Execute(...)
-(BOOL) execute;
-(BOOL) executeWithArrayParams:(NSArray*)params;
-(BOOL) executeWithParams:(int)count,...;
-(BOOL) execueWithVAList:(va_list)args;

-(BOOL) execute:(BOOL)bClear;
-(void) close;

-(NSString*)columnName:(NSInteger)nCol; //根据列得到名字，从0开始。
-(NSInteger)columnIndex:(NSString*)name;  //根据列名得到列的索引,如果得不到则返回-1,返回的重0开始。


//列值的设置和获取。
-(NSString*)stringValue:(NSInteger)nCol;
-(int)intValue:(NSInteger)nCol;
-(long long)longLongValue:(NSInteger)nCol;
-(double)doubleValue:(NSInteger)nCol;
-(NSData*)blobValue:(NSInteger)nCol;
-(NSDate*)dateValue:(NSInteger)nCol;     //要就数据库存储的是从1970年到现在的秒数,也就是必须存double型。

//列名来获取内容
-(NSString*)stringValueByName:(NSString*)colName;
-(int)intValueByName:(NSString*)colName;
-(long long)longLongValueByName:(NSString*)colName;
-(double)doubleValueByName:(NSString*)colName;
-(NSData*)blobValueByName:(NSString*)colName;
-(NSDate*)dateValueByName:(NSString*)colName;

//设置某个动态绑定列的值。
-(void)setString:(NSString*)strVal col:(NSInteger)nCol;   //列从0开始。
-(void)setInt:(int)iVal col:(NSInteger)nCol;
-(void)setLongLong:(long long)llVal col:(NSInteger)nCol;
-(void)setDouble:(double)dbVal col:(NSInteger)nCol;
-(void)setBlob:(NSData*)blobVal col:(NSInteger)nCol;
-(void)setNull:(NSInteger)nCol;
-(void)setDate:(NSDate*)dateValue col:(NSInteger)nCol;



//清除绑定的值
-(void)clear;

-(NSString*)sql;

//直接单步执行更新，插入，删除语句，用于执行不带参数的语句
+(BOOL)executeWithSql:(BSDatabase*)db withSql:(NSString*)strSql;

+(BSRecordset*) recordsetWithSql:(BSDatabase*)db withSql:strSql;


@end




