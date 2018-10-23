//
//  BSCommand.h
//  SCWCYClient
//
//  Created by apple on 14-5-23.
//  Copyright (c) 2014年 SunnadaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>



//网络命令
@interface BSNetworkCommand : NSObject

@property(nonatomic,strong) NSInvocation *inputInvocation;   //输入的调用。要求函数返回NSData对象。或者返回nill
@property(nonatomic,strong) NSInvocation *outputInvocation;  //返回的处理。入参是NSData和_inputInvocation。返回NSError型
@property(nonatomic,strong) NSString  *address;               //命令地址
@property(nonatomic,strong) NSString *method;
@property(nonatomic,strong) NSDictionary *head;
@property(nonatomic,strong) id target;
@property(nonatomic) BOOL async;
@property(nonatomic) BOOL isDownloadCmd;                    //是否是一条下载命令
//观察者
@property(nonatomic,strong) id observer;
@property(nonatomic) SEL action;     //-handle:(BSNotification*)notify
@property(nonatomic,strong) NSDictionary *extraInfo;

-(void) execute;
@end


//观察者对象
@interface BSObserver : NSObject

@property(nonatomic, readonly) id observer;
@property(nonatomic, readonly) SEL action;     //-handle:(BSNotification*)notify
@property(nonatomic, readonly) NSDictionary *extraInfo;

+(id)observerWith:(id)observer action:(SEL)action extraInfo:(NSDictionary*)extraInfo;

@end




@interface BSNotification : NSObject

@property(nonatomic, readonly, strong) id target;
@property(nonatomic, readonly) NSDictionary *extraInfo;
@property(nonatomic, readonly,strong) NSError *error;
@property(nonatomic, readonly) BSNetworkCommand *cmd;
+(id)notificationWith:(id)target extraInfo:(NSDictionary*)extraInfo error:(NSError*)error;

@end




/*
 代理的观察者对象，通常用于那些需要连续网络依次调用的指令。
 */
@interface BSProxyObserver : NSObject

@property(nonatomic, readonly) SEL proxyAction;  //设置这个代理的动作。


//初始化一个块。
-(id)initWithAction:(void (^)(BSNotification*))action;




@end






@protocol BSCommand<NSObject>

//启动命令
-(void)start;

-(BOOL)started;

//终止命令
-(void)cancel;

//异步标志
-(BOOL)async;

//是否是一个下载命令
-(BOOL)isDownloadcmd;

//停止计时器
-(void)stopTimer;

//添加接收的数据。
-(void)appendRecvData:(NSData*)data;


-(BOOL)removeObserver:(id)observer;

-(BOOL)removeAllObserver;

-(id)target;

-(NSInteger)statusCode;

-(void)handleResponseHeader:(NSInteger)statusCode url:(NSURL*)url allHeader:(NSDictionary*)allHeader;

-(BOOL)handleResponse:(NSInteger)statusCode;

-(BOOL)isEqualCommand:(NSString*)aAddress target:(id)aTarget sendData:(NSData*)aSendData;

-(BOOL)addObserver:(id)observer action:(SEL)action extraInfo:(NSDictionary*)extraInfo;


@end






@interface BSCommandScheduler : NSObject


@property(nonatomic, assign) NSInteger  maxCount;


+(BSCommandScheduler*)defaultCommandScheduler;
-(BOOL)handleResponse:(id<BSCommand>)command statusCode:(NSInteger)statusCode;
//命令地址，命令头选项，命令方法，是否异步，目标对象，目标对象输入处理，目标对象输出处理，目标对象接收数据处理，目标对象响应处理，目标对象通知处理，观察者，动作，附加信息
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
                 extraInfo:(NSDictionary*)extraInfo;


//添加下载命令
-(BOOL)addDownloadCommand:(NSString*)address
                    range:(NSRange)range
                 filePath:(NSString*)filePath
                 observer:(id)observer    //通知界面。
                   action:(SEL)action     //每一个进度都会给予提示，以及下载完成也会给予提示。
                extraInfo:(NSDictionary*)extraInfo;


//添加上载命令。
-(BOOL)addUploadCommand:(NSString*)address
                   data:(NSObject*)data   //上行的数据，可以是一个NSString的文件路径，也可以是一个UIImage，也可以是一个二进制NSData数据。
               fileName:(NSString*)fileName  //文件名
                 target:(id)target
       outputInvocation:(NSInvocation*)outputInvocation
               observer:(id)observer    //通知界面。
                 action:(SEL)action     //完成通知界面函数
              extraInfo:(NSDictionary*)extraInfo;

-(BOOL)addUploadCommand:(NSString*)address
                   data:(NSObject*)data
               fileName:(NSString*)fileName
                 target:(id)target
       outputInvocation:(NSInvocation*)outputInvocation
     progressInvocation:(NSInvocation*)progressInvocation
               observer:(id)observer    //通知界面。
                 action:(SEL)action     //每一个进度都会给予提示，以及下载完成也会给予提示。
              extraInfo:(NSDictionary*)extraInfo;

-(BOOL)removeTarget:(id)target;   //删除目标。

-(BOOL)removeObserver:(id)observer;  //删除界面观察者。

-(NSInteger) commandCount;          //命令数
-(NSInteger) commandButDownload;    //命令数除了下载的

@end
