//
//  InstructionsTableViewCell.h
//  ulife
//
//  Created by sunmax on 15/12/11.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstructionsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;

- (void)setCellInstructions:(NSString *)instructions;

@end