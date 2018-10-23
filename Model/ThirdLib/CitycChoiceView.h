//
//  CitycChoiceView.h
//  ulife
//
//  Created by sunmax on 15/12/25.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitycChoiceView : UIView
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (nonatomic,strong) void (^switchCity)();

@end
