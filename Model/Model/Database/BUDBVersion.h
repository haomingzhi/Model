//
//  YXBDVersion.h
//  YinXinBao
//
//  Created by umpay on 12-12-31.
//
//

#import <Foundation/Foundation.h>


/*
 * 本地数据库版本号，每个版本号描述数据库变更的信息
 * 100: 建立初始表
 */
#define INIT_DBVERSION 100     //最初始版本
#define NEW_DBVERSION  101


/*
  用于控制数据库的版本更新，以及数据模型的更新。
 */
@interface BUDBVersion : NSObject


//更新数据库
+(void)update:(BSDatabase*)db;

@end
