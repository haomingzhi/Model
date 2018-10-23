//
//  MemberCheckViewController.m
//  yihui
//
//  Created by air on 15/9/25.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "MemberCheckViewController.h"
#import "JYCheckAndBtnView.h"
#import "MemberCheckDelegateObj.h"
@interface MemberCheckViewController ()
{
    //    NSMutableArray *_sectionArr;
    //    IBOutlet MyTableView *_tableView;
    MyTableView *_mtableView;
    JYCheckAndBtnView *_bottomView;
    NSInteger _allCount;
    NSMutableArray *_dataArr;
}
@end

@implementation MemberCheckViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mtableView = (MyTableView *)[self.view viewWithTag:100];
   
    _dataArr = [NSMutableArray array];
    [(MemberCheckDelegateObj *)self.delegate addObserver:self forKeyPath:@"changeMark" options:NSKeyValueObservingOptionOld context:nil];

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
    ((MyTableView *)[self.view viewWithTag:100]).height = __SCREEN_SIZE.height - 64 - 49;
    _bottomView.height = 49;
    ((MyTableView *)[self.view viewWithTag:100]).refreshHeaderView = nil;
    _bottomView.width = __SCREEN_SIZE.width;
//     ((MyTableView *)[self.view viewWithTag:100]).refreshFooterView.hidden = YES;
}

-(void)refreshCurentPage:(NSArray *)arr
{
    [super refreshCurentPage:arr];
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
                _bottomView.isAllSelected = YES;
                _allCount = [self.delegate allSelected:YES];
                _bottomView.isAllSelected = NO;
                //                [_mtableView reloadData];
            }
            else
            {
                _bottomView.isAllSelected = YES;
                [self.delegate allSelected:NO];
                _bottomView.isAllSelected = NO;
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
    
    _bottomView.width = __SCREEN_SIZE.width;
    _bottomView.y = __SCREEN_SIZE.height - 64 - 49;
    [self.view addSubview:_bottomView];
    _bottomView.btnTitle = @"同意通过";
//        _bottomView.btnBackgroundColor = kUIColorFromRGB(mainColor);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
        _allCount = [(MemberCheckDelegateObj *)self.delegate allCount];
    if ([keyPath isEqualToString:@"changeMark"]) {
        //        JYBaseTableViewCell *cell = (JYBaseTableViewCell *)object;
        if(_bottomView.isAllSelected)
        {
            return;
        }
        NSMutableArray *arr = [object valueForKey:@"selectedArr"];
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


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *arr = [NSMutableArray array];
    [_dataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj[@"key"] isEqualToString:@"管理者"]) {
            [arr addObject:@"#"];
        }
        else
        {
            [arr addObject:obj[@"key"]];
        }
    }];
    return arr;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}
-(void)dealloc
{
    [(MemberCheckDelegateObj*)self.delegate removeObserver:self forKeyPath:@"changeMark"];
}

@end
