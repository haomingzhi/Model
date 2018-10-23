//
//  HyperlinksButton.h
//  lovecommunity
//
//  Created by air on 16/6/27.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HyperlinksButton : UIButton
{
    UIColor *lineColor;
}
@property(nonatomic,strong)id userInfo;
-(void)setColor:(UIColor*)color;
@end
