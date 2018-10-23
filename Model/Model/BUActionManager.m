

#import "BUActionManager.h"
#import "BUAction.h"
#import "BUSystem.h"



@interface BUActionManager()



@end


@interface BUActionManager(IO)

-(NSError *)updateActionListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input;

@end


@implementation BUActionManager

-(id) init
{
    self = [super init];
    if (self) {
        self.deserializationMap = @{@"list":@"BUAction,actions"};
    }
    return self;
}

//从数据库加载历史数据，现在没实现
-(void) loadFromDb
{
    //_actions  = [[NSMutableArray alloc]initWithArray:  [dbAdapter Load]];
    _actions = [[NSMutableArray alloc]init];
}

//获取轮播广告
-(BOOL)updateActionList:(BSACTIONTYPE) actionType categoryId:(NSString *) categoryId observer:(id)observer callback:(SEL)callback;
{
    NSString *requestUrl = @"";
    switch (actionType) {
        case BSACTIONTYPE_News:
            requestUrl = [NSString stringWithFormat:@"%@&id=%@",BU_BUSINESS_getZxLunBoImg,categoryId] ;
            break;
        case BSACTIONTYPE_TRADE:
            requestUrl = BU_BUSINESS_trade_getLunboList;
            break;
        default:
            break;
    }
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",busiSystem.apiHost,requestUrl]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(updateActionListOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
    return YES;
}

-(NSError *)updateActionListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    [self.actions removeAllObjects];
    [((BSJSON *)[jsonObj objectForKey:@"data"]) deserialization:self];
    return SuccessedError;
}


@end
