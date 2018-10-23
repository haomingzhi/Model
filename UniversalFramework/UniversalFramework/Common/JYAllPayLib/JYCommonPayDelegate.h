//
//  JYCommonPayDelegate.h
//  TestPayApp
//
//  Created by air on 15/6/5.
//  Copyright (c) 2015年 air. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JYCommonPayDelegate <NSObject>
- (void)payOrder:(NSDictionary *)payInfo
        callback:(void(^)(NSDictionary *resultDic))completionBlock;
-(BOOL)payResult:(id)dataDic;
@end
