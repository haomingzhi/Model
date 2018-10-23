//
//  SingleSelectionViewController.h
//  taihe
//
//  Created by air on 2016/11/18.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface SingleSelectionViewController : JYBaseViewController
@property(nonatomic,strong) void (^handleAction)(id o);
@property(nonatomic,strong)NSArray *dataArr;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *sureBtn;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UILabel *lineLb;
@property(nonatomic)NSInteger curRow;
+(SingleSelectionViewController *)toSingleSelectionVC:(NSArray*)dataArr;
@end
