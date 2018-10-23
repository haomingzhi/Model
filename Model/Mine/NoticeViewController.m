//
//  NoticeViewController.m
//  ulife
//
//  Created by sunmax on 15/12/15.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTableViewCell.h"
#import "BUSystem.h"
#import "BUNoticeList.h"
#import "BUdetailsViewController.h"
@interface NoticeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet MyTableView *_myTableView;
    NSInteger _count;
    IBOutlet UIView *_jurisdictionView;
    NSInteger _pitchOnCount;//是否选中
    __weak IBOutlet UIButton *_jurisdictionButton;
    __weak IBOutlet UIButton *_delButton;
    BOOL will;
    NSMutableArray * _click_mArr;
    UIView * _NoDetaView;
}

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"通知";
    _click_mArr = [NSMutableArray new];
    _pitchOnCount =2;
    [_delButton corner:[UIColor clearColor] radius:5];
//    _jurisdictionView.backgroundColor =[UIColor clearColor];
    [self addTableView];
    [self addNavigateRightButton];
    [self addJurisdictionView];
    [self refreshCurentPage];
    _NoDetaView =[self getUnfoundViewImageName:@"NoNotice" LabelUnfoundText:@"暂无通知"];
    _NoDetaView.hidden =YES;
    [self.view addSubview:_NoDetaView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNoticeView) name:@"RefreshNoticeView" object:nil];
    // Do any additional setup after loading the view from its nib.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)refreshNoticeView
{
 [self refreshCurentPage];
}

-(void)viewDidLayoutSubviews
{
    _NoDetaView.frame =CGRectMake(0, 0, __SCREEN_SIZE.width, __SCREEN_SIZE.height);
}

-(void)viewWillAppear:(BOOL)animated
{
//    [self refreshCurentPage];         
}
#pragma mark --- MyTableView
-(void) refreshCurentPage//刷新当前页面，头部下拉触发,网络层回调中调用、或者覆盖refreshTableHeaderNotification
{
    will =YES;
//    [busiSystem.notice noticeListObserver:self callback:@selector(noticeListNotification:)];
}

-(void) loadNextPage//加载下一页，尾部上拉触发,需要在网络层回调中，设置是否还有更多
{
    //    self.refresh =YES;
//    busiSystem.notice.PageInfo.page =busiSystem.notice.PageInfo.page+1;
//    [busiSystem.notice nextPage:self callback:@selector(noticeListNotification:)];
}

- (void)noticeListNotification:(BSNotification *)noti
{ ISTOLOGIN;
    BASENOTIFICATION(noti);
   
//    _myTableView.hasMore =busiSystem.notice.PageInfo.hasMore;
    if (will ==YES)
    {
        [_myTableView.dataArr removeAllObjects];//移除所有的数据
        will =NO;
    }
//    [_myTableView.dataArr addObjectsFromArray:busiSystem.notice.MsgList];
    [self refreshTableHeaderNotification:noti myTableView:_myTableView];
    if (_myTableView.dataArr.count ==0){
        _NoDetaView.hidden=NO;
        return;
    }
    [_myTableView reloadData];
}



- (void)deleteNoticeNotification:(BSNotification *)noti
{   ISTOLOGIN;
    BASENOTIFICATION(noti);
 
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"RefreshDiscover" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    [_myTableView.dataArr removeAllObjects];
//    [busiSystem.notice noticeListObserver:self callback:@selector(noticeListNotification:)];
}



#pragma mark --- View
- (void)addTableView
{
    [_myTableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoticeTableViewCell"];
    _myTableView.delegate =self;
    _myTableView.dataSource =self;
    _myTableView.dataArr =[NSMutableArray new];
    [_myTableView.refreshHeaderView resetState:YES];
//    [_myTableView setScrollEnabled:NO];
    [self setExtraCellLineHidden:_myTableView];
}

- (void)addJurisdictionView
{
    _jurisdictionView.frame =CGRectMake(0,__SCREEN_SIZE.height-64,__SCREEN_SIZE.width, 47);
    [_jurisdictionView corner:kUIColorFromRGB(color_black) radius:0 borderWidth:0.5];
    [self.view addSubview:_jurisdictionView];
}

- (void)addNavigateRightButton
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame =CGRectMake(0, 0, 30, 30);
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitleColor:kUIColorFromRGB(color_white) forState:UIControlStateNormal];
    _count =0;
    [rightBtn addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightNavButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem =rightNavButton;
}

#pragma mark --- Action
//全选
- (IBAction)jurisdictionAction:(id)sender {
    [_click_mArr removeAllObjects];
    _pitchOnCount =_pitchOnCount==2?1:_pitchOnCount==0?1:2;
    if (_pitchOnCount ==1) {
        [_jurisdictionButton setBackgroundImage:[UIImage imageNamed:@"pitchOn---Assistor@2x"] forState:0];
        [_click_mArr addObjectsFromArray:_myTableView.dataArr];
    }
    else{
        [_jurisdictionButton setBackgroundImage:[UIImage imageNamed:@"NoPitchOn---Assistor@2x"] forState:0];
        [self NoPitchOnPitchOnCount];
    }
    [_myTableView reloadData];
}

//编辑
- (void)rightButtonAction:(UIButton *)sender
{
    [self rightButtonTitle:sender];
}

//删除
- (IBAction)deleteAction:(id)sender {
    
    if (_pitchOnCount==1){
//        [busiSystem.notice deleteNoticeNoticeId:@"" Type:2 observer:self callback:@selector(deleteNoticeNotification:)];
        return;
    }
    NSString *NoticeIds =[self NoticeIds];
//    [busiSystem.notice deleteNoticeNoticeId:NoticeIds Type:1 observer:self callback:@selector(deleteNoticeNotification:)];
}

- (NSString *)NoticeIds
{
    NSString * str=@"";
    for (int i=0; i<_click_mArr.count; i++){
        BUNoticeList *noticeList =_click_mArr[i];
        if (i==0) {
            str =noticeList.NoticeId;
        }
        else{
            str =[NSString stringWithFormat:@"%@,%@",str,noticeList.NoticeId];
        }
    }
    return str;
}

- (void)NoPitchOnPitchOnCount
{
    for (int i=0; i<_myTableView.dataArr.count; i++){
        BUNoticeList *noticeList =_myTableView.dataArr[i];
        noticeList.pitchOnCount =NO;
    }
}

#pragma mark --- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _myTableView.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 78;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoticeTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"NoticeTableViewCell"];
    cell.click =^(){
        BUNoticeList *noticeList =_myTableView.dataArr[indexPath.row];
        noticeList.pitchOnCount = noticeList.pitchOnCount==YES?NO:YES;
        if (noticeList.pitchOnCount==YES) {
            noticeList.row =indexPath.row;
            [_click_mArr addObject:noticeList];
        }
        else{
            [self remove_click_mArr:noticeList];
        }
        _pitchOnCount=0;
        if (_click_mArr.count == _myTableView.dataArr.count) {
             [_jurisdictionButton setBackgroundImage:[UIImage imageNamed:@"pitchOn---Assistor@2x"] forState:0];
        }
        else{
            [_jurisdictionButton setBackgroundImage:[UIImage imageNamed:@"NoPitchOn---Assistor@2x"] forState:0];
        }
        NSLog(@"%ld",(long)indexPath.row);
    };
    BUNoticeList *notList =_myTableView.dataArr[indexPath.row];
    if (_pitchOnCount==1){
        cell.pitchOnCount =_pitchOnCount;
    }
    else if (_pitchOnCount==2){
        cell.pitchOnCount =0;
    }
    else{
        
        cell.pitchOnCount =notList.pitchOnCount;
    }
    [cell setCellTitle:notList.Title AddTime:notList.AddTime IsRead:notList.IsRead];
    _count ==0?[cell cancelEditNoticeCell]:[cell editNoticeCell];
    [cell pitchOn];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NoticeTableViewCell * cell =[tableView cellForRowAtIndexPath:indexPath];
    BUNoticeList *notList =_myTableView.dataArr[indexPath.row];
    [cell setCellTitle:notList.Title AddTime:notList.AddTime IsRead:notList.IsRead==0?1:1];
    NSInteger count =0;
    for (int i=0; i<_myTableView.dataArr.count; i++){
        BUNoticeList *notList1 =_myTableView.dataArr[i];
        if (notList1.IsRead ==1) {
            count++;
        }
    }
    if (notList.IsRead ==0) {
        count+=1;
    }
    if (count ==_myTableView.dataArr.count) {
//        busiSystem.newsInfoManager.HasMessage =@"0";
    }
    BUdetailsViewController *detaVC =[BUdetailsViewController new];
    detaVC.NoticeId =notList.NoticeId;
    detaVC.type =Notification;
    [self.navigationController pushViewController:detaVC animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    // 删除操作
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
        BUNoticeList *noticeList =_myTableView.dataArr[indexPath.row];
//        [busiSystem.notice deleteNoticeNoticeId:noticeList.NoticeId Type:1 observer:self callback:@selector(deleteNoticeNotification:)];
//    }
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *layTopRowAction2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"       " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        BUNoticeList *noticeList =_myTableView.dataArr[indexPath.row];
//        [busiSystem.notice deleteNoticeNoticeId:noticeList.NoticeId Type:1 observer:self callback:@selector(deleteNoticeNotification:)];
        NSLog(@"点击了删除");
        [tableView setEditing:NO animated:YES];
    }];
    layTopRowAction2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageContentWithFileName:@"wordDelete@2x"]];//[UIColor greenColor];
    NSArray *arr = @[layTopRowAction2];
    return arr;
}

#pragma mark --- Method
- (void)rightButtonTitle:(UIButton *)sender
{
    if (_myTableView.dataArr.count==0) {
        return;
    }
    if (_count == 0) {
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            _jurisdictionView.frame =CGRectMake(0, __SCREEN_SIZE.height -_jurisdictionView.height-64, __SCREEN_SIZE.width, _jurisdictionView.height);
        }];
        _myTableView.height =__SCREEN_SIZE.height-_jurisdictionView.height-64;
        [self refreshCurentPage];
        _count=1;
    }
    else 
    {
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            _jurisdictionView.frame =CGRectMake(0, __SCREEN_SIZE.height-64, __SCREEN_SIZE.width, _jurisdictionView.height);
        }];
        _myTableView.height =__SCREEN_SIZE.height-64;
        _count=0;
        _pitchOnCount =2;
        [_jurisdictionButton setBackgroundImage:[UIImage imageNamed:@"NoPitchOn---Assistor@2x"] forState:0];
    }
    [_myTableView reloadData];
}

-(BOOL)WhetherAll
{
    BOOL pitchOnCount = false;
    for (int i=0; i<_myTableView.dataArr.count; i++)
    {
        BUNoticeList *noticeList =_myTableView.dataArr[i];
        pitchOnCount =noticeList.pitchOnCount ==NO?NO:YES;
    }
    return pitchOnCount;
}

-(void)remove_click_mArr:(BUNoticeList *)noti
{
    for (int i=0; i<_click_mArr.count; i++) {
        BUNoticeList *noticeList =_click_mArr[i];
        if (noticeList.row == noti.row) {
            [_click_mArr removeObjectAtIndex:i];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
