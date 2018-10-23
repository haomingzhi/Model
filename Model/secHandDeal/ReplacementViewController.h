//
//  ReplacementViewController.h
//  intelligentgarbagecollection
//
//  Created by air on 2017/12/6.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>
#import "BUSystem.h"
@interface ReplacementViewController : BaseTableViewController
@property(nonatomic,strong) BUGetSecondhandGoods *secondHandGoods;
@property(nonatomic,strong)NSString *ID;
@end
