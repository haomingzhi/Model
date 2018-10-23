//
//  ShowCodeViewController.h
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/15.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JYBaseTableViewController.h"
@interface ShowCodeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *bgBtn;
- (IBAction)bgBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *dateLb;
@property (weak, nonatomic) IBOutlet UILabel *weekLb;
@property (weak, nonatomic) IBOutlet UIButton *signBtn;
- (IBAction)signAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

- (IBAction)btnAction:(UIButton *)sender;


@property (nonatomic,strong) id img;
@property (nonatomic,strong) NSDictionary *dataDic;
-(void)fitCellMode;
+(ShowCodeViewController *)toCreateVC:(NSDictionary *)dic;
@property (nonatomic,assign) NSInteger count;
@property(nonatomic,strong) void (^handleGoBack)(id userData);
@end
