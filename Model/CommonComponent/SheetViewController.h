//
//  SheetViewController.h
//  compassionpark
//
//  Created by air on 2017/4/5.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheetViewController : UIViewController
@property(nonatomic,strong)void (^callback)(id o);
@property(nonatomic,strong)NSArray *dataArr;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(void)initTableView;
+(SheetViewController *)toSheeVC:(NSArray*)dataArr;
@end
