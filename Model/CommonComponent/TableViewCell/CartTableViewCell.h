//
//  CartTableViewCell.h
//  oranllcshoping
//
//  Created by Steve on 2017/7/24.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"

@interface CartTableViewCell : JYAbstractTableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *selectedImgV;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *typeLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UIButton *selectedtypeBtn;
- (IBAction)selectdTypeAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
- (IBAction)reduceAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *numTextField;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addAction:(UIButton *)sender;
-(void)fitCellMode;
-(void)setIsSelect:(BOOL)isSelect isEdit:(BOOL)isEdit;
@end
