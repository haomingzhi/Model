//
//  BUMyAnnotationView.h
//  intelligentgarbagecollection
//
//  Created by Steve on 2017/12/19.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "BUSystem.h"

@interface BUMyAnnotationView : MAAnnotationView
@property (nonatomic,strong) BUGetStationInfo *station;
@end
