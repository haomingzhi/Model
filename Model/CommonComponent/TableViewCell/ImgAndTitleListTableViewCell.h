//
//  ImgAndTitleListTableViewCell.h
//  lovecommunity
//
//  Created by air on 16/6/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
@interface ImgAndTitleListTableViewCell : JYAbstractTableViewCell
@property(nonatomic,strong)void (^delCallback)(id o);
@property(nonatomic,strong)void (^fitCellMode)(id o);
-(void)setCellData:(NSDictionary *)dataDic;
-(void)fitHeadMode;
-(void)fitHeadModeB;
@end
