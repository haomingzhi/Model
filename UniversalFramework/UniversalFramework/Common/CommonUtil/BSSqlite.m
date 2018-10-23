//
//  BSSqlite.m
//  SCWCYClient
//
//  Created by apple on 14-5-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//


#import <sqlite3.h>
#import "BSSqlite.h"

//内部使用。用于对sqlite3的封装
@interface BSDatabase()

-(sqlite3*) database;

@end


@implementation  BSDatabase

-(sqlite3*)database
{
    return _db;
}


+(void)setThreadStrategy:(NSInteger)strategy
{
    sqlite3_config(strategy);
}

-(long long)lastInsertRowId
{
    if (_db == NULL)
        return 0;
    
    return sqlite3_last_insert_rowid(_db);
}

-(int)lastModifyCount
{
    if (_db == NULL)
        return 0;
    
    return sqlite3_changes(_db);
}



-(BSDatabase*)initWithPath:(NSString*)strPath
{
	self = [self init];
	if (self != nil)
	{
		if (![self open:strPath])
		{
			return nil;
		}
	}
	
	return self;
}




-(BOOL) open:(NSString*)strPath
{
	if ([self isOpen]) {
		[self close];
	}
	
	return sqlite3_open([strPath UTF8String], (sqlite3**)&_db) == SQLITE_OK;
}

-(void) close
{
	if ([self isOpen]) {
		sqlite3_close(_db);
		_db = NULL;
	}
}

-(BOOL) isOpen
{
	return _db != NULL;
}


-(BOOL) beginTransaction
{
	return [BSRecordset executeWithSql:self withSql:@"BEGIN"];
}

-(BOOL) commit
{
	return [BSRecordset executeWithSql:self withSql:@"COMMIT"];
}

-(BOOL) rollback
{
	return [BSRecordset executeWithSql:self withSql:@"ROLLBACK"];
}

-(void)dealloc
{
	[self close];
}


+(BSDatabase*) dbWithPath:(NSString*)strPath
{
	return [[BSDatabase alloc] initWithPath:strPath];
}



@end



/*
 *定义表格操作类
 */
@implementation BSRecordset
{
__strong NSMutableDictionary *_colMap;
}

-(void)loadColumnNames
{
    if (_colMap == nil)
    {
        _colMap = [[NSMutableDictionary alloc] init];
        
       int colCount = sqlite3_column_count(_stmt);
       for (int i = 0; i < colCount; i++)
       {
            [_colMap setObject:[NSNumber numberWithInt:i]
                                     forKey:[[NSString stringWithUTF8String:sqlite3_column_name(_stmt, i)] lowercaseString]];
        }
    }
}




-(id)initWithDB:(BSDatabase*)db
{
	self = [super init];
	if (self != nil)
    {
        _db = db;
        _stmt = NULL;
    }
    
	return self;
}


-(BOOL)open:(NSString*)strSql
{
	_error = SQLITE_OK;
	
	[self close];
	_error = sqlite3_prepare_v2([_db database], [strSql UTF8String], -1, (sqlite3_stmt**)&_stmt, NULL);
	
	return _error == SQLITE_OK;
}

-(BOOL)reset
{
	_error = SQLITE_OK;
	_error = sqlite3_reset(_stmt);
	return _error == SQLITE_OK;
}

-(int)step
{
	_error = sqlite3_step(_stmt);
    return _error;
}

-(BOOL)isOpen
{
	return _stmt != NULL;
}


-(BOOL)isEof
{
	return [self step] != SQLITE_ROW;
}


-(BOOL) execute
{
	return [self execute:NO];
}


- (void)bindColumn:(id)obj toColumn:(int)col
{
    
    if ((!obj) || ((NSNull *)obj == [NSNull null])) {
        [self setNull:col];
    }
    else if ([obj isKindOfClass:[NSData class]]) {
        [self setBlob:obj col:col];
    }
    else if ([obj isKindOfClass:[NSDate class]]) {
        [self setDate:obj col:col];
    }
    else if ([obj isKindOfClass:[NSNumber class]]) {
        
        if (strcmp([obj objCType], @encode(BOOL)) == 0) {
            [self setInt:([obj boolValue] ? 1 : 0) col:col];
        }
        else if (strcmp([obj objCType], @encode(int)) == 0) {
            [self setInt:[obj intValue] col:col];
        }
        else if (strcmp([obj objCType], @encode(long)) == 0) {
            [self setInt:[obj intValue] col:col];
        }
        else if (strcmp([obj objCType], @encode(long long)) == 0) {
            [self setLongLong:[obj longLongValue] col:col];
        }
        else if (strcmp([obj objCType], @encode(float)) == 0) {
            [self setDouble:[obj doubleValue] col:col];
        }
        else if (strcmp([obj objCType], @encode(double)) == 0) {
            [self setDouble:[obj doubleValue] col:col];
        }
        else if (strcmp([obj objCType], @encode(NSInteger)) == 0) {
            [self setInt:[obj intValue] col:col];
        }
        else if (strcmp([obj objCType], @encode(NSUInteger)) == 0) {
        
           [self setInt:[obj intValue] col:col];
        }
        else
        {
            [self setString:[obj description] col:col];
        }
    }
    else if ([obj isKindOfClass:[NSString class]])
    {
        [self setString:obj col:col];
    }
    else
    {
        [NSException raise:@"error type" format:nil];
    }
    
}



-(BOOL) executeWithArrayParams:(NSArray*)params
{
    //得到绑定的参数列表
    if (sqlite3_bind_parameter_count(_stmt) != params.count)
    {
        [NSException raise:@"bind cols error" format:nil];
        return NO;
    }
    
    //根据参数的类型。进行设置。。。
    for (int i = 0; i < params.count; i++)
    {
        [self bindColumn:[params objectAtIndex:i] toColumn:i];
    }
    
    return  [self execute];
}

-(BOOL) executeWithParams:(int)count,...
{
    va_list args;
    va_start(args, count);
    BOOL ok = [self execueWithVAList:args];
    va_end(args);
    
    return ok;
}

-(BOOL) execueWithVAList:(va_list)args
{
    int col = 0;
    int count = sqlite3_bind_parameter_count(_stmt);
    while (col < count) {
        [self bindColumn:va_arg(args, id) toColumn:col];
    }
   
    return [self execute];
}



-(BOOL) execute:(BOOL)bClear
{
	if ([self step] != SQLITE_DONE)
		return NO;
	
	[self reset];
	
	if (bClear)
		[self clear];
	
	return YES;
}

-(void)close
{
	if ([self isOpen]) {
		sqlite3_finalize(_stmt);
		_stmt = NULL;
	}
}

-(int)columnCount
{
    return sqlite3_column_count(_stmt);
}

-(NSString*)columnName:(NSInteger)nCol
{
    if (_stmt == NULL) {
        return nil;
    }
    
    return [NSString stringWithCString:sqlite3_column_name16(_stmt, nCol) encoding:NSUnicodeStringEncoding];
}

-(NSInteger)columnIndex:(NSString*)name
{
    [self loadColumnNames];
    
    NSNumber *n = [_colMap objectForKey:[name lowercaseString]];
    if (n) {
        
        return [n intValue];
    }
    
    return -1;
}



-(NSString*)stringValue:(NSInteger)nCol
{
	//如果值为空则返回nil;
	char *ptext = (char*)sqlite3_column_text(_stmt, nCol);
	if (ptext == NULL)
	{
		return nil;
	}
	return [NSString stringWithUTF8String:ptext];
}

-(int)intValue:(NSInteger)nCol
{
	return sqlite3_column_int(_stmt,nCol);
}

-(long long)longLongValue:(NSInteger)nCol
{
	return sqlite3_column_int64(_stmt, nCol);
}

-(double)doubleValue:(NSInteger)nCol
{
	return sqlite3_column_double(_stmt, nCol);
}

-(NSData*)blobValue:(NSInteger)nCol
{
	const char *pByte = (const char*)sqlite3_column_blob(_stmt, nCol);
	if (pByte == NULL)
	{
		return nil;
	}
	
	int nLen = sqlite3_column_bytes(_stmt, nCol);
	return [NSData dataWithBytes:pByte length:nLen];
}

-(NSDate*)dateValue:(NSInteger)nCol
{
    NSTimeInterval x = [self doubleValue:nCol];
    return [NSDate dateWithTimeIntervalSince1970:x];
}

-(NSString*)stringValueByName:(NSString*)colName
{
    return [self stringValue:[self columnIndex:colName]];
}

-(int)intValueByName:(NSString*)colName
{
    return [self intValue:[self columnIndex:colName]];
}

-(long long)longLongValueByName:(NSString*)colName
{
    return [self longLongValue:[self columnIndex:colName]];
}

-(double)doubleValueByName:(NSString*)colName
{
    return [self doubleValue:[self columnIndex:colName]];
}

-(NSData*)blobValueByName:(NSString*)colName
{
    return [self blobValue:[self columnIndex:colName]];
}

-(NSDate*)dateValueByName:(NSString*)colName
{
    return [self dateValue:[self columnIndex:colName]];
}


-(void)setString:(NSString*)strVal col:(NSInteger)nCol
{
	if (strVal == nil)
		sqlite3_bind_null(_stmt, nCol + 1);
	else
		sqlite3_bind_text(_stmt, nCol + 1, [strVal UTF8String], -1, NULL);
}

-(void)setInt:(int)iVal col:(NSInteger)nCol
{
	sqlite3_bind_int(_stmt, nCol + 1, iVal);
}

-(void)setLongLong:(long long)llVal col:(NSInteger)nCol
{
	sqlite3_bind_int64(_stmt, nCol + 1, llVal);
}

-(void)setDouble:(double)dbVal col:(NSInteger)nCol
{
	sqlite3_bind_double(_stmt, nCol + 1, dbVal);
}

-(void)setBlob:(NSData*)blobVal col:(NSInteger)nCol
{
	if (blobVal == nil)
		sqlite3_bind_null(_stmt, nCol + 1);
	else
		sqlite3_bind_blob(_stmt, nCol + 1, [blobVal bytes], [blobVal length], NULL);
}

-(void)setNull:(NSInteger)nCol
{
	sqlite3_bind_null(_stmt, nCol + 1);
}

-(void)setDate:(NSDate*)dateValue col:(NSInteger)nCol
{
    double x = [dateValue timeIntervalSince1970];
    [self setDouble:x col:nCol];
}

-(void)clear
{
	sqlite3_clear_bindings(_stmt);
}


-(NSString*)sql
{
	return [NSString stringWithUTF8String:sqlite3_sql(_stmt)];
}


//单步执行更新，插入，删除语句，用于执行不带参数的语句
+(BOOL)executeWithSql:(BSDatabase*)db withSql:(NSString*)strSql
{
	int ret = sqlite3_exec([db database], [strSql UTF8String], NULL, NULL, NULL);
	return ret == SQLITE_DONE;
}

-(BOOL)executeWithSql:(NSString*)strSql
{
	_error = sqlite3_exec([_db database], [strSql UTF8String], NULL, NULL, NULL);
	return _error == SQLITE_DONE;
}



+(BSRecordset*) recordsetWithDB:(BSDatabase*)db
{
	return [[BSRecordset alloc] initWithDB:db];
}

+(BSRecordset*) recordsetWithSql:(BSDatabase*)db withSql:strSql
{
	BSRecordset *p = [[BSRecordset alloc] initWithDB:db];
	if (![p open:strSql])
	{
		p = nil;
		return nil;
	}
	
	return p;
}




-(void)dealloc
{
	[self close];
}



@end



