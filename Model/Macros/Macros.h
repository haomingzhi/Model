//
//  Macros.h
//  ProjectTest
//
//  Created by fxft on 16/8/30.
//  Copyright © 2016年 fxft. All rights reserved.
//

#pragma mark -机型、系统、版本------
#pragma mark -
#pragma mark -----机型------



#define kHarpyCurrentVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//判断是否 Retina屏、设备是否iPhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 判断是否为iPhone */
#define isiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** 判断是否是iPad */
#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 判断是否为iPod */
#define isiPod ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x */
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#pragma mark -
#pragma mark -----系统------

//judge the simulator or hardware device        判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

#pragma mark -
#pragma mark -----版本------

/** 获取系统版本 */
#define APP_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define iOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])
#define CurrentSystemVersion ([[UIDevice currentDevice] systemVersion])

/** 是否为iOS6 */
#define iOS6 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) ? YES : NO)

/** 是否为iOS7 */
#define iOS7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)

/** 是否为iOS8 */
#define iOS8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)

/** 是否为iOS9 */
#define iOS9 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? YES : NO)

/** 是否为iOS10 */
#define iOS10 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) ? YES : NO)
/** 是否为iOS11 */
#define iOS11 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) ? YES : NO)

#pragma mark -
#pragma mark -屏幕宽高、视图坐标点宽高、设备大小比例、语言、字体、颜色、-------

#pragma mark -
#pragma mark -----屏幕宽高------

#define App_Frame_Height        [[UIScreen mainScreen] bounds].size.height
#define App_Frame_Width         [[UIScreen mainScreen] bounds].size.width

#define MainScreen_width  [UIScreen mainScreen].bounds.size.width
#define MainScreen_height [UIScreen mainScreen].bounds.size.height
#define UISreenWidthScale   MainScreen_width / 320

#pragma mark -
#pragma mark -----视图宽高------

#define GetViewWidth(view)  view.frame.size.width
#define GetViewHeight(view) view.frame.size.height
#define GetViewX(view)      view.frame.origin.x
#define GetViewY(view)      view.frame.origin.y

#pragma mark -
#pragma mark -----设备大小比例（当前以4.7寸屏为基本）------

#define kScreenWidthRatio  (App_Frame_Width / 375.0)
#define kScreenHeightRatio (iPhoneX ? 667.0/667.0 : (App_Frame_Height / 667.0))

#pragma mark -
#pragma mark -----当前语言------

#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#pragma mark -
#pragma mark -----字体大小（当前以4寸屏为基本）------
#define pxFont(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
//#define AdaptedFontSize(R)     CHINESE_SYSTEM(AdaptedWidth(R))
//中文字体
#define CHINESE_FONT_NAME  iOS9 ?@"PingFangSC-Regular" :@"Helvetica"//@"PingFangSC-Medium"//
#define CHINESE_FONT_MEDIUM iOS9 ? @"PingFangSC-Medium" :@"Helvetica"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:AdaptedWidth(x)]
#define CHINESE_MEDIUM(x) [UIFont fontWithName:CHINESE_FONT_MEDIUM size:AdaptedWidth(x)]

#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:AdaptedWidth(FONTSIZE)]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:AdaptedFontSize(FONTSIZE)]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:AdaptedFontSize(FONTSIZE)]

#pragma mark -
#pragma mark -----颜色------

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// rgb颜色转换（16进制->10进制）
#define RGBColorFrom16(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define PublicBlueColor RGBCOLOR(6, 146, 255)
#define PublicBlueTextColor RGBCOLOR(74, 144, 226)
#define PublicBGColor RGBCOLOR(244, 244, 244)
#define PublicGrayColor RGBCOLOR(155, 155, 155)
#define PublicRedColor RGBCOLOR(249, 53, 45)
#define PublicBlackColor [UIColor blackColor]
#define PublicWhiteColor [UIColor whiteColor]
#define PublicOrangeColor RGBColorFrom16(0xfd7923)
#define PublicPinkColor RGBColorFrom16(0xff6380)
#define PublicLineColor RGBColorFrom16(0xe5e5e5)
#define PublicTextGrayColor RGBCOLOR(171, 171, 171)
#define PublicTextBlackColor RGBCOLOR(34, 34, 34)

#pragma mark 测评
#define DefaultSelectColor [UIColor colorWithRed:229 / 255.0 green:233 / 255.0 blue:242 / 255.0 alpha:1.0]
#define SelectedColor [UIColor colorWithRed:32 / 255.0 green:160 / 255.0 blue:255 / 255.0 alpha:1.0]
#define DefineLabelColor [UIColor colorWithRed:74 / 255.0 green:74 / 255.0 blue:74 / 255.0 alpha:1.0]

#define PublicTextColor RGBCOLOR(77, 77, 77)

#pragma mark -
#pragma mark -打印日志------

#ifdef DEBUG
#   define YCLog(fmt, ...) NSLog( @"%s [line %d] ==>%@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:(fmt), ##__VA_ARGS__] );//NSLog((@"%s [Line %d]" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else

#   define YCLog(...)
#endif

#pragma mark -
#pragma mark -判断空值------

#pragma mark -
#pragma mark -----是否是空对象-----

#define IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]

#pragma mark -
#pragma mark -----字符串是否为空-----

#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

#pragma mark - 获取数据成功
#define getDataSuccess(data) [data[@"code"]integerValue] == 1

#pragma mark -
#pragma mark -----数组是否为空-----

#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

#pragma mark -
#pragma mark -----字典是否为空-----

#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

#pragma mark -
#pragma mark -引用（强、弱）------

#define MPWeakSelf(type)  __weak typeof(type) weak##type = type;
#define MPStrongSelf(type)  __strong typeof(type) type = weak##type;

#pragma mark -
#pragma mark -读取图片资源------

#define BaseHeadImgName @"列表"
#define defaultImage @""
#define PlaceholderImage [UIImage imageNamed:BaseHeadImgName]
//#define userHead @"Group 5"
#define userHeadPlaceImage [UIImage imageNamed:userHead]

#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

#pragma mark -
#pragma mark -本地存储------
/**
 *  存储对象
 */
#define UserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

/**
 存储bool型
 */
#define UserDefaultSetBOOLForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setBool:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}
/**
 *  获取对象
 */
#define UserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

/**
 *  获取BOOL对象
 */
#define UserDefaultBOOLForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] boolForKey:__KEY__]
/**
 *  删除对象
 */
#define UserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}
#pragma mark -
#pragma mark -单例------

#define singleton_interface(className) \
+ (className *)shared##className;

#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

#pragma mark -
#pragma mark -代码片段的运行时间------

#define TICK NSDate *startTime = [NSDate date];
#define TOCK YCLog(@"Time:%f", -[startTime timeIntervalSinceNow]);

#define JJweakSelf __weak typeof (self)XYweakSelf = self


#pragma mark - noti
#define userSelectedProvince @"SELECTEDPROVINCE"


#pragma mark - user
#define singleUser [UserInfoModel sharedUserInfoModel]

#define UICommonTableBkgColor UIColorFromRGB(0xe4e7ec)
#define Message_Font_Size   14        // 普通聊天文字大小
#define Notification_Font_Size   10   // 通知文字大小
#define Chatroom_Message_Font_Size 16 // 聊天室聊天文字大小


#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#pragma mark - UIColor宏定义
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.0)

#define dispatch_sync_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#pragma mark - 高度

#define navBarHei (iPhoneX ? 88: 64)
#define statuBarHei (iPhoneX ? 44: 20)
#define tabbarHei (iPhoneX ? 84: 50)






