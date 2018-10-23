//
//  GoodsParameterViewController.h
//  oranllcshoping
//
//  Created by Steve on 2017/8/8.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface GoodsParameterViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet MyTableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

- (IBAction)deleteBtnAction:(UIButton *)sender;
+(GoodsParameterViewController *)createVC:(NSDictionary *)dataDic;
@end
