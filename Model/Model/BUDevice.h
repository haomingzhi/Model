

#define MODEL_IPHONE                @"iPhone"
#define MODEL_IPHONE_3G             @"iPhone3G"
#define MODEL_IPHONE_3GS            @"iPhone3GS"
#define MODEL_IPHONE_4G             @"iPhone4G"
#define MODEL_IPHONE_4GS            @"iPhone4GS"
#define MODEL_IPHONE_5              @"iPhone5"
#define MODEL_IPHONE_5C             @"iPhone5C"
#define MODEL_IPHONE_5S             @"iPhone5S"
#define MODEL_VERIZON_IPHONE_4  @"Verizon iPhone 4"

#define MODEL_IPOD_TOUCH            @"iPod Touch"
#define MODEL_IPOD_TOUCH_2G         @"iPod Touch2G"
#define MODEL_IPOD_TOUCH_3G         @"iPod Touch3G"
#define MODEL_IPOD_TOUCH_4G         @"iPod Touch4G"


#define MODEL_IPAD                  @"iPad"
#define MODEL_IPHONE_SIMULATOR      @"iPhoneSimulator"
#define MODEL_UNKNOWN               @"unknown"



//系统设备类
@interface BUDevice : BUBase

@property(nonatomic,readonly) NSString *uuid;              //设备标识
@property(nonatomic, readonly) NSInteger screenWidth;      //屏幕宽度分辨率
@property(nonatomic, readonly) NSInteger screenHeight;     //高度分辨率
@property(nonatomic, readonly) NSString *type;             //设备类型
@property(nonatomic, readonly) NSString *osVersion;        //操作系统版本号
@property(nonatomic, readonly) NSString *imei;              //iphone得不到
@property(nonatomic, readonly) NSString *productor;        //设备厂家
@property(nonatomic, readonly) NSString *wifiMac;          //iphone得不到

+ (NSString *)getCurrentDeviceModel;
@end
