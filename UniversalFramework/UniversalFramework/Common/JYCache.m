//
//  JYcache.m
//  MeiliWan
//
//  Created by air on 15/4/28.
//  Copyright (c) 2015年 oranllc. All rights reserved.
//

#import "JYCache.h"
@interface JYCache()
{
    NSMutableDictionary *_dataDic;
    NSString *_rootPath;
}
@end
@implementation JYCache
+ (instancetype )manager
{
    static dispatch_once_t  onceToken;
    static JYCache * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[JYCache alloc] init];
        sSharedInstance->_dataDic = [NSMutableDictionary dictionary];
        sSharedInstance -> _rootPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        [sSharedInstance initCacheFolder];
    });
    return sSharedInstance;
}

-(void)initCacheFolder
{
   NSFileManager *fm = [NSFileManager defaultManager];
    NSString *dataPath = [_rootPath stringByAppendingPathComponent:@"cacheDic"];
    if(![fm fileExistsAtPath:dataPath])
    {
        BOOL res=[fm createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (res) {
            NSLog(@"文件夹创建成功");
        }else
            NSLog(@"文件夹创建失败");
    }
    NSString *imgPath = [_rootPath stringByAppendingPathComponent:@"cacheImg"];
    if (![fm fileExistsAtPath:imgPath]) {
        BOOL res=[fm createDirectoryAtPath:imgPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (res) {
            NSLog(@"文件夹创建成功");
        }else
            NSLog(@"文件夹创建失败");
    }
}

-(void)setCacheArr:(NSMutableArray *)dataArr
{
    NSString *path = _rootPath;
    path = [path stringByAppendingPathComponent:@"cacheDic/headData.archiver"];
    BOOL flag = [NSKeyedArchiver archiveRootObject:dataArr toFile:path];
    if (flag) {
        NSLog(@"文件创建成功");
    }else
        NSLog(@"文件创建失败");
}

-(NSMutableArray *)getCacheArr
{
    NSString *path = _rootPath;
    path = [path stringByAppendingPathComponent:@"cacheDic/headData.archiver"];
    NSMutableArray *dataArr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!dataArr) {
        dataArr = [NSMutableArray array];
    }
    return dataArr;
}

-(void)setCacheDic:(NSMutableDictionary *)data
{
    [_dataDic setDictionary:data];
    NSString *path = _rootPath;
    path = [path stringByAppendingPathComponent:@"cacheDic/headData.archiver"];
   BOOL flag = [NSKeyedArchiver archiveRootObject:_dataDic toFile:path];
    if (flag) {
        NSLog(@"文件创建成功");
    }else
        NSLog(@"文件创建失败");
}

-(NSMutableDictionary *)getCacheDic
{
    NSString *path = _rootPath;
    path = [path stringByAppendingPathComponent:@"cacheDic/headData.archiver"];
   NSMutableDictionary *dataDic = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return dataDic;
}

-(void)setCacheImgWithUrl:(NSURL *)url
{
   
}

-(void )setCacheImg:(UIImage *)img imgName:(NSString *)name
{
    NSString *path = _rootPath;
    path = [path stringByAppendingPathComponent:@"cacheImg"];
    path = [path stringByAppendingPathComponent:name];
     NSData *data = UIImagePNGRepresentation(img);
    [NSKeyedArchiver archiveRootObject:data toFile:path];
}

-(UIImage *)getCacheImg:(NSString *)imgName
{
   NSString *imgPath = [_rootPath stringByAppendingPathComponent:@"cacheImg"];
    imgPath = [imgPath stringByAppendingPathComponent:imgName];
   NSData *imgData = [NSKeyedUnarchiver unarchiveObjectWithFile:imgPath];
    UIImage *img = [UIImage imageWithData:imgData];
    return img;
}

-(NSArray *)getCacheImgList
{
    NSFileManager *fm = [NSFileManager defaultManager];
  NSString *imgPath = [_rootPath stringByAppendingPathComponent:@"cacheImg"];
    NSMutableArray *imgArr = [NSMutableArray array];
   NSArray *pathArr = [fm subpathsAtPath:imgPath];
    for (NSString *p in pathArr) {
       NSData *imgData = [NSKeyedUnarchiver unarchiveObjectWithFile:p];
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        dataDic[@"imgUrl"] = p;
        dataDic[@"imgData"] = imgData;
        [imgArr addObject:dataDic];
    }
    return imgArr;
}

-(void)cleanCache
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *dataPath = [_rootPath stringByAppendingPathComponent:@"cacheDic"];
    if([fm fileExistsAtPath:dataPath])
    {
        BOOL res = [fm removeItemAtPath:dataPath error:nil];
        if (res) {
            NSLog(@"文件夹删除成功");
        }else
            NSLog(@"文件夹删除失败");
    }
    NSString *imgPath = [_rootPath stringByAppendingPathComponent:@"cacheImg"];
    if ([fm fileExistsAtPath:imgPath]) {
        BOOL res = [fm removeItemAtPath:dataPath error:nil];
        if (res) {
            NSLog(@"文件夹删除成功");
        }else
            NSLog(@"文件夹删除失败");
    }
    
    [self initCacheFolder];
}

@end
