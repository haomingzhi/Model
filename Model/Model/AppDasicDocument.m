//
//  AppDasicDocument.m
//  ulife
//
//  Created by sunmax on 15/12/31.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "AppDasicDocument.h"
#import "BUSystem.h"
@implementation AppDasicDocument

- (id)init
{
    self = [super init];
    if (self) {
        self.deserializationMap = @{@"List":@"BUInstruction,instructionList"};
        _notice =[BUInstruction new];
    }
    return self;
}

#pragma mark --submit
//使用说明
-(BOOL)instructionUid:(NSString*)Uid  observer:(id)observer callback:(SEL)callback
{
    return [self sendRequest:[NSString stringWithFormat:@"%@%@&Uid=%@",busiSystem.apiHost,@"",busiSystem.agent.userId]
                                    head:nil
                                  method:@"GET"
                                   async:YES
                         inputInvocation:nil
                        outputInvocation:BSGetInvocationFromSel(self, @selector(instructionOutput:ok:input:))
                                observer:observer
                                  action:callback
                               extraInfo:nil];

}

//使用说明详情
-(BOOL)instruction:(NSString*)InsId  Uid:(NSString*)Uid  observer:(id)observer callback:(SEL)callback
{
    return [self sendRequest:[NSString stringWithFormat:@"%@%@&InsId=%@&Uid=%@",busiSystem.apiHost,@"",InsId,busiSystem.agent.userId]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(noticeDetailOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
    
}

-(NSError *)noticeDetailOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    [([(BSJSON *)[jsonObj objectForKey:@"Data"] objectForKey:@"List"][0])  deserialization:_notice];
     [RequestStatus setRequestResultStatus:jsonObj];
    return SuccessedError;
}

-(NSError *)instructionOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    _instructionList=nil;
    [((BSJSON *)[jsonObj objectForKey:@"Data"])  deserialization:self];
     [RequestStatus setRequestResultStatus:jsonObj];
    return SuccessedError;
}
//意见反馈
-(BOOL)writeBack:(NSString*)Content  observer:(id)observer callback:(SEL)callback
{
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(writeBackUserInput:));
        [input setArgument:&Content atIndex:2];
    //    [input setArgument:(__bridge void * _Nonnull)(regModel.Name) atIndex:3];
    //    [input setArgument:(__bridge void * _Nonnull)(regModel.Pwd) atIndex:4];
    //    [input setArgument:(__bridge void * _Nonnull)(regModel.RePwd) atIndex:5];
    //    [input setArgument:(__bridge void * _Nonnull)(regModel.registrationID) atIndex:6];
    //    [input setArgument:&smsCode atIndex:6];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",busiSystem.apiHost,@""]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(writeBackOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}


-(NSData *) writeBackUserInput:(NSString *)Content{
    return [[NSString stringWithFormat:@"Content=%@&Uid=%@",Content,busiSystem.agent.userId] dataUsingEncoding:NSUTF8StringEncoding];
}
-(NSError *)writeBackOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
     [RequestStatus setRequestResultStatus:jsonObj];
    return SuccessedError;
}

//关于我们
-(BOOL)aboutUsObserver:(id)observer callback:(SEL)callback
{
//    NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];    //获取项目名称
//    NSLog(@"%@",executableFile);
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];      //获取项目版本号
//    NSLog(@"%@",version);
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //    CFShow((__bridge CFTypeRef)(infoDictionary));
    // app名称
//    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
//    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
//    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
//    NSString * appVersion = [NSString stringWithFormat:@"%@：%@",app_Name,app_Version];
    NSString * Version =@"1.0.1";
    return [self sendRequest:[NSString stringWithFormat:@"%@%@&Version=%@",busiSystem.apiHost,@"",Version]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(aboutUsOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}
-(NSError *)aboutUsOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    [((BSJSON *)[jsonObj objectForKey:@"Data"])  deserialization:self];
     [RequestStatus setRequestResultStatus:jsonObj];
    return SuccessedError;
}
//-(BOOL) thirdLogin:(NSString *)accessToken userName:(NSString *)username auth:(NSString *) auth observer:(id)observer callback:(SEL)callback
//{
//    username = [username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString *parameterStr = [NSString stringWithFormat:@"&openid=%@&username=%@&auth=%@",accessToken,username,auth];
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",busiSystem.apiHost,BU_BUSINESS_authLogin,parameterStr]
//                        head:nil
//                      method:@"GET"
//                       async:YES
//             inputInvocation:nil
//            outputInvocation:BSGetInvocationFromSel(self, @selector(loginOutput:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:nil];
//}

@end
