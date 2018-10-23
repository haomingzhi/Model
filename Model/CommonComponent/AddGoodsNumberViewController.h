//
//  AddGoodsNumberViewController.h
//  compassionpark
//
//  Created by Steve on 2017/2/3.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddGoodsNumberViewController : JYBaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIImageView *line;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
- (IBAction)sureAction:(UIButton *)sender;
- (IBAction)reduceAction:(UIButton *)sender;
- (IBAction)addAction:(UIButton *)sender;
- (IBAction)deleteAction:(UIButton *)sender;
@property (nonatomic,assign) NSInteger maxNumber;
+(AddGoodsNumberViewController *)createVC:(UIViewController *)parentVC;
@property (nonatomic,strong) void (^callBack )(id o);
-(void)fitVCMode;
@end
