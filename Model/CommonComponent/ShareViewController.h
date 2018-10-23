//
//  ShareViewController.h
//  compassionpark
//
//  Created by air on 2017/4/12.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SheetViewController.h"

@interface ShareViewController : SheetViewController
@property(nonatomic,strong)void (^shareHandle)(id o);
+(ShareViewController *)toShareVC:(NSArray*)dataArr;
-(void)fitNoQQMode;
@end
