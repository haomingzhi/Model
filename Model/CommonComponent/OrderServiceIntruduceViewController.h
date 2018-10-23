//
//  OrderServiceIntruduceViewController.h
//  oranllcshoping
//
//  Created by Steve on 2017/7/24.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface OrderServiceIntruduceViewController : JYBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
- (IBAction)deleteAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet MyTableView *tableView;


+(OrderServiceIntruduceViewController *)createVC:(NSDictionary *)dic;
@end
