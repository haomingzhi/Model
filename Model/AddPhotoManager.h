//
//  AddPhotoManager.h
//  compassionpark
//
//  Created by air on 2017/4/5.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYAbstractTableViewCell.h"
@interface AddPhotoManager : NSObject
@property(nonatomic)NSInteger count;
@property(nonatomic,strong)void (^checkDoneCallBack)(id o);
@property(nonatomic,strong)void (^cancelCheckCallBack)();
@property(nonatomic,strong)void (^delImgCallBack)(id o);
-(id)initWith:(id)obj withImgArr:(NSMutableArray *)imgArr withCell:(JYAbstractTableViewCell *)cell withTableView:(UITableView *)tableView;
- (void) setupPhotoBrowser:(NSDictionary *)dic;
-(void)toPhoto;
-(void)toCheckOption:(id)userInfo;
-(void)delImg:(NSInteger )indexPath;
-(void)delImg:(NSInteger )indexPath withImgArr:(NSArray *)arr;
@end
