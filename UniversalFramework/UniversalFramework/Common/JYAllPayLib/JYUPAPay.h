//
//  JYUPAPay.h
//  TestPayApp
//
//  Created by air on 2017/6/12.
//  Copyright © 2017年 air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYCommonPayDelegate.h"

@interface JYUPAPay : NSObject<JYCommonPayDelegate>
+(instancetype)manager;
@end
