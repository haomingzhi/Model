
#import "BURes.h"
#import "BUCache.h"


NSString *UniversalFrameworkApiHost = nil;
NSString *UniversalFrameworkImgUrl = nil;
BOOL   UniversalFramework_isLogin;
BOOL UniversalFramework_isMustWIFILoadImg;
BOOL UniversalFramework_isGenThumb;   //是否生成缩略图
NSString *UniversalFramework_BundleName = nil;

@interface BURes()

@property(nonatomic,strong) NSString *cacheFile;       //本地文件缓存路径
@property(nonatomic,strong) NSString *remoteURL;       //远程的URL,这部分数据
@property(nonatomic,strong) NSString *relativeURL;     //相对URL。这个也是构造用，

@property(nonatomic) NSString *innerId;


@end


@implementation BURes


-(id)initWith:(NSString*)ident relativeURL:(NSString*)relativeURL type:(BURESTYPE)type
{
    self = [self init];
    if (self != nil)
    {
        [self paramInit:ident relativeURL:relativeURL type:type];
        self.isValid = YES;
    }
    return self;
}


-(NSInteger) length
{
    return self.remoteURL.length;
}
-(void) paramInit:(NSString*)ident relativeURL:(NSString*)relativeURL type:(BURESTYPE)type
{
    _ident = ident;
    _relativeURL = [BSUtility trimodoa:relativeURL];
    _cacheFile = nil;
    if (_relativeURL != nil && _relativeURL.length >0)
    {
        //如果mRemoteURL是相对地址即不以http开头的话则添加上基本地址。
        if ([_relativeURL hasPrefix:@"http"] || [_relativeURL hasPrefix:@"ftp"])
            _remoteURL = _relativeURL;
        else
//            _remoteURL = _relativeURL;
            _remoteURL =  [NSString stringWithFormat:@"%@%@",UniversalFrameworkImgUrl, _relativeURL];
        _remoteURL = [_remoteURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _innerId = _relativeURL.md5String;
    }
    
    _isCached = NO;
    _type = type;
    switch((int)_type)
    {
        case BURESTYPE_URL:
        case BURESTYPE_VIDEO:
            _isCached = YES;
            break;
    }
}

-(BOOL)isCached
{
    if (self.innerId == nil)
            return NO;
    
    
    if (_isCached)
        return YES;
    
    _isCached = [[NSFileManager defaultManager] fileExistsAtPath:self.cacheFile];
    
    return _isCached;
}


-(NSString *)cacheThumbFile
{
    NSArray *subFiles = [self.cacheFile componentsSeparatedByString:@".png"];
    return [NSString stringWithFormat:@"%@_thumb.png",subFiles[0]];
}

-(NSString *)thumbFile:(CGSize) thumbFileSize
{
    NSArray *subFiles = [self.cacheFile componentsSeparatedByString:@".png"];
    return [NSString stringWithFormat:@"%@*%ld*%ld.png",subFiles[0],(NSInteger)thumbFileSize.width,(NSInteger)thumbFileSize.height] ;
}

//-(NSString *)thumbFile:(CGSize) thumbFileSize
//{
//    return [NSString stringWithFormat: @"%@_%ld*%ld" ,self.cacheFile,(NSInteger)thumbFileSize.width,(NSInteger)thumbFileSize.height];
//}

-(NSString*)cacheFile
{
    if (_cacheFile != nil)
        return _cacheFile;
    
    if (self.innerId == nil)
        return nil;
    
    
    switch(_type)
    {
        case BURESTYPE_IMAGE:
            _cacheFile = [NSString stringWithFormat:@"%@/%@.png",[BUCache shareInstance].resCachePath,self.innerId];
            break;
        case BURESTYPE_HTML:
            _cacheFile = [NSString stringWithFormat:@"%@/%@.html",[BUCache shareInstance].resCachePath,self.innerId];
            break;
        case BURESTYPE_XML:
            _cacheFile = [NSString stringWithFormat:@"%@/%@.xml",[BUCache shareInstance].resCachePath,self.innerId];
            break;
        case BURESTYPE_TEXT:
            _cacheFile = [NSString stringWithFormat:@"%@/%@.txt",[BUCache shareInstance].resCachePath,self.innerId];
            break;
        default:
            break;
	}
    
    return _cacheFile;
}
//是否加载缩略图
-(void)displayRemoteImage:(UIImageView *) imageView imageName:(NSString *) imageName thumb:(BOOL) showThumb
{
    [self displayRemoteImage:imageView imageName:imageName thumb:showThumb isFitImgV:NO];
}
//是否加载缩略图
-(void)displayRemoteImage:(UIImageView *) imageView imageName:(NSString *) imageName thumb:(BOOL) showThumb isFitImgV:(BOOL) isFit
{
    if (self.isCached) {
        imageView.image = [UIImage imageWithContentsOfFile:showThumb ? self.cacheThumbFile : self.cacheFile];
    }
    else
    {
        if ( imageName.length >0) {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            if(!filePath)
            {
                filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@2x",imageName] ofType:@"png"];
            }
            
            imageView.image = [UIImage imageWithContentsOfFile:filePath];
            
        }

        if (self.relativeURL.length >0 )
            [self download:self callback:@selector(resDownloadNotification:) extraInfo:@{@"imageView":imageView,@"showThumb":@(showThumb),@"isFitImg":@(isFit)}];
    }

}

///缩略图
-(void)displayRemoteImage:(UIImageView *) imageView imageName:(NSString *) imageName thumb:(BOOL) showThumb size:(CGSize) thumbSize
{
    if (self.isCached) {
        if (!showThumb) {
            imageView.image = [UIImage imageWithContentsOfFile: self.cacheFile];
        }
        else {
            NSString *thumbFile = [self thumbFile:thumbSize];
            if (![[NSFileManager defaultManager] fileExistsAtPath:thumbFile]) {
                UIImage *img = [[UIImage imageWithContentsOfFile:self.cacheFile] imageByScalingToSize:thumbSize];
                NSData *thumbData = UIImageJPEGRepresentation(img,1);
                [thumbData writeToFile:thumbFile atomically:YES];
            }
            imageView.image = [UIImage imageWithContentsOfFile:thumbFile];
        }
    }
    else
    {
        if ( imageName.length >0) {
            imageView.image = [UIImage imageNamed:imageName];
        }
        if (self.relativeURL.length >0 )
            [self download:self callback:@selector(resDownloadNotification:) extraInfo:@{@"imageView":imageView,@"showThumb":@(showThumb),@"thumbSize":[NSValue valueWithCGSize:thumbSize]}];
    }
}

-(void) displayRemoteImage:(UIImageView *)imageView imageName:(NSString *)imageName
{
    [self displayRemoteImage:imageView imageName:imageName thumb:NO];
}




-(void) resDownloadNotification:(BSNotification *) noti
{
    if (noti.error.code ==0 && self.isValid) {
        BOOL showThumb = [[ noti.extraInfo objectForKey:@"showThumb"] boolValue];
        NSValue *sizeValue = [noti.extraInfo objectForKey:@"thumbSize"];
        BURes *res = (BURes *) noti.target;
        if (res.isCached) {
            UIImageView * imgv = (UIImageView  *)[ noti.extraInfo objectForKey:@"imageView"];
            if (!showThumb) {
                UIImage *image = [UIImage imageWithContentsOfFile: self.cacheFile];
                imgv.image = image;
//                [btn setImage:image forState:UIControlStateNormal];
//                imgv.contentMode = UIViewContentModeScaleToFill;
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"imgChange" object:self];
            }
            else {
                CGSize thumbSize = sizeValue.CGSizeValue;
                NSString *thumbFile = [self thumbFile:thumbSize];
                if (![[NSFileManager defaultManager] fileExistsAtPath:thumbFile]) {
                    UIImage *img = [[UIImage imageWithContentsOfFile:self.cacheFile] imageByScalingToSize:thumbSize];
                    NSData *thumbData = UIImageJPEGRepresentation(img,1);
                    [thumbData writeToFile:thumbFile atomically:YES];
                }
                UIImage *image = [UIImage imageWithContentsOfFile:thumbFile];
                imgv.image = image;
                if ([noti.extraInfo[@"isFitImg"]  boolValue]) {
                    imgv.width = MAX(imgv.width,image.size.width);
                    imgv.height = imgv.width *(image.size.height)/image.size.width;
                }
//                [btn setImage:image forState:UIControlStateNormal];
            }
        }
    }
}

//装载资源，如果资源在本地则直接通知，否则会有从网络进行数据请求
-(BOOL)download:(id)observer callback:(SEL)callback extraInfo:(NSDictionary*)extraInfo
{
   
    if (self.isCached || self.relativeURL.length <2)
    {
        return [self sendLocalRequest:nil observer:observer action:callback extraInfo:extraInfo];
        
    }
    else
    {
        if(UniversalFramework_isMustWIFILoadImg)
        {
            if(![[BURes getNetInfo] isEqualToString:@"WIFI"])
            {
                NSInvocation* invoke = BSGetInvocationFromSel(self, @selector(downloadOutput:ok:input:));
                [invoke invoke];
            return YES;
            }
        }
        return [self sendRequest:[self.remoteURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                            head:nil
                          method:@"GET"
                 inputInvocation:nil
                outputInvocation:BSGetInvocationFromSel(self, @selector(downloadOutput:ok:input:))
                        observer:observer
                          action:callback
                       extraInfo:extraInfo];
    }

}



-(NSError*)downloadOutput:(NSData*)recvData ok:(BOOL)ok input:(NSInvocation*)input
{
    if ([BUBase commandCount] ==1) {
//        [SVProgressHUD dismiss];
    }
    if (!ok)
	{
		//网络请求失败，这里定义一个固定的网络错误。
		return NetworkFailError;
	}
    
	//数据获取失败
	if (recvData == nil)
	{
		return DataRequestFailError;
	}
    
    [recvData writeToFile:self.cacheFile atomically:YES];
    UIImage *img = [UIImage imageWithContentsOfFile:self.cacheFile];
    if (img.size.width >1000)
    {
        CGFloat scaleRadio = img.size.width > img.size.height ? 500 / img.size.height :  500 / img.size.width;
        UIImage *thumbImg = [img scaleToSize:scaleRadio];
        NSData *thumbData = UIImageJPEGRepresentation(thumbImg,1);
        [thumbData writeToFile:self.cacheFile atomically:YES];
    }
    //生成缩略图文件
    if (UniversalFramework_isGenThumb) {
        UIImage *img = [UIImage imageWithContentsOfFile:self.cacheFile];
//        CGFloat scale = 0.1;
//        if(img.size.width == __SCREEN_SIZE.width)
//        {
//          scale = 0.1;
//        }
//        else if (img.size.width >= __SCREEN_SIZE.width/2)
//        {
//            scale = 0.2;
//        }
//        else if (img.size.width <  __SCREEN_SIZE.width/2 && img.size.width > 50)
//        {
//            scale = 0.4;
//        }
//        else if(img.size.width <= 50)
//        {
//            scale = 0.8;
//        }
        if (_cacheThumbFileSize.width == 0 || _cacheThumbFileSize.height == 0) {
           _cacheThumbFileSize = CGSizeMake(100, 100);
        }
        else
        {
//           if(img.size.width <=  __SCREEN_SIZE.width * 2 )
           {
               _cacheThumbFileSize = CGSizeMake(_cacheThumbFileSize.width, _cacheThumbFileSize.width * img.size.height / img.size.width);
           }
        }
            
        UIImage *thumbImg = [img imageToSize:_cacheThumbFileSize];
        NSData *thumbData = UIImageJPEGRepresentation(thumbImg,1);
        [thumbData writeToFile:self.cacheThumbFile atomically:YES];
    }
    
    _isCached = YES;
    
    return SuccessedError;
}


+(NSString*)getNetInfo
{
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    switch (type) {
        case 1:
        
        return @"2G";
        
        break;
        
        case 2:
        
        return @"3G";
        case 3:
        
        return @"4G";
        case 5:
        
        return @"WIFI";
        
        default:
        
        return @"NO-WIFI";//代表未知网络
        
        break;
    }
}
@end
