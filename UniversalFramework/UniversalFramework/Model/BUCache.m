
#import "BUCache.h"

@implementation BUCache


-(instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        //构建各种路径, db保存到Document目录下，资源保存在Library/Cached的res目录下
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _dataPath = [paths objectAtIndex:0];
        
        _dbPathFile = [_dataPath stringByAppendingPathComponent:@"app.db"];
        
        
        paths =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachedPath = [paths objectAtIndex:0];
        _resCachePath = [cachedPath stringByAppendingPathComponent:@"res"];
        
        NSFileManager * fileManager = [NSFileManager defaultManager];
         if (![fileManager fileExistsAtPath:_resCachePath])
         {
             [fileManager createDirectoryAtPath:_resCachePath withIntermediateDirectories:YES attributes:nil error:nil];
         }
        

        _canCache = YES;
        
        
    }
    
    return self;
}
-(float )sizeOfCache{
    NSLog(@"%@",self.resCachePath);
    float size;
    NSString *homePath=NSHomeDirectory();
//    NSString *libraryPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
//    size=[self folderSizeAtPath:libraryPath];
//    NSString *documentsPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    size+=[self folderSizeAtPath:documentsPath];
    size=[self folderSizeAtPath:homePath];
    return  size;
}


-(void) cleanCache
{
//    NSFileManager* manager = [NSFileManager defaultManager];
//    NSString *documentsPath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//     NSArray * documents = [manager contentsOfDirectoryAtPath:documentsPath error:nil];
    NSString *libraryPath= NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] ;
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] ;

    [self removeFolder:documentPath ];
    [self removeFolder:libraryPath ];
}

-(void)removeFolder:(NSString *)folder {
    NSFileManager* manager = [NSFileManager defaultManager];
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folder] objectEnumerator];
    NSString* fileName;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* deleteFile = [folder stringByAppendingPathComponent:fileName];
        NSError *error = nil;
        [manager removeItemAtPath:deleteFile error:&error];
    }
}
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
        return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}


+(BUCache*) shareInstance
{
    static dispatch_once_t once;
    static BUCache *sharedCache;
    dispatch_once(&once, ^ { sharedCache = [[BUCache alloc] init]; });
    return sharedCache;
}
@end
