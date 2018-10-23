
#import "BUAgent.h"
#import "BUSystem.h"
//#import "JPUSHService.h"
@implementation BUGetFind
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"userList":@"BUUserList,userList"};

     }
     return self;
}
-(NSDictionary*)getDic:(NSInteger)row
{
     if (row == 0) {
          return @{@"title":_title?:@""};
     }
     else if (row == 1)
     {
          return @{@"title":_subtitle?:@""};
     }
     else if (row == 2)
     {
          return @{@"img":_img?:@"defaultBanner",@"default":@"defaultBanner"};
     }
     else
     {
          return @{@"title":@"",@"detail":[NSString stringWithFormat:@"阅读次数：%ld",_clickCount]};
     }
}
@end
@implementation BUFoundSlishow
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"userList":@"BUUserList,userList"};

     }
     return self;
}
+(NSDictionary *)getArrDicWithThisArr:(NSArray*)arr
{
     NSMutableArray *tarr = [NSMutableArray new];
     [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          BUFoundSlishow *cc = obj;
          [tarr addObject:@{@"img":cc.img?:@"banner"}];
     }];
     return @{@"arr":tarr};
}
@end

@implementation BUGetMyIndex

@end

@implementation BUUserList
-(NSDictionary *)getDic
{
     NSString *name = _nickName;
     if (!name || [name isEqualToString:@""]) {
          name = _userName;
          if (name.length > 8) {
               name = [name stringByReplacingOccurrencesOfString:[name substringWithRange:NSMakeRange(3, 4)] withString:@"****"];
          }
          
     }
     return @{@"title":name?:@"",@"img":_userHead?:@"defaultHead",@"time":[NSString stringWithFormat:@"%ld",_integral],@"row":@(_indexPath.row+1),@"default":@"defaultHead"};
}
@end

@implementation BUGetIntegralRanking
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"userList":@"BUUserList,userList"};

     }
     return self;
}

-(NSDictionary *)getDic
{
     NSString *name = busiSystem.agent.userInfo.userName;
     if (!name || [name isEqualToString:@""]) {
          name = busiSystem.agent.userInfo.mobile;
     }
     return @{@"title":name?:@"",@"img":@"pointRkBg",@"source":[NSString stringWithFormat:@"%ld分",_integral],@"time":[NSString stringWithFormat:@"排名：%ld名",_ranking]};
}
@end

@implementation BUCourier

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"imageList":@"BUImageRes,imageList"};

     }
     return self;
}

-(NSDictionary *)getDic:(NSInteger)index{
     if (index == 0) {
          NSString *str = [NSString stringWithFormat:@"服务%ld次",(long)_serviceCount];
          NSString *str1 = [NSString stringWithFormat:@"跑腿半径: %@",_serviceArea];
          NSString *str2 = [NSString stringWithFormat:@"%@",_distance];
          return  @{@"img":_imagePath?:@"default",@"default":@"default",@"title":_realName?:@"",@"source":str,@"time":str1,@"distant":str2};
     }
     else if(index == 1){
          NSMutableArray *arr = [NSMutableArray new];
          [_imageList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               [arr addObject:@{@"img":obj?:[BUImageRes new]}];
          }];
          return @{@"arr":arr};
          
     }
     else if (index == 2){
          NSString *str = [NSString stringWithFormat:@"服务%ld次",(long)_serviceCount];
          NSString *str1 = @"";//[NSString stringWithFormat:@"跑腿半径: %@",_serviceArea];
          NSString *str2 = [NSString stringWithFormat:@"%@m",_distance];
          return @{@"img":@"icon_location",@"title":_realName?:@"",@"source":str1,@"time":str,@"distant":str2};
     }
     return @{};
}
@end

@implementation BUGetUserIndex

-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"myUser":@"BUUserInfo,myUser",@"courier":@"BUCourier,courier"};

     }
     return self;
}

-(void)setMyUser:(BUUserInfo *)myUser
{
     _myUser = myUser;
     busiSystem.agent.userInfo = _myUser;
}

@end

@implementation BUAddressNameAndId
-(id)init
{
    self = [super init];
    if(self){
        self.deserializationMap = @{@"id":@"NSString,aid"};
    }
    return self;
}
@end

@implementation BUSinceAddress
@end

@implementation BUHelp
-(id)init
{
    self = [super init];
    if(self){
        self.deserializationMap = @{@"id":@"NSString,hid",@"name":@"NSString,title"};
    }
    return self;
}
-(NSDictionary *)getDic{
    NSString *q = [NSString stringWithFormat:@"%@",_title?:@""];
//    NSString *a = [NSString stringWithFormat:@"A:%@",[_content stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]?:@""];
    return @{@"title":q};
}

@end


@implementation BUGetIntegralConfig
-(id)init
{
    self = [super init];
    if(self){
        self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
    }
    return self;
}
@end


@implementation BUGetInfoConfig
-(id)init
{
    self = [super init];
    if(self){
         self.deserializationMap = @{@"BUImageRes":@"BUImageRes",@"hotKeywordList":@"NSString,hotKeywordList"};
    }
    return self;
}

//-(void)setLogoUrl:(BUImageRes *)logoUrl
//{
//     _logoUrl = logoUrl;
//     [logoUrl download:nil callback:nil extraInfo:nil];
//}
@end


@implementation BUSign
-(id)init
{
     self = [super init];
     if(self){
          self.deserializationMap = @{@"signinPrize":@"BUSignInfo,signinPrize"};
     }
     return self;
}

-(NSDictionary*)getDic
{
     return @{@"title":[NSString stringWithFormat:@"您本月已签到%ld次",(long)_monthDay]};
}

@end


@implementation BUSignInfo

-(NSDictionary*)getDic
{
     return @{@"title":_title?:@"",@"detail":[NSString stringWithFormat:@"累计签到%ld天即可自动获取",(long)_day],@"state":_isReceive == 0?@"未获得": @"已获得",@"isGet":@(_isReceive == 1)};
}
@end

@implementation BUBespokeCity
-(id)init
{
    self = [super init];
    if(self){
        self.deserializationMap = @{@"id":@"NSString,aid"};
    }
    return self;
}
@end


@implementation BUUserAlreadyAuthList
-(id)init
{
    self = [super init];
    if(self){
        self.deserializationMap = @{@"companyAuth":@"BUCreateUserAuth,companyAuth",@"employAuth":@"BUCreateUserAuth,employAuth",@"ownerAuth":@"BUCreateUserAuth,ownerAuth",@"renterAuth":@"BUCreateUserAuth,renterAuth"};
    }
    return self;
}
@end


@implementation BUSysUserAgreement
@end


@implementation BUUserAddress

-(id)init
{
    self = [super init];
    if(self){
        self.deserializationMap = @{@"id":@"addrId",@"eadId":@"addrId"};
    }
    return self;
}

-(NSDictionary *)getDic:(NSInteger)index
{
     if (index == 0) {
          NSString *tel = [_tel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
          NSString *adrDetail = [NSString stringWithFormat:@"%@%@%@%@%@",_provinceName,_cityName,_areaName,_address,_floor];
          return    @{@"name":[NSString stringWithFormat:@"%@  %@",_userName ?:@"",tel],@"phone":@"",@"address":adrDetail};
     }
     
     else if(index == 1){
          NSString *tell = _tel?:@"";
          if (_tel.length == 11) {
               tell = [_tel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
          }
          NSString *title = [NSString stringWithFormat:@"%@ %@",_userName?:@"",tell];
          NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@",_provinceName,_cityName,_areaName,_address,_floor];
          if (_isDefault == 1) {
               return   @{@"title":title,@"source":@"默认",@"time":address};
          }else{
               return   @{@"title":title,@"time":address};
          }
          
     }
     
     else if(index == 5){
          NSString *tell = _tel?:@"";
//          if (_tel.length == 11) {
//               tell = [_tel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
//          }
          NSString *title = [NSString stringWithFormat:@"%@ %@",_userName?:@"",tell];
          NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@",_provinceName,_cityName,_areaName,_address,_floor];
//         if (_isDefault == 1) {
//              return   @{@"title":title,@"source":@"默认",@"time":address};
//         }else{
               return   @{@"title":title,@"time":address};
//         }
          
     }
     return @{};
}
//-(NSDictionary*)getDic:(NSInteger)index
//{
//    if (index == 0) {
//        NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@",_provinceName,_cityName,_areaName,_address,_detail];
//         return @{@"name":[NSString stringWithFormat:@"联系人:%@",_contacts?:@""],@"phone":_tell?:@"",@"address":address};
//    }else if(index == 1){
//        NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@",_provinceName,_cityName,_areaName,_address,_detail];
//         return @{@"title":[NSString stringWithFormat:@"联系人:%@",_contacts?:@""],@"source":_tell?:@"",@"time":address};
//    }else if(index == 2){
//        BOOL mark = NO;
//        if (_isDefault) {
//            mark = YES;
//        }
//         return @{@"name":[NSString stringWithFormat:@"联系人:%@",_contacts?:@""],@"phone":_tell?:@"",@"address":_address?:@"",@"mark":@(mark)};
//    }else if(index == 3){
//        NSString *address = [NSString stringWithFormat:@"%@%@%@%@",_provinceName,_cityName,_areaName,_address];
//         return @{@"title":[NSString stringWithFormat:@"联系人:%@",_contacts?:@""],@"source":_tell?:@"",@"time":_address};
//    }else if(index == 4){
//        BOOL mark = NO;
//        if (_isDefault) {
//            mark = YES;
//        }
//        NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@",_provName,_cityName,_areaName,_address,_detail];
//         return @{@"name":[NSString stringWithFormat:@"联系人:%@",_contacts?:@""],@"phone":_tell?:@"",@"address":address?:@"",@"mark":@(mark)};
//    }
//    else if(index == 5){
//         NSString *tell = _tel?:@"";
//         if (_tel.length == 11) {
//              tell = [_tel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
//         }
//         NSString *title = [NSString stringWithFormat:@"%@ %@",_userName?:@"",tell];
//         NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@",_provinceName,_cityName,_areaName,_address,_floor];
////         if (_isDefault == 1) {
////              return   @{@"title":title,@"source":@"默认",@"time":address};
////         }else{
//              return   @{@"title":title,@"time":address};
////         }
//
//    }
//    else if (index == 6){
//         NSString *tell = @"";
//         if (_tell.length == 11) {
//              tell = [_tell stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
//         }
//         NSString *title = [NSString stringWithFormat:@"%@ %@",_contacts,tell];
//         NSString *address = [NSString stringWithFormat:@"%@%@%@%@%@",_provinceName,_cityName,_areaName,_address,_detail];
//         return @{@"title":title,@"time":address};
//    }
//    return @{};
//}


@end


@implementation BUAbout

@end


@implementation BUUserAuth

- (id)init
{
    self = [super init];
    if (self) {
        
        self.deserializationMap = @{@"BUImageRes":@"BUImageRes"};
        
    }
    return self;
}
@end
@implementation BUUserAcinfo

@end

//@implementation BUGetUserGiftCard
//@end

@implementation BUUserInfo
- (id)init
{
    self = [super init];
    if (self) {
         
        self.deserializationMap = @{@"userAcinfo":@"BUUserAcinfo,userAcinfo",@"BUImageRes":@"BUImageRes"};
        
    }
    return self;
}
-(void)setUserId:(NSString *)userId
{
    _userId = userId;
    busiSystem.agent.userId = userId;
}
-(void)setNickName:(NSString *)nickName
{
     _nickName = nickName;
     busiSystem.agent.nickName = nickName;
}

-(void)setUserName:(NSString *)userName
{
     _userName = userName;
     busiSystem.agent.userName = userName;
}

//-(void)setCardNo:(NSString *)cardNo
//{
//    _cardNo = cardNo;
//    busiSystem.agent.cardNo = cardNo;
//}

-(void)setMobile:(NSString *)tel
{
     _mobile = tel;
    busiSystem.agent.tel = tel;
}
-(NSDictionary *)getUserAcinfoDic:(NSInteger)index
{
    //BUUserAcinfo *info = _userAcinfo[index];
    //NSString *time = [info.contentTime substringToIndex:MIN(10, info.contentTime.length)];
    return @{@"title":[NSString stringWithFormat:@"%@ 发表活动:%@",@"",@""]};
}
@end



@implementation BUAgent

- (id)init
{
    self = [super init];
    if (self) {
        _isLogin = NO;
         self.deserializationMap = @{@"Uid":@"userId",@"BUImageRes":@"BUImageRes",@"Area":@"cityId",@"mobile":@"tel"};
        _regModel =[BURegisterModel new];
//         self.canPush = YES;
    }
    return self;
}
-(void)setCanPush:(BOOL )canPush
{
     _canPush = canPush;
     [[NSUserDefaults standardUserDefaults] setObject:@(canPush) forKey:@"canPush"];
     [[NSUserDefaults standardUserDefaults]  synchronize];
}

-(void)setUserId:(NSString *)userId
{
    if (!_userId || [_userId isEqualToString:@""]) {
         busiSystem.agent.isLogin = NO;
    }
    else
    {
     busiSystem.agent.isLogin = YES;
    }
      _userId = userId;
 [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"kuserId"];
     [[NSUserDefaults standardUserDefaults]  synchronize];
}
-(void)setUserName:(NSString *)userName
{
     _userName = userName;
     [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
     [[NSUserDefaults standardUserDefaults]  synchronize];
}
-(void)setNickName:(NSString *)nickName
{
     _nickName = nickName;
     [[NSUserDefaults standardUserDefaults] setObject:nickName forKey:@"nickName"];
     [[NSUserDefaults standardUserDefaults]  synchronize];
}

-(void)setImg:(BUImageRes *)img
{
     _img = img;
     [[NSUserDefaults standardUserDefaults] setObject:img.Image forKey:@"img"];
     [[NSUserDefaults standardUserDefaults]  synchronize];
}

-(void)setCardNo:(NSString *)cardNo
{
    _cardNo = cardNo;
    [[NSUserDefaults standardUserDefaults] setObject:cardNo forKey:@"cardNo"];
     [[NSUserDefaults standardUserDefaults]  synchronize];
}

-(void)setPassword:(NSString *)password
{
    _password = password;
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}

-(void)setTel:(NSString *)tel
{
    _tel = tel;
    [[NSUserDefaults standardUserDefaults] setObject:tel forKey:@"tel"];
    [[NSUserDefaults standardUserDefaults]  synchronize];
}

-(void)setType:(NSInteger)type
{
    _type = type;
    [[NSUserDefaults standardUserDefaults] setObject:@(type) forKey:@"type"];
     [[NSUserDefaults standardUserDefaults]  synchronize];
}

-(void)setUserInfo:(BUUserInfo *)userInfo
{
    _userInfo = userInfo;
   // self.type = userInfo.type;
}

-(void)setToken:(NSString *)token
{
    if(!token)
    {
       
        _token = token;
//         [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"token"];
    }
    else{
//        busiSystem.agent.isLogin = YES;
        _token = token;
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
         [[NSUserDefaults standardUserDefaults]  synchronize];
    }
    
}

-(void)setIsLogin:(BOOL)isLogin
{
    if (!isLogin) {
//        _token = nil;
        _tel = nil;
        _isLogin = isLogin;
        _type = 0;
        _userId = nil;
//        [[NSUserDefaults standardUserDefaults] setObject:_token forKey:@"token"];
//        [[NSUserDefaults standardUserDefaults] setObject:_tel forKey:@"tell"];
//        [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:@"type"];
        self.isPush = NO;
//        [JPUSHService setTags:[NSSet setWithArray:@[]] alias:@"" callbackSelector:@selector(AliasCallback:tags:alias:) object:self];
    }
    else
    {
        self.isPush = YES;
//        [JPUSHService setTags:[NSSet setWithArray:@[@"1"]] alias:_tel callbackSelector:@selector(AliasCallback:tags:alias:) object:self];
        _isLogin = isLogin;
    }
}

-(void)setIsPush:(BOOL)isPush
{
    if (!isPush) {
        [self setPushInfo:@{@"arr":@[]}];
         [BUPushManager setTags:nil alias:@"" callbackSelector:@selector(AliasCallback:tags:alias:) object:self];
    }
    else
    {
        [self getPushInfo];
    }
    _isPush = isPush;
}

-(void)getPushInfo
{
//  [busiSystem.agent getUserAuth:busiSystem.agent.tel observer:self callback:@selector(getUserAuthNotification:)];
}

-(void)getUserAuthNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        if (busiSystem.agent.userAuth.state == 2) {
            [self getPushInfoList];
        }
        else
        {
               [self setPushInfo:@{@"arr":@[@"1"]}];
        NSArray *arr = self.pushInfo[@"arr"];
        [BUPushManager setTags:[NSSet setWithArray:arr] alias:_tel callbackSelector:@selector(AliasCallback:tags:alias:) object:self];
        }
    }
    else
    {
         [BUPushManager setTags:[NSSet setWithArray:@[@"1"]] alias:_tel callbackSelector:@selector(AliasCallback:tags:alias:) object:self];
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)getPushInfoList
{
    //[busiSystem.agent getUserAlreadyAuthList:_tel observer:self callback:@selector(getPushInfoNotification:)];
}

-(void)getPushInfoNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        NSMutableArray *marr = [NSMutableArray array];
        [marr addObject:@"1"];
        if(_userAlreadyAuthList.statue == 2)
        {
            [marr addObject:@"person"];
        }
        if(_userAlreadyAuthList.companyAuth.count > 0)//企业主
        {
            [marr addObject:@"boss"];
        }
        if(_userAlreadyAuthList.employAuth.count > 0)//员工
        {
            [marr addObject:@"employ"];
        }
        if(_userAlreadyAuthList.renterAuth.count > 0)//租户
        {
            [marr addObject:@"renter"];
        }
        if(_userAlreadyAuthList.ownerAuth.count > 0)//业主
        {
            [marr addObject:@"owner"];
        }
        [self setPushInfo:@{@"arr":marr}];
        NSArray *arr = self.pushInfo[@"arr"];
        [BUPushManager setTags:[NSSet setWithArray:arr] alias:_tel callbackSelector:@selector(AliasCallback:tags:alias:) object:self];
    }
    else
    {
         [BUPushManager setTags:[NSSet setWithArray:@[@"1"]] alias:_tel callbackSelector:@selector(AliasCallback:tags:alias:) object:self];
        HUDCRY(noti.error.domain, 1);
    }
}

-(void)setPushInfo:(NSDictionary *)pushInfo
{
    _pushInfo = pushInfo;
//    [[NSUserDefaults standardUserDefaults] setObject:pushInfo forKey:@"pushInfo"];
}

-(NSDictionary*)PushInfo
{
    if (!_pushInfo) {
        _pushInfo = @{@"arr":@[@"1"]};
    }
    return _pushInfo;
}

//-(void)setTel:(NSString *)tell
//{
//    _tel = tell;
//    [[NSUserDefaults standardUserDefaults] setObject:tell forKey:@"tell"];
//}

-(NSString *)AreaId
{
    return [NSString stringWithFormat:@"%ld",_Area];
}

-(void)setName:(NSString *)Name
{
    _Name = Name;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetUserName" object:nil];
}

#pragma mark --submit

//修改密码
-(BOOL) updatePwdByForget:(NSString *)tel Npwd:(NSString *)Npwd  observer:(id)observer callback:(SEL)callback
{
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(updatePwdByForgetInputPwd:Npwd:));
    [input setArgument:&tel atIndex:2];
    [input setArgument:&Npwd atIndex:3];
//    [input setArgument:&RePwd atIndex:4];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ACCOUNT,@""]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(passwordModifyOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSData *) updatePwdByForgetInputPwd:(NSString *)tel Npwd:(NSString *)Npwd
{
    NSString *url =[NSString stringWithFormat:@"tel=%@&pwd=%@&%@",tel,Npwd,[self getBaseUrlParem]];
     return [url dataUsingEncoding:NSUTF8StringEncoding];
}



-(BOOL) thirdLogin:(NSString *)accessToken userName:(NSString *)username auth:(NSString *) auth observer:(id)observer callback:(SEL)callback
{
    username = [username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *parameterStr = [NSString stringWithFormat:@"&openid=%@&username=%@&auth=%@",accessToken,username,auth];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",busiSystem.apiHost,BU_BUSINESS_authLogin,parameterStr]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(loginOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

static NSString *loginingUserId;
static NSString *loginingpassword;
//登录
-(BOOL)login:(NSString*)userId  password:(NSString*)password  observer:(id)observer callback:(SEL)callback
{
    if (self.isLogin)
        return [self sendLocalRequest:nil observer:observer action:callback extraInfo:nil];
    loginingUserId = userId;
    loginingpassword = [password md5String];
//  NSUserDefaults *du = [NSUserDefaults standardUserDefaults];
//    NSString *st = [du objectForKey:@"registrationID"];
//    if (!st||[st isEqualToString:@""]) {
////        st =  [APService registrationID];
//        [du setObject:st forKey:@"registrationID"];
//    }
   
//    NSString * str =[NSString stringWithFormat:@"?tel=%@&Pwd=%@&registrationID=%@",userId,loginingpassword];
 NSInvocation *input = BSGetInvocationFromSel(self, @selector(loginUserInput:userName:password:));
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_LOGIN,BU_BUSINESS_AccountLogin]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(loginOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSData *) loginUserInput:(NSString *)registrationID userName:(NSString *)userName password:(NSString *)password
{
    
    NSString * str =[NSString stringWithFormat:@"account=%@&pwd=%@&%@",loginingUserId,loginingpassword,[self getBaseUrlParem]];
    return [str dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(BOOL)mobileLogin:(NSString*) smsCode withMobile:(NSString*) mobile observer:(id)observer callback:(SEL)callback
{
     return [self mobileLogin: smsCode withMobile: mobile observer:observer callback:callback extraInfo:nil];
}

-(BOOL)mobileLogin:(NSString*) smsCode withMobile:(NSString*) mobile observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(mobileLoginInput: withMobile:));
     [input setArgument:&smsCode atIndex:2];
     [input setArgument:&mobile atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_LOGIN,BU_BUSINESS_TellLogin]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(mobileLoginOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)mobileLoginInput:(NSString*) smsCode withMobile:(NSString*) mobile
{
     NSString *request = [NSString stringWithFormat:@"code=%@&tell=%@&%@",smsCode,mobile,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)mobileLoginOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
      [(BSJSON *)[jsonObj objectForKey:@"data"] deserialization:self];
     return SuccessedError;

}

//登出
-(BOOL)logout:(id)observer callback:(SEL)callback
{
  /*  return [self sendRequest:[NSString stringWithFormat:@"%@%@&Uid=%@",busiSystem.apiHost,BU_BUSINESS_logout,busiSystem.agent.userId]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(logoutOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];*/
    return TRUE;

}

//推送设置
-(BOOL) pushSetStatus:(NSInteger)Status observer:(id)observer callback:(SEL)callback
{
    NSString *parameterStr = [NSString stringWithFormat:@"&Uid=%@&Status=%ld",busiSystem.agent.userId,(long)Status];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",busiSystem.apiHost,@"",parameterStr]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(pushSetOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSError *)pushSetOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    busiSystem.agent = [[BUAgent alloc] init];   //总是建立新的代理商。
     [RequestStatus setRequestResultStatus:jsonObj];
    return SuccessedError;
}

//用户注册
-(BOOL)registerUser:(NSString *)tel withPwd:(NSString *)pwd withCode:(NSString *)code observer:(id)observer callback:(SEL)callback;
{
//   NSString* inviteUserId = @"";
//    if (!img) {
        NSInvocation *input = BSGetInvocationFromSel(self, @selector(registerUserInput:withPwd:withCode:));
        //NSString *pwdMd5 = pwd.md5String;
        [input setArgument:&tel atIndex:2];
        [input setArgument:&pwd atIndex:3];
//        [input setArgument:&inviteUserId atIndex:4];
        [input setArgument:&code atIndex:4];
        [input retainArguments];
        return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_LOGIN,BU_BUSINESS_UserRegister]
                            head:nil
                          method:@"POST"
                           async:YES
                 inputInvocation:input
                outputInvocation:BSGetInvocationFromSel(self, @selector(registerUserOutput:ok:input:))
                        observer:observer
                          action:callback
                       extraInfo:nil];
//    }
//   else
//   {
//       NSData *imgdata = UIImageJPEGRepresentation([img imageByScalingToSize:CGSizeMake(160, 160)], 1);//(logoImg, 0.1);
//       NSMutableDictionary *dic = [NSMutableDictionary new];
//       //    dic[@"f1"] = @"f1";
//       dic[@"tel"] = tel;
//       dic[@"pwd"] = pwd;
//       dic[@"nickname"] = inviteUserId;
//       dic[@"smscode"] = code;
//       [dic addEntriesFromDictionary:[self getBaseUrlParemDic]];
//       return [self sendUploadRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_LOGIN,BU_BUSINESS_Register]
//                                 data:imgdata
//                             fileName:@"f1=f1.png"//[NSString stringWithFormat:@"file=%@accountId=%@&token=%@&%@",@"f1",_accountId,_token,[self getBaseUrlParem]]
//                     outputInvocation:BSGetInvocationFromSel(self, @selector(registerUserOutput:ok:input:))
//                             observer:observer
//                               action:callback
//                            extraInfo:dic];
//   }
}

-(NSData *) registerUserInput:(NSString *)tel withPwd:(NSString *)pwd  withCode:(NSString *)code
{
    NSString *request = [NSString stringWithFormat:@"mobile=%@&password=%@&smsCode=%@&%@",tel,[pwd md5String],code?:@"",[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
}

//修改密码
-(BOOL)passwordModify:(NSString *)Phone  oldPassword:(NSString*)Newpwd newPassword:(NSString*)RePwd observer:(id)observer callback:(SEL)callback
{

    NSInvocation *input = BSGetInvocationFromSel(self, @selector(passwordModifyInput:Npwd:RePwd:));
    [input setArgument:&Phone atIndex:2];
    [input setArgument:&Newpwd atIndex:3];
    [input setArgument:&RePwd atIndex:4];
    [input retainArguments];
            return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ACCOUNT,BU_BUSINESS_UpdateUserPwd]
                                head:nil
                              method:@"POST"
                               async:YES
                     inputInvocation:input
                    outputInvocation:BSGetInvocationFromSel(self, @selector(passwordModifyOutput:ok:input:))
                            observer:observer
                              action:callback
                           extraInfo:nil];
}

-(NSData *) passwordModifyInput:(NSString *)Phone Npwd:(NSString *)Newpwd RePwd:(NSString *)RePwd
{
    NSString *requestStr = [NSString stringWithFormat:@"tel=%@&oldpwd=%@&newpwd=%@",Phone,Newpwd,RePwd];
    return [requestStr dataUsingEncoding:NSUTF8StringEncoding];
}

//验证验证码
-(BOOL)checkVerify:(NSString *)Phone Verify:(NSString *)Verify observer:(id)observer callback:(SEL)callback
{
     
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(checkVerifyInput:Verify:));
     [input setArgument:&Phone atIndex:2];
     [input setArgument:&Verify atIndex:3];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",busiSystem.apiHost,BU_BUSINESS_GetSmsCode]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(sendSmsOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSData *)checkVerifyInput:(NSString *)Phone Verify:(NSString *)Verify
{
     NSString *requestStr = [NSString stringWithFormat:@"tel=%@&type=%@&%@",Phone,Verify,[self getBaseUrlParem]];
     return [requestStr dataUsingEncoding:NSUTF8StringEncoding];
}


//判断用户名
-(BOOL)checkUserName:(NSString*)Username observer:(id)observer callback:(SEL)callback
{
    return [self sendRequest:[NSString stringWithFormat:@"%@%@&Username=%@",busiSystem.apiHost,@"",[Username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:NULL
            outputInvocation:BSGetInvocationFromSel(self, @selector(checkUserName:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSError *)checkUserName:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    if (!ok || recvData == nil)\
    {\
        return NetworkFailError;\
    }\
    BSJSON *jsonObj = [self genJSONResponseHeader:recvData];\
    if (jsonObj == nil)\
    {\
        return DataRequestFailError;\
    }\
     [RequestStatus setRequestResultStatus:jsonObj];
    NSInteger retCode = [[jsonObj objectForKey:@"codeState"] integerValue];\
    retCode = retCode ==0 ? 1 : (retCode ==1 ? 2:retCode) ;\
    if (retCode != 1) {\
        NSString *retMsg = [jsonObj objectForKey:@"message"];\
        return CustomError(retCode,retMsg);\
    }\
    return SuccessedError;
}

-(BOOL)getMyIndex:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self getMyIndex: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getMyIndex:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getMyIndexInput:));
     [input setArgument:&userId atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_GetMyIndex]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getMyIndexOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getMyIndexInput:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@",userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getMyIndexOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _getMyIndex = nil;
 [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUGetMyIndex,getMyIndex"}];
     return SuccessedError;

}

//获取验证码
-(BOOL)sendSms:(NSString *)tel  observer:(id)observer callback:(SEL)callback
{
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(sendSmsInput:));
    [input setArgument:&tel atIndex:2];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_LOGIN,BU_BUSINESS_SmsCode]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(sendSmsOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSData *)sendSmsInput:(NSString *)tel
{
    NSString *url =[NSString stringWithFormat:@"tell=%@&type=0&%@",tel,[self getBaseUrlParem]];
    return [url dataUsingEncoding:NSUTF8StringEncoding];
}


-(BOOL)checkAuth:(id)observer callback:(SEL)callback
{
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(checkAuthInput));

    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_CheckAuth]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(checkAuthOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSData *)checkAuthInput
{
    NSString *url =[NSString stringWithFormat:@"%@",[self getBaseUrlParem]];
    return [url dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSError *)checkAuthOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    NSInteger code = [[(BSJSON *)jsonObj objectForKey:@"codeState"] integerValue];
    if (code == 1) {
        _token = [(BSJSON *)jsonObj objectForKey:@"message"];
    }else{
        _token =@"";
    }
    
    return SuccessedError;
}


//修改头像
-(BOOL)chageLogo:(UIImage *)img  observer:(id)observer callback:(SEL)callback
{
    NSData *logoData = UIImageJPEGRepresentation(img, 1);//[img imageByScalingToSize:CGSizeMake(320, 320)]
     NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithDictionary:[self getBaseUrlParemDic]];//@{@"id": _userId?:@"",@"type":@"1",@"token": _token?:@""
//                              };
     dataDic[@"userId"] = _userId?:@"";
     dataDic[@"typeMsg"] = @"1";
     dataDic[@"data"] = @"0";
     NSString *dtStr1 = [NSString stringWithFormat:@"%@.png",[[[BSUtility getUUIDString] dataUsingEncoding:NSUTF8StringEncoding] md5Data].hexStr];
    return [self sendUploadRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_UpUserInfo]
                              data:logoData
                          fileName:[NSString stringWithFormat:@"file=%@",dtStr1]//[NSString stringWithFormat:@"File=%@Uid=%@",logoName,_userId]
                  outputInvocation:BSGetInvocationFromSel(self, @selector(chageLogoOutput:ok:input:))
                          observer:observer
                            action:callback
                         extraInfo:dataDic];
}

-(BOOL)uploadImg:(UIImage *)img withType:(NSString *)type withId:(NSString *)aid observer:(id)observer callback:(SEL)callback
{

//NSData *logoData = UIImageJPEGRepresentation([img imageByScalingToSize:CGSizeMake(320, 320)], 1);
    NSDictionary *dataDic = @{@"id": aid?:@"",@"type":type?:@"1",@"token": _token?:@""
                          };
    NSString *dtStr1 = [NSString stringWithFormat:@"%@.png",[[[BSUtility getUUIDString] dataUsingEncoding:NSUTF8StringEncoding] md5Data].hexStr];
    return [self sendUploadRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,@""]
                          data:img
                      fileName:[NSString stringWithFormat:@"file=%@",dtStr1]//[NSString stringWithFormat:@"File=%@Uid=%@",logoName,_userId]
              outputInvocation:BSGetInvocationFromSel(self, @selector(chageLogoOutput:ok:input:))
                      observer:observer
                        action:callback
                     extraInfo:dataDic];
}

-(BOOL)uploadImgs:(NSArray*)imgs observer:(id)observer callback:(SEL)callback
{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
//    [dic addEntriesFromDictionary:[self getBaseUrlParemDic]];
    NSData *imgdata1;
    NSString *dtStr1 = [NSString stringWithFormat:@"%@.png",[[[BSUtility getUUIDString] dataUsingEncoding:NSUTF8StringEncoding] md5Data].hexStr];
    for (NSInteger i = 0; i < imgs.count; i++) {
        if (![imgs[i] isKindOfClass:[UIImage class]]) {
            continue;
        }
        if (!imgdata1) {
             imgdata1  = UIImageJPEGRepresentation([(UIImage*)imgs[i] imageByScalingToSize:CGSizeMake(320, 320)], 1);
            continue;
        }
     
        NSData *imgdata2 = UIImageJPEGRepresentation([imgs[i] imageByScalingToSize:CGSizeMake(320, 320)], 1);
        
        
        
        NSString *dtStr2 = [NSString stringWithFormat:@"%@.png",[[[BSUtility getUUIDString] dataUsingEncoding:NSUTF8StringEncoding] md5Data].hexStr];
        
        
         dic[[NSString stringWithFormat:@"file%ld=%@",(long)i+1,dtStr2]] = imgdata2;
        
    };
    
    [dic addEntriesFromDictionary:[self getBaseUrlParemDic]];
    return [self sendUploadRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_UploadFile]
                              data:imgdata1
                          fileName:[NSString stringWithFormat:@"file=%@",dtStr1]//[NSString stringWithFormat:@"File=%@Uid=%@",logoName,_userId]
                  outputInvocation:BSGetInvocationFromSel(self, @selector(uploadImgsOutput:ok:input:))
                          observer:observer
                            action:callback
                         extraInfo:dic];

}


-(NSError *)uploadImgsOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
     UNPACKETOUTPUTHEAD(recvData, ok);
     
     _imgsList = nil;
     
      [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUImageRes,imgsList"}];
     return SuccessedError;//CustomError(0, [jsonObj objectForKey:@"retmsg"]);
}



//-(BOOL)uploadImgCer:(UIImage *)img  observer:(id)observer callback:(SEL)callback
//{
//    
//    //NSData *logoData = UIImageJPEGRepresentation([img imageByScalingToSize:CGSizeMake(320, 320)], 1);
//    NSDictionary *dataDic = @{@"type":@"0",@"token": _token?:@""
//                              };
//    NSString *dtStr1 = [NSString stringWithFormat:@"%@.png",[[[BSUtility getUUIDString] dataUsingEncoding:NSUTF8StringEncoding] md5Data].hexStr];
//    return [self sendUploadRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_uploadFile]
//                              data:img
//                          fileName:[NSString stringWithFormat:@"file=%@",dtStr1]//[NSString stringWithFormat:@"File=%@Uid=%@",logoName,_userId]
//                  outputInvocation:BSGetInvocationFromSel(self, @selector(uploadImgCerOutput:ok:input:))
//                          observer:observer
//                            action:callback
//                         extraInfo:dataDic];
//}
//
//-(NSError *)uploadImgCerOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
//{
//    UNPACKETOUTPUTHEAD(recvData, ok);
//    _imgCerArr = nil;
//    [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUImageRes,imgCerArr"}];
//    return SuccessedError;//CustomError(0, [jsonObj objectForKey:@"retmsg"]);
//}
////修改头像
//-(BOOL)chageLogo:(NSString *)logoName observer:(id)observer callback:(SEL)callback
//{
//    NSInvocation *input = BSGetInvocationFromSel(self, @selector(chageLogoInputLogo:));
//    [input setArgument:&logoName atIndex:2];
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@",busiSystem.apiHost,BU_BUSINESS_uploadFile]
//                        head:nil
//                      method:@"POST"
//                       async:YES
//             inputInvocation:input
//            outputInvocation:BSGetInvocationFromSel(self, @selector(changeUserInfoOutput:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:nil];
//}

-(NSData *)chageLogoInputLogo:(NSString *)logoName
{
    NSString *url =[NSString stringWithFormat:@"Path=%@&Uid=%@",logoName,_userId];
    return [url dataUsingEncoding:NSUTF8StringEncoding];
}


//修改用户资料
-(BOOL) changeUserInfoType:(NSInteger)type  observer:(id)observer callback:(SEL)callback
{
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(changeUserInfoInputType:));
    [input setArgument:&type atIndex:2];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",busiSystem.apiHost,@""]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(changeUserInfoOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
    
}

#pragma mark -- IO
-(NSData *) changeUserInfoInputType:(NSInteger)type
{
    NSString * str=@"";
    switch (type) {
        case 1:
        {
            str=_Name;
        }
            break;
        case 2:
        {
            str=[NSString stringWithFormat:@"%ld",_sex];
        }
            break;
        case 3:
        {
            str =_Phone;
        }
            break;
            
        default:
            break;
    }
    return [[NSString stringWithFormat:@"Name=%@&Type=%ld&Uid=%@",str,(long)type,_userId] dataUsingEncoding:NSUTF8StringEncoding];
//    return [[NSString stringWithFormat:@"avatar=%@&username=%@&gender=%@&birthday=%@&address=%@",[BSUtility nullToEmpty:self.avatar] ,[BSUtility nullToEmpty:self.username],[BSUtility nullToEmpty:self.gender],[BSUtility nullToEmpty:self.birthday],[BSUtility nullToEmpty:self.address]] dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSData *) registerUserInput{
    loginingUserId = _regModel.Phone;
    loginingpassword = _regModel.Pwd;
//    NSData *imageData = UIImagePNGRepresentation(busiSystem.releases.Images[0]);
//    NSString *ImgString =[[NSString alloc] initWithData:imageData encoding:NSASCIIStringEncoding];
//    NSLog(@"%@",[NSString stringWithFormat:@"Phone=%@&Pwd=%@&RePwd=%@&Name=%@&registrationID=%@&Img=%@",_regModel.Phone,_regModel.Pwd,_regModel.RePwd,_regModel.Name,_regModel.registrationID,ImgString]);
    if (_regModel.Img) {
//        return [[NSString stringWithFormat:@"Phone=%@&Pwd=%@&RePwd=%@&Name=%@&registrationID=%@&Img=%@",_regModel.Phone,_regModel.Pwd,_regModel.RePwd,_regModel.Name,_regModel.registrationID,busiSystem.releases.Images[0]] dataUsingEncoding:NSUTF8StringEncoding];
    }
    else
    {
//        return [[NSString stringWithFormat:@"Phone=%@&Pwd=%@&RePwd=%@&Name=%@&registrationID=%@",_regModel.Phone,_regModel.Pwd,_regModel.RePwd,_regModel.Name,_regModel.registrationID] dataUsingEncoding:NSUTF8StringEncoding];
    }
    return NULL;
}


-(NSData *)sendSmsInput:(NSString *)sendType mobileNo:(NSString *)mobileNo
{
    NSString *requestString = [NSString stringWithFormat:@"mobile=%@&type=%@",mobileNo,sendType];
    return [requestString dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSError *)sendSmsOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
  /*  if (!ok || recvData == nil)\
    {\
        return NetworkFailError;\
    }\
    BSJSON *jsonObj = [self genJSONResponseHeader:recvData];\
    if (jsonObj == nil)\
    {\
        return DataRequestFailError;\
    }\
     [RequestStatus setRequestResultStatus:jsonObj];
    NSInteger retCode = [[jsonObj objectForKey:@"codeState"] integerValue];\
    retCode = retCode == 1 ? 0 : (retCode ==1 ? 2:retCode) ;\
    if (retCode != 1) {\
        NSString *retMsg = [jsonObj objectForKey:@"message"];\
        return CustomError(retCode,retMsg);\
    }\*/
    
//    _RetCode =[jsonObj objectForKey:@"RetCode"];
    return SuccessedError;
}

-(NSError *)changeUserInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
//    UNPACKETOUTPUTHEAD(recvData, ok);
    if (!ok || recvData == nil)\
    {\
        return NetworkFailError;\
    }\
    BSJSON *jsonObj = [self genJSONResponseHeader:recvData];\
    if (jsonObj == nil)\
    {\
        return DataRequestFailError;\
    }\
     [RequestStatus setRequestResultStatus:jsonObj];
    NSInteger retCode = [[jsonObj objectForKey:@"codeState"] integerValue];\
    retCode = retCode ==0 ? 1 : (retCode ==1 ? 2:retCode) ;\
    if (retCode != 1) {\
        NSString *retMsg = [jsonObj objectForKey:@"message"];\
        return CustomError(retCode,retMsg);\
    }\
    return SuccessedError;
}

-(NSError *)logoutOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
//    busiSystem.agent = [[BUAgent alloc] init];   //总是建立新的代理商。
     [RequestStatus setRequestResultStatus:jsonObj];
    return SuccessedError;
}

//登陆
-(NSError *)loginOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
     UNPACKETOUTPUTHEAD(recvData, ok);
   /* if (!ok || recvData == nil)\
    {\
        return NetworkFailError;\
    }\
    BSJSON *jsonObj = [self genJSONResponseHeader:recvData];\
    if (jsonObj == nil)\
    {\
        return DataRequestFailError;\
    }\
    NSInteger retCode = [[jsonObj objectForKey:@"codeState"] integerValue];\
    retCode = retCode ==0 ? 1 : (retCode ==1 ? 0:retCode) ;\
    [self setResposeState:jsonObj];\
    if (retCode != 0) {\
        NSString *retMsg = [jsonObj objectForKey:@"message"];\
        return CustomError(retCode,retMsg);\
    }\
    self.Phone = loginingUserId;
    */
//    self.password = loginingpassword;

    [(BSJSON *)[jsonObj objectForKey:@"data"] deserialization:self];
   
    
    return SuccessedError;
}

- (void)AliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}


-(NSData *)forgetPasswordInputInput:(NSString *) newPassword smsCode:(NSString *)smsCode mobile:(NSString *)mobile
{
    NSString *request = [NSString stringWithFormat:@"mobile=%@&password=%@&repassword=%@&verify=%@",mobile,newPassword,newPassword,smsCode];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
}
-(NSData *)passwordModifyInput:(NSString *)oldPassword newPassword:(NSString *) newPassword smsCode:(NSString *)smsCode
{
    NSString *request = [NSString stringWithFormat:@"oldpassword=%@&password=%@&repassword=%@&verify=%@",oldPassword,newPassword,newPassword,smsCode];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}


-(NSError *)passwordModifyOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
     [RequestStatus setRequestResultStatus:jsonObj];
    return SuccessedError;
}

-(NSError *)registerUserOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
//     [(BSJSON *)[jsonObj objectForKey:@"data"] deserialization:self];
//     [RequestStatus setRequestResultStatus:jsonObj];
//    __unsafe_unretained NSString *phone;
//    __unsafe_unretained NSString *userId;
//    __unsafe_unretained NSString *pwd;
////    [input getArgument:&phone atIndex:2];
////    [input getArgument:&userId atIndex:3];
////    [input getArgument:&pwd atIndex:4];
//    self.Phone = phone;
//    self.password = pwd;
//    self.userId =userId;
    return SuccessedError;
}


-(NSError *)chageLogoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
//     [RequestStatus setRequestResultStatus:jsonObj];
//    NSArray *imgs = [jsonObj objectForKey:@"data"];
//    self.userInfo.headImage = [[BUImageRes alloc] initWith:@"" relativeURL:imgs[0][@""] type:BURESTYPE_IMAGE];
//    [APService setAlias:@"" callbackSelector:@selector(AliasCallback:tags:alias:) object:self];
    
    _img = nil;
    NSString *str = [jsonObj objectForKey:@"data"];
     _img = [BUImageRes new];
     _img.Image = str;
    
    return SuccessedError;//CustomError(0, [jsonObj objectForKey:@"retmsg"]);
}

-(NSError *)noDataOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
     [RequestStatus setRequestResultStatus:jsonObj];
    return SuccessedError;
}

-(NSString *)getSign
{
    NSDate *now = [NSDate date];
    UInt64 recordTime = now.timeIntervalSince1970 * 1000;
    _timeStr = [NSString stringWithFormat:@"%llu",recordTime];
    _random = [BSUtility getUUIDString];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:_timeStr];
    [arr addObject:_random];
    [arr addObject:MyAppKey];
    [arr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *a = obj1;
        NSString *b = obj2;
        return  [a compare:b];
    }];
    NSString *arrStr = [arr componentsJoinedByString:@""];
    return [NSString stringWithFormat:@"%@%@",arrStr,MyAppSecret].md5String;
}


-(NSString *)md5code
{
//    NSDate *now = [NSDate date];
//    UInt64 recordTime = now.timeIntervalSince1970 * 1000;
//    _timeStr = [NSString stringWithFormat:@"%llu",recordTime];
//    _random = [BSUtility getUUIDString];
//    NSMutableArray *arr = [NSMutableArray array];
//    [arr addObject:_timeStr];
//    [arr addObject:_random];
//    [arr addObject:MyAppKey];
//    [arr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        NSString *a = obj1;
//        NSString *b = obj2;
//        return  [a compare:b];
//    }];
//    NSString *arrStr = [arr componentsJoinedByString:@""];
    _random = [NSString stringWithFormat:@"%u",(arc4random() % 1000000) + 100000];
    return [NSString stringWithFormat:@"%@%@%@",MyAppKey,MyAppSecret,_random].md5String;
}

-(BOOL)forgetPwd:(NSString*)tel  code:(NSString*)code withPwd:(NSString*)pwd  observer:(id)observer callback:(SEL)callback
{
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(forgetPwdInputPwd:code:withPwd:));
    [input setArgument:&tel atIndex:2];
    [input setArgument:&code atIndex:3];
    [input setArgument:&pwd atIndex:4];
//    [input setArgument:&oldPwd atIndex:5];
//    [input setArgument:&type atIndex:6];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_LOGIN,BU_BUSINESS_ForgotPwd]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(forgetPwdOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSData *) forgetPwdInputPwd:(NSString *)tel code:(NSString*)code withPwd:(NSString*)pwd
{
    NSString *request = [NSString stringWithFormat:@"tell=%@&code=%@&newPwd=%@&%@",tel,code,[pwd md5String],[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
}


-(NSError *)forgetPwdOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
  
    return SuccessedError;
}

-(BOOL)getUserAgreement:(id)observer callback:(SEL)callback
{
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_ACCOUNT,BU_BUSINESS_GetUserAgreement]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(getUserAgreementOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSError *)getUserAgreementOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    _sysUserAgreement = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUSysUserAgreement,sysUserAgreement"}];
    return SuccessedError;
}

-(BOOL) getGuidePage:(id)observer callback:(SEL)callback
{
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_HOME,BU_BUSINESS_GuidePage]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(getGuidePageOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSError *)getGuidePageOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    _guidePageArr = [NSMutableArray array];
     [(BSJSON *)[jsonObj objectForKey:@"data"] deserialization:self.guidePageArr];
    return SuccessedError;
}

-(BOOL) feedBack:(NSString *)tel withContent:(NSString *)content  withType:(NSString *)type observer:(id)observer callback:(SEL)callback
{
//    NSString *token = _token?:@"";
    NSString *userId = _userId?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(feedBackInput: withUserid: withFType: withTel:));
    [input setArgument:&content atIndex:2];
    [input setArgument:&userId atIndex:3];
    [input setArgument:&type atIndex:4];
    [input setArgument:&tel atIndex:5];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_SYS,@""]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(feedBackOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
    
}


-(NSData *)feedBackInput:(NSString*) content withUserid:(NSString*) userId withFType:(NSString*) fType withTel:(NSString*) tel
{
    NSString *request = [NSString stringWithFormat:@"mContent=%@&userID=%@&fType=%@&mContact=%@",content,userId,fType,tel];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)feedBackOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    
    return SuccessedError;
    
}

-(BOOL) updatePUV:(NSString *)stoid  observer:(id)observer callback:(SEL)callback
{
    NSString *request = [NSString stringWithFormat:@"?stoid=%@&deviceid=%@&source=0&%@",stoid,[[UIDevice currentDevice] uniqueDeviceIdentifier],[self getBaseUrlParem]];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_HOME,@"",request]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(updatePUVOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSError *)updatePUVOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
//        [(BSJSON *)[jsonObj objectForKey:@"data"] deserialization:self.guidePageArr];
    return SuccessedError;
}

-(BOOL) getUserInfo:(NSString *)uid  observer:(id)observer callback:(SEL)callback
{
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getUserInfoInput:));
    [input setArgument:&uid atIndex:2];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_GetUserInfo]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getUserInfoOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSData *) getUserInfoInput:(NSString *)uid
{
    NSString *request = [NSString stringWithFormat:@"userId=%@&%@",uid,[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSError *)getUserInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
//     _userInfo = nil;
         [(BSJSON *)[jsonObj objectForKey:@"data"] deserialization:self];
    return SuccessedError;
}

-(BOOL) updateUserInfo:(NSString *)userId withNickName:(NSString *)nickname withHeadImg:(NSString *)img withSex:(NSString *)sex withBirthDay:(NSString*)birthday  observer:(id)observer callback:(SEL)callback
{
//    NSDictionary *dataDic = @{@"userId": userId?:@"",@"nickName": nickname?:@"",@"token": _token?:@""
//                              };
//    if (img) {
//        UIImage *img1 = img;
//        NSData *imgdata1 = UIImageJPEGRepresentation([img1 imageByScalingToSize:CGSizeMake(320, 320)], 1);//(logoImg, 0.1);
//
//        NSMutableDictionary *dic = [NSMutableDictionary new];
//        //    dic[@"f1"] = @"f1";
//        [dic addEntriesFromDictionary:dataDic];
//        NSString *dtStr1 = [NSString stringWithFormat:@"%@.png",[[[BSUtility getUUIDString] dataUsingEncoding:NSUTF8StringEncoding] md5Data].hexStr];
//
//
//
//
//        [dic addEntriesFromDictionary:[self getBaseUrlParemDic]];
//        return [self sendUploadRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_UpdateUserInfo]
//                                  data:imgdata1
//                              fileName:[NSString stringWithFormat:@"file%d=%@",1,dtStr1]//[NSString stringWithFormat:@"file=%@accountId=%@&token=%@&%@",@"f1",_accountId,_token,[self getBaseUrlParem]]
//                      outputInvocation:BSGetInvocationFromSel(self, @selector(updateUserAuthOutput:ok:input:))
//                              observer:observer
//                                action:callback
//                             extraInfo:dic];
//    }
//    else
//    {
        NSInvocation *input = BSGetInvocationFromSel(self, @selector(updateUserInfoInput:withNickName:withSex: withBirthDay:));

        NSString *nickName = nickname;

//        NSString *certType = dataDic[@"certType"];
//        NSString *certName = dataDic[@"certName"];
//        NSString *certAddress = dataDic[@"certAddress"];
//        NSString *certTime = dataDic[@"certTime"];
        
        [input setArgument:&img atIndex:2];
        [input setArgument:&nickName atIndex:3];
        [input setArgument:&sex atIndex:4];
        [input setArgument:&birthday atIndex:5];
//        [input setArgument:&certName atIndex:6];
//        [input setArgument:&certAddress atIndex:7];
//        [input setArgument:&certTime atIndex:8];
        [input retainArguments];
        return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_UpdateUserInfo]
                            head:nil
                          method:@"POST"
                           async:YES
                 inputInvocation:input
                outputInvocation:BSGetInvocationFromSel(self, @selector(updateUserInfoOutput:ok:input:))
                        observer:observer
                          action:callback
                       extraInfo:nil];
//    }
}

-(NSData *) updateUserInfoInput:(NSString *)avatar withNickName:(NSString *)nickname withSex:(NSString *)sex withBirthDay:(NSString*)birthday
{
    NSString *request = [NSString stringWithFormat:@"userId=%@&avatar=%@&nikeName=%@&sex=%@&birthday=%@&%@",_userId,avatar,nickname,sex,birthday,[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSError *)updateUserInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
//    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUUserInfo,userInfo"}];
    return SuccessedError;
}

-(BOOL) changeHeadImage:(NSString *)tel withImage:(UIImage *)img observer:(id)observer callback:(SEL)callback
{
    NSData *imgdata = UIImageJPEGRepresentation([img imageToSize:CGSizeMake(160, 160)], 1);//(logoImg, 0.1);
    NSMutableDictionary *dic = [NSMutableDictionary new];
    //    dic[@"f1"] = @"f1";
    dic[@"tel"] = tel;
    dic[@"token"] = _token;
    [dic addEntriesFromDictionary:[self getBaseUrlParemDic]];
    return [self sendUploadRequest:[NSString stringWithFormat:@"%@%@",@"",@""]
                              data:imgdata
                          fileName:@"f1=f1.png"//[NSString stringWithFormat:@"file=%@accountId=%@&token=%@&%@",@"f1",_accountId,_token,[self getBaseUrlParem]]
                  outputInvocation:BSGetInvocationFromSel(self, @selector(changeHeadImageOutput:ok:input:))
                          observer:observer
                            action:callback
                         extraInfo:dic];
}

-(NSError *)changeHeadImageOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
    //    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUUserInfo,userInfo"}];
    return SuccessedError;
}

-(BOOL) getOtherUserInfo:(NSString *)tel  observer:(id)observer callback:(SEL)callback
{
    NSString *request = [NSString stringWithFormat:@"?tel=%@&%@",tel,[self getBaseUrlParem]];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",@"xxxx",@"",request]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(getOtherUserInfoOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSError *)getOtherUserInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
   // _otherUserInfo = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUUserInfo,otherUserInfo"}];

    return SuccessedError;
}

//-(BOOL) getUserAuth:(NSString *)tel  observer:(id)observer callback:(SEL)callback
//{
//    NSString *request = [NSString stringWithFormat:@"?tel=%@&%@",tel,[self getBaseUrlParem]];
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",@"yyyy",@"",request]
//                        head:nil
//                      method:@"GET"
//                       async:YES
//             inputInvocation:nil
//            outputInvocation:BSGetInvocationFromSel(self, @selector(getUserAuth:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:nil];
//}
//
//-(NSError *)getUserAuth:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
//{
//    UNPACKETOUTPUTHEAD(recvData, ok);
//    //    _guidePageArr = [NSMutableArray array];
//      [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUUserAuth,userAuth"}];
//    return SuccessedError;
//}

-(BOOL) updateUserAuth:(NSDictionary *)dataDic withImgs:(NSArray *)imgarr  observer:(id)observer callback:(SEL)callback
{
    if (imgarr.count > 0) {
        UIImage *img1 = imgarr[0];
        NSData *imgdata1 = UIImageJPEGRepresentation([img1 imageByScalingToSize:CGSizeMake(320, 320)], 1);//(logoImg, 0.1);
      
                NSMutableDictionary *dic = [NSMutableDictionary new];
        //    dic[@"f1"] = @"f1";
        [dic addEntriesFromDictionary:dataDic];
        NSString *dtStr1 = [NSString stringWithFormat:@"%@.png",[[[BSUtility getUUIDString] dataUsingEncoding:NSUTF8StringEncoding] md5Data].hexStr];
        UIImage *img2;
        if (imgarr.count == 2) {
           img2 = imgarr[1];
            NSData *imgdata2 = UIImageJPEGRepresentation([img2 imageByScalingToSize:CGSizeMake(320, 320)], 1);
            NSString *dtStr2 = [NSString stringWithFormat:@"%@.png",[[[BSUtility getUUIDString] dataUsingEncoding:NSUTF8StringEncoding] md5Data].hexStr];
            dic[[NSString stringWithFormat:@"file%d=%@",2,dtStr2]] = imgdata2;
        }
        
       
        
        [dic addEntriesFromDictionary:[self getBaseUrlParemDic]];
        return [self sendUploadRequest:[NSString stringWithFormat:@"%@%@",@"",@""]
                                  data:imgdata1
                              fileName:[NSString stringWithFormat:@"file%d=%@",1,dtStr1]//[NSString stringWithFormat:@"file=%@accountId=%@&token=%@&%@",@"f1",_accountId,_token,[self getBaseUrlParem]]
                      outputInvocation:BSGetInvocationFromSel(self, @selector(updateUserAuthOutput:ok:input:))
                              observer:observer
                                action:callback
                             extraInfo:dic];
    }
    else
    {
        NSInvocation *input = BSGetInvocationFromSel(self, @selector(updateUserAuthInputPwd:withRealName:withIdentity:withCertType:withCertName:withCertAddress:withCertTime:));
        NSString *tel = dataDic[@"tel"];
        NSString *realname = dataDic[@"realname"];
        NSString *identity = dataDic[@"identity"];
        NSString *certType = dataDic[@"certType"];
        NSString *certName = dataDic[@"certName"];
        NSString *certAddress = dataDic[@"certAddress"];
        NSString *certTime = dataDic[@"certTime"];
        
        [input setArgument:&tel atIndex:2];
        [input setArgument:&realname atIndex:3];
        [input setArgument:&identity atIndex:4];
        [input setArgument:&certType atIndex:5];
        [input setArgument:&certName atIndex:6];
        [input setArgument:&certAddress atIndex:7];
        [input setArgument:&certTime atIndex:8];
        [input retainArguments];
        return [self sendRequest:[NSString stringWithFormat:@"%@%@",@"",@""]
                            head:nil
                          method:@"POST"
                           async:YES
                 inputInvocation:input
                outputInvocation:BSGetInvocationFromSel(self, @selector(updateUserAuthOutput:ok:input:))
                        observer:observer
                          action:callback
                       extraInfo:nil];
    }
}

-(NSData *) updateUserAuthInputPwd:(NSString *)tel withRealName:(NSString *)realname withIdentity:(NSString *)identity withCertType:(NSString*)certType withCertName:(NSString *)certName withCertAddress:(NSString *)certAddress withCertTime:(NSString *)certTime
{
    NSString *request = [NSString stringWithFormat:@"tel=%@&realname=%@&identity=%@&certType=%@&certName=%@&certAddress=%@&certTime=%@&%@",tel,realname,identity,certType,certName,certAddress,certTime,[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSError *)updateUserAuthOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
    //    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUUserInfo,userInfo"}];
    return SuccessedError;
}

-(BOOL) getAbout:(id)observer callback:(SEL)callback
{
//    NSString *request = [NSString stringWithFormat:@"?wwoid=%@&%@",wwoid,[self getBaseUrlParem]];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",@"",@""]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(getAboutOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSError *)getAboutOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
    _about = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUAbout,about"}];
    return SuccessedError;
}

-(BOOL) getUserAuthType:(NSString *)tel withSapid:(NSString *)sapid observer:(id)observer callback:(SEL)callback extro:(id)ext
{
        NSString *request = [NSString stringWithFormat:@"?tel=%@&sapid=%@&%@",tel,sapid,[self getBaseUrlParem]];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",@"",@"",request]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(getUserAuthTypeOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:ext];
}

-(NSError *)getUserAuthTypeOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"NSString,userAuthType"}];
    return SuccessedError;
}

-(BOOL) getTell:(NSString *)sapid  observer:(id)observer callback:(SEL)callback
{
    NSString *request = [NSString stringWithFormat:@"?sapid=%@&%@",sapid,[self getBaseUrlParem]];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",@"",@"",request]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(getTellOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSError *)getTellOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
    _getTell = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUGetTell,getTell"}];
    return SuccessedError;
}


-(BOOL) getUserCodeState:(NSString *)tel withCode:(NSString *)code observer:(id)observer callback:(SEL)callback
{
NSString *request = [NSString stringWithFormat:@"?tell=%@&code=%@&%@",tel,code,[self getBaseUrlParem]];
return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_ACCOUNT,BU_BUSINESS_GetUserCodeState,request]
                    head:nil
                  method:@"GET"
                   async:YES
         inputInvocation:nil
        outputInvocation:BSGetInvocationFromSel(self, @selector(getUserCodeStateOutput:ok:input:))
                observer:observer
                  action:callback
               extraInfo:nil];
}

-(NSError *)getUserCodeStateOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
//    _getTell = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"codeState":@"NSString,codeResult"}];
    return SuccessedError;
}

-(BOOL) getShare:(NSString *)sapid withEntityid:(NSString *)entityid withType:(NSString*)type observer:(id)observer callback:(SEL)callback
{
    NSString *request = [NSString stringWithFormat:@"?sapid=%@&entityid=%@&type=%@&%@",sapid,entityid,type,[self getBaseUrlParem]];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@%@",BU_BUSINESS_DOMAIN_HOME,@"",request]
                        head:nil
                      method:@"GET"
                       async:YES
             inputInvocation:nil
            outputInvocation:BSGetInvocationFromSel(self, @selector(getShareOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSError *)getShareOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
    //    _getTell = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"NSString,shareData"}];
    return SuccessedError;
}

-(BOOL) getUserAddress:(NSString *)uid  observer:(id)observer callback:(SEL)callback
{
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getUserAddressInput:));
    [input setArgument:&uid atIndex:2];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_UserAddress]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getUserAddressOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSData *) getUserAddressInput:(NSString *)uid
{
    NSString *request = [NSString stringWithFormat:@"userId=%@&%@",uid,[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSError *)getUserAddressOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
    _userAddresses = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUUserAddress,userAddresses"}];
    return SuccessedError;
}

-(BOOL) changeUserPassword:(NSString *)type  withOldPwd:(NSString*)oldPwd withNewPwd:(NSString*)newPwd   observer:(id)observer callback:(SEL)callback
{

    NSInvocation *input = BSGetInvocationFromSel(self, @selector(changeUserPasswordInput:withOldPwd:withNewPwd:));
    [input setArgument:&type atIndex:2];
    [input setArgument:&oldPwd atIndex:3];
    [input setArgument:&newPwd atIndex:4];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_ChangeUserPassword]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(changeUserPasswordOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSData *) changeUserPasswordInput:(NSString *)type withOldPwd:(NSString*)oldPwd withNewPwd:(NSString*)newPwd
{
    NSString *request = [NSString stringWithFormat:@"userId=%@&oldPwd=%@&newPwd=%@&%@",_userId?:@"",oldPwd,newPwd,[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSError *)changeUserPasswordOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    
    //    _guidePageArr = [NSMutableArray array];
    //_userAddresses = nil;
    //[(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUUserAddress,userAddresses"}];
    return SuccessedError;
}

-(BOOL) updateUserAddress:(NSString *)addrid withContacts:(NSString*)contact withTel:(NSString*)tel  withProvinceName:(NSString*)provinceName withCityName:(NSString*)cityName  withAreaName:(NSString*)areaName withAddress:(NSString*)address withIsDefault:(NSString*)isDefault withLongitude:(NSString *)longitude withLatitude:(NSString *)latitude detail:(NSString *)detail observer:(id)observer callback:(SEL)callback
{
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(updateUserAddressInput: withContacts:withTel:withProvinceName:withCityName:withAreaName:withAddress:withIsDefault:withLongitude:withLatitude:detail:));
    [input setArgument:&addrid atIndex:2];
     [input setArgument:&contact atIndex:3];
     [input setArgument:&tel atIndex:4];
//     [input setArgument:&provinceId atIndex:5];
     [input setArgument:&provinceName atIndex:5];
//     [input setArgument:&cityId atIndex:7];
     [input setArgument:&cityName atIndex:6];
//     [input setArgument:&areaId atIndex:7];
     [input setArgument:&areaName atIndex:7];
     [input setArgument:&address atIndex:8];
     [input setArgument:&isDefault atIndex:9];
     [input setArgument:&longitude atIndex:10];
     [input setArgument:&latitude atIndex:11];
     [input setArgument:&detail atIndex:12];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_SaveUserAddress]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(updateUserAddressOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSData *) updateUserAddressInput:(NSString *)addrid withContacts:(NSString*)contact withTel:(NSString*)tel  withProvinceName:(NSString*)provinceName withCityName:(NSString*)cityName  withAreaName:(NSString*)areaName withAddress:(NSString*)address withIsDefault:(NSString*)isDefault withLongitude:(NSString *)longitude withLatitude:(NSString *)latitude detail:(NSString *)detail
{
     NSString *request = [NSString stringWithFormat:@"addrId=%@&cityName=%@&isDefault=%@&userId=%@&address=%@&areaName=%@&contacts=%@&tell=%@&provName=%@&longitude=%@&latitude=%@&detail=%@&%@",addrid,cityName,isDefault,_userId,address,areaName,contact,tel,provinceName,longitude,latitude,detail,[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSError *)updateUserAddressOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
   // _userAddresses = nil;
    //[(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUUserAddress,userAddresses"}];
    return SuccessedError;
}



-(BOOL) getSignInfo:(id)observer callback:(SEL)callback
{
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getSignInfoInput));
    
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_HOMEINDEX,BU_BUSINESS_Sigin]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getSignInfoOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSData *) getSignInfoInput
{
    NSString *request = [NSString stringWithFormat:@"userId=%@&token=%@&%@",_userId,_token?:@"",[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSError *)getSignInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
    _signInfo = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUSign,signInfo"}];
    return SuccessedError;
}

-(BOOL) addSign:(id)observer callback:(SEL)callback
{
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(addSignInput));
    
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_HOMEINDEX,BU_BUSINESS_AddSigin]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(addSignOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
}

-(NSData *) addSignInput
{
    NSString *request = [NSString stringWithFormat:@"userId=%@&token=%@&%@",_userId,_token?:@"",[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
}

-(NSError *)addSignOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
{
    UNPACKETOUTPUTHEAD(recvData, ok);
    //    _guidePageArr = [NSMutableArray array];
//    _sign = nil;
//    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUSign,sign"}];
    return SuccessedError;
}

-(BOOL)getInfoConfig:(id)observer callback:(SEL)callback
{
   return  [self getInfoConfig:observer callback:callback extraInfo:nil];
}

-(BOOL)getInfoConfig:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    NSString *token = busiSystem.agent.token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getInfoConfigInput:));
    [input setArgument:&token atIndex:2];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_HOMEINDEX,BU_BUSINESS_AppConfig]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getInfoConfigOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)getInfoConfigInput:(NSString*) token
{
    NSString *request = [NSString stringWithFormat:@"%@",[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)getInfoConfigOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    _config = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUGetInfoConfig,config"}];
    return SuccessedError;
    
}


//-(BOOL)getHelpTypeList:(id)observer callback:(SEL)callback
//{
//    return  [self getHelpTypeList:observer callback:callback extraInfo:nil];
//}
//
//-(BOOL)getHelpTypeList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
//{
//    NSString *token = busiSystem.agent.token?:@"";
//    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getHelpTypeListInput:));
//    [input setArgument:&token atIndex:2];
//    [input retainArguments];
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetHelpTypeList]
//                        head:nil
//                      method:@"POST"
//                       async:YES
//             inputInvocation:input
//            outputInvocation:BSGetInvocationFromSel(self, @selector(getHelpTypeListOutput:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:extraInfo];
//
//}
//
//
//-(NSData *)getHelpTypeListInput:(NSString*) token
//{
//    NSString *request = [NSString stringWithFormat:@"token=%@",token];
//    return [request dataUsingEncoding:NSUTF8StringEncoding];
//
//}
//
//-(NSError *)getHelpTypeListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
//
//{
//    UNPACKETOUTPUTHEAD(recvData, ok);
//    _helpTypeList = nil;
//    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUHelp,helpTypeList"}];
//    return SuccessedError;
//
//}



//-(BOOL)getHelpList:(NSString *)typeId observer:(id)observer callback:(SEL)callback
//{
//    return  [self getHelpList:typeId observer:observer callback:callback extraInfo:nil];
//}

//-(BOOL)getHelpList:(NSString *)typeId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
//{
//    NSString *token = busiSystem.agent.token?:@"";
//    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getHelpListInput:withHid:));
//    [input setArgument:&token atIndex:2];
//    [input setArgument:&typeId atIndex:3];
//    [input retainArguments];
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetHelpList]
//                        head:nil
//                      method:@"POST"
//                       async:YES
//             inputInvocation:input
//            outputInvocation:BSGetInvocationFromSel(self, @selector(getHelpListOutput:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:extraInfo];
//
//}
//
//
//-(NSData *)getHelpListInput:(NSString*) token withHid:(NSString *)typeId
//{
//    NSString *request = [NSString stringWithFormat:@"token=%@&typeId=%@",token,typeId];
//    return [request dataUsingEncoding:NSUTF8StringEncoding];
//
//}
//
//-(NSError *)getHelpListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
//
//{
//    UNPACKETOUTPUTHEAD(recvData, ok);
//    _helpList = nil;
//    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUHelp,helpList"}];
//    return SuccessedError;
//
//}
//
//-(BOOL)getHelpDetail:(NSString *)Id observer:(id)observer callback:(SEL)callback
//{
//    NSString *token = busiSystem.agent.token?:@"";
//    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getHelpDetailInput:withHid:));
//    [input setArgument:&token atIndex:2];
//    [input setArgument:&Id atIndex:3];
//    [input retainArguments];
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetHelpDetail]
//                        head:nil
//                      method:@"POST"
//                       async:YES
//             inputInvocation:input
//            outputInvocation:BSGetInvocationFromSel(self, @selector(getHelpDetailOutput:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:nil];
//
//}


//-(NSData *)getHelpDetailInput:(NSString*) token withHid:(NSString *)Id
//{
//    NSString *request = [NSString stringWithFormat:@"token=%@&id=%@",token,Id];
//    return [request dataUsingEncoding:NSUTF8StringEncoding];
//    
//}
//
//-(NSError *)getHelpDetailOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
//
//{
//    UNPACKETOUTPUTHEAD(recvData, ok);
//    _help = nil;
//    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUHelp,help"}];
//    return SuccessedError;
//    
//}


-(BOOL)getIntegralConfig:(id)observer callback:(SEL)callback
{
    return [self getIntegralConfig:observer callback:callback extraInfo:nil];
}

-(BOOL)getIntegralConfig:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
        NSString *token = busiSystem.agent.token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getIntegralConfigInput:));
    [input setArgument:&token atIndex:2];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetIntegralConfig]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getIntegralConfigOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)getIntegralConfigInput:(NSString*) token
{
    NSString *request = [NSString stringWithFormat:@"token=%@",token];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)getIntegralConfigOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    _integralConfig = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUGetIntegralConfig,integralConfig"}];

    return SuccessedError;
    
}


//-(BOOL)addUserPoint:(NSString *)typeId withEntityId:(NSString *)entityId withRemark:(NSString *)remark  observer:(id)observer callback:(SEL)callback
//{
//    return [self addUserPoint:typeId withEntityId:entityId withRemark:remark observer:observer callback:callback extraInfo:nil];
//}
//
//-(BOOL)addUserPoint:(NSString *)typeId withEntityId:(NSString *)entityId withRemark:(NSString *)remark  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
//{
////    NSString *token = busiSystem.agent.token?:@"";
//    NSInvocation *input = BSGetInvocationFromSel(self, @selector(addUserPointInput:withEntityId:withRemark:));
//    [input setArgument:&typeId atIndex:2];
//    [input setArgument:&entityId atIndex:3];
//    [input setArgument:&remark atIndex:4];
//    [input retainArguments];
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_AddUserPoint]
//                        head:nil
//                      method:@"POST"
//                       async:YES
//             inputInvocation:input
//            outputInvocation:BSGetInvocationFromSel(self, @selector(addUserPointOutput:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:extraInfo];
//
//}


-(NSData *)addUserPointInput:(NSString *)typeId withEntityId:(NSString *)entityId withRemark:(NSString *)remark
{
    NSString *request = [NSString stringWithFormat:@"token=%@&userId=%@&typeId=%@&entityId=%@&remark=%@",busiSystem.agent.token?:@"",busiSystem.agent.userId?:@"",typeId,entityId,remark];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)addUserPointOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    _adduserPoint = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"adduserPoint"}];
    
    return SuccessedError;
    
}


//-(BOOL)getHelpList:(id)observer callback:(SEL)callback
//{
//    return [self getHelpList:observer callback:callback extraInfo:nil];
//}
//
//-(BOOL)getHelpList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
//{
//    NSString *token = busiSystem.agent.token?:@"";
//    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getHelpListInput:));
//    [input setArgument:&token atIndex:2];
//    [input retainArguments];
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetHelpList]
//                        head:nil
//                      method:@"POST"
//                       async:YES
//             inputInvocation:input
//            outputInvocation:BSGetInvocationFromSel(self, @selector(getHelpListOutput:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:extraInfo];
//    
//}
//
//
//-(NSData *)getHelpListInput:(NSString*) token
//{
//    NSString *request = [NSString stringWithFormat:@"token=%@",token];
//    return [request dataUsingEncoding:NSUTF8StringEncoding];
//    
//}
//
//-(NSError *)getHelpListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
//
//{
//    UNPACKETOUTPUTHEAD(recvData, ok);
//    
//    return SuccessedError;
//    
//}

-(BOOL)getSinceAddressList:(id)observer callback:(SEL)callback
{
    return [self getSinceAddressList:observer callback:callback extraInfo:nil];
}

-(BOOL)getSinceAddressList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    NSString *token = busiSystem.agent.token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getSinceAddressListInput:));
    [input setArgument:&token atIndex:2];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetSinceAddressList]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getSinceAddressListOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)getSinceAddressListInput:(NSString*) token
{
    NSString *request = [NSString stringWithFormat:@"token=%@",token];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)getSinceAddressListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    _takeSelfAddressArr = nil;
    [(BSJSON*)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUUserAddress,takeSelfAddressArr"}];
    return SuccessedError;
    
}

-(BOOL)getSinceAddress:(NSString*) sid  observer:(id)observer callback:(SEL)callback
{
    return [self getSinceAddress:sid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getSinceAddress:(NSString*) sid  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
       NSString *token = busiSystem.agent.token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getSinceAddressInput: withToken:));
    [input setArgument:&sid atIndex:2];
    [input setArgument:&token atIndex:3];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetSinceAddress]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getSinceAddressOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)getSinceAddressInput:(NSString*) sid withToken:(NSString*) token
{
    NSString *request = [NSString stringWithFormat:@"id=%@&token=%@",sid,token];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)getSinceAddressOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    
    return SuccessedError;
    
}

-(BOOL)getBespokeCity:(id)observer callback:(SEL)callback
{
    return [self getBespokeCity:observer callback:callback extraInfo:nil];
}

-(BOOL)getBespokeCity:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    NSString *token = busiSystem.agent.token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getBespokeCityInput:));
    [input setArgument:&token atIndex:2];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetBespokeCity]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getBespokeCityOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)getBespokeCityInput:(NSString*) token
{
    NSString *request = [NSString stringWithFormat:@"token=%@",token];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)getBespokeCityOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    _cityArr = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUBespokeCity,cityArr"}];
    return SuccessedError;
    
}

-(BOOL)getProvinceList:(id)observer callback:(SEL)callback
{
    return [self getProvinceList:observer callback:callback extraInfo:nil];
}

-(BOOL)getProvinceList:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
      NSString *token = busiSystem.agent.token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getProvinceListInput:));
    [input setArgument:&token atIndex:2];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetProvinceList]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getProvinceListOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)getProvinceListInput:(NSString*) token
{
    NSString *request = [NSString stringWithFormat:@"token=%@",token];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)getProvinceListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    
    return SuccessedError;
    
}
-(BOOL)getCityList:(NSString*) cid   observer:(id)observer callback:(SEL)callback
{
    return [self getCityList:cid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getCityList:(NSString*) cid   observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    NSString *token = busiSystem.agent.token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getCityListInput: withToken:));
    [input setArgument:&cid atIndex:2];
    [input setArgument:&token atIndex:3];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetCityList]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getCityListOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)getCityListInput:(NSString*) cid withToken:(NSString*) token
{
    NSString *request = [NSString stringWithFormat:@"id=%@&token=%@",cid,token];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)getCityListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    
    return SuccessedError;
    
}

-(BOOL)getAreaList:(NSString*) cid observer:(id)observer callback:(SEL)callback
{
    return [self getAreaList:cid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getAreaList:(NSString*) cid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSString *token = busiSystem.agent.token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getAreaListInput: withToken:));
    [input setArgument:&cid atIndex:2];
    [input setArgument:&token atIndex:3];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_GetAreaList]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getAreaListOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)getAreaListInput:(NSString*) cid withToken:(NSString*) token
{
    NSString *request = [NSString stringWithFormat:@"id=%@&token=%@",cid,token];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)getAreaListOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    
    return SuccessedError;
    
}

-(BOOL) checkPayPassword:(NSString *)pwd  observer:(id)observer callback:(SEL)callback
{
    NSString *userId = _userId?:@"";
    NSString *token = _token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(checkPayPasswordInput: withUserid: withToken:));
    [input setArgument:&pwd atIndex:2];
    [input setArgument:&userId atIndex:3];
    [input setArgument:&token atIndex:4];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_CheckPayPassword]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(checkPayPasswordOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
    
}


-(NSData *)checkPayPasswordInput:(NSString*) password withUserid:(NSString*) userId withToken:(NSString*) token
{
    NSString *request = [NSString stringWithFormat:@"password=%@&userId=%@&token=%@",password,userId,token];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)checkPayPasswordOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    _codeResult =[(BSJSON *)jsonObj objectForKey:@"codeState"];
    return SuccessedError;
    
}

-(BOOL) checkSmsCode:(NSString *)code  observer:(id)observer callback:(SEL)callback
{
    NSString *tel = _userInfo.tel?:@"";
    NSString *token = _token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(checkSmsCodeInput: withToken: withTel:));
    [input setArgument:&code atIndex:2];
    [input setArgument:&token atIndex:3];
    [input setArgument:&tel atIndex:4];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_LOGIN,BU_BUSINESS_CheckSmsCode]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(checkSmsCodeOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:nil];
    
}


-(NSData *)checkSmsCodeInput:(NSString*) smsCode withToken:(NSString*) token withTel:(NSString*) tel
{
    NSString *request = [NSString stringWithFormat:@"smsCode=%@&token=%@&tel=%@",smsCode,token,tel];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)checkSmsCodeOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    
    return SuccessedError;
    
}

-(BOOL)setDefaultUserAddress:(NSString*) aid observer:(id)observer callback:(SEL)callback
{
   return  [self setDefaultUserAddress:aid   observer:observer callback:callback extraInfo:nil];
}

-(BOOL)setDefaultUserAddress:(NSString*) aid  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSString *token = _token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(setDefaultUserAddressInput: withToken:));
    [input setArgument:&aid atIndex:2];
    [input setArgument:&token atIndex:3];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_SetUserAddress]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(setDefaultUserAddressOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)setDefaultUserAddressInput:(NSString*) aid withToken:(NSString*) token
{
    NSString *request = [NSString stringWithFormat:@"addrId=%@&userId=%@&isDefault=%@&%@",aid,_userId,@"1",[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)setDefaultUserAddressOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    
    return SuccessedError;
    
}

-(BOOL)delUserAddress:(NSString*) aid observer:(id)observer callback:(SEL)callback
{
    return [self delUserAddress:aid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)delUserAddress:(NSString*) aid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSString *token = _token?:@"";
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(delUserAddressInput: withToken:));
    [input setArgument:&aid atIndex:2];
    [input setArgument:&token atIndex:3];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_DelUserAddress]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(delUserAddressOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];
    
}


-(NSData *)delUserAddressInput:(NSString*) aid withToken:(NSString*) token
{
    NSString *request = [NSString stringWithFormat:@"id=%@&userId=%@&%@",aid,_userId,[self getBaseUrlParem]];
    return [request dataUsingEncoding:NSUTF8StringEncoding];
    
}

-(NSError *)delUserAddressOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    
    return SuccessedError;
    
}

//-(BOOL)delImageFile:(NSString*) entityId withImagepath:(NSString*) imagePath  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
//{
//    NSString *token = _token?:@"";
//    NSInvocation *input = BSGetInvocationFromSel(self, @selector(delImageFileInput: withImagepath: withToken:));
//    [input setArgument:&entityId atIndex:2];
//    [input setArgument:&imagePath atIndex:3];
//    [input setArgument:&token atIndex:4];
//    [input retainArguments];
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_INDEX,BU_BUSINESS_DelImageFile]
//                        head:nil
//                      method:@"POST"
//                       async:YES
//             inputInvocation:input
//            outputInvocation:BSGetInvocationFromSel(self, @selector(delImageFileOutput:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:extraInfo];
//
//}
//
//
//-(NSData *)delImageFileInput:(NSString*) entityId withImagepath:(NSString*) imagePath withToken:(NSString*) token
//{
//    NSString *request = [NSString stringWithFormat:@"entityId=%@&imagePath=%@&token=%@",entityId,imagePath,token];
//    return [request dataUsingEncoding:NSUTF8StringEncoding];
//
//}
//
//-(NSError *)delImageFileOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
//
//{
//    UNPACKETOUTPUTHEAD(recvData, ok);
//
//    return SuccessedError;
//
//}

//-(BOOL)cardRemove:(id)observer callback:(SEL)callback
//{
//    return [self cardRemove:observer callback:callback extraInfo:nil];
//}
//
//-(BOOL)cardRemove:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
//{
//    NSString *token = _token?:@"";
//    NSString *userId = _userId?:@"";
//    NSInvocation *input = BSGetInvocationFromSel(self, @selector(cardRemoveInput: withUserid:));
//    [input setArgument:&token atIndex:2];
//    [input setArgument:&userId atIndex:3];
//    [input retainArguments];
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_CardRemove]
//                        head:nil
//                      method:@"POST"
//                       async:YES
//             inputInvocation:input
//            outputInvocation:BSGetInvocationFromSel(self, @selector(cardRemoveOutput:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:extraInfo];
//
//}


//-(NSData *)cardRemoveInput:(NSString*) token withUserid:(NSString*) userId
//{
//    NSString *request = [NSString stringWithFormat:@"token=%@&userId=%@",token,userId];
//    return [request dataUsingEncoding:NSUTF8StringEncoding];
//
//}
//
//-(NSError *)cardRemoveOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
//
//{
//    UNPACKETOUTPUTHEAD(recvData, ok);
//
//    return SuccessedError;
//
//}
//
//-(BOOL)addUserWithdraw:(NSString*) account withMoney:(NSString*) money  withName:(NSString*) name  observer:(id)observer callback:(SEL)callback
//{
//    return [self addUserWithdraw:account withMoney:money withName:name observer:observer callback:callback extraInfo:nil];
//}
//
//-(BOOL)addUserWithdraw:(NSString*) account withMoney:(NSString*) money  withName:(NSString*) name  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
//{
//    NSString *token = _token?:@"";
//    NSString *userId = _userId?:@"";
//
//    NSInvocation *input = BSGetInvocationFromSel(self, @selector(addUserWithdrawInput: withMoney: withUserid: withName: withToken:));
//    [input setArgument:&account atIndex:2];
//    [input setArgument:&money atIndex:3];
//    [input setArgument:&userId atIndex:4];
//    [input setArgument:&name atIndex:5];
//    [input setArgument:&token atIndex:6];
//    [input retainArguments];
//    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_AddUserWithdraw]
//                        head:nil
//                      method:@"POST"
//                       async:YES
//             inputInvocation:input
//            outputInvocation:BSGetInvocationFromSel(self, @selector(addUserWithdrawOutput:ok:input:))
//                    observer:observer
//                      action:callback
//                   extraInfo:extraInfo];
//
//}
//
//
//-(NSData *)addUserWithdrawInput:(NSString*) account withMoney:(NSString*) money withUserid:(NSString*) userId withName:(NSString*) name withToken:(NSString*) token
//{
//    NSString *request = [NSString stringWithFormat:@"account=%@&money=%@&userId=%@&name=%@&token=%@",account,money,userId,name,token];
//    return [request dataUsingEncoding:NSUTF8StringEncoding];
//
//}
//
//-(NSError *)addUserWithdrawOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input
//
//{
//    UNPACKETOUTPUTHEAD(recvData, ok);
//
//    return SuccessedError;
//
//}


-(BOOL)getUserIndex:(NSString*) sid observer:(id)observer callback:(SEL)callback
{
     return [self getUserIndex: sid observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getUserIndex:(NSString*) sid observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getUserIndexInput:));
     [input setArgument:&sid atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_GetUserIndex]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getUserIndexOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getUserIndexInput:(NSString*) sid
{
     NSString *request = [NSString stringWithFormat:@"id=%@&%@",sid,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getUserIndexOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _getUserIndex = nil;
    [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUGetUserIndex,getUserIndex"} ];
     return SuccessedError;

}

-(BOOL)saveUser:(NSString*) headImage withNickname:(NSString*) nickName withUserid:(NSString*) userId  observer:(id)observer callback:(SEL)callback
{
     return [self saveUser: headImage withNickname: nickName withUserid: userId  observer:observer callback:callback extraInfo:nil];
}

-(BOOL)saveUser:(NSString*) headImage withNickname:(NSString*) nickName withUserid:(NSString*) userId  observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(saveUserInput: withNickname: withUserid: withToken:));
     [input setArgument:&headImage atIndex:2];
     [input setArgument:&nickName atIndex:3];
     [input setArgument:&userId atIndex:4];
     [input setArgument:&_token atIndex:5];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_SaveUser]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(saveUserOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)saveUserInput:(NSString*) headImage withNickname:(NSString*) nickName withUserid:(NSString*) userId withToken:(NSString*) token
{
     NSString *request = [NSString stringWithFormat:@"headImage=%@&nickName=%@&userId=%@&token=%@&%@",headImage,nickName,userId,token,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)saveUserOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}


-(BOOL)changePassword:(NSString*) oldPassword withUserid:(NSString*) userId withNewpassword:(NSString*) newPassword observer:(id)observer callback:(SEL)callback
{
     return [self changePassword: oldPassword withUserid: userId withNewpassword: newPassword observer:observer callback:callback extraInfo:nil];
}

-(BOOL)changePassword:(NSString*) oldPassword withUserid:(NSString*) userId withNewpassword:(NSString*) newPassword observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(changePasswordInput: withUserid: withNewpassword:));
     [input setArgument:&oldPassword atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input setArgument:&newPassword atIndex:4];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_ChangePassword]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(changePasswordOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)changePasswordInput:(NSString*) oldPassword withUserid:(NSString*) userId withNewpassword:(NSString*) newPassword
{
     NSString *request = [NSString stringWithFormat:@"oldPassword=%@&userId=%@&newPassword=%@&%@",oldPassword,userId,newPassword,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)changePasswordOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)getIntegralRanking:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self getIntegralRanking: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getIntegralRanking:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getIntegralRankingInput:));
     [input setArgument:&userId atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_GetIntegralRanking]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getIntegralRankingOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getIntegralRankingInput:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&token=%@&%@",userId,_token,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getIntegralRankingOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _integralRanking = nil;
      [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUGetIntegralRanking,integralRanking"}];
     return SuccessedError;

}

-(BOOL)getUserDefaultAddress:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self getUserDefaultAddress: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getUserDefaultAddress:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     _userDefaultAddress = nil;
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getUserDefaultAddressInput:));
     [input setArgument:&userId atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_GetUserDefaultAddress]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getUserDefaultAddressOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getUserDefaultAddressInput:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&token=%@&%@",userId,_token,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getUserDefaultAddressOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _userDefaultAddress = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUUserAddress,userDefaultAddress"}];
     return SuccessedError;

}

-(BOOL)thirdLogin:(NSString*) userHead withNickname:(NSString*) nickName withUid:(NSString*) uid withType:(NSString*) type observer:(id)observer callback:(SEL)callback
{
     return [self thirdLogin: userHead withNickname: nickName withUid: uid withType: type observer:observer callback:callback extraInfo:nil];
}

-(BOOL)thirdLogin:(NSString*) userHead withNickname:(NSString*) nickName withUid:(NSString*) uid withType:(NSString*) type observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(thirdLoginInput: withNickname: withUid: withType:));
     [input setArgument:&userHead atIndex:2];
     [input setArgument:&nickName atIndex:3];
     [input setArgument:&uid atIndex:4];
     [input setArgument:&type atIndex:5];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_LOGIN,BU_BUSINESS_ThirdLogin]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(thirdLoginOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)thirdLoginInput:(NSString*) userHead withNickname:(NSString*) nickName withUid:(NSString*) uid withType:(NSString*) type
{
     NSString *request = [NSString stringWithFormat:@"userHead=%@&nickName=%@&uid=%@&type=%@&%@",userHead,nickName,uid,type,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)thirdLoginOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
 [(BSJSON *)[jsonObj objectForKey:@"data"] deserialization:self];
     return SuccessedError;

}

-(BOOL)userBindMobile:(NSString*) password withSmscode:(NSString*) smsCode withMobile:(NSString*) mobile withUserid:(NSString*) userId withType:(NSString *)type observer:(id)observer callback:(SEL)callback
{
     return [self userBindMobile: [password md5String] withSmscode: smsCode withMobile: mobile withUserid: userId withType:type observer:observer callback:callback extraInfo:nil];
}

-(BOOL)userBindMobile:(NSString*) password withSmscode:(NSString*) smsCode withMobile:(NSString*) mobile withUserid:(NSString*) userId withType:(NSString *)type observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(userBindMobileInput: withSmscode: withMobile: withUserid:withType:));
     [input setArgument:&password atIndex:2];
     [input setArgument:&smsCode atIndex:3];
     [input setArgument:&mobile atIndex:4];
     [input setArgument:&userId atIndex:5];
      [input setArgument:&type atIndex:6];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_USER,BU_BUSINESS_UserBindMobile]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(userBindMobileOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)userBindMobileInput:(NSString*) password withSmscode:(NSString*) smsCode withMobile:(NSString*) mobile withUserid:(NSString*) userId withType:(NSString *)type
{
     NSString *request = [NSString stringWithFormat:@"type=%@&password=%@&smsCode=%@&mobile=%@&userId=%@&%@",type,password,smsCode,mobile,userId,[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)userBindMobileOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}
-(BOOL)upUserInfo:(NSString*) userId withTypeMsg:(NSString *)typeMsg withData:(NSString *)data observer:(id)observer callback:(SEL)callback
{
     return [self upUserInfo: userId withTypeMsg:(NSString *)typeMsg withData:(NSString *)data observer:observer callback:callback extraInfo:nil];
}

-(BOOL)upUserInfo:(NSString*) userId withTypeMsg:(NSString *)typeMsg withData:(NSString *)data observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(upUserInfoInput:withTypeMsg:  withData: ));
     [input setArgument:&userId atIndex:2];
      [input setArgument:&typeMsg atIndex:3];
      [input setArgument:&data atIndex:4];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_UpUserInfo]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(upUserInfoOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)upUserInfoInput:(NSString*) userId withTypeMsg:(NSString *)typeMsg withData:(NSString *)data
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&typeMsg=%@&data=%@",userId,typeMsg,data];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)upUserInfoOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)userAddress:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self userAddress: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)userAddress:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(userAddressInput:));
     [input setArgument:&userId atIndex:2];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_UserAddress]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(userAddressOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)userAddressInput:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"userId=%@",userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)userAddressOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)addandUpAddress:(NSString*) userId withCityid:(NSString*) cityId withUsername:(NSString*) userName withAddressid:(NSString*) addressId withProvinceid:(NSString*) provinceId withAreaid:(NSString*) areaId withAddress:(NSString*) address withFloor:(NSString*) floor withIsdefault:(NSString*) isDefault withTel:(NSString*) tel observer:(id)observer callback:(SEL)callback
{
     return [self addandUpAddress: userId withCityid: cityId withUsername: userName withAddressid: addressId withProvinceid: provinceId withAreaid: areaId withAddress: address withFloor: floor withIsdefault: isDefault withTel: tel observer:observer callback:callback extraInfo:nil];
}

-(BOOL)addandUpAddress:(NSString*) userId withCityid:(NSString*) cityId withUsername:(NSString*) userName withAddressid:(NSString*) addressId withProvinceid:(NSString*) provinceId withAreaid:(NSString*) areaId withAddress:(NSString*) address withFloor:(NSString*) floor withIsdefault:(NSString*) isDefault withTel:(NSString*) tel observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(addandUpAddressInput: withCityid: withUsername: withAddressid: withProvinceid: withAreaid: withAddress: withFloor: withIsdefault: withTel:));
     [input setArgument:&userId atIndex:2];
     [input setArgument:&cityId atIndex:3];
     [input setArgument:&userName atIndex:4];
     [input setArgument:&addressId atIndex:5];
     [input setArgument:&provinceId atIndex:6];
     [input setArgument:&areaId atIndex:7];
     [input setArgument:&address atIndex:8];
     [input setArgument:&floor atIndex:9];
     [input setArgument:&isDefault atIndex:10];
     [input setArgument:&tel atIndex:11];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_AddandUpAddress]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(addandUpAddressOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)addandUpAddressInput:(NSString*) userId withCityid:(NSString*) cityId withUsername:(NSString*) userName withAddressid:(NSString*) addressId withProvinceid:(NSString*) provinceId withAreaid:(NSString*) areaId withAddress:(NSString*) address withFloor:(NSString*) floor withIsdefault:(NSString*) isDefault withTel:(NSString*) tel
{
     NSString *request = [NSString stringWithFormat:@"userId=%@&cityId=%@&userName=%@&addressId=%@&provinceId=%@&areaId=%@&address=%@&floor=%@&isDefault=%@&tel=%@",userId,cityId,userName,addressId,provinceId,areaId,address,floor,isDefault,tel];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)addandUpAddressOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}
-(BOOL)upMsgState:(NSString*) state withInformationid:(NSString*) informationId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self upMsgState: state withInformationid: informationId withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)upMsgState:(NSString*) state withInformationid:(NSString*) informationId withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(upMsgStateInput: withInformationid: withUserid:));
     [input setArgument:&state atIndex:2];
     [input setArgument:&informationId atIndex:3];
     [input setArgument:&userId atIndex:4];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_UpMsgState]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(upMsgStateOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)upMsgStateInput:(NSString*) state withInformationid:(NSString*) informationId withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"state=%@&informationId=%@&userId=%@",state,informationId,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)upMsgStateOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}

-(BOOL)addFeed:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self addFeed: msg withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)addFeed:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(addFeedInput: withUserid:));
     [input setArgument:&msg atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_MYPATH,BU_BUSINESS_AddFeed]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(addFeedOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)addFeedInput:(NSString*) msg withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"msg=%@&userId=%@",msg,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)addFeedOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}


-(BOOL)geTadvertising:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self geTadvertising: msg withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)geTadvertising:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(geTadvertisingInput: withUserid:));
     [input setArgument:&msg atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_SLIDESHOW,BU_BUSINESS_GeTadvertising]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(geTadvertisingOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)geTadvertisingInput:(NSString*) msg withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"msg=%@&userId=%@",msg,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)geTadvertisingOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _adImg = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUImageRes,adImg"} ];
//     NSString *str = [jsonObj objectForKey:@"data"];
//     _adImg = [BUImageRes new];
//     _adImg.Image = str;
     return SuccessedError;

}


-(BOOL)getSliGuide:(id)observer callback:(SEL)callback
{
     return [self getSliGuide:observer callback:callback extraInfo:nil];
}

-(BOOL)getSliGuide:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getSliGuideOutput));
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_SLIDESHOW,BU_BUSINESS_GetSliGuide]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getSliGuideOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];
     
}


-(NSData *)getSliGuideOutput
{
     NSString *request = [NSString stringWithFormat:@"%@",[self getBaseUrlParem]];
     return [request dataUsingEncoding:NSUTF8StringEncoding];
     
}

-(NSError *)getSliGuideOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _adImgList = nil;
     [(BSJSON *)jsonObj deserializationSpecifityMap:self map:@{@"data":@"BUImageRes,adImgList"} ];
     //     NSString *str = [jsonObj objectForKey:@"data"];
     //     _adImg = [BUImageRes new];
     //     _adImg.Image = str;
     return SuccessedError;
     
}








-(BOOL)getFoundSlishow:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
    return [self getFoundSlishow: msg withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getFoundSlishow:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
    NSInvocation *input = BSGetInvocationFromSel(self, @selector(getFoundSlishowInput: withUserid:));
    [input setArgument:&msg atIndex:2];
    [input setArgument:&userId atIndex:3];
    [input retainArguments];
    return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_TYPEMSG,BU_BUSINESS_GetFoundSlishow]
                        head:nil
                      method:@"POST"
                       async:YES
             inputInvocation:input
            outputInvocation:BSGetInvocationFromSel(self, @selector(getFoundSlishowOutput:ok:input:))
                    observer:observer
                      action:callback
                   extraInfo:extraInfo];

}


-(NSData *)getFoundSlishowInput:(NSString*) msg withUserid:(NSString*) userId
{
    NSString *request = [NSString stringWithFormat:@"msg=%@&userId=%@",msg,userId];
    return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getFoundSlishowOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
    UNPACKETOUTPUTHEAD(recvData, ok);
    _foundSlishowArr = nil;
 [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUFoundSlishow,foundSlishowArr"}];
    return SuccessedError;

}
-(BOOL)getFind:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self getFind: msg withUserid: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)getFind:(NSString*) msg withUserid:(NSString*) userId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(getFindInput: withUserid:));
     [input setArgument:&msg atIndex:2];
     [input setArgument:&userId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_TYPEMSG,BU_BUSINESS_GetFind]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(getFindOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)getFindInput:(NSString*) msg withUserid:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@""];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)getFindOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);
     _getFindArr = nil;
      [jsonObj  deserializationSpecifityMap:self map:@{@"data":@"BUGetFind,getFindArr"}];
     return SuccessedError;

}

-(BOOL)upCount:(NSString*) msg withDataId:(NSString*) userId observer:(id)observer callback:(SEL)callback
{
     return [self upCount: msg withDataId: userId observer:observer callback:callback extraInfo:nil];
}

-(BOOL)upCount:(NSString*) msg withDataId:(NSString*) dataId observer:(id)observer callback:(SEL)callback extraInfo:(NSDictionary *)extraInfo
{
     NSInvocation *input = BSGetInvocationFromSel(self, @selector(upCountInput: withDataId:));
     [input setArgument:&msg atIndex:2];
     [input setArgument:&dataId atIndex:3];
     [input retainArguments];
     return [self sendRequest:[NSString stringWithFormat:@"%@%@",BU_BUSINESS_DOMAIN_TYPEMSG,BU_BUSINESS_UpCount]
                         head:nil
                       method:@"POST"
                        async:YES
              inputInvocation:input
             outputInvocation:BSGetInvocationFromSel(self, @selector(upCountOutput:ok:input:))
                     observer:observer
                       action:callback
                    extraInfo:extraInfo];

}


-(NSData *)upCountInput:(NSString*) msg withDataId:(NSString*) userId
{
     NSString *request = [NSString stringWithFormat:@"typeMsg=%@&dataId=%@",msg,userId];
     return [request dataUsingEncoding:NSUTF8StringEncoding];

}

-(NSError *)upCountOutput:(NSData *)recvData ok:(BOOL)ok input:(NSInvocation *)input

{
     UNPACKETOUTPUTHEAD(recvData, ok);

     return SuccessedError;

}
@end
