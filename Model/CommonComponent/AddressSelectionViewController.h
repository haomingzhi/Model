//
//  AddressSelectionViewController.h
//  rentingshop
//
//  Created by air on 2018/4/3.
//  Copyright © 2018年 ORANLLC_IOS1. All rights reserved.
//

#import <UniversalFramework/UniversalFramework.h>

@interface AddressSelectionViewController : BaseTableViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property(nonatomic,strong) void (^handleAction)(id o);
@property(nonatomic,strong)NSArray *dataArr;
//@property(nonatomic)NSInteger curRow;
+(AddressSelectionViewController *)toAddressSelectionVC:(NSArray*)dataArr;
@end
