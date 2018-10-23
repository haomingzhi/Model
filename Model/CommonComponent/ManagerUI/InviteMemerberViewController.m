//
//  InviteMemerberViewController.m
//  yihui
//
//  Created by air on 15/9/14.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "InviteMemerberViewController.h"
#import "JYCheckAndBtnView.h"
#import "InviteMemerberDelegateObj.h"
//#import "JYBaseTableViewCell.h"
@interface InviteMemerberViewController ()
{
//    NSMutableArray *_sectionArr;
//    IBOutlet MyTableView *_tableView;
    MyTableView *_mtableView;
    JYCheckAndBtnView *_bottomView;
    NSInteger _allCount;
    NSMutableArray *_dataArr;
    BOOL _isHiddeAllSelectView;
}
@end

@implementation InviteMemerberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mtableView = (MyTableView *)[self.view viewWithTag:100];
    _dataArr = [NSMutableArray array];
    [(InviteMemerberDelegateObj *)self.delegate addObserver:self forKeyPath:@"changeMark" options:NSKeyValueObservingOptionOld context:nil];
   
    [self addBottomView];
}


//-(void)initTableView
//{
//    //[_delegate registerTableViewCell:@"ImgTitleAndDetailTableViewCell" withTableView:_tableView];
//    _tableView = [[MyTableView alloc] initWithFrame:CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height - 64 - 49) style:UITableViewStylePlain];
//    _sectionArr = [NSMutableArray array];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.refreshHeaderView = nil;
//    [self.delegate initTableViewCells:_sectionArr withTableView:_tableView];
//    
//    _tableView.tableFooterView = [[UIView alloc] init];
//}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    MyTableView *tableView = (MyTableView *)[self.view viewWithTag:100];
    tableView.height = __SCREEN_SIZE.height - 64 - 49;
    _bottomView.height = 49;
    _bottomView.width = __SCREEN_SIZE.width;
    tableView.sectionIndexColor = [UIColor lightGrayColor];
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
}



-(void)addBottomView
{
    _bottomView = (JYCheckAndBtnView *)[[[NSBundle mainBundle] loadNibNamed:@"JYCheckAndBtnView" owner:nil options:nil] lastObject];
//    _bottomView.height = 49;
    _bottomView.handleAction = ^( id obj){
        UIButton *btn = obj;
        if (btn.tag == 200) {
            btn.selected = !btn.selected;
            if (btn.selected) {
               _allCount = [self.delegate allSelected:YES];
//                [_mtableView reloadData];
            }
            else
            {
                [self.delegate allSelected:NO];
//                [_mtableView reloadData];
            }

        }
        else
        {
           
           id b= [self.delegate performSelector:@selector(inviteJoinCircle) withObject:nil];//邀请方法
            if (![b boolValue]) {
                 TOASTSHOW(@"请选择邀请成员");
            }
        }
    };
    if (_isHiddeAllSelectView) {
        [_bottomView hideAllSelectedView];
    }
    
    _bottomView.width = __SCREEN_SIZE.width;
    _bottomView.y = __SCREEN_SIZE.height - 64 - 49;
    [self.view addSubview:_bottomView];
    if (!_btnTitle) {
        _bottomView.btnTitle = @"邀请";
    }
    else
    {
    _bottomView.btnTitle = _btnTitle;
    }
//    _bottomView.btnBackgroundColor = kUIColorFromRGB(mainColor);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
     _allCount = [(InviteMemerberDelegateObj *)self.delegate allCount];
    if ([keyPath isEqualToString:@"changeMark"]) {
//        JYBaseTableViewCell *cell = (JYBaseTableViewCell *)object;
        if(_bottomView.isAllSelected)
        {
            return;
        }
        NSMutableArray *arr = [object valueForKey:@"selectedDataArr"];
        if(arr.count == _allCount)
        {
            _bottomView.isSelected = YES;
        }
        else
        {
            _bottomView.isSelected = NO;
        }
        NSLog(@"change what:%@",change);
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    NSMutableArray *arr = [NSMutableArray array];
//    [_dataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if ([obj[@"key"] isEqualToString:@"管理者"]) {
//            [arr addObject:@"#"];
//        }
//        else
//        {
//            [arr addObject:obj[@"key"]];
//        }
//    }];
//    return arr;
//    
//}
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    return index;
//}
-(void)dealloc
{
    [(InviteMemerberDelegateObj*)self.delegate removeObserver:self forKeyPath:@"changeMark"];
}

-(void)hideAllSelectedView
{
    _isHiddeAllSelectView = YES;
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
