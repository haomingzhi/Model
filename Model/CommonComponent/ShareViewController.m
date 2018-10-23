//
//  ShareViewController.m
//  compassionpark
//
//  Created by air on 2017/4/12.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "ShareViewController.h"
#import "ThreeBtnTableViewCell.h"
#import "OnlyTitleTableViewCell.h"
@implementation ShareViewController
{
     ThreeBtnTableViewCell *_shareCell;
     OnlyTitleTableViewCell *_titleCell;
}
-(id)init
{

     self = [super initWithNibName:@"SheetViewController" bundle:nil];
     return self;
}
-(void)viewDidLayoutSubviews
{
     self.view.height = 195;
}
-(void)initTableView{

     [super initTableView];
     _shareCell = [ThreeBtnTableViewCell createTableViewCell];
     _titleCell = [OnlyTitleTableViewCell createTableViewCell];
     [_titleCell setCellData:@{@"title":@"懂得分享的人最豪"}];
     self.tableView.backgroundColor = kUIColorFromRGB(color_0xf7f7f7);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
     UIView *v = [[UIView alloc] init];
     v.backgroundColor = kUIColorFromRGB(color_0xf7f7f7);
     if (section == 1) {
          return nil;
     }
     return v;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     if (section == 0) {
          return 2;
     }
     return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell *cell;
     if (indexPath.section == 0) {
          if (indexPath.row == 0) {
               cell = _titleCell;
               [_titleCell fitShareMode];
          }
          else
          {
               cell = _shareCell;
               NSDictionary *dic = self.dataArr[0];
               //        _shareCell = [ThreeBtnTableViewCell createTableViewCell];
               [_shareCell setCellData:dic];
               [_shareCell fitShareMode];

               __weak ShareViewController *weakSelf = self;
               [weakSelf fitNoQQMode];
               [_shareCell setHandleAction:^(NSDictionary *dic) {
                    UIButton *btn = dic[@"sender"];
                    if (weakSelf.shareHandle) {
                         weakSelf.shareHandle(btn);
                    }
               }];
          }
     }
     else
     {
          cell = [OnlyTitleTableViewCell dequeueReusableCell:self.tableView];
          [(OnlyTitleTableViewCell*)cell setCellData:@{@"title":@"取消"}];
          [(OnlyTitleTableViewCell*)cell fitSheetModeB];
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     CGFloat height = 100;
     if (indexPath.section == 0 && indexPath.row == 0) {
          height = 40;
     }
     else
          if (indexPath.section == 1) {
               height = 45;
          }
     return height;
}

-(void)fitNoQQMode
{
     [_shareCell getBtn:2].hidden = YES;

}

static ShareViewController *svc;
+(ShareViewController *)toShareVC:(NSArray*)dataArr
{
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
          svc = [[ShareViewController alloc] init];

     });

     //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
     MyDialog *myDialog = [[MyDialog alloc] initWithViewController:svc];
     svc.view.width = __SCREEN_SIZE.width;
     //    vc.doneCallBack = ^(NSString *pwd){
     //        [weakSelf toAddwithdraw:pwd];
     //    };
     svc.dataArr = dataArr;

     myDialog.mydelegate = svc;
     CGFloat h = 195;
     //    myDialog.bgColor = [UIColor clearColor];
     myDialog.isDownAnimate = NO;
     [myDialog showAtPosition:CGPointMake(0, __SCREEN_SIZE.height - h) animated:YES];
     myDialog.dismissOnTouchOutside = NO;
     [svc.tableView reloadData];

     return svc;

}

@end
