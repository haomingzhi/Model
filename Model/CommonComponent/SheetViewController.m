//
//  SheetViewController.m
//  compassionpark
//
//  Created by air on 2017/4/5.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SheetViewController.h"
#import "OnlyTitleTableViewCell.h"
@interface SheetViewController ()


@end

@implementation SheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTableView];
    [self fitMode];
}

-(void)fitMode
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initTableView{
    
    _tableView.bounces = NO;
//    _tableView.backgroundColor = kUIColorFromRGB(color_9);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [OnlyTitleTableViewCell registerTableViewCell:_tableView];
}

-(void)viewDidLayoutSubviews
{
    self.view.height = 40 *_dataArr.count + 10 + 45;
}

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _dataArr.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
      NSString *t = self.dataArr[indexPath.row];
        [(OnlyTitleTableViewCell*)cell setCellData:@{@"title":t}];
        [(OnlyTitleTableViewCell*)cell fitSheetMode];
        if (indexPath.row != _dataArr.count - 1) {
                  [(OnlyTitleTableViewCell*)cell showCustomSeparatorView:kUIColorFromRGB(color_lineColor) withInsets:UIEdgeInsetsMake(40, 0, 0, 0)];
        }
        else
        {
            [(OnlyTitleTableViewCell*)cell hiddenCustomSeparatorView];
        }
    }
    else
    {
        cell = [OnlyTitleTableViewCell dequeueReusableCell:_tableView];
        [(OnlyTitleTableViewCell*)cell setCellData:@{@"title":@"取消"}];
        [(OnlyTitleTableViewCell*)cell fitSheetModeB];
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 40;
    if (indexPath.section == 1) {
        height = 45;
    }
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = kUIColorFromRGB(color_0xf0f0f0);
    if (section == 1) {
        return nil;
    }
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 0.001;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_callback) {
        _callback(@{@"row":@(indexPath.row),@"isCancel":@(indexPath.section == 1)});
    }
    else
    {
        [self.parentDialog cancel];
    }
}

static SheetViewController *cvc;
+(SheetViewController *)toSheeVC:(NSArray*)dataArr
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cvc = [[SheetViewController alloc] init];
        
    });
    
    //   DealPasswordViewController *dealvc = [DealPasswordViewController new];
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:cvc];
    cvc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    cvc.dataArr = dataArr;
   
    myDialog.mydelegate = cvc;
    CGFloat h = 40 * cvc ->_dataArr.count + 10 + 45;
    //    myDialog.bgColor = [UIColor clearColor];
    myDialog.isDownAnimate = YES;
    [myDialog showAtPosition:CGPointMake(0, __SCREEN_SIZE.height - h) animated:YES];
    myDialog.dismissOnTouchOutside = NO;
     [cvc.tableView reloadData];
    
    return cvc;
    
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
