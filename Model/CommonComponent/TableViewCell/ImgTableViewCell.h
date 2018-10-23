//
//  ImgTableViewCell.h
//  ChaoLiu
//
//  Created by air on 15/7/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYAbstractTableViewCell.h"
#import "BUImageRes.h"
#import "AddPhotoManager.h"
@interface ImgTableViewCell :JYAbstractTableViewCell
//-(void)setCellData:(NSDictionary *)dataDic;
//-(CGFloat)heightOfCell:(UIImage *)img;
@property(nonatomic)AddPhotoManager *addPhotoManager;
@property(nonatomic,strong) void (^imgChangeHandle)(id sender);
@property(nonatomic,strong) IBOutlet UIImageView *imgV;
-(void)fitMyActivityMode:(NSString *)imgName;
-(void)fitMyActivityMode;
-(void)fitRepairsMode:(BUImageRes *)image;
-(void)fitActivityListMode;
-(void)fitTeacherMode;
-(void)fitMyInviteMode;
-(void)fitExamTicketMode;
-(void)fitActMsgMode;
-(void)fitHeadMode;
-(void)fitOddsRecMode;
-(void)fitBrandMakeShopMode;
-(void)fitEvaInfoMode;
-(void)fitYouBiRuleMode;
-(void)fitTopicMode;
-(void)fitshopMode;
-(void)fitAboutUsMode;
-(void)fitReplacementMode;
-(void)fitDiscoveMode;
-(void)fitSeverCenterMode;
-(void)fitZhiMaAuthMode;


-(void)toPhoto;
-(void)initAddPhotoManager:(NSInteger)count withImgArr:(NSMutableArray *)aimgArr withVC:(UIViewController *)vc withTableView:(UITableView*)tableView;
-(void)toCheckOption:(id)userInfo;
-(void)delImg:(NSInteger )indexPath;
-(void)delImg:(NSInteger )indexPath withImgArr:(NSArray *)arr;
- (void) setupPhotoBrowser:(NSDictionary *)dic;
@end
