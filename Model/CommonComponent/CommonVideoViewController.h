//
//  CommonVideoViewController.h
//  compassionpark
//
//  Created by Steve on 2017/4/12.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface CommonVideoViewController : JYBaseViewController
@property (nonatomic,strong) NSString *url;
+(CommonVideoViewController *)setVideoViewController:(NSString *)url;
-(void)setVideoViewController:(NSString *)url;
@end
