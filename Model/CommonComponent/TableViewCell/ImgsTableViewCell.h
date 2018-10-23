//
//  ImgsTableViewCell.h
//  yihui
//
//  Created by air on 15/8/31.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPhotoManager.h"
#import "JYAbstractTableViewCell.h"
@interface ImgsTableViewCell : JYAbstractTableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic)NSInteger limitCount;
//@property(nonatomic) AddImgMode mode;
@property(nonatomic)AddPhotoManager *addPhotoManager;
-(void)toPhoto;
-(void)initAddPhotoManager:(NSInteger)count withImgArr:(NSMutableArray *)aimgArr withVC:(UIViewController *)vc withTableView:(UITableView*)tableView;
-(void)toCheckOption:(id)userInfo;
-(void)delImg:(NSInteger )indexPath;
-(void)delImg:(NSInteger )indexPath withImgArr:(NSArray *)arr;
- (void) setupPhotoBrowser:(NSDictionary *)dic;


-(void)fitMode;
-(void)fitTopicMode;
-(void)fitEvaMode;
@end
