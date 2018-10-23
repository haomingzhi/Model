

#import "BUSystem.h"
#import "BUDBVersion.h"
#import "BUSystemConfigDBAdapter.h"
#import "BUVersion.h"


BUSystem *busiSystem = nil;

@interface BUSystem()

@end

@implementation BUSystem

-(id)initWithApp:(NSString *)appId
{
    self = [self init];
    if (self != nil)
    {
        _appId = appId;
        
        NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
        _appVer =[infoDict objectForKey:@"CFBundleVersion"];
        _cache = [[BUCache alloc] init];
        self.apiHost = BU_BUSINESS_DOMAIN;
    }
    
    return self;
}

-(void)doSystemInit
{
    //公钥初始化
    NSData *module = [@"B5CE747C46781C81488F169C72828B72233E6E3B70525D2CE088665EC1B61F3F5FC7FE96CFB8BFFA699D61D0316ACC8C021A03ABF703C75510990F95008E4A3303ACF424B3E7EFEA001D0499CE00EB293A79B2054D11852E66D81EABF9B714A0013611059810C4CD670B50AC5D2E6B743049A5297AD38690C25BB3BBF95A331D" hexData];    
    NSData *exponent = [@"010001" hexData];
    
    NSMutableArray *testArray = [[NSMutableArray alloc] init];
    [testArray addObject:module];
    [testArray addObject:exponent];
    _publicKeyData = [testArray berData];
    
    //初始化数据库
    [BSDatabase setThreadStrategy:3];  //保证多线程的序列访问。
    _db = [[BSDatabase alloc] initWithPath:self.cache.dbPathFile];
    
    
    //数据库升级处理
    [BUDBVersion update:_db];

    //创建各个管理器
    _device = [[BUDevice alloc] init];
    _agent = [[BUAgent alloc] init];

    _globalParams = [[NSMutableDictionary alloc]init];
    _version = [[BUVersion alloc] init];
    _errorMonitors = @[@(-1),@(-2),@(-1001)];//-1网络错误
    _headManager = [BUHeadManager new];
      _pushManager = [BUPushManager new];
    _payManager = [BUPayManager new];
    _areaManager = [BUAreaManager new];
     _indexManager = [BUIndexManager new];
     _orderManager = [BUOrderManager new];
     _getOrderListManager = [BUGetOrderListManager new];
//     _sysManager = [BUSysManager new];
     
     _getCourierListManager = [BUGetCourierListManager new];
     _userManager = [BUUserManager new];
     _shopManager = [BUShopManager new];
     _getShopListManager = [BUGetShopListManager new];
     _getGoodsListManager = [BUGetGoodsListManager new];
     _getServiceListManager = [BUGetServiceListManager new];
     _getActivityManager = [BUGetActivityManager new];
     _getRecyclingOrderListManager = [BUGetRecyclingOrderListManager new];
     _getCommentListManager = [BUGetCommentListManager new];

          _getCollectListManager = [BUGetCollectListManager new];
     _dustbinManager = [BUDustbinManager new];
     _getAfterSaleListManager = [BUGetAfterSaleListManager new];
     _getCourierOrderListManager = [BUGetCourierOrderListManager new];
     _myPathManager = [BUMyPathManager new];
}



-(BOOL)updateGlobalParam
{
    return TRUE;
}




-(void) loadFromDb
{
    BUSystemConfigDBAdapter *systemConfigDb = [[BUSystemConfigDBAdapter alloc]initWithDb:busiSystem.db];
    NSArray *tmpConfig= [systemConfigDb Load];
    NSDictionary *systemConfig;
    if (tmpConfig != NULL && tmpConfig.count ==1) {
        systemConfig = [tmpConfig objectAtIndex:0];
    }
//    [self.actionManager loadFromDb];
//    [self.categoryManager loadFromDb];
    [self.areaManager loadFromDb];
}

-(NSURL *)apiHostUrl
{
    return [NSURL URLWithString:_apiHost];
}

@end

BOOL initBusiSystem(NSString *appId)
{
    if (busiSystem == nil)
    {
        busiSystem = [[BUSystem alloc] initWithApp:appId];
        [busiSystem doSystemInit];
        [busiSystem loadFromDb];
        [busiSystem updateGlobalParam];
    }
    return busiSystem != NULL;
}

