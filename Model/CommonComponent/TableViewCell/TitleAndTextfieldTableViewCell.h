//
//  TitleAndTextfieldTableViewCell.h
//  spokesman
//
//  Created by LinFeng on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"

@interface TitleAndTextfieldTableViewCell : JYAbstractTableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (assign,nonatomic) NSInteger state;
//@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
-(void)hiddenTextField;
-(void)fitCellMode;
-(void)fitUpPersonInfoMode;
-(void)fitConfirmOrderMode;
-(void)fitWithdrawMode;
-(void)fitUserCardRechargeMode;
-(void)fitUpPersonInfoModeB;
-(void)fitPersonInfoMode;
-(void)fitInvoiceMode;
-(void)fitFillOrderMode;
@end
