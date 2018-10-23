//
//  MyActionViewController.h
//  compassionpark
//
//  Created by Steve on 2017/3/2.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface MyActionViewController : JYBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *titleOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *titleTwoBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)titleOneAction:(UIButton *)sender;
- (IBAction)titleTwoAction:(UIButton *)sender;

- (IBAction)canCelAction:(UIButton *)sender;
+(MyActionViewController *)createLimitVC;
-(void)setData:(NSDictionary *)dic;
@end
