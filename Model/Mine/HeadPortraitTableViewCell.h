//
//  HeadPortraitTableViewCell.h
//  ulife
//
//  Created by sunmax on 15/12/11.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUImageRes.h"
#import "JYAbstractTableViewCell.h"
@interface HeadPortraitTableViewCell : JYAbstractTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headImage;
@property (weak, nonatomic) IBOutlet UIButton *userName;
@property (nonatomic, strong)void (^pushLogin)();

- (void)setcell:(BUImageRes *)imageRes userName:(NSString *)userName;

-(UIImageView *)imgView;
-(void)fitRegMode;
@end
