//
//  DDCarouselTableViewCell.h
//  DDZX_xyzx
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 ddzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDCarouselTableViewCell : UITableViewCell
@property(nonatomic,strong)void (^callBack)(NSDictionary *dic);
- (void)refresh:(NSDictionary *)dic;
@end
