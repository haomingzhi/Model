

#import <Foundation/Foundation.h>
#import "CommonUtil.h"

//根据对象以及SEL类型得到一个NSInvocation对象
extern NSInvocation* BSGetInvocationFromSel(NSObject *obj, SEL sel);


#define UnknownError ([NSError errorWithDomain:@"未知错误" code:1 userInfo:nil])
#define SuccessedError     ([NSError errorWithDomain:@"" code:0 userInfo:nil])
#define NetworkFailError ([NSError errorWithDomain:@"网络请求失败" code:-1 userInfo:nil])
#define DataRequestFailError ([NSError errorWithDomain:@"数据获取失败" code:-2 userInfo:nil])
#define DataParseFailError ([NSError errorWithDomain:@"数据解析失败" code:-3 userInfo:nil])
#define SignitureFailError ([NSError errorWithDomain:@"数据包异常,签名不匹配" code:-4 userInfo:nil])
#define CustomError(errorCode,msg) ([NSError errorWithDomain:(msg) code:(errorCode) userInfo:nil])
//一般性错误，比如输入密码错误

//未登录
#define ERROR_CODE_UNLOGIN      -500
//订单号为空
#define ERROR_CODE_ORDERNO_EMPTY -200


//默认登陆密码
#define ERRORCODE_DEFAULTLOGINPASSWORD 1005
//默认支付密码
#define ERRORCODE_DEFAULTPAYPASSWORD 1006

#define intToStr(intArg) ([NSString stringWithFormat:@"%ld",((long)intArg)])

//增加前缀
#define addStrPrefix(prefix,strArg) ([NSString stringWithFormat:@"%@%@",(prefix),(strArg)])
#define addIntPrefix(prefix,intArg) ([NSString stringWithFormat:@"%@%ld",(prefix),(intArg)])
#define addFloatPrefix(prefix,floatArg) ([NSString stringWithFormat:@"%@%.2f",(prefix),(floatArg)])

#define nullToEmpty(str) (!str || [(str) length] ==0 ? @"" : (str))

#define  DIDGROUPNOTIFICATION(noti)\
if (noti.error.code ==0 && [BUBase commandCount] ==0) {\
    HUDDISMISS;\
}\
else if (noti.error.code != 0 ) {\
    if ([BUBase commandCount] ==0) {\
        [SVProgressHUD dismiss];\
        if ([self isKindOfClass:NSClassFromString(@"JYBaseViewController")] && [busiSystem.errorMonitors indexOfObject:@(noti.error.code)] != NSNotFound)\
        {\
            BSNetworkCommand *cmd = noti.cmd;\
            [self performSelector:@selector(addToHistoryCommand:) withObject:cmd];\
            [self performSelector:@selector(showLoadingFailureCoverView:) withObject:[NSString stringWithFormat:@"%@,请点击屏幕重试",noti.error.domain]];\
        }\
    }\
    return;\
}

#define BASENOTIFICATION(noti)\
if (noti.error.code ==0) {\
HUDDISMISS;\
[[JYNetErrorManager manager] dismissErrorView:NSStringFromClass([noti.target class])];\
}\
else {\
if ([self isKindOfClass:NSClassFromString(@"JYBaseViewController")] && [busiSystem.errorMonitors indexOfObject:@(noti.error.code)] != NSNotFound)\
{\
BSNetworkCommand *cmd = noti.cmd;\
[self performSelector:@selector(addToHistoryCommand:) withObject:cmd];\
if([self valueForKey:@"view"])\
{\
BSNetworkCommand *cmd = noti.cmd;\
[self performSelector:@selector(addToHistoryCommand:) withObject:cmd];\
[self performSelector:@selector(showLoadingFailureCoverView:) withObject:@"加载失败,请点击屏幕重试"];\
[SVProgressHUD dismiss];\
}\
}\
else \
HUDCRY(noti.error.domain, TOAST_LONGERTIMER); \
return;\
}\

#define BASENOTIFICATIONWITHCANMISS(noti,can)\
if (noti.error.code ==0) {\
if(can)\
{\
HUDDISMISS;\
[[JYNetLoadingManager manager] dismissLoadingView];\
[[JYNetErrorManager manager] dismissErrorView];\
}\
}\
else {\
    if ([self isKindOfClass:NSClassFromString(@"JYBaseViewController")] && [busiSystem.errorMonitors indexOfObject:@(noti.error.code)] != NSNotFound)\
    {\
        BSNetworkCommand *cmd = noti.cmd;\
        [self performSelector:@selector(addToHistoryCommand:) withObject:cmd];\
if([self valueForKey:@"view"])\
{\
BSNetworkCommand *cmd = noti.cmd;\
[self performSelector:@selector(addToHistoryCommand:) withObject:cmd];\
[self performSelector:@selector(showLoadingFailureCoverView:) withObject:@"加载失败,请点击屏幕重试"];\
[SVProgressHUD dismiss];\
}\
    }\
    else \
        HUDCRY(noti.error.domain, TOAST_LONGERTIMER); \
    return;\
}\

#define JYLOADING [[JYNetLoadingManager manager] addLoadingView:self.view withTip:@"拼命加载中..." withImg: [UIImage imageContentWithFileName:@"run2"]]

#define JYBASENOTIFICATION(noti)\
if (noti.error.code ==0) {\
HUDDISMISS;\
[[JYNetLoadingManager manager] dismissLoadingView];\
[[JYNetErrorManager manager] dismissErrorView:NSStringFromClass([noti.target class])];\
}\
else {\
if ([self isKindOfClass:NSClassFromString(@"JYBaseViewController")] && [busiSystem.errorMonitors indexOfObject:@(noti.error.code)] != NSNotFound)\
{\
BSNetworkCommand *cmd = noti.cmd;\
[self performSelector:@selector(addToHistoryCommand:) withObject:cmd];\
[[JYNetErrorManager manager] addErrorView:self.view withTip:@"网络异常" withImg:[UIImage imageContentWithFileName:@"netError"] withTag:NSStringFromClass([noti.target class]) withTarget:self withAction:@selector(handleRedo:)];\
[[JYNetLoadingManager manager] dismissLoadingView];\
HUDDISMISS;\
}\
else \
{\
[[JYNetLoadingManager manager] dismissLoadingView];\
HUDCRY(noti.error.domain, TOAST_LONGERTIMER); \
}\
return;\
}

#define JYBASENOTIFICATIONWITHCANMISS(noti,can)\
if (noti.error.code ==0) {\
    if(can)\
    {\
    HUDDISMISS;\
    [[JYNetLoadingManager manager] dismissLoadingView];\
    [[JYNetErrorManager manager] dismissErrorView];\
    }\
}\
else {\
if ([self isKindOfClass:NSClassFromString(@"JYBaseViewController")] && [busiSystem.errorMonitors indexOfObject:@(noti.error.code)] != NSNotFound)\
{\
BSNetworkCommand *cmd = noti.cmd;\
[self performSelector:@selector(addToHistoryCommand:) withObject:cmd];\
[[JYNetErrorManager manager] addErrorView:self.view withTip:@"网络异常" withImg:[UIImage imageContentWithFileName:@"netError"] withTarget:self withAction:@selector(handleRedo:)];\
[[JYNetLoadingManager manager] dismissLoadingView];\
HUDDISMISS;\
}\
else \
HUDCRY(noti.error.domain, TOAST_LONGERTIMER); \
return;\
}

#define JYBASENOTIFICATIONWITHCANMISSANDVC(noti,can,vc)\
if (noti.error.code ==0) {\
if(can)\
{\
HUDDISMISS;\
[[JYNetLoadingManager manager] dismissLoadingView];\
[[JYNetErrorManager manager] dismissErrorView];\
}\
}\
else {\
if ([self isKindOfClass:NSClassFromString(@"JYBaseViewController")] && [busiSystem.errorMonitors indexOfObject:@(noti.error.code)] != NSNotFound)\
{\
BSNetworkCommand *cmd = noti.cmd;\
[self performSelector:@selector(addToHistoryCommand:) withObject:cmd];\
[[JYNetErrorManager manager] addErrorView:vc.view withTip:@"网络异常" withImg:[UIImage imageContentWithFileName:@"netError"] withTarget:self withAction:@selector(handleRedo:)];\
[[JYNetLoadingManager manager] dismissLoadingView];\
HUDDISMISS;\
}\
else \
HUDCRY(noti.error.domain, TOAST_LONGERTIMER); \
return;\
}



#define  UNPACKETOUTPUTHEAD(recvData,ok) UNPACKETOUTPUTHEADWITHSUCESSEDCODE(recvData,ok,1)

#define UNPACKETOUTPUTHEADWITHSUCESSEDCODE(recvData,ok,sucessedCode)\
if (!ok || recvData == nil)\
{\
return NetworkFailError;\
}\
BSJSON *jsonObj = [self genJSONResponseHeader:recvData];\
if (jsonObj == nil)\
{\
return DataRequestFailError;\
}\
NSInteger retCode = [[jsonObj objectForKey:@"codeState"] integerValue];\
retCode = retCode == 1 ? 0 : (retCode ==0 ? 1:retCode) ;\
[self setResposeState:jsonObj];\
if (retCode != 0) {\
NSString *retMsg = [jsonObj objectForKey:@"message"];\
return CustomError(retCode,retMsg);\
}\


//#define  UNPACKETOUTPUTHEAD(recvData,ok) UNPACKETOUTPUTHEADWITHSUCESSEDCODE(recvData,ok,1)
//
//#define UNPACKETOUTPUTHEADWITHSUCESSEDCODE(recvData,ok,sucessedCode)\
//if (!ok || recvData == nil)\
//{\
//    return NetworkFailError;\
//}\
//BSJSON *jsonObj = [self genJSONResponseHeader:recvData];\
//if (jsonObj == nil)\
//{\
//    return DataRequestFailError;\
//}\
//NSInteger retCode = [[jsonObj objectForKey:@"RetCode"] integerValue];\
//retCode = retCode ==0 ? 1 : (retCode ==1 ? 0:retCode) ;\
//if (retCode != 1) {\
//NSString *retMsg = [jsonObj objectForKey:@"RetMsg"];\
//return CustomError(retCode,retMsg);\
//}\


#define DESENCRYPTJASON(jsonData,jsonObj)\
    NSData *rawData = [jsonData serialization:NSUTF8StringEncoding];\
    NSData *ripeData = [BSSecurity desEncrypt:busiSystem.agent.key.hexData rawData:rawData];\
    [jsonObj setObject:ripeData.hexStr forKey:BU_PROPERTY_KEY_DATA];\
    return [self signJSONData:jsonObj];\


//返回码
#define BU_PROPERTY_KEY_RETCODE @"flag"
//返回描述
#define BU_PROPERTY_KEY_RETMSG  @"msg"
//数据
#define BU_PROPERTY_KEY_DATA    @"data"

#define BU_K_VERSION    @"version"
#define BU_K_APPID      @"appid"






//定义系统权限功能。
#define  BUMENU_REALESTATESAPPOINTMENT          @"100"      //物业预约
#define  BUMENU_SHOP                            @"200"      //社区商城
#define  BUMENU_CONVENIENTINFO	    @"300"   //便民资讯
#define  BUMENU_BRANDUNION          @"400"   //品牌联盟
#define  BUMENU_ALLMARKETING        @"500"   //宽带充值
#define  BUMENU_INTELLECTUAL   	    @"600"   //智能家居





/*
  业务系统基类。所有的业务类都从这里派生
 */
@interface BUBase : NSObject
@property(nonatomic)NSInteger codeState;
@property(nonatomic,strong)NSString *message;
@property(nonatomic) NSDictionary *deserializationMap; //由于json反序列化的时候无法知道数组类型，这里提供映射关系。或者包含本属性的其他类型，如通过NSString 类型转换成BUImageRes
@property(nonatomic) NSArray *serializationMap; //指定类型当作字符串看待，比如BUImageRes
@property(nonatomic) NSArray *ignorePropertys;  //序列化的适合，指定需要忽略的属性

@property(nonatomic) CGFloat height;            //缓存cell高度
-(void)setResposeState:(BSJSON*)jsonObj;
//-(NSString *)getBaseUrlParem;
//序列化指定字段
-(NSString *) serialization:(NSArray *) fields;

-(NSDictionary *) getCellData;
-(NSDictionary *) getCellData:(NSArray *) fields;
-(BOOL) commonRequest:(NSString*) requestStr observer:(id) observer callback:(SEL) callback;
-(BOOL) commonRequest:(NSString*) requestStr output:(NSInvocation*)outputInvocation observer:(id) observer callback:(SEL) callback;


-(BOOL) commonRequestData:(NSString *)requestStr observer:(id)observer callback:(SEL)callback;
-(BOOL) commonRequest:(NSString*) requestStr ext:(NSDictionary *)ext observer:(id) observer callback:(SEL) callback;


-(NSError *)noDataOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input;
//将观察者从业务对象中删除。
-(BOOL)removeObserver:(id)observer;
//停止请求。派生类在需要的时候可以重载这个方法。
-(void)stopRequest;

//无参数
-(BOOL)sendRequest:(NSString*)address
          outputInvocation:(NSInvocation*)outputInvocation
                  observer:(id)observer
                    action:(SEL)action;


-(BOOL)sendRequest:(NSString*)address
   inputInvocation:(NSInvocation*)inputInvocation
  outputInvocation:(NSInvocation*)outputInvocation
		  observer:(id)observer
			action:(SEL)action
		 extraInfo:(NSDictionary*)extraInfo;


-(BOOL)sendRequest:(NSString*)address
              head:(NSDictionary*)head
            method:(NSString*)method
   inputInvocation:(NSInvocation*)inputInvocation
  outputInvocation:(NSInvocation*)outputInvocation
          observer:(id)observer
            action:(SEL)action
         extraInfo:(NSDictionary*)extraInfo;

-(BOOL)sendRequest:(NSString*)address
              head:(NSDictionary*)head
            method:(NSString*)method
            async :(BOOL)async
   inputInvocation:(NSInvocation*)inputInvocation
  outputInvocation:(NSInvocation*)outputInvocation
          observer:(id)observer
            action:(SEL)action
         extraInfo:(NSDictionary*)extraInfo;


-(BOOL)sendUploadRequest:(NSString*)address
                    data:(NSObject*)data
                fileName:(NSString*)fileName
        outputInvocation:(NSInvocation*)outputInvocation
                observer:(id)observer
                  action:(SEL)action
               extraInfo:(NSDictionary*)extraInfo;



-(BOOL)sendLocalRequest:(NSError*)error
               observer:(id)observer
                 action:(SEL)action
              extraInfo:(NSDictionary*)extraInfo;



//发送业务平台请求
-(BOOL)sendBusiRequest:(NSInvocation*)inputInvocation
  outputInvocation:(NSInvocation*)outputInvocation
		  observer:(id)observer
			action:(SEL)action
		 extraInfo:(NSDictionary*)extraInfo;


-(BOOL)sendBusiRequest:(NSInvocation*)inputInvocation
      outputInvocation:(NSInvocation*)outputInvocation
                 async:(BOOL)async
              observer:(id)observer
                action:(SEL)action
             extraInfo:(NSDictionary*)extraInfo;

//发送资源平台请求
-(BOOL)sendResourceRequest:(NSInvocation*)inputInvocation
          outputInvocation:(NSInvocation*)outputInvocation
       observer:(id)observer
         action:(SEL)action
      extraInfo:(NSDictionary*)extraInfo;


//生成JSON请求头
-(BSJSON*)genJSONRequestHeader:(NSString*) busiType;

//生成JSON响应头
-(BSJSON*)genJSONResponseHeader:(NSData*)recvData;

-(NSString*)genHTTPRequest:(NSString*)busiType params:(NSString*)params;
-(NSString *)genHTTPRequest:(NSString *)url busiType:(NSString *)busiType params:(NSString *)params;

//签名数据报文,返回jsonObj签名后的整体报文。
-(NSData*)signJSONData:(BSJSON*)jsonObj;

//无数据域报文组包
-(NSData*)getInputNodata:(NSString*) busiType;

+(NSString *)getVisitUrl:(NSString*)url;

+(NSString *)getVisitUrl:(NSString *)url host:(NSString *)hostUrl;

+(NSInteger) commandCount; //查看命令池是否有命令没有执行完毕

@end
