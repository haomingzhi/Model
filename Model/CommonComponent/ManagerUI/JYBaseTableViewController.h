//
//  JYBaseTableViewController.h
//  TestTableView
//
//  Created by wujiayuan on 15/8/13.
//  Copyright (c) 2015年 wujyapp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TableStyle) {
    TableStyleGroup,
    TableStylePlain
};

@protocol JYBaseTableViewDelegate<NSObject>
@optional
-(NSString *)getTitle;
-(void)initTableViewCells:(NSMutableArray *)cellArr;
-(void)initTableViewCells:(NSMutableArray *)cellArr withTableView:(UITableView *)tableView;
-(void)initTableViewCells:(NSMutableArray *)cellArr withTableView:(UITableView *)tableView context:(UIViewController *)context;
-(void)registerTableViewCell:(NSString *)tableViewCellName withTableView:(UITableView *)tableView;
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView;
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)deleteCellHandleAction:(NSIndexPath *)indexPath;
-(NSInteger)allSelected:(BOOL)isSelected;//返回选择的数量
-(UIView *)getNoDataView;//无数据时显示的视图
-(void)rightHandleActon:(id)sender;
-(void)setFootView:(UITableView *)tableView;
-(void)btnHandle:(NSString *)keyword;
@end

@interface JYBaseTableViewController : BaseTableViewController
@property(nonatomic)TableStyle tableStyle;
@property(nonatomic,strong) id<JYBaseTableViewDelegate> delegate;
-(void)refreshCurentPage:(id) obj;
-(void)deleteAllCelllManager;
@end
