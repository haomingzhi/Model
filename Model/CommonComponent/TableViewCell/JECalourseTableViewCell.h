//
//  JECalourseTableViewCell.h
//  rentingshop
//
//  Created by air on 2018/3/8.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
#import "JECalourseView.h"
@interface JECalourseTableViewCell : JYAbstractTableViewCell<JECalourseViewDataSource>
 
@property(nonatomic,strong)JECalourseView* calourse;
@property(nonatomic,strong) void (^selecedtItem)(id sender);
-(void)fitHeadMode;
@end
