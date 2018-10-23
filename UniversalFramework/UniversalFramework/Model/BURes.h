
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
@property(nonatomic,readonly) NSString *cacheThumbFile;  //缩略图文件
@property(nonatomic) CGSize cacheThumbFileSize;//生成的缩略图大小
@property(nonatomic,readonly) NSString *remoteURL;       //远程的URL,这部分数据
@property(nonatomic,readonly) NSString *relativeURL;     //相对URL。这个也是构造用，
@property(nonatomic) BURESTYPE   type;         //资源的类型
@property(nonatomic) BOOL isCached;             //是否在本地已经缓存
@property(nonatomic) BOOL isValid;  //是否有效
@property(nonatomic,readonly) NSInteger length;
-(void) paramInit:(NSString*)ident relativeURL:(NSString*)relativeURL type:(BURESTYPE)type;

-(id)initWith:(NSString*)ident relativeURL:(NSString*)relativeURL type:(BURESTYPE)type;
-(void)displayRemoteImage:(UIImageView *) imageView imageName:(NSString *) imageName thumb:(BOOL) showThumb isFitImgV:(BOOL) isFit;
//装载资源，如果资源在本地则直接通知，否则会有从网络进行数据请求
-(BOOL)download:(id)observer callback:(SEL)callback extraInfo:(NSDictionary*)extraInfo;

-(void)displayRemoteImage:(UIImageView *) imageView imageName:(NSString *) imageName;

//是否加载缩略图
-(void)displayRemoteImage:(UIImageView *) imageView imageName:(NSString *) imageName thumb:(BOOL) showThumb;
//是否加载缩略图
-(void)displayRemoteImage:(UIImageView *) imageView imageName:(NSString *) imageName thumb:(BOOL) showThumb size:(CGSize) thumbSize;

@end

extern NSString *UniversalFrameworkApiHost;
extern NSString * UniversalFrameworkImgUrl;
extern BOOL UniversalFramework_isLogin;
extern BOOL UniversalFramework_isMustWIFILoadImg;//是否必须WiFi才能请求加载图片
extern BOOL UniversalFramework_isGenThumb;
extern NSString *UniversalFramework_BundleName;
