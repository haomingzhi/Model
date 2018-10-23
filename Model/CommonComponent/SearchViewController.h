//
//  SearchViewController.h
//  yihui
//
//  Created by air on 15/9/8.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//
typedef enum : NSUInteger {
    NormoalMode,
    BtnShowMode,
    BtnTipShowMode
} ContactCellMode;

#import  <UniversalFramework/UniversalFramework.h>
@interface SearchViewController : BaseTableViewController
@property(nonatomic,strong) void (^callBack)(id obj);
@property(nonatomic) ContactCellMode mode;
-(void)initTableViewSections:(NSArray *)arr;
-(void)refreshTableView:(NSArray*)arr;
@property(nonatomic) BOOL isCanDelete;
@property(nonatomic,strong)  BOOL (^canDeleteCallBack)(id obj);//返回是否可以删除
@property(nonatomic,strong)NSString *noDataTip;
@property(nonatomic,strong)NSString *noDataBtnTip;
@property(nonatomic,strong) void (^selectedRowcallBack)(NSIndexPath *indexPath);
@property(nonatomic,strong) void (^callBtncallBack)(id obj);
@property(nonatomic,strong) void (^deleteCallBack)(id obj);
@property(nonatomic,strong) void (^searchCallBack)(NSString *str);
@property(nonatomic,strong) void (^noDataBtnCallBack)(id obj);
@end
