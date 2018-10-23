//
//  BSCommand.m
//  SCWCYClient
//
//  Created by apple on 14-5-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import "BSCommand.h"


@implementation BSNetworkCommand

-(void) execute
{
    [[BSCommandScheduler defaultCommandScheduler] addCommand:self.address
                                                        head:self.head
                                                      method:self.method
                                                       async:self.async
                                                      target:self.target
                                             inputInvocation:self.inputInvocation
                                            outputInvocation:self.outputInvocation
                                          progressInvocation:nil
                                          responseInvocation:nil
                                      notificationInvocation:nil                                                                        observer:self.observer
                                                      action:self.action
                                                   extraInfo:self.extraInfo];
}

@end


@implementation BSObserver
{
    __weak id _weakobserver;
    __strong id _proxyobserver;
}

-(id)observer
{
    if (_weakobserver != nil)
        return _weakobserver;
    else
        return _proxyobserver;
}

-(id)initWithObserver:(id)observer action:(SEL)action extraInfo:(NSDictionary*)extraInfo
{
    self = [self init];
    if (self != nil)
    {
        if ([observer isKindOfClass:[BSProxyObserver class]])
            _proxyobserver = observer;
        else
            _weakobserver = observer;

        _action = action;
        _extraInfo = extraInfo;
    }

    return self;
}

-(void)dealloc
{
    _proxyobserver = nil;
    _weakobserver = nil;
}


+(id)observerWith:(id)observer action:(SEL)action extraInfo:(NSDictionary*)extraInfo
{
    return [[BSObserver alloc] initWithObserver:observer action:action extraInfo:extraInfo];
}

@end


@interface BSNotification()
@end



@implementation BSNotification


-(id)initWithTarget:(id)target extraInfo:(NSDictionary*)extraInfo error:(NSError*)error
{
    self = [self init];
    if (self != nil)
    {
        _target = target;
        _extraInfo = extraInfo;
        _error = error;
    }

    return self;
}

-(BSNetworkCommand *)cmd
{
    return [self.extraInfo objectForKey:@"networkCommand"];
}

+(id)notificationWith:(id)target extraInfo:(NSDictionary*)extraInfo error:(NSError*)error
{
    return [[BSNotification alloc] initWithTarget:target extraInfo:extraInfo error:error];
}

-(void)dealloc
{

}

@end


@interface BSProxyObserver()

@property(nonatomic, copy) void(^action)(BSNotification* notify);

@end

@implementation BSProxyObserver

-(void)proxyActionImpl:(BSNotification *)noti
{
    if (self.action != nil)
    {
        self.action(noti);
        self.action = nil;
    }
}

//初始化一个块。
-(id)initWithAction:(void (^)(BSNotification*))action
{
    self = [self init];
    if (self != nil)
    {
        _proxyAction = @selector(proxyActionImpl:);
        self.action = action;
    }

    return self;
}


-(void)dealloc
{

}

@end



@interface BSCommandInner : NSObject {
@private
    BOOL _async;                         //是否异步。

    NSInvocation *_inputInvocation;   //输入的调用。要求函数返回NSData对象。或者返回nill
    NSInvocation *_outputInvocation;  //返回的处理。入参是NSData和_inputInvocation。返回NSError型
    NSInvocation *_progressInvocation;  //数据接收过程
    NSInvocation *_responseInvocation;  //响应头处理
    NSInvocation *_notificationInvocation; //通知统一处理。

    //界面观察部分
    NSMutableArray*  _observers;          //界面观察者数组。

    NSData  *_recvData;           //指定接受的数据
}

@property(nonatomic, readonly) NSString  *address;                 //命令地址
@property(nonatomic,readonly,retain) NSData *sendData;            //发送数据
@property(nonatomic, readonly,strong) id target;                     //命令的委托对象。
@property(nonatomic, readonly) NSInteger statusCode;      //状态代码


-(id)initWithCommand:(NSString*)address
             request:(NSURLRequest*)request
               async:(BOOL)async
              target:(id)target
            sendData:(NSData*)sendData
     inputInvocation:(NSInvocation*)inputInvocation
    outputInvocation:(NSInvocation*)outputInvocation
  progressInvocation:(NSInvocation*)progressInvocation
  responseInvocation:(NSInvocation*)responseInvocation
notificationInvocation:(NSInvocation*)notificationInvocation
            observer:(id)observer
              action:(SEL)action
           extraInfo:(NSDictionary*)extraInfo;


-(BOOL)addObserver:(id)observer action:(SEL)action extraInfo:(NSDictionary*)extraInfo;
-(BOOL)removeObserver:(id)observer;  //返回命令是否还有观察者，如果没有则应该停止命令
-(BOOL)removeAllObserver;

-(void)handleResponseHeader:(NSInteger)statusCode url:(NSURL*)url allHeader:(NSDictionary *)allHeader;
-(BOOL)handleResponse:(NSInteger)statusCode;

-(BOOL)isEqualCommand:(NSString*)aAddress target:(id)aTarget sendData:(NSData*)aSendData;

//提供给队列调用的函数。
-(void)appendRecvData:(NSData*)data;




@end

@implementation BSCommandInner


-(id)initWithCommand:(NSString*)address
             request:(NSURLRequest*)request
               async:(BOOL)async
              target:(id)target
            sendData:(NSData*)sendData
     inputInvocation:(NSInvocation*)inputInvocation
    outputInvocation:(NSInvocation*)outputInvocation
  progressInvocation:(NSInvocation*)progressInvocation
  responseInvocation:(NSInvocation*)responseInvocation
notificationInvocation:(NSInvocation*)notificationInvocation
            observer:(id)observer
              action:(SEL)action
           extraInfo:(NSDictionary*)extraInfo
{
    self = [super init];
    if (self != nil)
    {
        _address = address;
        _async = async;
        _target = target;
        _sendData = sendData;
        _inputInvocation = inputInvocation;
        _outputInvocation = outputInvocation;
        _progressInvocation = progressInvocation;
        _responseInvocation = responseInvocation;
        _notificationInvocation = notificationInvocation;
        [self addObserver:observer action:action extraInfo:extraInfo];
        _recvData = nil;
        _statusCode = 200;

        //如果是同步且request不为nil则进行同步处理。
        if (request != nil && !_async)
        {
            NSURLResponse *response = nil;
            NSError *error = nil;
            _recvData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            NSLog(@"命令应答:%@",[[NSString alloc]initWithData:_recvData encoding:NSUTF8StringEncoding] );
            NSLog(@"应答报文:%@",[[NSString alloc]initWithData:_recvData encoding:NSUTF8StringEncoding] );
            //判断如果不是http则
            if (error != nil && error.code != 0)
            {
                _statusCode = error.code;
            }

            if (response != nil && ([response.URL.scheme isEqualToString:@"http"] || [response.URL.scheme isEqualToString:@"https"]))
            {
                NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse*)response;
                _statusCode = httpresponse.statusCode;
                [self handleResponseHeader:_statusCode url:httpresponse.URL allHeader:httpresponse.allHeaderFields];
            }

        }


    }

    return self;


}

-(void)dealloc
{
    [_observers removeAllObjects];
}



-(BOOL)addObserver:(id)observer action:(SEL)action extraInfo:(NSDictionary*)extraInfo
{
    if (observer == nil)
        return YES;

    if (_observers == nil)
    {
        _observers = [[NSMutableArray alloc] initWithCapacity:1];
    }

    BOOL isExist = NO;
    for (BSObserver *ob in _observers)
    {
        if (ob.observer == observer && ob.action == action)
        {
            isExist = YES;
            break;
        }
    }

    if (!isExist)
    {
        [_observers addObject:[BSObserver observerWith:observer action:action extraInfo:extraInfo]];
    }

    return isExist;
}

-(BOOL)removeObserver:(id)observer
{
    if (_observers == nil)
        return NO;         //这里要返回NO,因为既然没有观察者则因为返回NO，否则会把那些没有观察者的调用给清除掉了。modify by oybq at 2014-9-14

    for (NSInteger i = [_observers count] - 1; i >=0; i--)
    {
        BSObserver *ob = [_observers objectAtIndex:i];
        if (ob.observer == observer)
        {
            [_observers removeObjectAtIndex:i];
        }
    }

    if ([_observers count] == 0)
    {
        _target = nil;
        _inputInvocation = nil;
        _outputInvocation = nil;
        _progressInvocation = nil;
        _responseInvocation = nil;
        _notificationInvocation = nil;
        _sendData = nil;
        _recvData = nil;
        return YES;
    }

    return NO;
}

-(BOOL)removeAllObserver
{
    if (_observers != nil)
    {
        [_observers removeAllObjects];
        _observers = nil;
    }

    _target = nil;
    _inputInvocation = nil;
    _outputInvocation = nil;
    _progressInvocation = nil;
    _responseInvocation = nil;
    _notificationInvocation = nil;
    _sendData = nil;
    _recvData = nil;
    return YES;
}

-(void)handleResponseHeader:(NSInteger)statusCode url:(NSURL*)url allHeader:(NSDictionary *)allHeader
{
    if (_responseInvocation != nil)
    {
        [_responseInvocation setArgument:&statusCode atIndex:2];
        [_responseInvocation setArgument:&url atIndex:3];
        [_responseInvocation setArgument:&allHeader atIndex:4];

        if (_responseInvocation.target != nil)
            [_responseInvocation invoke];
        else if (_target != nil)
        {
            [_responseInvocation invokeWithTarget:_target];
        }
    }

    _responseInvocation = nil;
}

-(BOOL)handleResponse:(NSInteger)statusCode
{

    @autoreleasepool {

        //尽早删除多余数据。
        _sendData = nil;

        NSError *error = nil;
        if (_target != nil && _outputInvocation != nil)
        {
            //如果状态不是大于等于200并且小于300则默认是错误的。不再进行数据解析，
            BOOL bOK = (statusCode >=200 && statusCode < 300)? YES:NO;
            if(_recvData.length < 60800)
            {
                NSLog(@"应答报文:%@",bOK ? [[NSString alloc]initWithData:_recvData encoding:NSUTF8StringEncoding] : [NSString stringWithFormat:@"%ld",statusCode] );
            }else
            {
                NSLog(@"应答报文数据量很大，可能是图片就不打印了");
            }
            [_outputInvocation setArgument:&_recvData atIndex:2];   //返回的原始数据
            [_outputInvocation setArgument:(void*)&bOK atIndex:3];  //返回是否成功。
            [_outputInvocation setArgument:&_inputInvocation atIndex:4];  //原始输入参数部分

            if (_outputInvocation.target == nil)
                [_outputInvocation invokeWithTarget:_target];
            else
                [_outputInvocation invoke];

            __unsafe_unretained NSError *err =  nil;
            [_outputInvocation getReturnValue:(void*)&err];    //返回处理错误代码。
            error = err ;
            if (error.code != 0)
            {
                NSLog(@"%@",error.domain);
            }
        }

        //尽快删除多余内存数据。
        _recvData = nil;
        _inputInvocation = nil;
        _outputInvocation = nil;

        //通知所有界面对象。
        for (BSObserver *ob in _observers)
        {
            id realTarget = _target;
            //判断ob.extraInfo是否为nil。如果不为nil.则取特定的key,和action。并执行
            //特定的方法。并将target设定为key中的observer.
            if (ob.extraInfo != nil)
            {
                id buObserver = [ob.extraInfo objectForKey:@"buobserver"];
                NSString *bustrAction = [ob.extraInfo objectForKey:@"buaction"];
                if (buObserver != nil && bustrAction != nil)
                {
                    SEL buAction =  sel_registerName([bustrAction UTF8String]);

                    _Pragma("clang diagnostic push")
                    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
                    [buObserver performSelector:buAction withObject:[BSNotification notificationWith:_target
                                                                                           extraInfo:nil
                                                                                               error:error]];


                    realTarget = buObserver;
                }
            }

            if (ob.observer != nil && ob.action != nil)
            {
                //如果是异步的则直接调用，否则发送到主线陈，造成异步调用效果

                [ob.observer performSelectorOnMainThread:ob.action
                                              withObject:[BSNotification notificationWith:realTarget
                                                                                extraInfo:ob.extraInfo
                                                                                    error:error] waitUntilDone:NO];
            }
        }

        //执行全局通知。。。
        if (_notificationInvocation != nil)
        {
            [_notificationInvocation setArgument:&error atIndex:2];

            if (_notificationInvocation.target != nil)
                [_notificationInvocation invoke];
            else if (_target != nil)
            {
                [_notificationInvocation invokeWithTarget:_target];
            }
        }

        _notificationInvocation = nil;

        [_observers removeAllObjects];
        _observers = nil;

    }

    return YES;
}



-(BOOL)isEqualCommand:(NSString*)aAddress target:(id)aTarget sendData:(NSData*)aSendData
{
    if (aSendData == nil)
    {
        return [self.address isEqualToString:aAddress] &&
        (self.target == aTarget);
    }
    else
    {
        return [self.address isEqualToString:aAddress] &&
        (self.target == aTarget) &&
        [self.sendData isEqualToData:aSendData];
    }

}


-(void)appendRecvData:(NSData*)data
{
    if (_recvData == nil)
    {
        _recvData = [[NSMutableData alloc] initWithCapacity:512];
    }

    if (_recvData != nil)
    {
        NSMutableData *p = (NSMutableData*)_recvData;

        //这里不考虑进度数据获取。。
        [p appendData:data];
    }
}



@end




//建立一个非异步命令.如果是非异步命令则只记录信息什么也不做。
@interface BSSyncCommand : NSObject<BSCommand>
{
@private

    BSCommandInner *_cmdInner;
}

@property (nonatomic) BOOL isDownloadCmd;

-(id)initWithCommand:(NSString*)address
             request:(NSURLRequest*)request
              target:(id)target
            sendData:(NSData*)sendData
     inputInvocation:(NSInvocation*)inputInvocation
    outputInvocation:(NSInvocation*)outputInvocation
  progressInvocation:(NSInvocation*)progressInvocation
  responseInvocation:(NSInvocation*)responseInvocation
notificationInvocation:(NSInvocation*)notificationInvocation
            observer:(id)observer
              action:(SEL)action
           extraInfo:(NSDictionary*)extraInfo
            delegate:(id)delegate;

@end


@implementation BSSyncCommand


//启动命令
-(void)start
{

}

-(BOOL)started
{
    return YES;
}

//终止命令
-(void)cancel
{

}

//异步标志
-(BOOL)async
{
    return NO;
}

-(BOOL) isDownloadcmd
{
    return self.isDownloadCmd;
}

//停止计时器
-(void)stopTimer
{

}

//添加接收的数据。
-(void)appendRecvData:(NSData*)data
{
    return [_cmdInner appendRecvData:data];
}


-(BOOL)removeObserver:(id)observer
{
    return [_cmdInner removeObserver:observer];
}

-(BOOL)removeAllObserver
{
    return [_cmdInner removeAllObserver];
}

-(id)target
{
    return _cmdInner.target;
}

-(NSInteger)statusCode
{
    return _cmdInner.statusCode;
}

-(void)handleResponseHeader:(NSInteger)statusCode url:(NSURL*)url allHeader:(NSDictionary *)allHeader
{
    [_cmdInner handleResponseHeader:statusCode url:url allHeader:allHeader];
}

-(BOOL)handleResponse:(NSInteger)statusCode
{
    return [_cmdInner handleResponse:statusCode];
}

-(BOOL)isEqualCommand:(NSString*)aAddress target:(id)aTarget sendData:(NSData*)aSendData
{
    return [_cmdInner isEqualCommand:aAddress target:aTarget sendData:aSendData];
}

-(BOOL)addObserver:(id)observer action:(SEL)action extraInfo:(NSDictionary*)extraInfo
{
    return [_cmdInner addObserver:observer action:action extraInfo:extraInfo];
}



-(id)initWithCommand:(NSString*)address
             request:(NSURLRequest*)request
              target:(id)target
            sendData:(NSData*)sendData
     inputInvocation:(NSInvocation*)inputInvocation
    outputInvocation:(NSInvocation*)outputInvocation
  progressInvocation:(NSInvocation*)progressInvocation
  responseInvocation:(NSInvocation*)responseInvocation
notificationInvocation:(NSInvocation*)notificationInvocation
            observer:(id)observer
              action:(SEL)action
           extraInfo:(NSDictionary*)extraInfo
            delegate:(id)delegate
{
    self = [super init];
    if (self != nil)
    {
        _cmdInner = [[BSCommandInner alloc] initWithCommand:address
                                                    request:request
                                                      async:NO
                                                     target:target
                                                   sendData:sendData
                                            inputInvocation:inputInvocation
                                           outputInvocation:outputInvocation
                                         progressInvocation:progressInvocation
                                         responseInvocation:responseInvocation
                                     notificationInvocation:notificationInvocation
                                                   observer:observer
                                                     action:action
                                                  extraInfo:extraInfo];



    }

    return self;

}





@end



#pragma mark ---
#pragma mark BSAsyncCommand implementation


@interface BSAsyncCommand : NSObject<BSCommand>
{
@private
    BOOL _started;
    NSTimer *_timeoutCtrl;
    BOOL _useTimeoutCtrl;  //是否使用超时控制。只有在请求为POST且有body时才使用超时控制，否则不使用超时控制。默认是不使用的。
    __weak id _delegate;
    BSCommandInner *_cmdInner;
}
@property(nonatomic)NSInteger dataTotal;
@property (nonatomic) BOOL isDownloadCmd;
@property (nonatomic,strong)NSURLRequest * currentRequest;
@property (nonatomic,strong)NSURLSessionDataTask *task;
@property (nonatomic,strong)NSURLSession *session;
@end


@implementation BSAsyncCommand


-(void)handleTimeout:(NSTimer*)tm
{
    NSLog(@"命令超时:%@",self.currentRequest.URL.absoluteString);
    //这里发送超时处理。
    [self cancel];

    if (_delegate != nil && [_delegate respondsToSelector:@selector(connection:didFailWithError:)])
    {
        [_delegate connection:self didFailWithError:[NSError errorWithDomain:@"Request Timeout" code:408 userInfo:nil]];
    }
}



//启动命令
-(void)start
{
    //如果是同步则什么也不做。
    // [super start];
    self.task = [self.session dataTaskWithRequest:self.currentRequest];
    // 3.执行任务
    [self.task resume];
    _started = YES;

    //如果是异步且有发送数据时这里启动定时器。
    [self stopTimer];
    if (_useTimeoutCtrl)
    {
        NSString *contentType = self.currentRequest.allHTTPHeaderFields[@"Content-Type"];
        NSInteger timeout = [contentType hasPrefix:@"multipart"] ? 300 :60;
        _timeoutCtrl = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(handleTimeout:) userInfo:nil repeats:NO];
    }

}

-(BOOL)started
{
    return _started;
}

//终止命令
-(void)cancel
{
    [self stopTimer];
    //[super cancel];
    [self.task suspend];
}

//异步标志
-(BOOL)async
{
    return YES;
}

-(BOOL) isDownloadcmd
{
    return self.isDownloadCmd;
}

//停止计时器
-(void)stopTimer
{
    if (_timeoutCtrl != nil)
    {
        [_timeoutCtrl invalidate];
        _timeoutCtrl = nil;
    }
}

//添加接收的数据。
-(void)appendRecvData:(NSData*)data
{
    [_cmdInner appendRecvData:data];
}


-(BOOL)removeObserver:(id)observer
{
    BOOL bOk = [_cmdInner removeObserver:observer];
    if (bOk)
        [self cancel];
    return bOk;
}

-(BOOL)removeAllObserver
{
    BOOL bOk = [_cmdInner removeAllObserver];
    [self cancel];
    return bOk;
}

-(id)target
{
    return _cmdInner.target;
}

-(NSInteger)statusCode
{
    return _cmdInner.statusCode;
}

-(void)handleResponseHeader:(NSInteger)statusCode url:(NSURL*)url allHeader:(NSDictionary *)allHeader
{
    [_cmdInner handleResponseHeader:statusCode url:(NSURL*)url allHeader:allHeader];
}

-(BOOL)handleResponse:(NSInteger)statusCode
{
    return [_cmdInner handleResponse:statusCode];
}

-(BOOL)isEqualCommand:(NSString*)aAddress target:(id)aTarget sendData:(NSData*)aSendData
{
    return [_cmdInner isEqualCommand:aAddress target:aTarget sendData:aSendData];
}

-(BOOL)addObserver:(id)observer action:(SEL)action extraInfo:(NSDictionary*)extraInfo
{
    return [_cmdInner addObserver:observer action:action extraInfo:extraInfo];
}



-(id)initWithCommand:(NSString*)address
             request:(NSURLRequest*)request
              target:(id)target
            sendData:(NSData*)sendData
     inputInvocation:(NSInvocation*)inputInvocation
    outputInvocation:(NSInvocation*)outputInvocation
  progressInvocation:(NSInvocation*)progressInvocation
  responseInvocation:(NSInvocation*)responseInvocation
notificationInvocation:(NSInvocation*)notificationInvocation
            observer:(id)observer
              action:(SEL)action
           extraInfo:(NSDictionary*)extraInfo
            delegate:(id)delegate
{
    self = [super init];
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                 delegate:self
                                            delegateQueue:nil];
    self.currentRequest = request;
    if (self != nil)
    {
        _delegate = delegate;
        _started = NO;

        //是否使用超时控制。只有在请求为POST且有body时才使用超时控制，否则不使用超时控制。默认是不使用的。
        _useTimeoutCtrl = ([request.HTTPMethod isEqualToString:@"POST"] && (request.HTTPBody != nil || request.HTTPBodyStream != nil));
        _timeoutCtrl = nil;
        _cmdInner = [[BSCommandInner alloc] initWithCommand:address
                                                    request:request
                                                      async:YES
                                                     target:target
                                                   sendData:sendData
                                            inputInvocation:inputInvocation
                                           outputInvocation:outputInvocation
                                         progressInvocation:progressInvocation
                                         responseInvocation:responseInvocation
                                     notificationInvocation:notificationInvocation
                                                   observer:observer
                                                     action:action
                                                  extraInfo:extraInfo];
    }

    return self;
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    //【注意：此处需要允许处理服务器的响应，才会继续加载服务器的数据。 若在接收响应时需要对返回的参数进行处理(如获取响应头信息等),那么这些处理应该放在这个允许操作的前面。】
    NSLog(@"命令应答:%@",response.URL.absoluteString);
    [self stopTimer];
    if ([response.URL.scheme isEqualToString:@"http"] || [response.URL.scheme isEqualToString:@"https"])
    {
        NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse*)response;

        [(id<BSCommand>)self handleResponseHeader:httpresponse.statusCode url:httpresponse.URL allHeader:httpresponse.allHeaderFields];
        NSHTTPURLResponse *httpResponse = ( NSHTTPURLResponse *)response;

        if (httpResponse && [httpResponse respondsToSelector : @selector (allHeaderFields)]){

            NSDictionary *httpResponseHeaderFields = [httpResponse allHeaderFields ];



            double total_ = [[httpResponseHeaderFields objectForKey : @"Content-Length" ] longLongValue ];


            ((BSAsyncCommand*)self).dataTotal = total_;
            NSLog ( @"请求总进度：%f" , total_);

        }
        if (httpresponse.statusCode < 200 || httpresponse.statusCode >= 300)
        {
            //[command cancel];  //停止网络返回。
            [[BSCommandScheduler defaultCommandScheduler] handleResponse:(id<BSCommand>)self statusCode:httpresponse.statusCode];
        }
    }

    completionHandler(NSURLSessionResponseAllow);
}
// 2.接收到服务器的数据（此方法在接收数据过程会多次调用）
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    // 处理每次接收的数据，例如每次拼接到自己创建的数据receiveData
    // [self.receiveData appendData:data];
    [(id<BSCommand>)self appendRecvData:data];
}
// 3.3.任务完成时调用（如果成功，error == nil）
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if(error == nil){
        /*
         请求完成,成功或者失败的处理
         */
        [[BSCommandScheduler defaultCommandScheduler] handleResponse:self statusCode:200];
    }
    else{
        NSLog(@"请求失败:%@",error);
        if (((NSHTTPURLResponse*)task.response).statusCode < 200 || ((NSHTTPURLResponse*)task.response).statusCode >= 300)
        {
            [self cancel];  //停止网络返回。
            [[BSCommandScheduler defaultCommandScheduler] handleResponse:self statusCode:((NSHTTPURLResponse*)task.response).statusCode];
        }
    }
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSLog(@"证书认证");
    NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
    return [[challenge sender] useCredential: credential
                  forAuthenticationChallenge: challenge];
    //    if ([[[challenge protectionSpace] authenticationMethod] isEqualToString: NSURLAuthenticationMethodServerTrust]) {
    //        do
    //        {
    //            SecTrustRef serverTrust = [[challenge protectionSpace] serverTrust];
    //            NSCAssert(serverTrust != nil, @"serverTrust is nil");
    //            if(nil == serverTrust)
    //            break; /* failed */
    //            /**
    //             *  导入多张CA证书（Certification Authority，支持SSL证书以及自签名的CA），请替换掉你的证书名称
    //             */
    //            NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ca" ofType:@"cer"];//自签名证书
    //            NSData* caCert = [NSData dataWithContentsOfFile:cerPath];
    //
    //            NSCAssert(caCert != nil, @"caCert is nil");
    //            if(nil == caCert)
    //            break; /* failed */
    //
    //            SecCertificateRef caRef = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)caCert);
    //            NSCAssert(caRef != nil, @"caRef is nil");
    //            if(nil == caRef)
    //            break; /* failed */
    //
    //            //可以添加多张证书
    //            NSArray *caArray = @[(__bridge id)(caRef)];
    //
    //            NSCAssert(caArray != nil, @"caArray is nil");
    //            if(nil == caArray)
    //            break; /* failed */
    //
    //            //将读取的证书设置为服务端帧数的根证书
    //            OSStatus status = SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)caArray);
    //            NSCAssert(errSecSuccess == status, @"SecTrustSetAnchorCertificates failed");
    //            if(!(errSecSuccess == status))
    //            break; /* failed */
    //
    //            SecTrustResultType result = -1;
    //            //通过本地导入的证书来验证服务器的证书是否可信
    //            status = SecTrustEvaluate(serverTrust, &result);
    //            if(!(errSecSuccess == status))
    //            break; /* failed */
    //            NSLog(@"stutas:%d",(int)status);
    //            NSLog(@"Result: %d", result);
    //
    //            BOOL allowConnect = (result == kSecTrustResultUnspecified) || (result == kSecTrustResultProceed);
    //            if (allowConnect) {
    //                NSLog(@"success");
    //            }else {
    //                NSLog(@"error");
    //            }
    //
    //            /* kSecTrustResultUnspecified and kSecTrustResultProceed are success */
    //            if(! allowConnect)
    //            {
    //                break; /* failed */
    //            }
    //
    //#if 0
    //            /* Treat kSecTrustResultConfirm and kSecTrustResultRecoverableTrustFailure as success */
    //            /*   since the user will likely tap-through to see the dancing bunnies */
    //            if(result == kSecTrustResultDeny || result == kSecTrustResultFatalTrustFailure || result == kSecTrustResultOtherError)
    //            break; /* failed to trust cert (good in this case) */
    //#endif
    //
    //            // The only good exit point
    //            NSLog(@"信任该证书");
    //
    //            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
    //            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
    //            return [[challenge sender] useCredential: credential
    //                          forAuthenticationChallenge: challenge];
    //
    //        }
    //        while(0);
    //    }
    //
    //    // Bad dog
    //    NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
    //    completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge,credential);
    //    return [[challenge sender] cancelAuthenticationChallenge: challenge];
}

-(void)dealloc
{
    if (_timeoutCtrl != nil)
    {
        [_timeoutCtrl invalidate];
    }

    _delegate = nil;
}




@end


@implementation BSCommandScheduler
{

    NSMutableArray *_commands;
}

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        _maxCount = 8;
        _commands = [[NSMutableArray alloc] initWithCapacity:_maxCount];
    }

    return self;
}


+(BSCommandScheduler*)defaultCommandScheduler
{
    static BSCommandScheduler *cmdScheduler = nil;

    static dispatch_once_t done;
    dispatch_once(&done, ^{

        cmdScheduler = [[BSCommandScheduler alloc] init];
    });

    return cmdScheduler;
}

//启动命令。并且返回已经启动了的命令数量
-(NSInteger)startCommands
{
    NSInteger startedCount = 0;
    for (id<BSCommand> cmd in _commands)
    {
        if (cmd.started)
            startedCount++;
    }

    if (startedCount < _maxCount)
    {
        //先把前面的启动了。
        for (id<BSCommand> cmd in _commands)
        {
            if (!cmd.started)
            {
                [cmd start];
                startedCount++;
            }

            if (startedCount >= _maxCount)
            {
                break;
            }
        }

    }

    return startedCount;

}


+(id)commandWithCommand:(NSString*)address
                   head:(NSDictionary*)head
                 method:(NSString*)method
                  async:(BOOL)async              //指定是否异步，如果地址为nil则一定是同步，如果地址不为nil则根据async来指定同步还是异步。
                 target:(id)target
               sendData:(NSData*)sendData
        inputInvocation:(NSInvocation*)inputInvocation
       outputInvocation:(NSInvocation*)outputInvocation
     progressInvocation:(NSInvocation*)progressInvocation
     responseInvocation:(NSInvocation*)responseInvocation
 notificationInvocation:(NSInvocation*)notificationInvocation
               observer:(id)observer
                 action:(SEL)action
              extraInfo:(NSDictionary*)extraInfo
               delegate:(id)delegate
{

    NSLog(@"命令请求=%@",address);
    if (inputInvocation) {

        //        [inputInvocation invoke];
        //        __unsafe_unretained NSData *sendDataTemp = nil;
        //        [inputInvocation getReturnValue:(void*)&sendDataTemp];
        NSString *dataStr = [[NSString alloc] initWithData:sendData encoding:NSUTF8StringEncoding];
        NSLog(@"body命令请求参数%@",dataStr);
    }
    //建立request对象。
    NSMutableURLRequest *pRequest = nil;
    if (address != nil)
    {
        NSURL *pURL = [[NSURL alloc] initWithString:address];
        if (pURL == NULL) {
            NSLog(@"非法url=%@",address);
        }
        pRequest = [NSMutableURLRequest requestWithURL:pURL];
        if (pRequest != nil)
        {
            //设置命令的方法
            [pRequest setTimeoutInterval:30];
            [pRequest setHTTPMethod:method];

            if (head != nil)
            {
                //添加自定义头。
                for (NSString *key in [head allKeys])
                {
                    [pRequest setValue:[head objectForKey:key] forHTTPHeaderField:key];
                }
            }

            if (sendData != nil)
                [pRequest setHTTPBody:sendData];
        }
    }

    //指定是否异步，如果地址为nil则一定是同步，如果地址不为nil则根据async来指定同步还是异步。
    if (pRequest == nil)
        async = NO;

    if (async)
    {
        return [[BSAsyncCommand alloc] initWithCommand:address
                                               request:pRequest
                                                target:target
                                              sendData:sendData
                                       inputInvocation:inputInvocation
                                      outputInvocation:outputInvocation
                                    progressInvocation:progressInvocation
                                    responseInvocation:responseInvocation
                                notificationInvocation:notificationInvocation
                                              observer:observer
                                                action:action
                                             extraInfo:extraInfo
                                              delegate:delegate];

    }
    else
    {
        return [[BSSyncCommand alloc] initWithCommand:address
                                              request:pRequest
                                               target:target
                                             sendData:sendData
                                      inputInvocation:inputInvocation
                                     outputInvocation:outputInvocation
                                   progressInvocation:progressInvocation
                                   responseInvocation:responseInvocation
                               notificationInvocation:notificationInvocation
                                             observer:observer
                                               action:action
                                            extraInfo:extraInfo
                                             delegate:delegate];
    }

}

-(BOOL)removeCommand:(id<BSCommand>)command
{
    //删除指定的命令
    [command removeAllObserver];
    @synchronized(_commands) {
        for (NSInteger i = 0; i < [_commands count]; i++)
        {
            id<BSCommand> cmd = [_commands objectAtIndex:i];
            if (cmd == command)
            {
                [_commands removeObjectAtIndex:i];
                break;
            }
        }

        //继续启动命令
        [self startCommands];
    }
    return YES;
}


-(BOOL)handleResponse:(id<BSCommand>)command statusCode:(NSInteger)statusCode
{
    BOOL bOK = [command handleResponse:statusCode];

    //停止命令。并且从命令队列中删除掉。清除调用所有
    [self removeCommand:command];
    return bOK;
}



-(id<BSCommand>)addCommand:(NSString*)address
                      head:(NSDictionary*)head
                    method:(NSString*)method
                     async:(BOOL)async
                    target:(id)target
           inputInvocation:(NSInvocation*)inputInvocation
          outputInvocation:(NSInvocation*)outputInvocation
        progressInvocation:(NSInvocation*)progressInvocation
        responseInvocation:(NSInvocation*)responseInvocation
    notificationInvocation:(NSInvocation*)notificationInvocation
                  observer:(id)observer
                    action:(SEL)action
                 extraInfo:(NSDictionary*)extraInfo
{

    NSMutableDictionary *myExtraInfo = [[NSMutableDictionary alloc] initWithDictionary:extraInfo];
    BSNetworkCommand *cmd = [[BSNetworkCommand alloc] init];
    cmd.target = target;
    cmd.address = address;
    cmd.method = method;
    cmd.head = head;
    cmd.async = async;
    cmd.inputInvocation = inputInvocation;
    cmd.outputInvocation = outputInvocation;
    cmd.observer = observer;
    cmd.action = action;
    cmd.extraInfo = extraInfo;
    [myExtraInfo setObject:cmd forKey:@"networkCommand"];
    extraInfo = myExtraInfo;

    //这里只是调试时使用
#if DEBUG == 1

    BOOL bsync = [[NSUserDefaults  standardUserDefaults] boolForKey:@"use_syncNetwork"];
    if (bsync)
        async = NO;

    //use_syncNetwork

#endif


    //得到输入的返回数据。
    NSData *sendData = nil;
    if (target != nil && inputInvocation != nil)
    {
        //可以通过这个来控制一些内部结构的生成
        if (inputInvocation.target == nil)
            [inputInvocation invokeWithTarget:target];
        else
            [inputInvocation invoke];

        __unsafe_unretained NSData *sendDataTemp = nil;
        [inputInvocation getReturnValue:(void*)&sendDataTemp];
        sendData = sendDataTemp;
    }

    //如果有地址并且是异步才进行多观察者判断。
    if (address != nil && async)
    {
        for (id<BSCommand> cmd in _commands)
        {
            if ([cmd isEqualCommand:address target:target sendData:sendData])
            {
                [cmd addObserver:observer action:action extraInfo:extraInfo];

                return cmd;
            }
        }
    }

    id<BSCommand> newCmd = [BSCommandScheduler commandWithCommand:address
                                                             head:head
                                                           method:method
                                                            async:async
                                                           target:target
                                                         sendData:sendData
                                                  inputInvocation:inputInvocation
                                                 outputInvocation:outputInvocation
                                               progressInvocation:progressInvocation
                                               responseInvocation:responseInvocation
                                           notificationInvocation:notificationInvocation
                                                         observer:observer
                                                           action:action
                                                        extraInfo:extraInfo
                                                         delegate:self];
    if ([address hasSuffix:@".png"] || [address hasSuffix:@".jpg"] || [address hasSuffix:@".jpeg"]) {
        id cmd = newCmd;
        [cmd setValue:@(YES) forKey:@"isDownloadCmd"];
    }


    if (newCmd.async)
    {
        //获取已经启动的数量。如果超过则直接加入命令但不启动，如果没有超过则启动并加入队列。
        if ([self startCommands] < _maxCount)
            [newCmd start];

        [_commands addObject:newCmd];
    }
    else
    {
        [self handleResponse:newCmd statusCode:newCmd.statusCode];
    }

    return newCmd;
}

//添加下载命令
-(BOOL)addDownloadCommand:(NSString*)address
                    range:(NSRange)range
                 filePath:(NSString*)filePath
                 observer:(id)observer    //通知界面。
                   action:(SEL)action     //每一个进度都会给予提示，以及下载完成也会给予提示。
                extraInfo:(NSDictionary*)extraInfo
{
    return NO;
}


//内部构件一个inputInvocation
-(NSData*)addUploadInputInvocation:(NSObject*)data fileName:(NSString*)fileName extraInfo:(NSDictionary*)extraInfo
{
    //拼装上载数据。
    NSData  *uploadData = nil;
    if ([data isKindOfClass:[UIImage class]])
    {
        uploadData = UIImageJPEGRepresentation(((UIImage*)data),0);
    }
    else if ([data isKindOfClass:[NSString class]])
    {
        //文件路径
        uploadData = [NSData dataWithContentsOfFile:(NSString*)data];
    }
    else if ([data isKindOfClass:[NSData class]])
    {
        uploadData = (NSData*)data;
    }

    if (uploadData == nil)
        return nil;


    NSMutableData *sendData = [[NSMutableData alloc] init];
    NSArray *files = [fileName componentsSeparatedByString:@"="];


    [sendData appendData: [[NSString stringWithFormat:@"----71c34e2f20216\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"", files.count ==2 ? files[0] : @"file"] dataUsingEncoding:NSUTF8StringEncoding] ];

    [sendData appendBytes: files.count == 2 ? [files[1] UTF8String] : [files[0] UTF8String] length:strlen([files.count == 2 ? files[1] : files[0] UTF8String])];
    [sendData appendBytes:"\"\r\nContent-Type: application/octet-stream\r\n\r\n" length:45];
    [sendData appendData:uploadData];
    [sendData appendBytes:"\r\n" length:2];

    NSMutableArray *uploadNames = [[NSMutableArray alloc] initWithArray:extraInfo.allKeys];
    [uploadNames sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult sortResult;
        NSString* v1 = obj1;
        NSString* v2 = obj2;
        sortResult =  [v1 compare:v2];
        return sortResult;
    }];
    //@{@"file=xxxx.png":imageData}
    if (extraInfo != NULL) {
        for (int i =0; i < uploadNames.count; i++) {
            NSString *key = [uploadNames objectAtIndex:i];
            if ([[extraInfo objectForKey:key] isKindOfClass:[NSData class]]) {
                NSArray *files = [key componentsSeparatedByString:@"="];
                NSString *str1 = [NSString stringWithFormat:@"----71c34e2f20216\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@\"",files.count ==2 ? files[0] : @"file",files.count == 2 ? files[1] : files[0] ];
                [sendData appendData:[str1 dataUsingEncoding:NSUTF8StringEncoding]];
                [sendData appendData:[@"\r\nContent-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [sendData appendData: [extraInfo objectForKey:key] ];
                [sendData appendBytes:"\r\n" length:2];
            }
            else {
                NSString *str1 = [NSString stringWithFormat:@"----71c34e2f20216\r\nContent-Disposition: form-data; name=\"%@\"",key ];
                [sendData appendData:[str1 dataUsingEncoding:NSUTF8StringEncoding]];
                [sendData appendData:[@"\r\nContent-Type: text/plain; charset=UTF-8\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                [sendData appendData: [[extraInfo objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding]];
                [sendData appendBytes:"\r\n" length:2];
            }

        }
    }

    [sendData appendBytes:"----71c34e2f20216--" length:19];


    return sendData;
}


//添加上载命令。//@{@"file=xxxx.png":imageData}
-(BOOL)addUploadCommand:(NSString*)address
                   data:(NSObject*)data
               fileName:(NSString*)fileName
                 target:(id)target
       outputInvocation:(NSInvocation*)outputInvocation
               observer:(id)observer    //通知界面。
                 action:(SEL)action     //每一个进度都会给予提示，以及下载完成也会给予提示。
              extraInfo:(NSDictionary*)extraInfo
{
    return  [self addUploadCommand:address data:data fileName:fileName target:target outputInvocation:outputInvocation progressInvocation:nil observer:observer action:action extraInfo:extraInfo];
}

-(BOOL)addUploadCommand:(NSString*)address
                   data:(NSObject*)data
               fileName:(NSString*)fileName
                 target:(id)target
       outputInvocation:(NSInvocation*)outputInvocation
     progressInvocation:(NSInvocation*)progressInvocation
               observer:(id)observer    //通知界面。
                 action:(SEL)action     //每一个进度都会给予提示，以及下载完成也会给予提示。
              extraInfo:(NSDictionary*)extraInfo
{
    NSMethodSignature *sig = [self methodSignatureForSelector:@selector(addUploadInputInvocation:fileName:extraInfo:)];
    NSInvocation *inputInvocation = [NSInvocation invocationWithMethodSignature:sig];
    [inputInvocation setSelector:@selector(addUploadInputInvocation:fileName:extraInfo:)];

    [inputInvocation setArgument:&data atIndex:2];
    [inputInvocation setArgument:&fileName atIndex:3];
    [inputInvocation setArgument:&extraInfo atIndex:4];
    [inputInvocation retainArguments];
    inputInvocation.target = self;

    return [self addCommand:address
                       head:@{@"Content-Type":@"multipart/form-data; boundary=--71c34e2f20216"}
                     method:@"POST"
                      async:YES
                     target:target
            inputInvocation:inputInvocation
           outputInvocation:outputInvocation
         progressInvocation:progressInvocation
         responseInvocation:nil
     notificationInvocation:nil
                   observer:observer
                     action:action
                  extraInfo:NULL];
}





-(BOOL)removeTarget:(id)target
{
    if (_commands == nil)
        return NO;

    for (NSInteger i = [_commands count] - 1; i >= 0; i--)
    {
        id<BSCommand> cmd = [_commands objectAtIndex:i];
        if (cmd.target == target)
        {
            [cmd removeAllObserver];
            [_commands removeObjectAtIndex:i];
        }
    }

    //继续启动命令
    [self startCommands];

    return YES;

}

-(BOOL)removeObserver:(id)observer  //删除界面观察者。如果一个命令没有观察者则应该停止该命令。
{
    if (_commands == nil)
        return NO;

    for (NSInteger i = [_commands count] - 1; i >= 0; i--)
    {
        id<BSCommand> cmd = [_commands objectAtIndex:i];
        if ([cmd removeObserver:observer])  //如果没有了观察者。内部会停止命令
        {
            [_commands removeObjectAtIndex:i];
        }
    }

    //继续启动命令
    [self startCommands];

    return YES;
}

-(NSInteger) commandCount
{
    return _commands.count;
}

-(NSInteger) commandButDownload
{
    __block NSInteger counter =0;
    [_commands enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isDownloadcmd]) {
            counter++;
        }
    }];
    return counter;
}

#pragma mark -- connect
- (void)connection:(id<BSCommand>)command didFailWithError:(NSError *)error
{
    //如果错误则应该停止解析
    [command cancel];
    [self handleResponse:command statusCode:error.code];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {

    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {


    //直接验证服务器是否被认证（serverTrust），这种方式直接忽略证书验证，直接建立连接，但不能过滤其它URL连接，可以理解为一种折衷的处理方式，实际上并不安全，因此不推荐。
    SecTrustRef serverTrust = [[challenge protectionSpace] serverTrust];
    return [[challenge sender] useCredential: [NSURLCredential credentialForTrust: serverTrust]
                  forAuthenticationChallenge: challenge];

    //    if ([[[challenge protectionSpace] authenticationMethod] isEqualToString: NSURLAuthenticationMethodServerTrust]) {
    //        do
    //        {
    //            SecTrustRef serverTrust = [[challenge protectionSpace] serverTrust];
    //            NSCAssert(serverTrust != nil, @"serverTrust is nil");
    //            if(nil == serverTrust)
    //            break; /* failed */
    //            /**
    //             *  导入多张CA证书（Certification Authority，支持SSL证书以及自签名的CA）
    //             */
    //            NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"cloudwin" ofType:@"cer"];//自签名证书
    //            NSData* caCert = [NSData dataWithContentsOfFile:cerPath];
    //
    //            NSString *cerPath2 = [[NSBundle mainBundle] pathForResource:@"apple" ofType:@"cer"];//SSL证书
    //            NSData * caCert2 = [NSData dataWithContentsOfFile:cerPath2];
    //
    //            NSCAssert(caCert != nil, @"caCert is nil");
    //            if(nil == caCert)
    //            break; /* failed */
    //
    //            NSCAssert(caCert2 != nil, @"caCert2 is nil");
    //            if (nil == caCert2) {
    //                break;
    //            }
    //
    //            SecCertificateRef caRef = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)caCert);
    //            NSCAssert(caRef != nil, @"caRef is nil");
    //            if(nil == caRef)
    //            break; /* failed */
    //
    //            SecCertificateRef caRef2 = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)caCert2);
    //            NSCAssert(caRef2 != nil, @"caRef2 is nil");
    //            if(nil == caRef2)
    //            break; /* failed */
    //
    //            NSArray *caArray = @[(__bridge id)(caRef),(__bridge id)(caRef2)];
    //
    //            NSCAssert(caArray != nil, @"caArray is nil");
    //            if(nil == caArray)
    //            break; /* failed */
    //
    //            OSStatus status = SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)caArray);
    //            NSCAssert(errSecSuccess == status, @"SecTrustSetAnchorCertificates failed");
    //            if(!(errSecSuccess == status))
    //            break; /* failed */
    //
    //            SecTrustResultType result = -1;
    //            status = SecTrustEvaluate(serverTrust, &result);
    //            if(!(errSecSuccess == status))
    //            break; /* failed */
    //            NSLog(@"stutas:%d",(int)status);
    //            NSLog(@"Result: %d", result);
    //
    //            BOOL allowConnect = (result == kSecTrustResultUnspecified) || (result == kSecTrustResultProceed);
    //            if (allowConnect) {
    //                NSLog(@"success");
    //            }else {
    //                NSLog(@"error");
    //            }
    //            /* https://developer.apple.com/library/ios/technotes/tn2232/_index.html */
    //            /* https://developer.apple.com/library/mac/qa/qa1360/_index.html */
    //            /* kSecTrustResultUnspecified and kSecTrustResultProceed are success */
    //            if(! allowConnect)
    //            {
    //                break; /* failed */
    //            }
    //
    //#if 0
    //            /* Treat kSecTrustResultConfirm and kSecTrustResultRecoverableTrustFailure as success */
    //            /*   since the user will likely tap-through to see the dancing bunnies */
    //            if(result == kSecTrustResultDeny || result == kSecTrustResultFatalTrustFailure || result == kSecTrustResultOtherError)
    //            break; /* failed to trust cert (good in this case) */
    //#endif
    //
    //            // The only good exit point
    //            return [[challenge sender] useCredential: [NSURLCredential credentialForTrust: serverTrust]
    //                          forAuthenticationChallenge: challenge];
    //
    //        } while(0);
    //    }
    //    */
    // Bad dog
    //   return [[challenge sender] cancelAuthenticationChallenge: challenge];

}


- (void)connection:(id<BSCommand>)command didReceiveResponse:(NSURLResponse *)response
{
    //如果不是200或者201则认为是失败的。应该停止网络请求。
    //因为系统内部会自动重定向301和302，所以这里不做301和302的判断。
    //因为scheme是可以支持http,https,ftp等协议，而ftp协议是没有响应状态码的所以这里要进行过滤处理。
    NSLog(@"命令应答:%@",response.URL.absoluteString);
    [command stopTimer];
    if ([response.URL.scheme isEqualToString:@"http"] || [response.URL.scheme isEqualToString:@"https"])
    {
        NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse*)response;

        [command handleResponseHeader:httpresponse.statusCode url:httpresponse.URL allHeader:httpresponse.allHeaderFields];
        NSHTTPURLResponse *httpResponse = ( NSHTTPURLResponse *)response;

        if (httpResponse && [httpResponse respondsToSelector : @selector (allHeaderFields)]){

            NSDictionary *httpResponseHeaderFields = [httpResponse allHeaderFields ];



            double total_ = [[httpResponseHeaderFields objectForKey : @"Content-Length" ] longLongValue ];


            ((BSAsyncCommand*)command).dataTotal = total_;
            NSLog ( @"请求总进度：%f" , total_);

        }
        if (httpresponse.statusCode < 200 || httpresponse.statusCode >= 300)
        {
            [command cancel];  //停止网络返回。
            [self handleResponse:command statusCode:httpresponse.statusCode];
        }
    }
}

- (void)connection:(id<BSCommand>)command didReceiveData:(NSData *)data
{
    //追加数据的接受,这里后续可以增加回调处理下载进度通知的情况？？如何通知
    [command appendRecvData:data];
}

- (void)connectionDidFinishLoading:(id<BSCommand>)command
{
    [self handleResponse:command statusCode:200];

}





@end
