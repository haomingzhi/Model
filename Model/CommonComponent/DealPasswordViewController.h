//
//  DealPasswordViewController.h
//  lovecommunity
//
//  Created by air on 16/8/24.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface DealPasswordViewController : JYBaseViewController
@property(nonatomic,strong) MyPwdTextField *passwordTf;
@property(nonatomic,strong)IBOutlet UIButton *forgetBtn;
@property (strong, nonatomic) IBOutlet UIButton *closeBtn;

@property(nonatomic,strong)IBOutlet UILabel *titleLb;
@property(nonatomic,strong)IBOutlet UILabel *tipLb;
 @property(nonatomic,strong) UIViewController *parentVC;
@property(nonatomic,copy)void (^doneCallBack)(id);
@property(nonatomic,copy)void (^forgetCallBack)(id);
@property(nonatomic,copy)void (^reDoCallBack)(id);
@property(nonatomic,strong)id userInfo;
+(DealPasswordViewController *)toDealVC:(UIViewController *)parentVC;
-(void)fitMode;
@end
