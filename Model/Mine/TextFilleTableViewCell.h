//
//  TextFilleTableViewCell.h
//  ulife
//
//  Created by sunmax on 15/12/10.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFilleTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong)void(^recovery)();
- (void)setCell:(NSString *)placeHolder;
@end
