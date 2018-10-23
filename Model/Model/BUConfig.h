

#ifndef ModelBUConfig_h
#define ModelBUConfig_h

/*

 */

//post JSON 接入地址
#define  COMMON_URL_BUSI    @""
#define FITWIDTHSCALE  __SCREEN_SIZE.width/320.0
#define REFITWIDTHSCALE  320.0/__SCREEN_SIZE.width
#define LoadingHintString   @"正在加载数据..."
#define SubmitHintString    @"正在提交数据..."
#define MyAppKey @"8df1b74cfa009913"
#define MyAppSecret @"ad40ddc53b004e52baf3c75256cfdb37"
#define AliUrlSchemes @"RS"
#define WXUrlSchemes @"wx98f1d735376d922e"
#define ZMUrlSchemes @"ZMRS"//芝麻信用回调打开
#define WXAppSecret @"49b346470a35d23ed14a4598b2bae377"

//#define  BU_BUSINESS_DOMAINIP  @"http://192.168.30.250:212"//线下
#define  BU_BUSINESS_DOMAINIP   @"http://likeapi.oranllc.com" //线上
#define  BU_BUSINESS_SHAREIP @"http://likeadmin.oranllc.com"
#define  BU_BUSINESS_DOMAIN  [NSString stringWithFormat:@"%@",BU_BUSINESS_DOMAINIP]
#define  BU_BUSINESS_DOMAIN_LOGIN [NSString stringWithFormat:@"%@/api/Login",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_HOME [NSString stringWithFormat:@"%@/api/Home",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_INDEX [NSString stringWithFormat:@"%@/api/Index",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_HOMEINDEX [NSString stringWithFormat:@"%@/api/HomeIndex",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_TYPEMSG [NSString stringWithFormat:@"%@/api/TypeMsg",BU_BUSINESS_DOMAIN]

#define  BU_BUSINESS_DOMAIN_ACCOUNT [NSString stringWithFormat:@"%@/api/Account",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_USER [NSString stringWithFormat:@"%@/api/User",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_ORDER [NSString stringWithFormat:@"%@/api/Order",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_VALUES [NSString stringWithFormat:@"%@/api/Values",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_PRODUCT [NSString stringWithFormat:@"%@/api/Product",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_AUTH [NSString stringWithFormat:@"%@/api/Auth",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_PAY [NSString stringWithFormat:@"%@/api/Pay",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_SYS [NSString stringWithFormat:@"%@/api/Sys",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_USERSET [NSString stringWithFormat:@"%@/api/UserSet",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_MYPATH [NSString stringWithFormat:@"%@/api/MyPath",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_SLIDESHOW [NSString stringWithFormat:@"%@/api/Slideshow",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_TYPEMSG [NSString stringWithFormat:@"%@/api/TypeMsg",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_SECONDHAND [NSString stringWithFormat:@"%@/api/Secondhand",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_SHOP [NSString stringWithFormat:@"%@/api/Shop",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_SERVICE [NSString stringWithFormat:@"%@/api/Service",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_DUSTBIN [NSString stringWithFormat:@"%@/api/Dustbin",BU_BUSINESS_DOMAIN]
#define  BU_BUSINESS_DOMAIN_SECONDHAND [NSString stringWithFormat:@"%@/api/Secondhand",BU_BUSINESS_DOMAIN]
//=======用户管理========//
//三方登陆
#define BU_BUSINESS_authLogin @"?g=Mobile&m=Public&a=authLogin"
//
//////获取验证码
//#define BU_BUSINESS_GetSms @"?c=Api&a=sendVerify"
//////修改头像
//#define BU_BUSINESS_uploadFile @"/UploadFile"
//#define BU_BUSINESS_DelImageFile @"/DelImageFile"



#define BU_BUSINESS_GetMyIndex  @"/GetMyIndex"
#define BU_BUSINESS_UpUserInfo   @"/UpUserInfo"
#define BU_BUSINESS_ForgotPwd @"/ForgotPwd"
#define BU_BUSINESS_UserAddress @"/UserAddress"
#define BU_BUSINESS_GetProvinlist   @"/GetProvinlist"
#define BU_BUSINESS_AddandUpAddress   @"/AddandUpAddress"
#define BU_BUSINESS_UpMsgState @"/UpMsgState"
#define BU_BUSINESS_AddFeed  @"/AddFeed"
#define BU_BUSINESS_GeTadvertising @"/GeTadvertising"
#define BU_BUSINESS_GetSliGuide @"/GetSliGuide"
#define BU_BUSINESS_GetFoundSlishow @"/GetFoundSlishow"
#define BU_BUSINESS_GetFind @"/GetFind"
#define BU_BUSINESS_UpCount @"/UpCount"
#define BU_BUSINESS_AddCoupon @"/AddCoupon"
#define BU_BUSINESS_BringStock @"/BringStock"
#define BU_BUSINESS_GetUserMsg @"/GetUserMsg"
#define BU_BUSINESS_GetMyCoupon @"/GetMyCoupon"
#define BU_BUSINESS_GetColloc @"/GetColloc"
#define BU_BUSINESS_AddandUpCon @"/AddandUpCon"
#define BU_BUSINESS_AddOrderMsg @"/AddOrderMsg"
#define BU_BUSINESS_SaleType @"/SaleType"
#define BU_BUSINESS_Buyoutld @"/Buyoutld"
#define BU_BUSINESS_OrderMsgList @"/OrderMsgList"
#define BU_BUSINESS_AddBuyoutld @"/AddBuyoutld"
#define BU_BUSINESS_BuyouInfo @"/BuyouInfo"
#define BU_BUSINESS_ReletList @"/ReletList"
#define BU_BUSINESS_AddRele @"/AddRele"
#define BU_BUSINESS_ReletInfo @"/ReletInfo"
#define BU_BUSINESS_SaleList @"/SaleList"
#define BU_BUSINESS_AddSale @"/AddSale"
#define BU_BUSINESS_SaleInfo @"/SaleInfo"
#define BU_BUSINESS_RrfundPath @"/RrfundPath"
#define BU_BUSINESS_Refund @"/Refund"
#define BU_BUSINESS_DeleAddress @"/DeleAddress"
#define BU_BUSINESS_GetPublicAppAuthorize @"/GetPublicAppAuthorize"
#define BU_BUSINESS_UserCertification @"/UserCertification"
#define BU_BUSINESS_GetZhimaCreditScore @"/GetZhimaCreditScore"
//service
#define BU_BUSINESS_GetServiceInfo @"/GetServiceInfo"
#define BU_BUSINESS_GetServiceList @"/GetServiceList"
#define BU_BUSINESS_GetServiceTypeList @"/GetServiceTypeList"
//shop
#define BU_BUSINESS_GetShopInfo @"/GetShopInfo"
#define BU_BUSINESS_GetShopList @"/GetShopList"
#define BU_BUSINESS_GetShopTypeList @"/GetShopTypeList"
#define BU_BUSINESS_GetGoodsInfo @"/GetGoodsInfo"
#define BU_BUSINESS_GetGoodsList @"/GetGoodsList"
#define BU_BUSINESS_GetGoodsTypeList @"/GetGoodsTypeList"
#define BU_BUSINESS_MainPath @"/MainPath"
//index
#define BU_BUSINESS_GetInfoConfig @"/GetInfoConfig"
#define BU_BUSINESS_GetVersion @"/GetVersion"
#define BU_BUSINESS_GetProvinceList @"/GetProvinceList"
#define BU_BUSINESS_GetCityList @"/GetCityList"
#define BU_BUSINESS_GetAreaList @"/GetAreaList"
#define BU_BUSINESS_GetOpenCityList @"/GetOpenCityList"
#define BU_BUSINESS_GetCarouselList @"/GetCarouselList"
#define BU_BUSINESS_GetHelpTypeList @"/GetHelpTypeList"
#define BU_BUSINESS_GetHelpList @"/GetHelpList"
#define BU_BUSINESS_GetActivityList @"/GetActivityList"
#define BU_BUSINESS_GetActivity @"/GetActivity"
#define BU_BUSINESS_UploadFile @"/UploadFile"


//homeIndex
#define BU_BUSINESS_AppConfig @"/AppConfig"
#define BU_BUSINESS_GetIndex @"/GetIndex"
#define BU_BUSINESS_GetIndexActivity @"/GetIndexActivity"
#define BU_BUSINESS_GetIndexOptimi @"/GetIndexOptimi"
#define BU_BUSINESS_Sigin @"/Sigin"
#define BU_BUSINESS_AddSigin @"/AddSigin"


//homeIndex
#define BU_BUSINESS_GetProType @"/GetProType"
#define BU_BUSINESS_GetTypeInfo @"/GetTypeInfo"
#define BU_BUSINESS_GetProductItem @"/GetProductItem"
#define BU_BUSINESS_GetProductPrice @"/GetProductPrice"
#define BU_BUSINESS_Collection @"/Collection"
#define BU_BUSINESS_GetEvaluationPageList @"/GetEvaluationPageList"
#define BU_BUSINESS_GetLeaseRule @"/GetLeaseRule"
#define BU_BUSINESS_GetPayMoney @"/GetPayMoney"
#define BU_BUSINESS_SubmitOrder @"/SubmitOrder"
#define BU_BUSINESS_OptimiInfo @"/OptimiInfo"
#define BU_BUSINESS_OrderCoupon @"/OrderCoupon"

//user
#define BU_BUSINESS_GetUserAddressList @"/GetUserAddressList"
#define BU_BUSINESS_AddUserCart @"/AddUserCart"
#define BU_BUSINESS_GetUserCart @"/GetUserCart"
#define BU_BUSINESS_DelUserCart @"/DelUserCart"
#define BU_BUSINESS_AddGoodsCollect @"/AddGoodsCollect"
#define BU_BUSINESS_GetCourierInfo @"/GetCourierInfo"
#define BU_BUSINESS_GetCourierList @"/GetCourierList"
#define BU_BUSINESS_GetUserCartCount @"/GetUserCartCount"

#define BU_BUSINESS_MobileLogin @"/MobileLogin"
#define BU_BUSINESS_TellLogin @"/TellLogin"
#define BU_BUSINESS_UserLogin @"/UserLogin"
#define BU_BUSINESS_AccountLogin @"/AccountLogin"
#define BU_BUSINESS_UserRegister @"/UserRegister"
#define BU_BUSINESS_CreateUser @"/CreateUser"
#define BU_BUSINESS_GetUserAgreement @"/GetUserAgreement"
#define BU_BUSINESS_GetSmsCode @"/GetSmsCode"
#define BU_BUSINESS_SmsCode @"/SmsCode"
#define BU_BUSINESS_UpdateUserPwd @"/UpdateUserPwd"
#define BU_BUSINESS_ForgetPassword @"/ForgetPassword"
#define BU_BUSINESS_GetUserCodeState @"/GetUserCodeState"
#define BU_BUSINESS_ForgotPwd @"/ForgotPwd"

#define BU_BUSINESS_GetInviteUserList @"/GetInviteUserList"
#define BU_BUSINESS_Carousel @"/Carousel"
#define BU_BUSINESS_GetInfoConfig @"/GetInfoConfig"
#define BU_BUSINESS_GetIntegralConfig @"/GetIntegralConfig"
#define BU_BUSINESS_GetHelpList @"/GetHelpList"
#define BU_BUSINESS_GetSinceAddressList @"/GetSinceAddressList"
#define BU_BUSINESS_GetSinceAddress @"/GetSinceAddress"
#define BU_BUSINESS_GetBespokeCity @"/GetBespokeCity"
#define BU_BUSINESS_GetCityList @"/GetCityList"
//#define BU_BUSINESS_GetProvinceList @"/GetProvinceList"
#define BU_BUSINESS_GetAreaList @"/GetAreaList"
//#define BU_BUSINESS_Feedback @"/Feedback"
#define BU_BUSINESS_GetBespokeDetail @"/GetBespokeDetail"
#define BU_BUSINESS_GetUserPushMsg @"/GetUserPushMsg"
#define BU_BUSINESS_ViewPushMsg @"/ViewPushMsg"
#define BU_BUSINESS_DelPushMsg @"/DelPushMsg"
#define BU_BUSINESS_StartPage @"/StartPage"
#define BU_BUSINESS_GuidePage @"/GuidePage"
#define BU_BUSINESS_GetHelpTypeList @"/GetHelpTypeList"
#define BU_BUSINESS_CheckAuth @"/CheckAuth"

#define BU_BUSINESS_CheckPayPassword @"/CheckPayPassword"
#define BU_BUSINESS_CheckSmsCode @"/CheckSmsCode"
#define BU_BUSINESS_GetUserAddress @"/GetUserAddress"
#define BU_BUSINESS_UpdateUserInfo @"/UpdateUserInfo"
#define BU_BUSINESS_ChangeUserPassword @"/ChangeUserPassword"
#define BU_BUSINESS_UpdateUserAddress @"/UpdateUserAddress"
#define BU_BUSINESS_SaveUserAddress @"/SaveUserAddress"
#define BU_BUSINESS_DelUserAddress @"/DelUserAddress"
#define BU_BUSINESS_SetDefaultUserAddress @"/SetDefaultUserAddress"
#define BU_BUSINESS_SetUserAddress @"/SetUserAddress"

#define BU_BUSINESS_Search @"/Search"

#define BU_BUSINESS_GetSignInfo @"/GetSignInfo"
#define BU_BUSINESS_Sign @"/Sign"
#define BU_BUSINESS_GetUserFavorite @"/GetUserFavorite"
#define BU_BUSINESS_AddUserFavorite @"/AddUserFavorite"
#define BU_BUSINESS_DelUserFavorite @"/DelUserFavorite"

#define BU_BUSINESS_GetOrderDetail @"/GetOrderDetail"

#define BU_BUSINESS_OrderOper @"/OrderOper"


#define BU_BUSINESS_GetGoodsList @"/GetGoodsList"
#define BU_BUSINESS_GetGoodsTypeList @"/GetGoodsTypeList"
//#define BU_BUSINESS_GetCardTypeList @"/GetCardTypeList"
#define BU_BUSINESS_GetGoodsDetail @"/GetGoodsDetail"
//
#define BU_BUSINESS_GetActivityList @"/GetActivityList"
#define BU_BUSINESS_GetActivityDetail @"/GetActivityDetail"
#define BU_BUSINESS_GetActivityGoodsList @"/GetActivityGoodsList"





#define BU_BUSINESS_File @"/File"


//order
#define BU_BUSINESS_AddShoppingCart @"/AddShoppingCart"
#define BU_BUSINESS_GetShoppingCartList @"/GetShoppingCartList"
#define BU_BUSINESS_GetShoppingCartCount  @"/GetShoppingCartCount"
#define BU_BUSINESS_ShoppingCartDelBatch @"/ShoppingCartDelBatch"
#define BU_BUSINESS_GetShoppingCartItem @"/GetShoppingCartItem"
#define BU_BUSINESS_GetCouponList @"/GetCouponList"
#define BU_BUSINESS_SubmitShoppingCart @"/SubmitShoppingCart"

#define BU_BUSINESS_GetMyOrderPageList @"/GetMyOrderPageList"
#define BU_BUSINESS_GetMyOrderItemInfo @"/GetMyOrderItemInfo"
#define BU_BUSINESS_OperOrder @"/OperOrder"
#define BU_BUSINESS_GetTrackOrder @"/GetTrackOrder"
#define BU_BUSINESS_GetMyOrderForEvaluatePageList @"/GetMyOrderForEvaluatePageList"
#define BU_BUSINESS_Evaluate @"/Evaluate"
#define BU_BUSINESS_GetMyOrderForBackPageList @"/GetMyOrderForBackPageList"
#define BU_BUSINESS_GetBackOrderItem @"/GetBackOrderItem"
#define BU_BUSINESS_ToBackOrder @"/ToBackOrder"
#define BU_BUSINESS_GetBackTypeList @"/GetBackTypeList"
#define BU_BUSINESS_GetMyCouponList @"/GetMyCouponList"

#define BU_BUSINESS_GetDeliveryAddress @"/GetDeliveryAddress"
#define BU_BUSINESS_AddDeliveryAddress @"/AddDeliveryAddress"
#define BU_BUSINESS_UpdateDeliveryAddress @"/UpdateDeliveryAddress"
#define BU_BUSINESS_GetUserStatistics @"/GetUserStatistics"
#define BU_BUSINESS_GetUserInfo @"/GetUserInfo"
#define BU_BUSINESS_UpdateUserInfo @"/UpdateUserInfo"
#define BU_BUSINESS_ChangeUserPassword @"/ChangeUserPassword"
#define BU_BUSINESS_ValidateAddress @"/ValidateAddress"
#define BU_BUSINESS_GetDefaultAddressID @"/GetDefaultAddressID"
#define BU_BUSINESS_GetDeliveryAddressList @"/GetDeliveryAddressList"
#define BU_BUSINESS_DeleteAddress @"/DeleteAddress"
#define BU_BUSINESS_UserMember @"/UserMember"
#define BU_BUSINESS_UserAge @"/UserAge"
#define BU_BUSINESS_UserPay @"/UserPay"
#define BU_BUSINESS_AddUserPay @"/AddUserPay"
#define BU_BUSINESS_GetMessageList @"/GetMessageList"
#define BU_BUSINESS_GetMessageInfo @"/GetMessageInfo"
#define BU_BUSINESS_GetSysHelpTypeList @"/GetSysHelpTypeList"
#define BU_BUSINESS_GetSysHelpTypeMsgList @"/GetSysHelpTypeMsgList"
#define BU_BUSINESS_GetInviteInfo @"/GetInviteInfo"
#define BU_BUSINESS_GetSysInfo @"/GetSysInfo"


#define BU_BUSINESS_GetSecondhandGoods @"/GetSecondhandGoods"
#define BU_BUSINESS_GetSecondhandGoodsList @"/GetSecondhandGoodsList"
#define BU_BUSINESS_SaveSecondhandGoods @"/SaveSecondhandGoods"
#define BU_BUSINESS_DelSecondhandGoods @"/DelSecondhandGoods"
#define BU_BUSINESS_GetUserIndex @"/GetUserIndex"
#define BU_BUSINESS_SaveUser @"/SaveUser"
#define BU_BUSINESS_ChangePassword @"/ChangePassword"
#define BU_BUSINESS_GetCollectList @"/GetCollectList"
#define BU_BUSINESS_GetOrderInfo @"/GetOrderInfo"
#define BU_BUSINESS_GetOrderList @"/OrderList"
#define BU_BUSINESS_OrderAdd @"/OrderAdd"
#define BU_BUSINESS_OrderPay @"/OrderPay"
#define BU_BUSINESS_PayOrder @"/PayOrder"
#define BU_BUSINESS_UpOrder @"/UpOrder"
#define BU_BUSINESS_OrderDel @"/OrderDel"
#define BU_BUSINESS_RecyclingOrderAdd @"/RecyclingOrderAdd"
#define BU_BUSINESS_OrderCancel @"/OrderCancel"
#define BU_BUSINESS_OrderFinish  @"/OrderFinish"
#define BU_BUSINESS_GetComment @"/GetComment"
#define BU_BUSINESS_GetCommentList @"/GetCommentList"
#define BU_BUSINESS_AddComment @"/AddComment"
#define BU_BUSINESS_GetCommentbyOrderId @"/GetCommentbyOrderId"
#define BU_BUSINESS_GetRecyclingOrderList @"/GetRecyclingOrderList"
#define BU_BUSINESS_DelGoodsCollect @"/DelGoodsCollect"
#define BU_BUSINESS_GetStationInfo @"/GetStationInfo"
#define BU_BUSINESS_GetStationList @"/GetStationList"
#define BU_BUSINESS_GetQrCode @"/GetQrCode"
#define BU_BUSINESS_GetRecyclingStat @"/GetRecyclingStat"
#define BU_BUSINESS_GetRecyclingOrder @"/GetRecyclingOrder"
#define BU_BUSINESS_UserBindMobile @"/UserBindMobile"
#define BU_BUSINESS_ThirdLogin @"/ThirdLogin"
#define BU_BUSINESS_GetUserDefaultAddress @"/GetUserDefaultAddress"
#define BU_BUSINESS_GetIntegralRanking @"/GetIntegralRanking"
#define BU_BUSINESS_GetDustbinTypeList @"/GetDustbinTypeList"
#define BU_BUSINESS_OrderBack @"/OrderBack"
#define BU_BUSINESS_GetAfterSaleDetail @"/GetAfterSaleDetail"
#define BU_BUSINESS_GetAfterSaleList @"/GetAfterSaleList"
#define BU_BUSINESS_GetSysMessageList @"/GetSysMessageList"
#define BU_BUSINESS_GetReasonList @"/GetReasonList"
#define BU_BUSINESS_GetSysMessage @"/GetSysMessage"
#define BU_BUSINESS_OrderConfirm @"/OrderConfirm"
#define BU_BUSINESS_OrderConfirmbyCourier @"/OrderConfirmbyCourier"
#define BU_BUSINESS_GetCourierOrderList @"/GetCourierOrderList"
#define BU_BUSINESS_GetExpressInfo @"/GetExpressInfo"



#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define kWeakSelf __weak __typeof__(self) weakSelf = self;
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//notification
#define KNOTIFICATION_ADDMSG_TO_LIST @"KNOTIFICATION_ADDMSG_TO_LIST"
#define KNOTIFICATION_LOGINCHANGE @"loginStateChange"
#define KNOTIFICATION_CHAT @"chat"
#define KNOTIFICATION_SETTINGCHANGE @"settingChange"

#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]



#define kAppKey @"KF_appkey"
#define kCustomerName @"KF_name"
#define kCustomerNickname @"KF_nickname"
#define kCustomerTenantId @"KF_tenantId"
#define kCustomerProjectId @"KF_projectId"

#define hxPassWord @"123456"

//测试模式
#define BU_USERTYPE_DEBUG 1
//开发模式
#define BU_USERTYPE_DEVELOP 2
//现网模式
#define BU_USERTYPE_PRODUCT 3



//指定要使用的模式，不同的平台配置可能不一样
#define BU_USERTYPE BU_USERTYPE_DEBUG

#if BU_USERTYPE == BU_USERTYPE_DEBUG //测试平台配置
#define BU_INITURL BU_INITURL_DEBUG
#elif BU_USERTYPE == BU_USERTYPE_DEVELOP //开发平台配置
#define BU_INITURL BU_INITURL_DEVELOP
#elif BU_USERTYPE == BU_USERTYPE_PRODUCT //生产平台配置
#define BU_INITURL BU_INITURL_PRODUCT
#endif

#endif
