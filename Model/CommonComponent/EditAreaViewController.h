//
//  EditAreaViewController.h
//  compassionpark
//
//  Created by air on 2017/3/30.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAreaViewController : UIViewController
-(void)fitMode;
@property(nonatomic,strong) void (^handleAction)(id o);
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic)NSInteger curRow;
@property (strong, nonatomic) IBOutlet UIPickerView *areaPv;
+(EditAreaViewController *)toEditAreaVC:(NSArray*)dataArr;
@end
