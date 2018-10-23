//
//  ShareFriendViewController.h
//  compassionpark
//
//  Created by air on 2017/3/16.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareFriendViewController : UIViewController
@property(nonatomic,strong)void (^callBack)(id o);
+(ShareFriendViewController *)toShareVC;
@end
