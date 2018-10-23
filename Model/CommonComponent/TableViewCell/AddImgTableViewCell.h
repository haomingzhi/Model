//
//  AddImgTableViewCell.h
//  ChaoLiu
//
//  Created by air on 15/7/16.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPhotoManager.h"
#define AddImgListCellWidth 80//((__SCREEN_SIZE.width)/3.0 - 68)
#define AddImgListScale 1


#import "JYAbstractTableViewCell.h"
typedef enum : NSUInteger {
    AddImgModeFix,
    AddImgModeMutable
} AddImgMode;
@interface AddImgTableViewCell : JYAbstractTableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic)NSInteger limitCount;
@property(nonatomic) AddImgMode mode;
@property(nonatomic)AddPhotoManager *addPhotoManager;
@property(nonatomic,strong) void (^fitCellMode)(id o);
@property (nonatomic,assign)BOOL head;
-(void)fitMode:(CGFloat)y;
-(void)setNull;
//-(void)fitMode;
-(void)fitRepairServerMode;
-(void)fitHeadPromoteMode;
-(void)fitSendInfoMode;
-(void)fitCommentMode;
-(void)fitPersonInfoSettingMode;
-(void)fitPublishSecHandDealMode;
//@property(nonatomic,strong) void (^selecedtItem)(NSInteger row);
//@property(nonatomic,strong) void (^deleteItem)(NSInteger row);
//-(void)setCellData:(NSArray *)dataArr;
//@property(nonatomic)
-(void)toPhoto;
-(void)initAddPhotoManager:(NSInteger)count withImgArr:(NSMutableArray *)aimgArr withVC:(UIViewController *)vc withTableView:(UITableView*)tableView;
-(void)toCheckOption:(id)userInfo;
-(void)delImg:(NSInteger )indexPath;
-(void)delImg:(NSInteger )indexPath withImgArr:(NSArray *)arr;
- (void) setupPhotoBrowser:(NSDictionary *)dic;
-(void)fitFeedbackMode;
-(void)fitPublishEvaMode;
-(void)fitPublishAnswerMode;
@end
