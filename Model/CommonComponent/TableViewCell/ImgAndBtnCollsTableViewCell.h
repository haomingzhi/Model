//
//  ImgAndBtnCollsTableViewCell.h
//  taihe
//
//  Created by air on 2016/11/14.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
#import "AddPhotoManager.h"
@interface ImgAndBtnCollsTableViewCell : JYAbstractTableViewCell
@property(nonatomic)AddPhotoManager *addPhotoManager;
-(void)fitUpPersonInfoMode;
-(void)fitCompanyCerMode;
-(void)fitPersonCerInfoMode;
-(void)fitCerInfoMode;
-(void)fitCerInfoModeB;
-(void)toPhoto;
-(void)initAddPhotoManager:(NSInteger)count withImgArr:(NSMutableArray *)aimgArr withVC:(UIViewController *)vc withTableView:(UITableView*)tableView;
-(void)toCheckOption:(id)userInfo;
-(void)delImg:(NSInteger )indexPath;
-(void)delImg:(NSInteger )indexPath withImgArr:(NSArray *)arr;
- (void) setupPhotoBrowser:(NSDictionary *)dic;
@end
