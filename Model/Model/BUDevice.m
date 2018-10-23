
#import "BUDevice.h"

#import <sys/utsname.h>
#import <sys/types.h>
#import <sys/sysctl.h>

@interface BUDevice()

@property(nonatomic) NSString *uuid;              //设备标识
@property(nonatomic) NSString *type;

@end

@implementation BUDevice

-(id)init
{
    self = [super init];
    if (self != nil)
    {
    }
    
    return self;
}

-(NSString*)uuid
{
    
    if (_uuid != nil)
        return _uuid;
    
    
    if ([[UIDevice currentDevice] systemVersion].integerValue >= 6)
    {
        @synchronized(self)
        {
            _uuid = [self getPermanentIdForVender];
        }
        
    }
    else
    {
        _uuid = [NSString stringWithFormat:@"mac%@", [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier]];
    }
    
    return _uuid;

}

-(NSInteger)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

-(NSInteger)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

-(NSString*)osVersion
{
    return [UIDevice currentDevice].systemVersion;
}

-(NSString*)imei
{
    return @"";
}

-(NSString*)productor
{
    return @"apple";
}

-(NSString*)wifiMac
{
    return @"";
}

-(NSString*)type
{
    if (_type != nil)
        return _type;
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform  = [NSString stringWithUTF8String:machine];
    free(machine);
    _type = [self deviceModel:platform];
    
    return _type;

}

#pragma mark -- Private Method


-(NSString *)deviceModel:(NSString*)platform
{
    if ([platform isEqualToString:@"iPhone1,1"])
        return MODEL_IPHONE;
    if ([platform isEqualToString:@"iPhone1,2"])
        return MODEL_IPHONE_3G;
    if ([platform isEqualToString:@"iPhone2,1"])
        return MODEL_IPHONE_3GS;
    if ([platform isEqualToString:@"iPhone3,1"])
        return MODEL_IPHONE_4G;
    if ([platform isEqualToString:@"iPhone4,1"])
        return MODEL_IPHONE_4GS;
    if ([platform isEqualToString:@"iPhone5,1"]) {
        return MODEL_IPHONE_5;
    }
    if ([platform isEqualToString:@"iPhone5,2"])
        return MODEL_IPHONE_5;
    if ([platform isEqualToString:@"iPhone5,3"]) {
        return MODEL_IPHONE_5C;
    }
    if ([platform isEqualToString:@"iPhone5,4"]) {
        return MODEL_IPHONE_5C;
    }
    if ([platform isEqualToString:@"iPhone6,1"]) {
        return MODEL_IPHONE_5S;
    }
    if ([platform isEqualToString:@"iPhone6,2"]) {
        return MODEL_IPHONE_5S;
    }
    if ([platform isEqualToString:@"iPhone3,2"]) {
        return MODEL_VERIZON_IPHONE_4;
    }
    if ([platform isEqualToString:@"iPod1,1"])
        return MODEL_IPOD_TOUCH;
    if ([platform isEqualToString:@"iPod2,1"])
        return MODEL_IPOD_TOUCH_2G;
    if ([platform isEqualToString:@"iPod3,1"])
        return MODEL_IPOD_TOUCH_3G;
    if ([platform isEqualToString:@"iPod4,1"])
        return MODEL_IPOD_TOUCH_4G;
    if ([platform isEqualToString:@"iPad1,1"])
        return MODEL_IPAD;
    if ([platform isEqualToString:@"iPad2,1"]) {
        return MODEL_IPAD;
    }
    if ([platform isEqualToString:@"iPad2,2"]) {
        return MODEL_IPAD;
    }
    if ([platform isEqualToString:@"iPad2,3"]) {
        return MODEL_IPAD;
    }
    if ([platform isEqualToString:@"i386"])
        return MODEL_IPHONE_SIMULATOR;
    if ([platform isEqualToString:@"x86_64"]) {
        return MODEL_IPHONE_SIMULATOR;
    }
    return MODEL_UNKNOWN;
}



- (NSString *)getPermanentIdForVender
{
    NSString *idForVender;
    
    //构建wapper
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"miniClientSec" accessGroup:nil];
    
    //尚未写入钥匙串
    if (((NSString*)[wrapper objectForKey:(__bridge id)(kSecAttrAccount)]).length == 0)
    {
        idForVender = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [wrapper resetKeychainItem];
        [wrapper setObject:idForVender forKey:(__bridge id)(kSecAttrAccount)];
    }
    else
    {
        idForVender = [wrapper objectForKey:(__bridge id)(kSecAttrAccount)];
    }
    
    return idForVender;
}

+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4";
    
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPadAir2";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPadmini4";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return platform;
}
@end
