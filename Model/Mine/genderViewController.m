//
//  genderViewController.m
//  B2C
//
//  Created by ORANLLC_IOS1 on 15/7/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "genderViewController.h"
#import "BUSystem.h"

@interface genderViewController ()

@end

@implementation genderViewController
{
    NSArray *itemList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    itemList = @[@"男",@"女",@"取消"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- UITableViewDataSource


//绑定 tableview 的数据源
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSInteger startTag = 8453;
    static NSString * identify = @"Tableidentify";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 40)]; //标题
        lable.backgroundColor = [UIColor clearColor];
        lable.font = [UIFont fontWithName:FONT_NAME_BODY size:FONTS_H4];
        lable.textColor = kUIColorFromRGB(color_mainTheme);
        lable.textAlignment = NSTextAlignmentCenter;
        lable.tag = startTag;
        [cell.contentView addSubview:lable];
        
    }
    
    UILabel *labelTitle = (UILabel *)[cell.contentView viewWithTag:startTag];
    labelTitle.text = itemList[indexPath.row];
    
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    //向右箭头样式
    
    //自定义cell 被选中的颜色
    cell.backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return itemList.count;
}


//委托解决行高问题
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   40;
}

#pragma  mark --UITableViewDelegate

//行的选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *selectValue = itemList[indexPath.row];
//    if ([selectValue isEqualToString:@"取消"]) {
//        
//        [self.parentDialog cancel];
//    }
//    else {
//        busiSystem.agent.gender = selectValue;
//        HUDSHOW(SubmitHintString);
//        [busiSystem.agent changeUserInfo:self callback:@selector(changeUserInfoNotification:)];
//    }
}


-(void) changeUserInfoNotification:(BSNotification *) noti
{
    BASENOTIFICATION(noti);
    [self.parentDialog dismiss];
}

@end
