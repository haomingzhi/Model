//
//  ZoneChoseViewController.m
//  taihe
//
//  Created by air on 2016/11/16.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "ZoneChoseViewController.h"
#import "BUSystem.h"
@interface ZoneChoseViewController ()

@end

@implementation ZoneChoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setDataSource
{
//    self.dataArr = [NSMutableArray array];
//    [self.dataArr addObject:@"东二环泰禾"];
//    [self.dataArr addObject:@"园区一"];
//    [self.dataArr addObject:@"园区二"];
//    [self.dataArr addObject:@"园区三"];
//    [self.dataArr addObject:@"园区四"];
    [self.collectionView reloadData];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.curIndexPath) {
        self.curIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    SelectBtnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectBtnCollectionViewCell" forIndexPath:indexPath];
    BUAreaPark *pk = self.dataArr[indexPath.row];
    [cell setCellData:@{@"title":pk.name,@"isChecked":@(self.curIndexPath.row == indexPath.row)}];
    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    ImgListCollectionViewCell *cell = (ImgListCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    if (!cell.imageView.userInteractionEnabled) {
    //        return;
    //    }
    //    UITableView *tableView = (UITableView *)collectionView.superview.superview.superview.superview;
    //    CGRect rect = [self.contentView convertRect:self.bounds toView:tableView.window];//坐标系统转换
    self.curIndexPath = indexPath;
    [self.collectionView reloadData];
    if (self.handleAction) {
        self.handleAction(@{@"title":self.dataArr[indexPath.row]});
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
static ZoneChoseViewController *zonevc;
+(ZoneChoseViewController *)toTypeVC
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zonevc = [[ZoneChoseViewController alloc] initWithNibName:@"TypeChoseViewController" bundle:nil];
        
    });
    
   
    MyDialog *myDialog = [[MyDialog alloc] initWithViewController:zonevc];
    zonevc.view.width = __SCREEN_SIZE.width;
    //    vc.doneCallBack = ^(NSString *pwd){
    //        [weakSelf toAddwithdraw:pwd];
    //    };
    myDialog.mydelegate = zonevc;
    myDialog.bgColor = [UIColor clearColor];
    myDialog.isDownAnimate = NO;
    [myDialog showAtPosition:CGPointMake(0,64) animated:NO];
    myDialog.dismissOnTouchOutside = YES;
    
    
    return zonevc;
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
