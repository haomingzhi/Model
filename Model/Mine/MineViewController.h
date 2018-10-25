//
//  MineViewController.h
//  B2C
//
//  Created by air on 15/7/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface MineViewController : UIViewController
@property (nonatomic, copy, setter=loginoutBlock:) void (^loginoutBlock)(void);

//-(void)toWitchView:(id)data type:(NSInteger)type;
@end
