//
//  RegisterViewController.h
//  taihe
//
//  Created by air on 2016/11/9.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "OnlyBottomBtnTableViewCell.h"
#import "TextFieldTableViewCell.h"
#import "TitleAndTextBtnTableViewCell.h"
#import "RegisterNextViewController.h"
@interface RegisterViewController : BaseTableViewController
@property (strong, nonatomic)OnlyBottomBtnTableViewCell *nextCell;
@property (strong, nonatomic)TitleAndTextBtnTableViewCell *tipCell;
@property (strong, nonatomic)TextFieldTableViewCell *phoneCell;
@property (strong, nonatomic)TextFieldTableViewCell *codeCell;
@property (strong, nonatomic)TextFieldTableViewCell *pwdCell;
@property (strong, nonatomic)TextFieldTableViewCell *surepwdCell;
 @property (strong, nonatomic) OnlyBottomBtnTableViewCell *toLoginBtnCell;
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
-(void)checkSns:(UIButton *)btn;
@end
