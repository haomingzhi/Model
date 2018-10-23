//
//  YXBDVersion.m
//  YinXinBao
//
//  Created by umpay on 12-12-31.
//
//

#import "BUDBVersion.h"

@implementation BUDBVersion

//每个数据库版本升级，这里增加一个函数。
+(void)update100:(BSDatabase*)db
{
    [BSRecordset executeWithSql:db withSql:@"DROP TABLE IF EXISTS S_GOODSTER"];
    [BSRecordset executeWithSql:db withSql:@"DROP TABLE IF EXISTS S_GOODSTERVERSION"];
    [BSRecordset executeWithSql:db withSql:@"DROP TABLE IF EXISTS S_GOODSPRODUCT"];
    [BSRecordset executeWithSql:db withSql:@"DROP TABLE IF EXISTS S_GOODSPRODUCTACTION"];
    [BSRecordset executeWithSql:db withSql:@"DROP TABLE IF EXISTS D_GOODSSALE"];
    [BSRecordset executeWithSql:db withSql:@"DROP TABLE IF EXISTS S_GOODSACTINFO"];
    [BSRecordset executeWithSql:db withSql:@"DROP TABLE IF EXISTS PARAMS"];
    [BSRecordset executeWithSql:db withSql:@"DROP TABLE IF EXISTS SYSCFGINFO"];
    [BSRecordset executeWithSql:db withSql:@"DROP TABLE IF EXISTS CITYCODE"];
    
    [BSRecordset executeWithSql:db withSql:@"create table S_GOODSTER ("
    @"TERMINAL_ID          VARCHAR2(20)  PRIMARY KEY   not null,"
    @"NAME                 VARCHAR2(20),"
    @"BRAND                VARCHAR2(100),"
    @"PRICE                real(15,5),"
    @"DISCOUNT             real(15,5),"
    @"SALESCOUNT           integer(10),"
    @"THUMBNAI_URL         VARCHAR2(100),"
    @"MODEL_DESC           VARCHAR2(100),"
    @"IMAGE_URLS           VARCHAR2(500),"
    @"DETAIL_URL           VARCHAR2(100),"
    @"IS_HOST              VARCHAR2(2),"
    @"IS_RECOMMEND         VARCHAR2(2),"
    @"BIND_PRODUCTS        VARCHAR2(200),"
    @"NET_TYPE             integer(10),"
    @"SIZES                real(15,5),"
    @"SCPARAM              VARCHAR2(30),"
    @"OS                   VARCHAR2(20),"
    @"NETWORK              VARCHAR2(30),"
    @"MUSIC                VARCHAR2(50),"
    @"VIDEO                VARCHAR2(50),"
    @"MAINPIXEL            integer(10),"
    @"STANDBY              integer(10),"
    @"CALLTIME             integer(10),"
    @"STATUS               VARCHAR2(2),"
    @"CHANGE_TIME          DATE)"];
    
     
	// 终端型号表
	[BSRecordset executeWithSql:db withSql:@"create table S_GOODSTERVERSION  ("
     @"TERMAIL_ID           VARCHAR2(20)        not null,"
    @"VER_CODE             VARCHAR2(10)         not null,"
    @"VER_NAME             VARCHAR2(20),"
    @"CONTRACT_PRICE       real(15,5),"
    @"CONTRACT_DISCOUNT    real(15,5),"
    @"BARE_PRICE           real(15,5),"
    @"BARE_DISCOUNT        real(15,5))"];
    
	// 套餐信息表
	[BSRecordset executeWithSql:db withSql:@"create table S_GOODSPRODUCT  ("
    @"PRODUCT_ID           VARCHAR2(20)         PRIMARY KEY           not null,"
    @"NAME                 VARCHAR2(50),"
    @"STATUS               VARCHAR2(2),"
    @"BRAND                VARCHAR2(20),"
    @"PRICE                real(15,5),"
    @"DISCOUNT             real(15,5),"
    @"SALES_COUNT          integer(10),"
    @"THUMBNAI_URL         VARCHAR2(100),"
    @"PRODUCT_DESC         VARCHAR2(200),"
    @"PRODUCT_SUMMARY      VARCHAR2(100),"
    @"PLAN_TYPE            integer(10),"
    @"NET_TYPE             integer(10),"
    @"IMAGE_URLS           VARCHAR2(500),"
    @"VOICE_LEN            VARCHAR2(100),"
    @"SMS_COUNT            VARCHAR2(100),"
    @"FLOW_SIZE            VARCHAR2(100),"
    @"FLOW_UNIT            VARCHAR2(100),"
    @"MONTHLY_FEE          VARCHAR2(100),"
    @"PAY_TYPE             integer(10),"
    @"DETAIL_URL           VARCHAR2(100),"
    @"CHANGE_TIME          DATE)"];
    //套餐活动信息表    
    [BSRecordset executeWithSql:db withSql:@"create table S_GOODSPRODUCTACTION  ("
    @"ACTIVITY_CODE      VARCHAR2(30)      PRIMARY KEY       not null,"
    @"ACTIVITY_NAME      VARCHAR2(50),"
    @"ACTIVITY_DESC      VARCHAR2(100),"
    @"ACT_TYPE           VARCHAR2(2),"
    @"ACT_PROTPER        integer(10),"
    @"PRO_ID             VARCHAR2(50)                    not null,"
    @"STOREDFEE          real(15,5),"
    @"PRESENTEDFEE       real(15,5),"
    @"THAWPRO            real(15,5),"
    @"TOTOLSALEFEE       real(15,5),"
    @"MONTHLOWESTFEE     real(15,5),"
    @"AREA_CODE          VARCHAR2(10),"
    @"STARTDATE          VARCHAR2(30),"
    @"ENDDATE            VARCHAR2(30),"
    @"RES_TYPE           VARCHAR2(2),"
    @"RES_FEE            real(15,5),"
    @"RES_RELE           VARCHAR2(2),"
    @"RES_BRAND          VARCHAR2(30),"
    @"RES_MODEL          VARCHAR2(30),"
    @"DEPID              VARCHAR2(30),"
    @"DEPFEE             real(15,5),"
    @"MONTH_PRESENT      VARCHAR2(30),"
    @"NET_TYPE           VARCHAR2(2)"
    @")"];

    
	// 热销商品信息表
	[BSRecordset executeWithSql:db withSql:@"create table D_GOODSSALE  ("
    @"PRODUCT_ID           VARCHAR2(20)      PRIMARY KEY   not null,"
    @"TYPE                 VARCHAR2(10)                    not null,"
    @"NAME                 VARCHAR2(100),"
    @"BRAND                VARCHAR2(50),"
    @"PRICE                real(15,5),"
    @"DISCOUNT             real(15,5),"
    @"SALES_COUNT          integer(10),"
    @"THUMBNAI_URL        VARCHAR2(200),"
    @"PRODUCT_DESC         VARCHAR2(300))"];
    
	// 活动信息表
	[BSRecordset executeWithSql:db withSql:@"create table S_GOODSACTINFO  ("
    @"ACTIVITY_ID          VARCHAR2(30)                    not null,"
    @"TYPE                 integer(10),"
    @"IMAGE_URL            VARCHAR2(100),"
    @"ACT_DESC             VARCHAR2(200),"
    @"CONTENT              VARCHAR2(200),"
    @"START_TIME           DATE,"
    @"END_TIME             DATE,"
    @"IS_VALID             VARCHAR2(2),"
    @"CHANGE_TIME          DATE)"];
    
	// 创建参数表
	[BSRecordset executeWithSql:db withSql:@"CREATE TABLE PARAMS ("
    @"_id integer PRIMARY KEY autoincrement, "
    @"s_type varchar(4),"
    @"s_code varchar(10),"
    @"s_value TEXT,"
    @"s_relationcode varchar(10),"
    @"s_param varchar(10))"];
    
	// 创建系统配置信息表
	[BSRecordset executeWithSql:db withSql:@"CREATE TABLE SYSCFGINFO ("
    @"_id TEXT PRIMARY KEY, "
    @"file_name TEXT,"
     @"file_path TEXT,"
    @"file_tag TEXT)"];
    
	// 创建城市和区域编码表
	[BSRecordset executeWithSql:db withSql:@"CREATE TABLE CITYCODE ("
    @"_id integer PRIMARY KEY autoincrement, "
    @"rec_id TEXT,"
    @"city_name TEXT,"
    @"area_code TEXT)"]; 
}

+(void)update101:(BSDatabase *)db
{
    [BSRecordset executeWithSql:db withSql:@"DROP TABLE IF EXISTS S_GOODSPRODUCT2"];
    [BSRecordset executeWithSql:db withSql:@"DROP TABLE IF EXISTS S_GOODSPRODUCTACTION2"];
    
    // 套餐信息表
    [BSRecordset executeWithSql:db withSql:@"create table S_GOODSPRODUCT2  ("
     @"PRODUCT_ID           VARCHAR2(20)         PRIMARY KEY           not null,"
     @"PSAMID               VARCHAR2(30),"
     @"CRCCODE              VARCHAR2(10),"
     @"NAME                 VARCHAR2(50),"
     @"BRAND                VARCHAR2(20),"
     @"PRODUCT_DESC         VARCHAR2(200),"
     @"PLAN_TYPE            integer(10),"
     @"NET_TYPE             integer(10),"
     @"VOICE_LEN            VARCHAR2(100),"
     @"SMS_COUNT            VARCHAR2(100),"
     @"FLOW_SIZE            VARCHAR2(100),"
     @"MONTHLY_FEE          VARCHAR2(100),"
     @"PAY_TYPE             integer(10),"
     @"THUMBNAI_URL         VARCHAR2(100),"
     @"PRICE                real(15,5),"
     @"DISCOUNT             real(15,5),"
     @"SALES_COUNT          integer(10),"
     @"DETAIL_URL           VARCHAR2(100),"
     @")"];
    //套餐活动信息表
    [BSRecordset executeWithSql:db withSql:@"create table S_GOODSPRODUCTACTION2  ("
     @"ACTIVITY_CODE      VARCHAR2(30)      PRIMARY KEY       not null,"
     @"PSAMID             VARCHAR2(30),"
     @"CRCCODE            VARCHAR2(10),"
     @"ACTIVITY_NAME      VARCHAR2(50),"
     @"ACTIVITY_DESC      VARCHAR2(100),"
     @"ACT_TYPE           VARCHAR2(2),"
     @"ACT_PROTPER        integer(10),"
     @"PRO_ID             VARCHAR2(50)                    not null,"
     @"STOREDFEE          real(15,5),"
     @"PRESENTEDFEE       real(15,5),"
     @"THAWPRO            real(15,5),"
     @"TOTOLSALEFEE       real(15,5),"
     @"MONTHLOWESTFEE     real(15,5),"
     @"AREA_CODE          VARCHAR2(10),"
     @"STARTDATE          VARCHAR2(30),"
     @"ENDDATE            VARCHAR2(30),"
     @"RES_TYPE           VARCHAR2(2),"
     @"RES_FEE            real(15,5),"
     @"RES_RELE           VARCHAR2(2),"
     @"RES_BRAND          VARCHAR2(30),"
     @"RES_MODEL          VARCHAR2(30),"
     @"DEPID              VARCHAR2(30),"
     @"DEPFEE             real(15,5),"
     @"MONTH_PRESENT      VARCHAR2(30),"
     @"NET_TYPE           VARCHAR2(2),"
     @"REC_UPDATETIME     DATE"
     @")"];
    
}
+(void)doDBUpdate:(NSInteger)version db:(BSDatabase*)db
{
    char actionName[128];
    sprintf(actionName, "update%ld:", version);
    SEL action = sel_registerName(actionName);
    [self performSelector:action withObject:db];
}

+(void)update:(BSDatabase*)db
{
    [db beginTransaction];
    
    NSInteger dbversion = INIT_DBVERSION;  //默认初始版本
    
    //判断是否有系统配置表,如果没有配置表则建立配置表,并设置key = dbversion  value = INIT_DBVERSION
    BSRecordset *sysCfgRecordSet = [BSRecordset recordsetWithSql:db withSql:@"SELECT param_value FROM lc_system_cfg WHERE param_name=?"];
    if (sysCfgRecordSet == nil)
    {
        [BSRecordset executeWithSql:db withSql:@"CREATE TABLE lc_system_cfg (param_name varchar(32) NOT NULL, param_value varchar(255), PRIMARY KEY (param_name) ON CONFLICT REPLACE)"];
        
        sysCfgRecordSet = [BSRecordset recordsetWithSql:db withSql:@"INSERT INTO lc_system_cfg(param_name, param_value) VALUES (?, ?)"];
        [sysCfgRecordSet setString:@"dbversion" col:0];
        [sysCfgRecordSet setString:[NSString stringWithFormat:@"%d", INIT_DBVERSION] col:1];
        [sysCfgRecordSet execute];
        
        
        //建立初始版本的数据字典
        [self doDBUpdate:INIT_DBVERSION db:db];
    }
    else
    {
        [sysCfgRecordSet setString:@"dbversion" col:0];
        if (![sysCfgRecordSet isEof])
        {
            dbversion = [sysCfgRecordSet stringValue:0].integerValue;
        }
    }
    
    [sysCfgRecordSet close];
    
    
    //判断当前的版本和配置表的版本号，如果当前的大于系统配置表中的数据则根据版本号进行数据更新。
    for (NSInteger i = dbversion + 1 ; i <= NEW_DBVERSION; i++)
    {
        [self doDBUpdate:NEW_DBVERSION db:db];
    }
    
    //更新数据库的版本号
    if (dbversion < NEW_DBVERSION)
    {
        sysCfgRecordSet = [BSRecordset recordsetWithSql:db withSql:@"UPDATE lc_system_cfg SET param_value = ? WHERE param_name = ?"];
        [sysCfgRecordSet setString:[NSString stringWithFormat:@"%d", NEW_DBVERSION] col:0];
        [sysCfgRecordSet setString:@"dbversion" col:1];
        [sysCfgRecordSet execute];
        [sysCfgRecordSet close];
    }
    
    [db commit];

}

@end
