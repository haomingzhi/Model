//
//  JYAbstractTableViewCell.h
//  TestTableView
//
//  Created by wujiayuan on 15/8/29.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYAbstractTableViewCell : UITableViewCell
+(id)createTableViewCell;
+(void)registerTableViewCell:(UITableView *)tableView;
+(void)registerTableViewCell:(UITableView *)tableView withTag:(NSString*)tag;
+(id)dequeueReusableCell:(UITableView *)tableView;
+(id)dequeueReusableCell:(UITableView *)tableView  withTag:(NSString*)tag;
-(void)setCellData:(NSDictionary *)dataDic;
-(id)heightOfCell;
-(void)showSeparatorView;

-(void)hiddenSeparatorView;
-(void)showSeparatorView:(UIColor *)color withInsets:(UIEdgeInsets)insets;
@property(nonatomic)bool hasInit;
@property(nonatomic)bool isDispear;
@property(nonatomic)bool isNoData;
@property(nonatomic,strong) void (^handleAction)(id sender);
@property(nonatomic,strong) id (^handleActionHasBack)(id sender);
-(void)fitContentSize:(UIView *)view;
-(void)fitContentSize:(UIView *)view withPadding:(UIEdgeInsets)inset;
-(CGFloat)getCellHeight;
-(void)showCustomSeparatorView:(UIColor *)color withInsets:(UIEdgeInsets)insets;
-(void)showCustomSeparatorView;
-(void)hiddenCustomSeparatorView;
-(void)modifiDeleteBtn;
@end
