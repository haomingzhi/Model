//
//  ShowIntegralViewController.h
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/18.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowIntegralViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *integralLb;
- (IBAction)btnAction:(UIButton *)sender;
+(ShowIntegralViewController *)toShowIntrgral:(NSString *)title withIntegral:(NSString *)integral;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@end
