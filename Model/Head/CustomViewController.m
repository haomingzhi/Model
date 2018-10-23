//
//  CustomViewController.m
//  taihe
//
//  Created by LinFeng on 2016/11/29.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "CustomViewController.h"
#import "OnlyTitleTableViewCell.h"
#import "BUSystem.h"
#import "ImgTableViewCell.h"
#import "TitleDetailTableViewCell.h"

@interface CustomViewController (){
    OnlyTitleTableViewCell *_contentCell;
    TitleDetailTableViewCell *_titleCell;
}

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//     _scpid = @"348790fed93e4f8d851d628dc7a6c9a0";
    [self initTableView];
    HUDSHOW(@"加载中");
    [self getData];
    self.title = @"图文详情";
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getData{
    [busiSystem.getCustomManager getCustom:busiSystem.agent.sapid withScpid:_scpid observer:self callback:@selector(getCustomNotification:)];
}

-(void)getCustomNotification:(BSNotification *)noti{
    
    BASENOTIFICATION(noti);
    
    
    
    [_contentCell setCellData:@{@"title":busiSystem.getCustomManager.content}];
    [_contentCell fitRepairMode];
    
    [_titleCell setCellData:@{@"title":busiSystem.getCustomManager.title,@"detail":busiSystem.getCustomManager.createTime}];
    [_titleCell fitCustomMode];
    
    _tableView.dataArr = [NSMutableArray arrayWithArray:busiSystem.getCustomManager.imagePath];
    [_tableView reloadData];
    
}

- (void)initTableView{
    
    
    _contentCell = (OnlyTitleTableViewCell *)[OnlyTitleTableViewCell createTableViewCell];
    
    _titleCell = (TitleDetailTableViewCell *)[TitleDetailTableViewCell createTableViewCell];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.height = __SCREEN_SIZE.height - 64;
    _tableView.refreshHeaderView = nil;
    _tableView.width = __SCREEN_SIZE.width;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [ImgTableViewCell registerTableViewCell:_tableView];
    
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableView.dataArr.count +2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            cell = _titleCell;
            break;
        case 1:
            cell = _contentCell;
            break;
        default:
        {
            cell = [ImgTableViewCell dequeueReusableCell:_tableView];
            [(ImgTableViewCell *)cell fitRepairsMode:_tableView.dataArr[indexPath.row -2]];
        }
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return _titleCell.cellHeight;
    }
    
    if (indexPath.row == 1) {
        if (busiSystem.getCustomManager.content) {
            CGSize size = [busiSystem.getCustomManager.content size:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(__SCREEN_SIZE.width - 30, __SCREEN_SIZE.height*2)];
            return  size.height+25;
        }
    }
    return (__SCREEN_SIZE.width -30)/330.0*200 +10;
}

@end
