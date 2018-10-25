



#import "BUImageRes.h"
#import "BURegisterModel.h"
#import "BULCManager.h"
#import "BUOrderManager.h"

@interface BUGetFind : BUBase
@property(nonatomic) NSInteger clickCount;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *findId;
@property(strong,nonatomic) NSString *subtitle;
@property(strong,nonatomic)  BUImageRes *img;
@property(strong,nonatomic) NSString *content;
-(NSDictionary *)getDic:(NSInteger)row;
@property(nonatomic) CGFloat rHeight;
@end

@interface BUFoundSlishow : BUBase
@property(strong,nonatomic) NSString *note;
@property(strong,nonatomic) BUImageRes *img;
@property(strong,nonatomic) NSString *parmaId;
@property(strong,nonatomic) NSString *name;
@property(nonatomic) NSInteger type;
@property(strong,nonatomic) NSString *url;
+(NSDictionary *)getArrDicWithThisArr:(NSArray*)arr;
@end

@interface BUAddressNameAndId : BUBase
@property(strong,nonatomic) NSString *aid;
@property(strong,nonatomic) NSString *name;
@end

@interface BUSinceAddress : BUBase
@property(strong,nonatomic) NSString *contacts;
@property(strong,nonatomic) NSString *tel;
@property(strong,nonatomic) NSString *address;
@end

@interface BUGetMyIndex : BUBase
@property(strong,nonatomic) NSString *refund;//到期退还
@property(strong,nonatomic) NSString *buyout;//买断
@property(strong,nonatomic) NSString *renewal;//续租
@property(strong,nonatomic) NSString *lease;//租赁中
@property(strong,nonatomic) NSString *payment;//待付款
@property(strong,nonatomic) NSString *coupons;//优惠卷
@property(strong,nonatomic) NSString *delivery;//发货中
@property(strong,nonatomic) NSString *collection;//收藏
@property(strong,nonatomic) NSString *after;//售后
@property(nonatomic) NSInteger isCertifi;
@property(strong,nonatomic) NSString *evaluate;//待评价
@end
//@interface BUHelp :BUBase
//@property(strong,nonatomic) NSString *title;
//@property(strong,nonatomic) NSString *content;
//@end


@interface BUGetIntegralConfig :BUBase
@property(nonatomic) NSInteger signOne;
@property(nonatomic) NSInteger signSeven;
@property(strong,nonatomic) NSString *signExplain;
@property(strong,nonatomic) NSString *recommendContent;
@property(nonatomic) NSInteger signFive;
@property(nonatomic) NSInteger shareGoods;
@property(strong,nonatomic) NSString *operTime;
@property(strong,nonatomic) NSString *recommendImage;
@property(nonatomic) NSInteger integralToMoney;
@property(nonatomic) NSInteger signTwo;
@property(nonatomic) NSInteger signSix;
@property(nonatomic) NSInteger signFour;
@property(nonatomic) NSInteger recommendRegister;
@property(strong,nonatomic) NSString *integralExplain;
@property(strong,nonatomic) NSString *sisId;
@property(nonatomic) NSInteger signThree;
@property(nonatomic) NSInteger recommendBuy;
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic) NSString *recommendTitle;
@property(strong,nonatomic) NSString *recommendExplain;
@end


@interface BUGetInfoConfig :BUBase

@property(strong,nonatomic) NSString *keyword;
@property(strong,nonatomic) NSString *hotKeyword;
@property(strong,nonatomic) NSString *signRules;
@property(strong,nonatomic) NSArray *hotKeywordList;
@property(strong,nonatomic) NSString *note;
//@property(nonatomic) BOOL isadForStartPage;
@property(strong,nonatomic) NSString *configId;
@property(strong,nonatomic) NSString *userAgreement;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) BUImageRes *logo;
@property(strong,nonatomic) NSString *aboutUS;
@property(strong,nonatomic) NSString *service;//客服电话
@property(strong,nonatomic) BUImageRes *signPicture;
@property(strong,nonatomic) NSString *leaseRules;
//@property(nonatomic) BOOL isGuideForStartPage;
@property(strong,nonatomic) NSString *email;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) BUImageRes *goodsDefaultPic;
@property(strong,nonatomic) NSString *leaseService;

//old
@property(strong,nonatomic) BUImageRes *userImage;
@property(strong,nonatomic) BUImageRes *logoUrl;
@property(strong,nonatomic) NSString *adImage;
@property(strong,nonatomic) NSString *inviteContent;
//@property(strong,nonatomic) NSString *service;
//@property(strong,nonatomic) NSString *aboutUs;
@property(strong,nonatomic) NSString *shareUrl;
@property(nonatomic) NSInteger payLimit;
@property(nonatomic) NSInteger secondaryIntegral;
@property(nonatomic) NSInteger integralExchange;




//@property(nonatomic) CGFloat withdrawMin;
//@property(strong,nonatomic) NSString *createTime;
//@property(strong,nonatomic) NSString *aboutUs;
//@property(strong,nonatomic) NSString *topColor1;
//@property(nonatomic) NSInteger drawPercentage1;
//@property(nonatomic) CGFloat withdrawAddupMax;
//@property(strong,nonatomic) NSString *customerService;
//@property(strong,nonatomic) NSString *userAgreement;
//@property(strong,nonatomic) NSString *operTime;
//@property(strong,nonatomic) BUImageRes *pottersImage;
//@property(strong,nonatomic) NSString *pottersName;
//@property(strong,nonatomic) NSString *hintExamCard;
//@property(nonatomic) NSInteger drawPercentage2;
//@property(strong,nonatomic) BUImageRes *identityImage;
//@property(strong,nonatomic) NSString *hintCourse;
//@property(strong,nonatomic) NSString *inviteContent;
//@property(strong,nonatomic) BUImageRes *teaSpecialistImage;
//@property(strong,nonatomic) NSString *topColor2;
//@property(strong,nonatomic) NSString *hintIdentity;
//@property(strong,nonatomic) NSString *bottomColor;
//@property(strong,nonatomic) BUImageRes *hintAuthentication;
//@property(strong,nonatomic) NSString *ssiId;
//@property(strong,nonatomic) NSString *hintTeaSpecialist;
//@property(strong,nonatomic) NSString *teaSpecialistName;
//@property(nonatomic) CGFloat withdrawMax;
//@property(strong,nonatomic) NSString *hintExam;
//@property(strong,nonatomic) NSString *identityName;
//@property(strong,nonatomic) NSString *hintPotters;
@end


@interface BUSign :BUBase
@property(nonatomic) NSInteger isDaySigin;
@property(nonatomic) NSInteger monthDay;
@property(strong,nonatomic) NSArray *signinPrize;
-(NSDictionary*)getDic;
@end

@interface BUSignInfo :BUBase
@property(strong,nonatomic) NSString *effectime;
@property(nonatomic) NSInteger totalCount;
@property(nonatomic) NSInteger status;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *code;
@property(strong,nonatomic) NSString *couponId;
@property(nonatomic) NSInteger limitget;
@property(nonatomic) NSInteger exceedType;
@property(strong,nonatomic) NSString *exceedTime;
@property(strong,nonatomic) NSString *operTime;
@property(nonatomic) NSInteger day;
@property(nonatomic) NSInteger isReceive;
@property(nonatomic) NSInteger type;
@property(nonatomic) NSInteger exceedDay;
@property(strong,nonatomic) NSString *scopeName;
@property(nonatomic) NSInteger getThreshold;
@property(nonatomic) NSInteger scope;
@property(strong,nonatomic) NSString *adminId;
@property(strong,nonatomic) NSString *starTime;
@property(nonatomic) CGFloat price;
@property(strong,nonatomic) NSString *remark;
@property(nonatomic) CGFloat threshold;
@property(strong,nonatomic) NSString *createTime;
-(NSDictionary*)getDic;
@end

@interface BUUserAlreadyAuthList:BUBase
@property(nonatomic,strong)NSArray *companyAuth;
@property(nonatomic,strong)NSArray *employAuth;
@property(nonatomic,strong)NSArray *ownerAuth;
@property(nonatomic,strong)NSArray *renterAuth;
@property(nonatomic,strong)NSString* realName;
@property(nonatomic,strong)NSString* identity;
@property(nonatomic)NSInteger  statue;
@end

@interface BUSysUserAgreement:BUBase
@property(strong,nonatomic) NSString *suaId;
@property(strong,nonatomic) NSString *content;
@property(strong,nonatomic) NSString *createTime;
@end


@interface BUUserAddress:BUBase

@property(strong,nonatomic) NSString *longitude;
//@property(strong,nonatomic) NSString *provName;
@property(strong,nonatomic) NSString *latitude;
//@property(strong,nonatomic) NSString *detail;


@property(strong,nonatomic) NSString *areaId;
@property(strong,nonatomic) NSString *cityName;
@property(strong,nonatomic) NSString *postcode;
@property(nonatomic) NSInteger isDefault;
@property(strong,nonatomic) NSString *addressId;
@property(strong,nonatomic) NSString *userName;
@property(strong,nonatomic) NSString *address;
@property(strong,nonatomic) NSString *areaName;
@property(strong,nonatomic) NSString *provinceName;
@property(strong,nonatomic) NSString *tel;
@property(strong,nonatomic) NSString *provinceId;
@property(strong,nonatomic) NSString *floor;
@property(strong,nonatomic) NSString *cityId;

-(NSDictionary*)getDic:(NSInteger)index;
@end


@interface BUAbout:BUBase
@property(strong,nonatomic) NSString *sveId;
@property(strong,nonatomic) NSString *createTime;
@property(strong,nonatomic) NSString *content;
@property(strong,nonatomic) NSString *downloadPath;
@property(strong,nonatomic) NSString *version;
@end
@interface BUUserAuth:BUBase
@property(strong,nonatomic) BUImageRes *identityPositive;
@property(strong,nonatomic) NSString *identity;
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) BUImageRes *identityBack;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *authFail;
@property(nonatomic) NSInteger certType;
@property(strong,nonatomic) NSString *certAddress;
@property(strong,nonatomic) NSString *certTime;
@property(strong,nonatomic) NSString *certName;
@end
@interface BUUserAcinfo:BUBase
@property(strong,nonatomic) NSString *contentTime;
@property(strong,nonatomic) NSString *content;
@end


@interface BUUserInfo : BUBase
@property(nonatomic) NSInteger state;
@property(strong,nonatomic) NSString *userName;
@property(strong,nonatomic) BUImageRes *headImage;
@property(nonatomic) NSInteger sex;
@property(strong,nonatomic) NSString *mobile;
//@property(nonatomic) CGFloat cardBalance;
@property(nonatomic) NSInteger type;
//@property(strong,nonatomic) NSString *cardNo;
//@property(assign,nonatomic) NSInteger isAuth;
@property(nonatomic) CGFloat balance;

@property(strong,nonatomic) NSString *expiryDate;
@property(strong,nonatomic) NSString *userId;
@property(strong,nonatomic) NSString *nickName;
//@property(strong,nonatomic) NSString *userName;
@property(strong,nonatomic) NSString *birthday;
//@property(strong,nonatomic) NSString *CourierId;
@property(nonatomic) NSInteger integral;
@property(nonatomic) NSInteger point;
@property(strong,nonatomic) NSString *tel;
@property(nonatomic)NSInteger msgCount;
@property(strong,nonatomic) NSString *isPotters;
@property(nonatomic) NSInteger hasPayPassword;
@property(strong,nonatomic) NSString *shareUrl;
//@property(strong,nonatomic) BUImageRes *shareQRCode;
//@property(strong,nonatomic) NSString *payCode;
@property(strong,nonatomic) BUImageRes *payCodeImage;
-(NSDictionary *)getUserAcinfoDic:(NSInteger)index;
@property(strong,nonatomic) BUImageRes *halfBodyImage;
@property(strong,nonatomic) BUImageRes *identitycationImage;
@end

@interface BUBespokeCity :BUBase
@property(strong,nonatomic) NSString *aid;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *parentId;
@end

@interface BUHelp : BUBase
@property(strong,nonatomic) NSString *hid;
@property(strong,nonatomic) NSString *title;
@property(strong,nonatomic) NSString *content;
@property(strong,nonatomic) NSString *typeName;
-(NSDictionary *)getDic;
@end
@interface BUCourier : BUBase
@property(strong,nonatomic) NSString *realName;
@property(strong,nonatomic) NSString *serviceArea;
@property(strong,nonatomic) NSString *courierId;
@property(strong,nonatomic) NSString *distance;
@property(strong,nonatomic) NSString *longitude;
@property(strong,nonatomic) NSArray *imageList;
@property(strong,nonatomic) NSString *intro;
@property(strong,nonatomic) NSString *telephone;
@property(strong,nonatomic) BUImageRes *imagePath;
@property(nonatomic) NSInteger serviceCount;
@property(strong,nonatomic) NSString *stationId;
@property(nonatomic) CGFloat income;
@property(nonatomic) CGFloat balance;
@property(strong,nonatomic) NSString *latitude;
-(NSDictionary *)getDic:(NSInteger)index;
@end

@interface BUGetUserIndex : BUBase
@property(strong,nonatomic) BUCourier *courier;
@property(strong,nonatomic) BUUserInfo *myUser;
@property(nonatomic) NSInteger hasMsg;
@property(nonatomic) NSInteger waitForPay;
@property(nonatomic) NSInteger waitForComment;
@property(nonatomic) NSInteger dustbinCount;
@property(nonatomic) NSInteger afterSales;
@property(nonatomic) NSInteger secondhandCount;
@property(nonatomic) NSInteger waitForFinish;
@property(nonatomic) NSInteger collectCount;
@property(nonatomic) NSInteger myExpress;
@property(nonatomic)BOOL isCourier;
@end

@interface BUUserList : BUBase
@property(strong,nonatomic) NSString *userHead;
@property(strong,nonatomic) NSString *nickName;
@property(strong,nonatomic) NSString *userName;
@property(nonatomic) NSInteger integral;
@property(nonatomic) NSInteger ranking;
@property(nonatomic,strong)NSIndexPath *indexPath;
-(NSDictionary*)getDic;
@end
@interface BUGetIntegralRanking : BUBase
@property(nonatomic) NSInteger integral;
@property(nonatomic) NSInteger ranking;
@property(strong,nonatomic) NSArray *userList;
-(NSDictionary *)getDic;
@end

//代理商对象类。
@interface BUAgent : BULCManager
@property(strong,nonatomic)NSArray * getFindArr;
@property(strong,nonatomic)NSArray *foundSlishowArr;
@property(strong,nonatomic)BUGetMyIndex *getMyIndex;
@property(nonatomic) NSInteger isDaySigin;//是否签到
@property(strong,nonatomic) BUImageRes *img;
@property(strong,nonatomic) BUImageRes *adImg;
@property(strong,nonatomic) NSArray *adImgList;//引导页
@property(strong,nonatomic) NSString *idCard;
@property(strong,nonatomic) NSString *trueName;
@property(nonatomic) NSInteger isCredit;
@property(assign,nonatomic) CGFloat creditMoney;
//@property(nonatomic) NSInteger sex;
@property(strong,nonatomic) NSString *nickName;
@property(nonatomic)BOOL canPush;
@property (nonatomic,strong) BUAddress *address;
@property(nonatomic,strong) NSString *storeId;
@property(nonatomic) NSInteger type;//判断认证
@property(nonatomic) NSString *cardNo;
@property(nonatomic) NSString *tel;
@property(nonatomic) NSString *token;
@property(nonatomic) NSString *Phone;          //账号--手机号
@property(nonatomic) NSString *password;        //密码
@property(nonatomic) NSString *userId;
@property(nonatomic) NSString *AreaId;
@property(nonatomic) NSString *userName;
@property(strong,nonatomic) NSString *Name; //昵称
@property(strong,nonatomic) NSString *email;    //邮箱
@property(strong,nonatomic) BUImageRes *Image;   //用户头像
@property(strong,nonatomic) NSString *mobile;   //手机号
//@property(assign,nonatomic) NSInteger Type; //1---用户 2---站长
@property(assign,nonatomic) NSInteger Area; //地区ID
@property(assign,nonatomic) NSInteger sex; //性别 0：男 1：女
@property(strong,nonatomic) NSArray *imgArr;
@property(strong,nonatomic) NSMutableArray *guidePageArr;
@property(strong,nonatomic)BUUserAddress *userDefaultAddress;
@property(strong,nonatomic) NSString *avatar;
@property(strong,nonatomic) NSString *expiryDate;
//@property(strong,nonatomic) NSString *nikeName;
@property(strong,nonatomic) NSString *birthday;
@property(nonatomic) BOOL isFirstOrder;
@property(nonatomic) BOOL isVip;
@property(strong,nonatomic)BUGetIntegralRanking *integralRanking;
@property(nonatomic) NSInteger RetCode;
@property(nonatomic) NSString *RetMsg;
@property(nonatomic) NSString *AreaName;
@property(nonatomic,assign) NSInteger cityId;
@property(nonatomic,strong) NSString *cityName;//当前所在城市
@property(nonatomic,assign) NSInteger AllowPush;//是否推送 1：可以 0：不可以
@property(nonatomic) BUUserAuth *userAuth;
@property(nonatomic,strong)BURegisterModel *regModel;//注册参数模型
@property(nonatomic) NSString *serviceTel;              //客服电话
@property(nonatomic) NSString *LocationCityName;//2级定位城市
@property(nonatomic) NSString *log;
@property(nonatomic) NSString *lat;
@property(nonatomic) NSString *timeStr;    //时间戳
@property(nonatomic) NSString *random;     //随机码
@property(nonatomic) BOOL isLogin;              //是否已经登录
@property(nonatomic) BOOL isCancel;             //是否已经注销
@property(nonatomic) BUUserInfo *userInfo;
//@property(nonatomic) BUUserInfo *otherUserInfo;
@property(nonatomic) NSString *userAuthType;
@property(nonatomic) BUAbout *about;
@property(nonatomic) NSArray *getTell;
@property(nonatomic) NSString *codeResult;
@property(nonatomic,strong)BUSysUserAgreement *sysUserAgreement;
@property(nonatomic) BOOL isNeedRefreshTabA;//是否刷新各个tab首页页面
@property(nonatomic) BOOL isNeedRefreshTabB;
@property(nonatomic) BOOL isNeedRefreshTabC;
@property(nonatomic) BOOL isNeedRefreshTabD;
@property(nonatomic) BOOL isPush;
@property(nonatomic,strong) NSDictionary *pushInfo;
@property(nonatomic,strong) NSString *shareData;
@property(nonatomic,strong)BUUserAlreadyAuthList *userAlreadyAuthList;
@property(nonatomic,strong)NSArray *userAddresses;
@property(nonatomic,strong)NSArray *getUserGiftCardList;
@property(nonatomic,strong)BUSign *signInfo;
//@property(nonatomic,strong)BUSign *sign;
@property(nonatomic,strong)NSArray *cityArr;//专属城市
@property(nonatomic,strong)NSArray *imgCerArr;
@property(nonatomic,strong)NSArray *takeSelfAddressArr;//自提地址
@property(nonatomic,strong) BUGetInfoConfig *config;//系统消息配置
@property(nonatomic,strong)BUGetIntegralConfig *integralConfig;
@property(nonatomic,strong)BUGetUserIndex *getUserIndex;
//@property(nonatomic) BUAbout *aboutData;
//================//

-(NSString*)getSign;
-(NSString *)md5code;
//登陆
-(BOOL)login:(NSString*)userId  password:(NSString*)password  observer:(id)observer callback:(SEL)callback;
-(BOOL)mobileLogin:(NSString*) smsCode withMobile:(NSString*) mobile observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)mobileLogin:(NSString*) smsCode withMobile:(NSString*) mobile observer:(id)observer callback:(SEL)callback;
//忘记密码
-(BOOL)forgetPwd:(NSString*)tel  code:(NSString*)code withPwd:(NSString*)pwd  observer:(id)observer callback:(SEL)callback;

//判断用户名
-(BOOL)checkUserName:(NSString*)Username observer:(id)observer callback:(SEL)callback;

//三方登陆
-(BOOL) thirdLogin:(NSString *)accessToken userName:(NSString *)username auth:(NSString *) auth observer:(id)observer callback:(SEL)callback;

//用户注册
-(BOOL)registerUser:(NSString *)tel withPwd:(NSString *)pwd withCode:(NSString *)code observer:(id)observer callback:(SEL)callback;
;

//退出登录
-(BOOL)logout:(id)observer callback:(SEL)callback;



//密码修改，passwordType == BUMODIFYTYPE 0修改密码 ，1忘记密码，3：手机绑定
-(BOOL)passwordModify:(NSString *)mobile  oldPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword observer:(id)observer callback:(SEL)callback;

//获取验证码
-(BOOL)sendSms:(NSString *)tel  observer:(id)observer callback:(SEL)callback;

//验证验证码
-(BOOL)checkVerify:(NSString *)Phone Verify:(NSString *)Verify observer:(id)observer callback:(SEL)callback;

//修改头像
//-(BOOL)chageLogo:(NSString *)logoName logoData:(NSData *)logoData  observer:(id)observer callback:(SEL)callback;

//修改头像
-(BOOL)chageLogo:(UIImage *)img  observer:(id)observer callback:(SEL)callback;

//修改用户资料
-(BOOL) changeUserInfoType:(NSInteger)type  observer:(id)observer callback:(SEL)callback;

//修改密码  
-(BOOL) updatePwdByForget:(NSString *)pwd Npwd:(NSString *)Npwd observer:(id)observer callback:(SEL)callback;

-(BOOL)changePassword:(NSString*) oldPassword withUserid:(NSString*) userId withNewpassword:(NSString*) newPassword observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)changePassword:(NSString*) oldPassword withUserid:(NSString*) userId withNewpassword:(NSString*) newPassword observer:(id)observer callback:(SEL)callback;
//推送设置
-(BOOL) pushSetStatus:(NSInteger)Status observer:(id)observer callback:(SEL)callback;


-(BOOL) getUserAgreement:(id)observer callback:(SEL)callback;
-(BOOL) getGuidePage:(id)observer callback:(SEL)callback;

-(BOOL) feedBack:(NSString *)tel withContent:(NSString *)content  withType:(NSString *)type  observer:(id)observer callback:(SEL)callback;
-(BOOL) updatePUV:(NSString *)stoid  observer:(id)observer callback:(SEL)callback;

-(BOOL) getUserInfo:(NSString *)tel  observer:(id)observer callback:(SEL)callback;

-(BOOL) updateUserInfo:(NSString *)userId withNickName:(NSString *)nickname withHeadImg:(NSString *)img withSex:(NSString *)sex withBirthDay:(NSString*)birthday  observer:(id)observer callback:(SEL)callback;

-(BOOL) changeHeadImage:(NSString *)tel withImage:(UIImage *)img observer:(id)observer callback:(SEL)callback;

-(BOOL) getOtherUserInfo:(NSString *)tel  observer:(id)observer callback:(SEL)callback;

//-(BOOL) getUserAuth:(NSString *)tel  observer:(id)observer callback:(SEL)callback;

-(BOOL) updateUserAuth:(NSDictionary *)dataDic withImgs:(NSArray *)imgarr  observer:(id)observer callback:(SEL)callback;

-(BOOL) getUserAuthType:(NSString *)tel withSapid:(NSString *)sapid observer:(id)observer callback:(SEL)callback  extro:(id)ext;
-(BOOL) getAbout:(id)observer callback:(SEL)callback;
-(BOOL) getTell:(NSString *)sapid  observer:(id)observer callback:(SEL)callback;
-(BOOL) getUserCodeState:(NSString *)tel withCode:(NSString *)code observer:(id)observer callback:(SEL)callback;

-(BOOL) getShare:(NSString *)sapid withEntityid:(NSString *)entityid withType:(NSString*)type observer:(id)observer callback:(SEL)callback;
-(BOOL) getUserAddress:(NSString *)uid  observer:(id)observer callback:(SEL)callback;
-(BOOL) changeUserPassword:(NSString *)type  withOldPwd:(NSString*)oldPwd withNewPwd:(NSString*)newPwd   observer:(id)observer callback:(SEL)callback;

-(BOOL) updateUserAddress:(NSString *)addrid withContacts:(NSString*)contact withTel:(NSString*)tel  withProvinceName:(NSString*)provinceName withCityName:(NSString*)cityName  withAreaName:(NSString*)areaName withAddress:(NSString*)address withIsDefault:(NSString*)isDefault withLongitude:(NSString *)longitude withLatitude:(NSString *)latitude detail:(NSString *)detail observer:(id)observer callback:(SEL)callback;

-(BOOL) getUserGiftCardList:(id)observer callback:(SEL)callback;

-(BOOL) delUserGiftCard:(NSString *)cardId  observer:(id)observer callback:(SEL)callback;

-(BOOL) cardBind:(NSString *)cardPwd withCardNo:(NSString*)cardNo observer:(id)observer callback:(SEL)callback;
-(BOOL) cardRecharge:(NSString *)cardPwd withCardNo:(NSString*)cardNo observer:(id)observer callback:(SEL)callback;

-(BOOL) getSignInfo:(id)observer callback:(SEL)callback;
-(BOOL) addSign:(id)observer callback:(SEL)callback;
-(BOOL) checkPayPassword:(NSString *)pwd  observer:(id)observer callback:(SEL)callback;
-(BOOL) checkSmsCode:(NSString *)code  observer:(id)observer callback:(SEL)callback;
-(BOOL)getHelpList:(id)observer callback:(SEL)callback;
-(BOOL)getHelpDetail:(NSString *)Id observer:(id)observer callback:(SEL)callback;
-(BOOL)delUserAddress:(NSString*) aid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)delUserAddress:(NSString*) aid observer:(id)observer callback:(SEL)callback;
-(BOOL)setDefaultUserAddress:(NSString*) aid  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)setDefaultUserAddress:(NSString*) aid  observer:(id)observer callback:(SEL)callback;
-(BOOL)uploadImg:(UIImage *)img withType:(NSString *)type withId:(NSString *)aid observer:(id)observer callback:(SEL)callback;
//-(BOOL)uploadImgCer:(UIImage *)img  observer:(id)observer callback:(SEL)callback;//证书上传接口
//-(BOOL)test:(NSString *)tel  observer:(id)observer callback:(SEL)callback;


//上传图片
@property (nonatomic,strong) NSArray *imgsList;
-(BOOL)uploadImgs:(NSArray*)imgs observer:(id)observer callback:(SEL)callback;


//-(BOOL)delImageFile:(NSString*) entityId withImagepath:(NSString*) imagePath  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

//自提地址
-(BOOL)getSinceAddressList:(id)observer callback:(SEL)callback;
//系统消息配置
-(BOOL)getInfoConfig:(id)observer callback:(SEL)callback;

-(BOOL)getIntegralConfig:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getIntegralConfig:(id)observer callback:(SEL)callback;

//添加用户积分
@property (nonatomic,strong) NSString *adduserPoint;

//检查接口授权
-(BOOL)checkAuth:(id)observer callback:(SEL)callback;


-(BOOL)getUserIndex:(NSString*) sid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)getUserIndex:(NSString*) sid observer:(id)observer callback:(SEL)callback;

-(BOOL)saveUser:(NSString*) headImage withNickname:(NSString*) nickName withUserid:(NSString*) userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)saveUser:(NSString*) headImage withNickname:(NSString*) nickName withUserid:(NSString*) userId  observer:(id)observer callback:(SEL)callback;

-(BOOL)getIntegralRanking:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getIntegralRanking:(NSString*) userId observer:(id)observer callback:(SEL)callback;

-(BOOL)getUserDefaultAddress:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getUserDefaultAddress:(NSString*) userId observer:(id)observer callback:(SEL)callback;
-(BOOL)thirdLogin:(NSString*) userHead withNickname:(NSString*) nickName withUid:(NSString*) uid withType:(NSString*) type observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)thirdLogin:(NSString*) userHead withNickname:(NSString*) nickName withUid:(NSString*) uid withType:(NSString*) type observer:(id)observer callback:(SEL)callback;
//
//-(BOOL)userBindMobile:(NSString*) password withSmscode:(NSString*) smsCode withMobile:(NSString*) mobile withUserid:(NSString*) userId withType:(NSString *)type observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
//-(BOOL)userBindMobile:(NSString*) password withSmscode:(NSString*) smsCode withMobile:(NSString*) mobile withUserid:(NSString*) userId withType:(NSString *)type observer:(id)observer callback:(SEL)callback;
-(BOOL)getMyIndex:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getMyIndex:(NSString*) userId observer:(id)observer callback:(SEL)callback;
-(BOOL)upUserInfo:(NSString*) userId withTypeMsg:(NSString *)typeMsg withData:(NSString *)data observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)upUserInfo:(NSString*) userId withTypeMsg:(NSString *)typeMsg withData:(NSString *)data observer:(id)observer callback:(SEL)callback;

-(BOOL)userAddress:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)userAddress:(NSString*) userId observer:(id)observer callback:(SEL)callback;
-(BOOL)addandUpAddress:(NSString*) userId withCityid:(NSString*) cityId withUsername:(NSString*) userName withAddressid:(NSString*) addressId withProvinceid:(NSString*) provinceId withAreaid:(NSString*) areaId withAddress:(NSString*) address withFloor:(NSString*) floor withIsdefault:(NSString*) isDefault withTel:(NSString*) tel observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)addandUpAddress:(NSString*) userId withCityid:(NSString*) cityId withUsername:(NSString*) userName withAddressid:(NSString*) addressId withProvinceid:(NSString*) provinceId withAreaid:(NSString*) areaId withAddress:(NSString*) address withFloor:(NSString*) floor withIsdefault:(NSString*) isDefault withTel:(NSString*) tel observer:(id)observer callback:(SEL)callback;
-(BOOL)upMsgState:(NSString*) state withInformationid:(NSString*) informationId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)upMsgState:(NSString*) state withInformationid:(NSString*) informationId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;

-(BOOL)addFeed:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)addFeed:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;

-(BOOL)geTadvertising:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)geTadvertising:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;
//引导页
-(BOOL)getSliGuide:(id)observer callback:(SEL)callback;
-(BOOL)getSliGuide:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;

-(BOOL)getFoundSlishow:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getFoundSlishow:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;
-(BOOL)getFind:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)getFind:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback;
-(BOOL)upCount:(NSString*) msg withDataId:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo;
-(BOOL)upCount:(NSString*) msg withDataId:(NSString*) userId observer:(id)observer callback:(SEL)callback;
@end
