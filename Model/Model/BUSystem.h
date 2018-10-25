
#import "BUDevice.h"
#import "BUAgent.h"
#import "BUVersion.h"
#import "BUPayManager.h"
//#import "BUHeadManager.h"
#import "BUArea.h"
#import "BUMapAddress.h"
#import "BUPushManager.h"
//#import "BUGetOrderListManager.h"
//#import "BUIndexManager.h"
//#import "BUShopManager.h"
//#import "BUGetShopListManager.h"
//#import "BUGetGoodsListManager.h"
//#import "BUGetServiceListManager.h"
//#import "BUGetActivityManager.h"
//#import "BUGetRecyclingOrderListManager.h"
//#import "BUGetCommentListManager.h"
//#import "BUMyPathManager.h"
//#import "BUGetCollectListManager.h"
//#import "BUDustbinManager.h"
//#import "BUUserManager.h"
//#import "BUGetCourierListManager.h"
//#import "BUOrderManager.h"
//#import "BUGetCommentListManager.h"
//#import "BUGetAfterSaleListManager.h"
//#import "BUGetCourierOrderListManager.h"
//#import "BUMyPointAntation.h"
//#import "BUGetToDoorRecyclingOrderListManager.h"

/*
   业务系统类，所有的业务访问入口都从这里开始。。
 */
@interface BUSystem : BUBase


@property(nonatomic, readonly) NSString *appId;       //应用的标识,用于区分不同的target
@property(nonatomic, readonly) NSString *appVer;      //应用的版本号
@property(nonatomic, readonly) BUDevice *device;      //设备
@property(nonatomic) BUAgent *agent;                  //用户管理器
@property(nonatomic) NSInteger uid;                   //当前uId
//@property(nonatomic, readonly) BUActionManager *actionManager;      //活动管理器
//@property(nonatomic, readonly) BUActionManager *zxActionManager;    //资讯活动管理

@property(nonatomic,readonly) BUAreaManager *areaManager;
//@property(nonatomic,readonly)BUUserSetManager *userSetManager;
@property(nonatomic, readonly) NSMutableDictionary *globalParams;   //全局参数列表
@property(nonatomic, readonly) BUVersion *version;                  //版本信息，查服务器版本返回的信息
@property(nonatomic, readonly) BUCache *cache;                      //缓存信息，内部使用
@property(nonatomic, readonly) NSData *publicKeyData;               //公钥，内部使用！！！！
@property(nonatomic, readonly) BSDatabase *db;                      //数据库，内部使用！！！！
//@property(nonatomic, readonly) BUHeadManager *headManager;
//@property(nonatomic, readonly)BUGetOrderListManager *getOrderListManager;
//@property(nonatomic, readonly)BUGetCollectListManager *getCollectListManager;
//@property(nonatomic, readonly)BUUserManager  *userManager;
//@property(nonatomic,readonly) BUGetShopListManager *getShopListManager;
//@property(nonatomic,readonly) BUShopManager *shopManager;
//@property(nonatomic,readonly) BUGetCourierListManager *getCourierListManager;
//@property(nonatomic,readonly) BUGetGoodsListManager *getGoodsListManager;
//@property(nonatomic,readonly) BUGetServiceListManager *getServiceListManager;
//@property(nonatomic,readonly) BUGetActivityManager *getActivityManager;
//@property(nonatomic,readonly) BUGetCommentListManager *getCommentListManager;
//@property(nonatomic,readonly)BUGetRecyclingOrderListManager *getRecyclingOrderListManager;

//@property(nonatomic,readonly)BUDustbinManager *dustbinManager;
//@property(nonatomic,readonly)BUGetAfterSaleListManager *getAfterSaleListManager;
//@property(nonatomic,readonly)BUGetCourierOrderListManager *getCourierOrderListManager;
//@property(strong,nonatomic)BUMyPathManager *myPathManager;
//@property(nonatomic,readonly)BUGetUserPushMsgManager *getUserPushMsgManager;


//@property(nonatomic,readonly)BUIndexManager *indexManager;


@property(nonatomic,readonly)BUOrderManager *orderManager  ;

@property(nonatomic, readonly) NSArray *errorMonitors;      //异常监听器，那些异常号需要重新加载
@property(nonatomic) NSString *apiHost;
@property(nonatomic) NSURL *apiHostUrl;
@property(nonatomic, readonly) BUPushManager *pushManager;
@property(nonatomic, readonly)BUPayManager *payManager;
//@property(nonatomic, readonly)BUSysManager *sysManager;
-(id)initWithApp:(NSString*)appId;



@end

extern BUSystem *busiSystem;

//初始化业务系统
BOOL initBusiSystem(NSString *appId);

