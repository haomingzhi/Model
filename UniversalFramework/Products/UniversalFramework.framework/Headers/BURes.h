
#import "BUBase.h"


/**
 * 资源类型，目前只有：
 * 1。 IMAGE,HTML,XML,TEXT才会本地存储，其他没有本地存储；
 * 2。IMAGE支持断点续传，其他不支持
 * 3。VIDEO,URL 类型都只是保存的是URL，其他没有意义。。。
 */
typedef enum _BURESTYPE
{
    BURESTYPE_IMAGE = 1,
    BURESTYPE_TEXT = 2,
    BURESTYPE_HTML = 3,
    BURESTYPE_VIDEO = 4,
    BURESTYPE_XML = 5,
    BURESTYPE_URL = 6
    
}BURESTYPE;


@interface BURes : BUBase

@property(nonatomic) NSString *ident;                    //资源的标识
@property(nonatomic,readonly) NSString *cacheFile;       //本地文件缓存路径
@property(nonatomic,readonly) NSString *remoteURL;       //远程的URL,这部分数据
@property(nonatomic,readonly) NSString *relativeURL;     //相对URL。这个也是构造用，
@property(nonatomic) BURESTYPE   type;         //资源的类型
@property(nonatomic) BOOL isCached;             //是否在本地已经缓存


-(void) paramInit:(NSString*)ident relativeURL:(NSString*)relativeURL type:(BURESTYPE)type;

-(id)initWith:(NSString*)ident relativeURL:(NSString*)relativeURL type:(BURESTYPE)type;

//装载资源，如果资源在本地则直接通知，否则会有从网络进行数据请求
-(BOOL)download:(id)observer callback:(SEL)callback extraInfo:(NSDictionary*)extraInfo;

@end

extern NSString *UniversalFrameworkApiHost;