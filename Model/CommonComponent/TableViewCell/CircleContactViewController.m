//
//  CircleContactViewController.m
//  yihui
//
//  Created by air on 15/10/15.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "CircleContactViewController.h"
#import "SearchViewController.h"
#import "BUSystem.h"
#import "JYNoDataViewController.h"
#import "JYCommonTool.h"
#import "JYTableViewCellManager.h"
@interface CircleContactViewController ()
{

    UIView *_viewB;

    SearchViewController *_vc;
    NSMutableArray *_tempArr;
    NSMutableArray *_tempArr2;
    NSMutableArray *_localArr;
    NSInteger _curTab;
    JYNoDataViewController *_noVc;
}
@end

@implementation CircleContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setViewB];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) setViewB
{
    __weak CircleContactViewController *weakself = self;
    _vc = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    //    [self addChildViewController:vc];
    _vc.mode = NormoalMode;
    _vc.callBack = ^(NSMutableArray *arr){
        _tempArr = arr;
        
        [weakself getContactList];
    };
    _vc.isCanDelete = YES;
    _vc.deleteCallBack = ^(id obj){
        //        NSLog(@"sss ccc jjj");
        NSIndexPath *indexPath = obj;
        NSMutableDictionary *sDic = _localArr[indexPath.section];
        NSMutableArray *arr = sDic[@"value"];
         BUFriend *f = arr[indexPath.row];
        [busiSystem.circleUserManager deleteCircleMem:busiSystem.homePageManager.cid userId:f.circle_uid ext:@{@"userInfo":indexPath} observer:self  callback:@selector(delMemNotification:)];
    };
    
    _vc.canDeleteCallBack = ^(NSIndexPath *indexPath){
        NSMutableDictionary *sDic = _localArr[indexPath.section];
        NSMutableArray *arr = sDic[@"value"];
        BUFriend *f = arr[indexPath.row];
        if( [f.circle_uid integerValue] == busiSystem.agent.userId||[f.role integerValue] == 1)
        {
            return NO;
        }
        else{
            return YES;
        }
      
    };

    _vc.searchCallBack = ^(NSString *str){
        _tempArr2  = [NSMutableArray array];
        if ([str isEqualToString:@""]) {
            [_tempArr2 addObjectsFromArray:_localArr];
            [_tempArr removeAllObjects];
            [_tempArr addObjectsFromArray:_tempArr2];
            [_vc refreshTableView:_tempArr2];
        }
        else
        {
            [_localArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSDictionary *dic = obj;
                NSArray *arr = dic[@"value"];
                [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    BUFriend *f = obj;
                    //全拼搜索
                    if([[f.realNamePinYin uppercaseString] containsString:[str uppercaseString]])
                    {
                        [_tempArr2 addObject:f];
                    }
                    //拼音首字母
                    if ([[f.realNamePY uppercaseString] containsString:[str uppercaseString]]) {
                        if ([_tempArr2 indexOfObject:f] == NSNotFound) {
                            [_tempArr2 addObject:f];
                        }
                    }
                    //汉字搜索
                    if ([[f.realname uppercaseString] containsString:[str uppercaseString]]) {
                        if ([_tempArr2 indexOfObject:f] == NSNotFound) {
                            [_tempArr2 addObject:f];
                        }
                    }
                    
                }];
            }];
            NSArray *mArr = [self getSectionData:_tempArr2];
            [_tempArr removeAllObjects];
            [_tempArr addObjectsFromArray:mArr];
            [_vc refreshTableView:mArr];
        }
    };
    _viewB = _vc.view;
[self.view addSubview:_viewB];
}

-(void)delMemNotification:(BSNotification *)noti
{
    BASENOTIFICATION(noti);
    NSIndexPath *indexPath = noti.extraInfo[@"userInfo"];
    [self deleteRowHandle:indexPath];
}
-(void)deleteRowHandle:(NSIndexPath *)indexPath
{
    NSMutableDictionary *sDic = _localArr[indexPath.section];
    NSMutableArray *arr = sDic[@"value"];
    BUFriend *f = arr[indexPath.row];
    [arr removeObject:f];
    if(arr.count == 0)
    {
        [_localArr removeObject:sDic];
    }
    _tempArr2  = [NSMutableArray array];
    [_tempArr2 addObjectsFromArray:_localArr];
    NSArray *mArr = _tempArr2;
    [_tempArr removeAllObjects];
    [_tempArr addObjectsFromArray:mArr];
    [_vc refreshTableView:mArr];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshContactView" object:nil];
}

-(NSMutableArray *)getSectionData:(NSArray *)nArr
{
    NSMutableArray *tArr = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"key"] = @"管理者";
    dic[@"value"] = [NSMutableArray array];
    [tArr addObject:dic];
    [nArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BUFriend *frd = obj;
        if ([frd.role integerValue] != 3) {
            NSMutableDictionary *di1 = tArr[0];
            NSMutableArray *sArr = di1[@"value"];
            [sArr addObject:frd];
        }
        else
        {
            NSString *pname = [JYCommonTool toPingYin:frd.realname];
            
            
            //
            BOOL has = NO;
            NSMutableDictionary *selDic;
            for (NSMutableDictionary *obj2 in tArr) {
                NSString *frd2 = obj2[@"key"];
                if ([[[pname substringToIndex:1] uppercaseString] isEqualToString:frd2]) {
                    has = YES;
                    selDic = obj2;
                }
                else
                {
                    if([JYCommonTool hasNumberString:[pname substringToIndex:1]])
                    {
                        if ([frd2 isEqualToString:@"#"]) {
                            has = YES;
                            selDic = obj2;
                        }
                        
                    }
                }
            }
            
            
            if (!has) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                if ([JYCommonTool hasNumberString:[pname substringToIndex:1]]) {
                    dic[@"key"] = @"#";
                }
                else
                {
                    dic[@"key"] = [[pname substringToIndex:1] uppercaseString];
                }
                dic[@"value"] = [NSMutableArray arrayWithObjects:frd, nil];
                [tArr addObject:dic];
            }
            else
            {
                NSMutableArray *sArr = selDic[@"value"];
                [sArr addObject:frd];
            }
        }
    }];
    NSMutableDictionary *di1 = tArr[0];
    NSMutableArray *sArr = di1[@"value"];
    if (sArr.count == 0) {
        [tArr removeObject:di1];
    }
    [tArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString * v1 = ((NSDictionary *)obj1)[@"key"];
        NSString  *v2 = ((NSDictionary *)obj2)[@"key"];;
        NSComparisonResult sortResult =  [v1 isEqualToString:@"管理者"] ? NSOrderedAscending : [v1 compare:v2];
        return sortResult;
    }];
    
    return tArr;
}

-(void)getContactList
{
    //HUDSHOW(LoadingHintString);
    busiSystem.friendManager.friendList = nil;
    [busiSystem.friendManager getContactListWithCid:busiSystem.homePageManager.cid observer:self callback:@selector(contactListNotification:)];
}
-(void) contactListNotification:(BSNotification *) noti
{
//    [self didGroupNotification:noti];
BASENOTIFICATION(noti);
    [_tempArr removeAllObjects];
    //    [_tempArr addObjectsFromArray:busiSystem.friendManager.findFriendList];
    NSMutableArray *sArr = [busiSystem.friendManager getSectionData:busiSystem.friendManager.contactList hasManager:YES]; //[self getSectionData:busiSystem.friendManager.contactList];
    [_tempArr addObjectsFromArray:sArr];
    _localArr = sArr;
    [_vc refreshTableView:sArr];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
