//
//  TitleAndDetailWithImgTableViewCell.h
//  yihui
//
//  Created by air on 15/9/1.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
#import "AddPhotoManager.h"
@interface TitleAndDetailWithImgTableViewCell : JYAbstractTableViewCell
@property(nonatomic)AddPhotoManager *addPhotoManager;
-(void)fitTaskCenterMode;
-(void)fitMyYoubiMode;
-(void)fitPersonCenterMode;

-(void)toPhoto;
-(void)initAddPhotoManager:(NSInteger)count withImgArr:(NSMutableArray *)aimgArr withVC:(UIViewController *)vc withTableView:(UITableView*)tableView;
-(void)toCheckOption:(id)userInfo;
-(void)delImg:(NSInteger )indexPath;
-(void)delImg:(NSInteger )indexPath withImgArr:(NSArray *)arr;
- (void) setupPhotoBrowser:(NSDictionary *)dic;

@end
