
#import "BUManager.h"

@interface BUCache : BUManager

@property(nonatomic) NSString *dataPath;   ////缓存的路径
@property(nonatomic) NSString *resCachePath;  //资源缓存路径
@property(nonatomic) NSString *dbPathFile;    //数据库文件的路径，在mDataPath下叫WCY.db
@property(nonatomic) BOOL canCache;           //是否可以进行缓存

+(BUCache*) shareInstance;
@end
