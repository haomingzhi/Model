
#import "BUBase.h"
#import "CommonUtil.h"
#import <objc/runtime.h>

//单位秒
double RES_UPDATE_INTERVAL = 60*60;//60 * 1000;


NSInvocation* BSGetInvocationFromSel(NSObject *obj, SEL sel)
{
	NSMethodSignature *sig = [obj methodSignatureForSelector:sel];
	NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
	[inv setSelector:sel];
	return inv;
}



@implementation BUBase

-(id)init
{
    self = [super init];
    if(self){
        self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
        
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] allocWithZone:zone] init];
    NSArray *propertyList = [copy getPropertyKeyList];
    for (NSString *p in propertyList) {
        [copy setValue: [self valueForKey:p] forKey:p];
    }
    return copy;
}
-(NSDictionary *) getCellData
{
    return NULL;
}
-(NSDictionary *) getCellData:(NSArray *) fields
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    for (NSString * field in fields) {
        if ([self isExists:field]) {
            [result setObject:nullToEmpty([self valueForKey:field]) forKey:field];
        }
    }
    return result;
}
#pragma mark -- Public Method

-(BOOL) commonRequestData:(NSString *)requestStr observer:(id)observer callback:(SEL)callback
{
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",UniversalFrameworkApiHost,requestStr]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(commonRequestDataOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}
-(BOOL) commonRequest:(NSString*) requestStr output:(NSInvocation*)outputInvocation observer:(id) observer callback:(SEL) callback
{
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",UniversalFrameworkApiHost,requestStr]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:outputInvocation
                    observer:observer
                      action:callback
                   extraInfo:NULL];
}
-(BOOL) commonRequest:(NSString*) requestStr ext:(NSDictionary *)ext observer:(id) observer callback:(SEL) callback
{
    return [self sendRequest:requestStr
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(commonRequestOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:ext];
}
-(BOOL) commonRequest:(NSString*) requestStr observer:(id) observer callback:(SEL) callback
{
    return [self commonRequest:requestStr ext:nil observer:observer callback:callback];
}

-(NSError *)noDataOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    return SuccessedError;
}

-(NSError *)commonRequestDataOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    [[jsonObj objectForKey:@"Data" ] deserialization:self];
    return SuccessedError;
}

-(NSError *)commonRequestOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    [jsonObj deserialization:self];
    return SuccessedError;
}


-(BOOL)removeObserver:(id)observer
{
	return [[BSCommandScheduler defaultCommandScheduler] removeObserver:observer];
}

//暂停网络交互
-(void)stopRequest
{
    [[BSCommandScheduler defaultCommandScheduler] removeTarget:self];
}

+(NSInteger) commandCount
{
    return [[BSCommandScheduler defaultCommandScheduler] commandButDownload];
}


#pragma mark -- Private Method

//网络交互方法（简要）
-(BOOL)sendRequest:(NSString*)address
   inputInvocation:(NSInvocation*)inputInvocation
  outputInvocation:(NSInvocation*)outputInvocation
             async:(BOOL)async
		  observer:(id)observer
			action:(SEL)action
		 extraInfo:(NSDictionary*)extraInfo
{
    
    return [[BSCommandScheduler defaultCommandScheduler] addCommand:address
                                                               head:nil
                                                             method:@"POST"
                                                              async:async
                                                             target:self
                                                    inputInvocation:inputInvocation
                                                   outputInvocation:outputInvocation
                                                 progressInvocation:nil
                                                 responseInvocation:nil
                                             notificationInvocation:nil                                                                        observer:observer
                                                             action:action
                                                          extraInfo:extraInfo];
}
//无参数
-(BOOL)sendRequest:(NSString*)address
  outputInvocation:(NSInvocation*)outputInvocation
          observer:(id)observer
            action:(SEL)action
{
    return [self sendRequest:address inputInvocation:NULL outputInvocation:outputInvocation async:YES observer:observer action:action extraInfo:NULL];
}

-(BOOL)sendRequest:(NSString*)address
   inputInvocation:(NSInvocation*)inputInvocation
  outputInvocation:(NSInvocation*)outputInvocation
		  observer:(id)observer
			action:(SEL)action
		 extraInfo:(NSDictionary*)extraInfo
{
    return [self sendRequest:address inputInvocation:inputInvocation outputInvocation:outputInvocation async:YES observer:observer action:action extraInfo:extraInfo];
}


-(BOOL)sendRequest:(NSString*)address
              head:(NSDictionary*)head
            method:(NSString*)method
            async :(BOOL)async
   inputInvocation:(NSInvocation*)inputInvocation
  outputInvocation:(NSInvocation*)outputInvocation
          observer:(id)observer
            action:(SEL)action
         extraInfo:(NSDictionary*)extraInfo
{
    if ([address hasPrefix:@"http"] || [address hasPrefix:@"https"]|| [address hasPrefix:@"ftp"])
        ;
    else
        address =  [NSString stringWithFormat:@"%@%@", UniversalFrameworkApiHost, address];
    
    return [[BSCommandScheduler defaultCommandScheduler] addCommand:address
                                                               head:head
                                                             method:method
                                                              async:async
                                                             target:self
                                                    inputInvocation:inputInvocation
                                                   outputInvocation:outputInvocation
                                                 progressInvocation:nil
                                                 responseInvocation:nil
                                             notificationInvocation:nil
                                                           observer:observer
                                                             action:action
                                                          extraInfo:extraInfo];
}

//网络交互方法（详细）
-(BOOL)sendRequest:(NSString*)address
			  head:(NSDictionary*)head
			method:(NSString*)method
   inputInvocation:(NSInvocation*)inputInvocation
  outputInvocation:(NSInvocation*)outputInvocation
		  observer:(id)observer
			action:(SEL)action
		 extraInfo:(NSDictionary*)extraInfo
{
    return  [self sendRequest:address head:head method:method async:YES inputInvocation:inputInvocation outputInvocation:outputInvocation observer:observer action:action extraInfo:extraInfo ];
}

//网络交互方法（上传）
-(BOOL)sendUploadRequest:(NSString*)address
                    data:(NSObject*)data
                fileName:(NSString*)fileName
        outputInvocation:(NSInvocation*)outputInvocation
                observer:(id)observer
                  action:(SEL)action
               extraInfo:(NSDictionary*)extraInfo
{
    if ([address hasPrefix:@"http"] || [address hasPrefix:@"https"]|| [address hasPrefix:@"ftp"])
        ;
    else
        address =  [NSString stringWithFormat:@"%@%@", UniversalFrameworkApiHost, address];
    
    return [[BSCommandScheduler defaultCommandScheduler] addUploadCommand:address
                                                                     data:data
                                                                 fileName:fileName
                                                                   target:self
                                                         outputInvocation:outputInvocation
                                                                 observer:observer
                                                                   action:action
                                                                extraInfo:extraInfo];
}




-(BOOL)sendLocalRequest:(NSError*)error
               observer:(id)observer
                 action:(SEL)action
              extraInfo:(NSDictionary*)extraInfo
{
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(localInput:));
    [input setArgument:&error atIndex:2];
    [input retainArguments];
    
    return [self sendRequest:nil
			 inputInvocation:input
			outputInvocation:BSGetInvocationFromSel(self, @selector(localOutput:ok:input:))
					observer:observer
					  action:action
				   extraInfo:extraInfo];
    
}





//发送资源平台请求
-(BOOL)sendResourceRequest:(NSInvocation*)inputInvocation
      outputInvocation:(NSInvocation*)outputInvocation
              observer:(id)observer
                action:(SEL)action
             extraInfo:(NSDictionary*)extraInfo
{
    return YES;
    
}


-(BSJSON*)genJSONRequestHeader:(NSString*) busiType
{
    BSJSON *dictObj = [[BSJSON alloc] init];
//    
//    [dictObj setObject:busiSystem.agent.channelId forKey:BU_PROPERTY_KEY_CHANNELID];
//    if (busiSystem.agent != nil && busiSystem.agent.userId != nil)
//        [dictObj setObject:busiSystem.agent.userId forKey:BU_PROPERTY_KEY_USER];
//    else
//        [dictObj setObject:@"" forKey:BU_PROPERTY_KEY_USER];
//    
//    if (busiSystem.orderManager.currentOrder != nil && busiSystem.orderManager.currentOrder.ident != nil)
//        [dictObj setObject:busiSystem.orderManager.currentOrder.ident forKey:BU_PROPERTY_KEY_ORDERNO];
//    else
//        [dictObj setObject:@"" forKey:BU_PROPERTY_KEY_ORDERNO];
//    [dictObj setObject:busiType forKey:BU_PROPERTY_KEY_BUSITYPE];
//    
//    if (busiSystem.device != nil && busiSystem.device.uuid != nil)
//        [dictObj setObject:busiSystem.device.uuid forKey:BU_PROPERTY_KEY_DEVICEID];
//    else
//        [dictObj setObject:@"" forKey:BU_PROPERTY_KEY_DEVICEID];
//    
//    [dictObj setObject:@"02" forKey:BU_PROPERTY_KEY_CLIENTTYPE];
//    if (busiSystem.appVer != nil)
//        [dictObj setObject:busiSystem.appVer forKey:BU_PROPERTY_KEY_CLIENTVERSION];
//    else
//        [dictObj setObject:@"" forKey:BU_PROPERTY_KEY_CLIENTVERSION];
//    //拼装报文头部的data2部分的数据
//    BSJSON *data2Json = [[BSJSON alloc] init];
//    if (busiSystem.agent.psam != NULL && busiSystem.agent.psam.randKey != NULL) {
//        [data2Json setObject:busiSystem.agent.psam.randKey forKey:BU_PROPERTY_KEY_RANDKEY];
//    }
//    else [data2Json setObject:@"" forKey:BU_PROPERTY_KEY_RANDKEY];
//    
//    if (busiSystem.agent.psam != NULL && busiSystem.agent.psam.randkeyEncrypt != NULL) {
//        [data2Json setObject:busiSystem.agent.psam.randkeyEncrypt forKey:BU_PROPERTY_KEY_RANDKEYSTR];
//    }
//    else [data2Json setObject:@"" forKey:BU_PROPERTY_KEY_RANDKEYSTR];
//    
//    NSData *rawData = [data2Json serialization:NSUTF8StringEncoding];
//    //des加密
//    NSData *ripeData = [BSSecurity desEncrypt:busiSystem.agent.key.hexData rawData:rawData];
//    [dictObj setObject:ripeData.hexStr forKey:BU_PROPERTY_KEY_DATA2];
    return dictObj;
    //return NULL;
}

-(BSJSON*)genJSONResponseHeader:(NSData*)recvData
{
    if (recvData == nil)
        return nil;
    
    BSJSON *jsonObj = [[BSJSON alloc] initWithData:recvData encoding:NSUTF8StringEncoding];
    
    return jsonObj;
}


-(NSData*)signJSONData:(BSJSON*)jsonObj
{
    
//    NSMutableString *sbSign = [[NSMutableString alloc] init];
//    
//    [sbSign appendString:BU_PROPERTY_KEY_CHANNELID];
//    [sbSign appendString:[jsonObj objectForKey:BU_PROPERTY_KEY_CHANNELID]];
//    
//    [sbSign appendString:BU_PROPERTY_KEY_USER];
//    [sbSign appendString:[jsonObj objectForKey:BU_PROPERTY_KEY_USER]];
//    
//    [sbSign appendString:BU_PROPERTY_KEY_ORDERNO];
//    [sbSign appendString:[jsonObj objectForKey:BU_PROPERTY_KEY_ORDERNO]];
//    
//    [sbSign appendString:BU_PROPERTY_KEY_BUSITYPE];
//    [sbSign appendString:[jsonObj objectForKey:BU_PROPERTY_KEY_BUSITYPE]];
//    
//    [sbSign appendString:BU_PROPERTY_KEY_PSAMNO];
//    [sbSign appendString:[jsonObj objectForKey:BU_PROPERTY_KEY_PSAMNO]];
//    
//    [sbSign appendString:BU_PROPERTY_KEY_DEVICEID];
//    [sbSign appendString:[jsonObj objectForKey:BU_PROPERTY_KEY_DEVICEID]];
//    
//    [sbSign appendString:BU_PROPERTY_KEY_CLIENTTYPE];
//    [sbSign appendString:[jsonObj objectForKey:BU_PROPERTY_KEY_CLIENTTYPE]];
//    
//    [sbSign appendString:BU_PROPERTY_KEY_CLIENTVERSION];
//    [sbSign appendString:[jsonObj objectForKey:BU_PROPERTY_KEY_CLIENTVERSION]];
//
//    [sbSign appendString:BU_PROPERTY_KEY_DATA2];
//    [sbSign appendString:[jsonObj objectForKey:BU_PROPERTY_KEY_DATA2]];
//    
//    [sbSign appendString:BU_PROPERTY_KEY_DATA];
//    [sbSign appendString:[jsonObj objectForKey:BU_PROPERTY_KEY_DATA]];
//
//    //这里加一个特殊的命令判断是系统登录后如果返回1005则表示密码需要修改，但这时候是没有登录的。
//    //而进行密码修改又需要从服务器里使用返回的KEY来作密码修改的签名校验，所以这里做一个特殊化处理。
//    NSString *busiType = (NSString*)[jsonObj objectForKey:BU_PROPERTY_KEY_BUSITYPE];
//    if (busiSystem.agent != nil && (busiSystem.agent.isLogin || [busiType isEqualToString:BU_COMMAND_PASSWORDMODIFY]))
//        [sbSign appendString:busiSystem.agent.key];
//    
//    NSData *md = [sbSign dataUsingEncoding:NSUTF8StringEncoding];
//    [jsonObj setObject:md.md5Data.hexStr forKey:BU_PROPERTY_KEY_SIGN];
//    //NSLog(@"sign =%@,signCode =%@",sbSign,[jsonObj objectForKey:BU_PROPERTY_KEY_SIGN]);
//    return  [jsonObj serialization:NSUTF8StringEncoding];
    return NULL;
}

-(NSString*)genHTTPRequestHead:(NSString* )busiType{
//    NSMutableString *sData = [[NSMutableString alloc] init];
//    @try {
//        [sData appendString:@"ChannelId="];
//        [sData appendString:busiSystem.agent.channelId];
//        if(busiSystem.agent!=nil && busiSystem.agent.userId!=nil) {
//            [sData appendString:@"$AreaCode="];
//            [sData appendString:busiSystem.agent.regionId];
//            [sData appendString:@"$User="];
//            [sData appendString:busiSystem.agent.userId];
//        } else {
//            [sData appendString:@"$AreaCode="];
//            [sData appendString:@"$User="];
//        }
//        [sData appendString:@"$ClientAppID="];
//        [sData appendString:busiSystem.appId];
//        [sData appendString:@"$BusiType="];
//        [sData appendString:busiType];
//        
//        [sData appendString:@"$ReqTime="];
//        NSDateFormatter *format = [[NSDateFormatter alloc] init];
//        [format setDateFormat:@"yyyyMMddHHmmss"];
//        [sData appendString:[format stringFromDate:[NSDate date]]];
//        
//        [sData appendString:@"$TransID="];
//        if(busiSystem.orderManager.currentOrder!=nil && busiSystem.orderManager.currentOrder.ident!=nil) {
//            [sData appendString:busiSystem.orderManager.currentOrder.ident];
//        } else {
//            [sData appendString:@""];
//        }
//        
//        [sData appendString:@"$DeviceCode="];
//        [sData appendString:busiSystem.device.uuid];
//        [sData appendString:@"$DeviceType="];
//        [sData appendString:busiSystem.device.type];
//        [sData appendString:@"$DeviceScreen="];
//        [sData appendString:[NSString stringWithFormat:@"%d",busiSystem.device.screenWidth]];
//        [sData appendString:@"x"];
//        [sData appendString:[NSString stringWithFormat:@"%d",busiSystem.device.screenHeight]];
//        [sData appendString:@"$OSType=2"];
//        [sData appendString:@"$OSVersion="];
//        [sData appendString:busiSystem.device.osVersion];
//        [sData appendString:@"$ClientVersion="];
//        [sData appendString:busiSystem.appVer];
//    }
//    @catch (NSException *exception) {
//        NSLog(@"genHTTPRequestHead拼装异常");
//    }
//    
//    return sData;
    return @"";
}

-(NSString *)genHTTPRequest:(NSString *)url busiType:(NSString *)busiType params:(NSString *)params{
    NSMutableString *sData = [[NSMutableString alloc] init];
    [sData appendString:url];
    @try {
        NSString *signStr = [NSString stringWithFormat:@"%@%@%@%@",@"Commheads",[self genHTTPRequestHead:busiType],@"Params",params];
        NSData *signData = [signStr dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"SignStr=%@,SignCode=%@",signStr,signData.md5Data.hexStr);
        [sData appendString:@"Commheads="];
        [sData appendString:[self genHTTPRequestHead:busiType]];
        [sData appendString:@"&Params="];
        [sData appendString:params];
        [BSUtility AddCookie:[BSUtility getHost:url] OriginUrl:[BSUtility getHost:url] CookieName:@"sign" CookieValue:signData.md5Data.hexStr];
        //[sData appendString:@"&SIGN="];
        //[sData appendString:signData.md5Data.hexStr];
    }
    @catch (NSException *exception) {
        NSLog(@"拼装资源请求数据异常");
    }
    
    return sData;
}

-(NSString *)genHTTPRequest:(NSString *)busiType params:(NSString *)params{
    //return [self genHTTPRequest:DEFAULT_RES_SERVICE_URL busiType:busiType params:params];
//    return [self genHTTPRequest:@"http://220.249.190.132:18023/res/resource/dispacherAction.shtml?" busiType:busiType params:params];
    return NULL;
    
}



-(NSData*)localInput:(NSError*)error
{
    return nil;
}

-(NSError*)localOutput:(NSData*)recvData ok:(BOOL)ok input:(NSInvocation*)input
{
    NSError *error = nil;
    
    __unsafe_unretained NSError *err = nil;
    [input getArgument:&err atIndex:2];
    error = err;
    //如果error为nil那么构造出一个返回为0的错误代码
    if (error == nil)
        error = SuccessedError;
    
    return error;
}

-(NSData*)getInputNodata:(NSString*) busiType
{
//    //拼装报文头
//    BSJSON *jsonObj = [self genJSONRequestHeader:busiType];
//    BSJSON *jsonData = [[BSJSON alloc] init];
//    [jsonData setObject:busiSystem.device.type forKey:BU_PROPERTY_KEY_CLIENTTYPE];
//    [jsonData setObject:busiSystem.appVer forKey:BU_PROPERTY_KEY_CLIENTTYPE];
//    //把报文部分加密
//    NSData *rawData = [jsonData serialization:NSUTF8StringEncoding];
//    //des加密
//    NSData *ripeData = [BSSecurity desEncrypt:busiSystem.agent.key.hexData rawData:rawData];
//    [jsonObj setObject:ripeData.hexStr forKey:BU_PROPERTY_KEY_DATA];
//    return [self signJSONData:jsonObj];
    return NULL;
}

+(NSString *)getVisitUrl:(NSString*)url
{
//    NSString *bsServiceUrl = [busiSystem.globalParams objectForKey: BU_K_RES_BS_SERVICE_URL] == NULL ? DEFAULT_RES_BS_BASE_URL
//    :[busiSystem.globalParams objectForKey:BU_K_RES_BS_SERVICE_URL];
//    return [BUBase getVisitUrl:url host:bsServiceUrl];
    return NULL;
}


+(NSString *)getVisitUrl:(NSString *)url host:(NSString *)hostUrl
{
//    NSString *bsServiceUrl = hostUrl;
//    NSString *signCode;
//    NSMutableString *result = [[NSMutableString alloc]init];
//    if (url != NULL && url.length >0 ) {
//        NSInteger width = busiSystem.device.screenWidth;
//        NSInteger height = busiSystem.device.screenHeight;
//        if (![url hasPrefix:@"http://"] && ![url hasPrefix:@"https://"]) {
//            [result appendString:bsServiceUrl];
//        }
//        [result appendString:url];
//        if (busiSystem.agent.userId != NULL && busiSystem.agent.userId.length >0) {
//            NSString *urlSignParameter= [NSString stringWithFormat:@"%@%@%@%@%@%@",@"apple",(busiSystem.agent.userId == nil? @"" : busiSystem.agent.userId),busiSystem.device.uuid,busiSystem.appId,busiSystem.appVer,busiSystem.agent.key];
//            NSData *signData = [urlSignParameter dataUsingEncoding:NSUTF8StringEncoding];
//            signCode= signData.md5Data.hexStr;
//            NSLog(@"SignStr=%@,SignCode=%@",urlSignParameter,signData.md5Data.hexStr);
//        }
//        else
//        {//MD5(type+uid+device_id+app_id+version)
//            NSString *urlSignParameter= [NSString stringWithFormat:@"%@%@%@%@%@",@"apple",@"null",busiSystem.device.uuid,busiSystem.appId,busiSystem.appVer];
//            NSData *signData = [urlSignParameter dataUsingEncoding:NSUTF8StringEncoding];
//            signCode= signData.md5Data.hexStr;
//            NSLog(@"SignStr=%@,SignCode=%@",urlSignParameter,signData.md5Data.hexStr);
//        }
//        
//        [result appendString:[NSString stringWithFormat:@"?w=%d&h=%d&type=apple&uid=%@&device_id=%@&app_id=%@&version=%@",width,height,(busiSystem.agent.userId == nil? @"null" : busiSystem.agent.userId),busiSystem.device.uuid,busiSystem.appId,busiSystem.appVer]];
//    }
//    [BSUtility AddCookie:[BSUtility getHost:bsServiceUrl] OriginUrl:[BSUtility getHost:bsServiceUrl] CookieName:@"sign" CookieValue:signCode];
//    NSLog(result);
//    return result;
    return NULL;
}

//序列化指定字段
-(NSString *) serialization:(NSArray *) fields
{
    BOOL isFirstField = YES;
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendString:[self isKindOfClass:[NSArray class]] ? @"[" : @"{" ];
    for (NSString *propertyName in fields){
        if (!isFirstField)
            [result appendString:@","];
        if (self.ignorePropertys == NULL || [self.ignorePropertys indexOfObject:fields] == NSNotFound) {
            isFirstField = NO;
            [result appendFormat:@"\"%@\":", fields];
            NSString *propertyValueType = [self getpropertyType:propertyName];
            if ([propertyValueType isEqualToString:NSStringFromClass([NSString class])] || [propertyValueType isEqualToString:NSStringFromClass([NSNumber class])]) { //简单类型
                id objVal = [self valueForKey:propertyName];
                //添加value
                if ([propertyValueType isEqualToString:NSStringFromClass([NSString class])])
                {
                    [result appendFormat:@"\"%@\"", objVal == NULL ? @"" : objVal];
                }
                else if ([propertyValueType isEqualToString:NSStringFromClass([NSNumber class])])
                {
                    [result appendFormat:@"%@",objVal == NULL ? 0 : objVal];
                }
            }
            else if ([propertyValueType isEqualToString:NSStringFromClass([NSArray class])] || [propertyValueType isEqualToString:NSStringFromClass([NSMutableArray class])] )
            {
                NSArray * objVal = (NSArray *)[self valueForKey:propertyName];
                if (objVal == NULL) {
                    [result appendString:@"[]"];
                }
                else {
                    NSMutableString *jsonArray = [[NSMutableString alloc] init];
                    [jsonArray appendString:@"["];
                    for (int i =0; i < objVal.count; i++) {
                        if (i != 0) {
                            [jsonArray appendString:@","];
                        }
                        [jsonArray appendString:[objVal[i] description]];
                    }
                    [jsonArray appendString:@"]"];
                    [result appendString:jsonArray];
                }
            }
            else {
                if (self.serializationMap != NULL && [self.serializationMap indexOfObject:propertyValueType] != NSNotFound) {//把他当作字符串看待
                    id objVal = [self valueForKey:propertyName];
                    //添加value
                    [result appendFormat:@"\"%@\"", objVal  == NULL ? @"" : [objVal description]];
                }
                else {
                    id objVal = [self valueForKey:propertyName];
                    //添加value
                    [result appendFormat:@"%@", objVal  == NULL ? @"{}" : [objVal description]];
                }
            }
        }
        else NSLog(@"属性=%@被忽略了",fields);
    }
    [result appendString:[self isKindOfClass:[NSArray class]] ? @"]" : @"}" ];
    return result;
}
//根据Property，序列化成json对象
-(NSString *)description
{
//    NSMutableDictionary *propertyList;
//    unsigned int outCount, i;
//    propertyList = [[NSMutableDictionary alloc] init];
//    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
//    for (i=0; i<outCount; i++)
//    {
//        objc_property_t property = properties[i];
//        NSString *propertyAttributes  = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
//        NSString *className = [([propertyAttributes componentsSeparatedByString:@","][0])componentsSeparatedByString:@"\""][1];
//        NSString *propertyName = [([propertyAttributes componentsSeparatedByString:@","].lastObject)componentsSeparatedByString:@"_"][1];
//        propertyList[propertyName] = className;
//    }
    
    return [self serialization:[self getPropertyKeyList]];
}

-(void)setResposeState:(BSJSON*)jsonObj
{
     self.codeState = [[jsonObj objectForKey:@"codeState"] integerValue];
    _message = [jsonObj objectForKey:@"message"];
}

-(void)setCodeState:(NSInteger)codeState
{
    if (codeState == -1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BUBaseCodeStateChange" object:nil];
    }
    _codeState = codeState;
}
@end
