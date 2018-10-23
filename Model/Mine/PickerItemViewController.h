//
//  PickerItemViewController.h
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/8/6.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//



@interface PickerItemViewController : JYBaseViewController
@property (nonatomic,strong) NSString *selectedString;
@property(nonatomic,strong) void (^handleSelect)(NSInteger index);
+(void)showSelect:(NSArray *) selectList completion:(void (^)(NSInteger index))completion;
@end
