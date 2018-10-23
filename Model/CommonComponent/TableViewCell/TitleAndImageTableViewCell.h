//
//  TitleAndImageTableViewCell.h
//  yihui
//
//  Created by ORANLLC_IOS1 on 15/10/19.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
#import "AddPhotoManager.h"
@interface TitleAndImageTableViewCell : JYAbstractTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property(nonatomic)AddPhotoManager *addPhotoManager;
-(void)fitPersonMode;
-(void)fitRegNextMode;
-(void)fitUserCerMode;
-(void)fitCerTypeMode;
-(void)fitPublishActMode;
-(void)fitChoseUnitMode;
-(void)fitSeverCenterMode;
-(void)toPhoto;
-(void)initAddPhotoManager:(NSInteger)count withImgArr:(NSMutableArray *)aimgArr withVC:(UIViewController *)vc withTableView:(UITableView*)tableView;
-(void)toCheckOption:(id)userInfo;
-(void)delImg:(NSInteger )indexPath;
-(void)delImg:(NSInteger )indexPath withImgArr:(NSArray *)arr;
- (void) setupPhotoBrowser:(NSDictionary *)dic;
-(void)fitPersonInfoMode;
-(void)fitAuditProgressMode;
-(void)fitPublishEvaMode;
-(void)fitSearchMode;
-(void)fitPublishAnswerMode;
-(void)fitPublishSecHandMode;
-(void)fitReplacementMode;
-(void)fitPublishEvaModeB;
-(void)fitSexCheckMode;
@end
