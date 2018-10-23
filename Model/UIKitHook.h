

#import <Foundation/Foundation.h>
/**
   系统界面的钩子程序可以用于某个特定效果的实现，而无需改动代码
 */
@interface UIKitHook : NSObject

//调用这个改变默认实现
+(void)loadAllHooks;

@end
