//
//  JYcache.h
//  MeiliWan
//
//  Created by air on 15/4/28.
//  Copyright (c) 2015年 oranllc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYCache : NSObject
+ (instancetype)manager;
-(void)setCacheDic:(NSMutableDictionary *)data;
-(NSMutableDictionary *)getCacheDic;
-(void )setCacheImg:(UIImage *)img imgName:(NSString *)name;
-(UIImage *)getCacheImg:(NSString *)imgName;
-(UIImage *)getCacheImgList;
-(void)setCacheImgWithUrl:(NSURL *)url;
-(NSMutableArray *)getCacheArr;
-(void)setCacheArr:(NSMutableArray *)dataArr;
-(void)cleanCache;
@end
