//
//  MIneTableViewCell.h
//  ulife
//
//  Created by sunmax on 15/12/11.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;



- (void)setCellImage:(NSString *)image name:(NSString *)name;
@end
