//
//  AboutUsTableViewCell.h
//  ulife
//
//  Created by sunmax on 15/12/10.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface AboutUsTableViewCell : JYAbstractTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *edition;
@property (weak, nonatomic) IBOutlet UILabel *introduces;

- (void)setCellEdition:(NSString *)edition;

- (void)setCellIntroduces:(NSString *)introduces;

- (void)setCellLogo;

- (void)setintroducesContent;

@end
