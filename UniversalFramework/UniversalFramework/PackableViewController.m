//
//  PackableViewController.m
//  UniversalFramework
//  可收缩表格
//  Created by ORANLLC_IOS1 on 15/10/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "PackableViewController.h"
@implementation groupView



@end

@interface PackableViewController ()

@end

@implementation PackableViewController
{
    NSMutableArray* headViewArray;
    NSArray * _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    headViewArray=[[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setDataSource:(NSArray *) dataSource
{
    _dataSource = dataSource;
    [self loadHeadView];
}


-(groupView *) getGroupview:(id) groupData
{
    return [[groupView alloc] init];
   
    
}

- (void)loadHeadView
{
    [headViewArray removeAllObjects];
    int sectionIndex=0 ;
    for (NSDictionary * dataItem in _dataSource) {
        //id key = dataItem[@"key"];
        groupView *gv = [self getGroupview:dataItem index: sectionIndex];
        gv.section =sectionIndex;
        NSArray *ds = (NSArray *)dataItem[@"value"];
        gv.handleOpen = ^(id sender,NSInteger sectionIndex)
        {
            groupView *owner = (groupView *) sender;
            owner.open = !owner.open;
            [self.view.subviews[0] reloadData];
        };
        gv.open =gv.is_search?YES:ds.count==0?0:sectionIndex==0;
        [headViewArray addObject:gv];
        sectionIndex++;
    }
    [self.view.subviews[0] reloadData];
}


#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    groupView *gv = headViewArray[indexPath.section];
   // return gv.frame.size.height;
    return 53;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     groupView *gv = headViewArray[section];
    UILabel *topline=(UILabel *)[gv viewWithTag:100];
    UILabel *bottomline=(UILabel *)[gv viewWithTag:200];
   
    if (section>0&&((groupView *)headViewArray[section-1]).open) {
        NSArray *ds = (NSArray *)[_dataSource[section -1] objectForKey:@"value"];
        topline.frame=ds.count!=0?CGRectMake(0, 0, __SCREEN_SIZE.width, 1):
        CGRectZero;
    }
    else{
        topline.frame=section==0?CGRectMake(0, 0, __SCREEN_SIZE.width, 1):
         CGRectZero;
    }
    if (section==headViewArray.count-1&&!gv.open) {
        bottomline.frame=CGRectMake(0, gv.height-1, __SCREEN_SIZE.width, 1);
    }
    else{
        bottomline.frame=CGRectMake(14, gv.height-1, __SCREEN_SIZE.width, 1);
    }
    
    return gv;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 53;
}
#pragma mark --UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    groupView *gv = headViewArray[section];
    if (!gv.open) {
        return 0;
    }
    NSArray *ds = (NSArray *)[_dataSource[section] objectForKey:@"value"];
    return ds.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return headViewArray.count;
}


@end
