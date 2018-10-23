//
//  SignViewController.m
//  compassionpark
//
//  Created by air on 2017/3/16.
//  Copyright © 2017年 ORANLLC_IOS1. All rights reserved.
//

#import "SignViewController.h"
#import "TitleDetailTableViewCell.h"
#import "FourIconBtnTableViewCell.h"
#import "TwoTabsTableViewCell.h"
#import "BlankTableViewCell.h"
#import "BUSystem.h"
#import "SuccessTipViewController.h"
#import "SignTableViewCell.h"
#import "SignATableViewCell.h"
#import "MyCouponViewController.h"

@interface SignCard:NSObject
@property (strong, nonatomic)NSString *img;

@property (strong, nonatomic)NSString *himg;
@property (strong, nonatomic)NSString *title;
@property (strong, nonatomic)NSString *htitle;
@property (readonly, nonatomic)NSString *curTitle;
@property (readonly, nonatomic)NSString *curImg;
@property ( nonatomic)BOOL isSign;
+(NSArray *)createSignCardArr:(NSInteger)count withToSignIndex:(NSInteger)index;

@end
@implementation SignCard

+(NSArray *)createSignCardArr:(NSInteger)count withToSignIndex:(NSInteger)index
{
     NSMutableArray *arr = [NSMutableArray array];
     for (NSInteger i = 0; i < count; i ++) {
            SignCard *s = [SignCard new];
          s.title = [NSString stringWithFormat:@"第%ld天",i+1];
          if (i <= index) {
               s.isSign = YES;
          }
          [arr addObject:s];
     }
     return arr;
}

-(id)init
{
     self =  [super init];
     self.title = @"";;
     self.img = @"sign_unCheck";
     self.himg = @"sign_check";
     return self;
}


-(NSString*)curTitle
{
          return _title?:@"";
}

-(NSString *)curImg
{
     if ( _isSign) {
          return _himg?:@"";
     }
     
     else
     {
          return _img?:@"";
     }
}

@end

@interface SignCardList:NSObject
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,readonly)SignCard *aLc;
@property(nonatomic,readonly)SignCard *bLc;
@property(nonatomic,readonly)SignCard *cLc;
@property(nonatomic,readonly)SignCard *dLc;
@property(nonatomic,readonly)SignCard *eLc;
@property(nonatomic,readonly)SignCard *fLc;
@property(nonatomic,readonly)SignCard *gLc;
@property(nonatomic,readonly)SignCard *hLc;
@property(nonatomic)NSInteger toIndex;
-(NSDictionary *)getDic:(NSInteger)index withRow:(NSInteger)row;
@end

@implementation SignCardList
-(SignCard*)aLc
{
     SignCard *a = _dataArr[0];
     
     return a;
}

-(SignCard*)bLc
{
     SignCard *a = _dataArr[1];
     
     return a;
}

-(SignCard*)cLc
{
     SignCard *a = _dataArr[2];
     
     return a;
}
-(SignCard*)dLc
{
     SignCard *a = _dataArr[3];
     
     return a;
}
-(SignCard*)eLc
{
     SignCard *a = _dataArr[4];
     
     return a;
}
-(SignCard*)fLc
{
     SignCard *a = _dataArr[5];
     
     return a;
}
-(SignCard*)gLc
{
     SignCard *a = _dataArr[6];
     
     return a;
}
-(SignCard*)hLc
{
     SignCard *a = _dataArr[7];
     
     return a;
}

-(id)init
{
     self =  [super init];
     _toIndex = 1;
     _dataArr = (NSMutableArray *)[SignCard createSignCardArr:8 withToSignIndex:_toIndex];
     
     return self;
}

//-(NSInteger)toIndex
//{
//     return _toIndex;
//}

-(void)setToIndex:(NSInteger)toIndex
{
     _toIndex = toIndex;
     for (NSInteger i = 0; i < _dataArr.count; i ++) {
          SignCard *a = _dataArr[i];
          if (i <= toIndex) {
               a.isSign = YES;
          }
          else
          {
               a.isSign = NO;
          }
     }
}

-(NSDictionary *)getDic:(NSInteger)index withRow:(NSInteger)row
{
     if (index != -1) {
          SignCard *c = _dataArr[index + row * 4];
          c.isSign = YES;
     }
     
     if (row == 0) {
          return @{@"oneTitle":self.aLc.curTitle,@"twoTitle":self.bLc.curTitle,@"threeTitle":self.cLc.curTitle,@"fourTitle":self.dLc.curTitle,@"aimg":self.aLc.curImg,@"bimg":self.bLc.curImg,@"cimg":self.cLc.curImg,@"dimg":self.dLc.curImg};
     }
     else
     {
          return @{@"oneTitle":self.eLc.curTitle,@"twoTitle":self.fLc.curTitle,@"threeTitle":self.gLc.curTitle,@"fourTitle":self.hLc.curTitle,@"aimg":self.eLc.curImg,@"bimg":self.fLc.curImg,@"cimg":self.gLc.curImg,@"dimg":self.hLc.curImg};
     }
}
@end
@interface SignViewController ()
{
 
    TitleDetailTableViewCell *_tipCell;
  
    
    NSInteger _mode;
    BOOL _isNodata;
}
@property (strong, nonatomic) IBOutlet MyTableView *tableView;
@property (strong, nonatomic)FourIconBtnTableViewCell *aCell;
@property (strong, nonatomic)FourIconBtnTableViewCell *bCell;
 @property (strong, nonatomic)TwoTabsTableViewCell *signCell;
 @property ( nonatomic)   BOOL isSign;
@property (strong, nonatomic)SignCardList *sCardList;

@property (strong,nonatomic) SignTableViewCell *signCellA;
@property (strong,nonatomic) SignATableViewCell *signCellB;
@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"签到";
//    _mode = busiSystem.agent.signInfo.state;
//    if ([busiSystem.agent.integralConfig.signExplain isEqualToString:@""]) {
//        _isNodata = YES;
//    }
    
    [self initTableView];
     [self addView];
    HUDSHOW(@"加载中");
    [self getData];
}


-(void)addView{
     UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, __SCREEN_SIZE.height- NAVBARHEIGHT - TABBARNONEHEIGHT-52, __SCREEN_SIZE.width, 52+TABBARNONEHEIGHT)];
     view.backgroundColor = kUIColorFromRGB(color_2);
     [self.view addSubview:view];
     
     UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 9, __SCREEN_SIZE.width-30, 36)];
     btn.backgroundColor = kUIColorFromRGB(color_0xf74056);
     [btn setTitle:@"查看我的优惠券" forState:UIControlStateNormal];
     [btn setTitleColor:kUIColorFromRGB(color_2) forState:UIControlStateNormal];
     [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
     btn.layer.cornerRadius = btn.height/2.0;
     btn.layer.shadowColor = kUIColorFromRGB(color_0xf74056).CGColor;
     btn.layer.shadowRadius = 8.0;
     btn.layer.shadowOpacity = 0.43;
     btn.layer.shadowOffset = CGSizeMake(0, 0);
     [view addSubview:btn];
}

-(void)btnAction{
     MyCouponViewController *vc = [MyCouponViewController new];
     [self.navigationController pushViewController:vc animated:YES];
}

-(void)getData
{
     if (busiSystem.agent.isDaySigin == 0) {
          [self addSign];
     }else{
          [self getSignInfo];
     }
}

-(void)addSign{

     [busiSystem.agent addSign:self callback:@selector(addSignNotification:)];
}


-(void)addSignNotification:(BSNotification*)noti
{
     if (noti.error.code == 0) {
      
          busiSystem.agent.isDaySigin = 1;
          [self getSignInfo];
     }
     else
     {
          
          HUDCRY(noti.error.domain, 1);
     }
}


-(void)getSignInfo{
     [busiSystem.agent getSignInfo:self callback:@selector(getSignInfoNotification:)];
}

-(void)getSignInfoNotification:(BSNotification*)noti
{

     if (noti.error.code == 0) {
         
          HUDDISMISS;
          busiSystem.agent.isNeedRefreshTabA = NO;
          NSMutableArray *arr = [NSMutableArray new];
          [busiSystem.agent.signInfo.signinPrize enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               BUSignInfo *s = obj;
               [arr addObject: [s getDic]];
          }];
          [_signCellA setData:[busiSystem.agent.signInfo getDic]];
          
          [_signCellB setCellData:@{@"arr":arr,@"signRule":busiSystem.agent.config.signRules}];
          [_signCellB fitCellMode];
          [_tableView reloadData];
     }
     else
     {
          
          HUDCRY(noti.error.domain, 1);
     }
}

-(void)sign
{
//    [busiSystem.agent sign:self callback:@selector(signNotification:)];
}

-(void)signNotification:(BSNotification *)noti
{
    if (noti.error.code == 0) {
        HUDDISMISS;
//        NSInteger day = busiSystem.agent.sign.continuityDays;
//       NSInteger jf = busiSystem.agent.sign.integral;
////        [_signTipCell setCellData:@{@"title":[NSString stringWithFormat:@"今天已签到,明天记得继续签到哦！已连续签到%ld天",day]}];
//        busiSystem.agent.signInfo.state = 1;
//        _mode = busiSystem.agent.signInfo.state;
//        [_tableView reloadData];
//        NSString *sjf = [NSString stringWithFormat:@"签到成功\n获得 %ld 积分",jf];
//        HUDSMILE(sjf, 2);
//        [busiSystem.agent getUserInfo:busiSystem.agent.userId observer:nil callback:nil];
    }
    else
    {
        HUDCRY(noti.error.domain, 2);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initTableView{
    __weak SignViewController *weakSelf = self;
    _tableView.refreshHeaderView = nil;
     _tableView.x = 0;
     _tableView.y = 0;
     _tableView.width = __SCREEN_SIZE.width;
     _tableView.height = __SCREEN_SIZE.height - NAVBARHEIGHT - TABBARNONEHEIGHT - 52;
     _tableView.bounces = NO;

     _signCellA = [SignTableViewCell createTableViewCell];
     _signCellB = [SignATableViewCell createTableViewCell];
     [_signCellB setCellData:@{@"arr":@[]}];
     [_signCellB fitCellMode];
     
//     _sCardList = [SignCardList new];
//     _sCardList.toIndex = arc4random() % 8;
//     if (_sCardList.toIndex == 7) {
//          _isSign = YES;
//     }
//     _signCell = [TwoTabsTableViewCell createTableViewCell];
//     [_signCell setCellData:@{@"img":@"sign_img",@"bgImg":@"signBg",@"tab1":_isSign?@"今日已签":@"立即签到",@"tab2":@"坚持每天连续签到可以获多重奖励哦"}];
//     [_signCell fitSignMode];
//     [_signCell setTabOneCallBack:^(UIButton *btn){
//          if (weakSelf.isSign) {
//               [weakSelf showSignTip];
//               return ;
//          }
//          weakSelf.isSign = YES;
//          [weakSelf.signCell setCellData:@{@"img":@"sign_img",@"bgImg":@"signBg",@"tab1":@"今日已签",@"tab2":@"坚持每天连续签到可以获多重奖励哦"}];
//          [weakSelf.signCell fitSignMode];
//          if ((weakSelf.sCardList.toIndex + 1) < 4) {
//               [weakSelf.aCell setCellData:[weakSelf.sCardList getDic:weakSelf.sCardList.toIndex + 1 withRow:0]];
//               [weakSelf.aCell fitLuckMode:20 withHeight:121];
//               [weakSelf animation:btn];
//               UIButton *abtn = [weakSelf.aCell viewWithTag:100 + weakSelf.sCardList.toIndex + 1];
//               [weakSelf animation:abtn];
//          }
//          else
//          {
//               [weakSelf.bCell setCellData:[weakSelf.sCardList getDic:weakSelf.sCardList.toIndex + 1 - 4 withRow:1]];
//               [weakSelf.bCell fitLuckMode:15 withHeight:131];
//               [weakSelf animation:btn];
//               UIButton *bbtn = [weakSelf.bCell viewWithTag:100 + weakSelf.sCardList.toIndex + 1 - 4];
//               [weakSelf animation:bbtn];
//          }
//
//          SuccessTipViewController *vc = [SuccessTipViewController toVC:weakSelf];
//          [vc fitSignMode:@{@"toIndex":@(weakSelf.sCardList.toIndex + 1 + 1)}];
//
//     }];
//
//     _tipCell = [TitleDetailTableViewCell createTableViewCell];
//     [_tipCell setCellData:@{@"title":@"温馨提示：",@"detail":@" 每日签到可获得10成长值和10优币的奖励，连续完成8天签到可 上额外获得奖励，连续签到满8天后将会重置签到记录。"}];
//     [_tipCell fitSignMode];
//
//     _aCell = [FourIconBtnTableViewCell createTableViewCell];
//     [_aCell setCellData:[_sCardList getDic:-1 withRow:0]];
//     [_aCell fitLuckMode:20 withHeight:121];
//
//     _bCell = [FourIconBtnTableViewCell createTableViewCell];
//
//     [_bCell setCellData:[_sCardList getDic:-1 withRow:1]];
//     [_bCell fitLuckMode:15 withHeight:131];
     _tableView.backgroundColor = kUIColorFromRGB(color_f8f8f8);
}

-(void)showSignTip
{
   HUDCRY(@"今天已经签到了哦", 2);
}
-(void)animation:(UIView *)parentView
{
     //     UIView *parentView = [self.view viewWithTag:1000];
     //设置动画效果
     
     [UIView beginAnimations:@"doflip" context:nil];
     
     //设置时常
     
     [UIView setAnimationDuration:1];
     
     //设置动画淡入淡出
     
     [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
     
     //设置代理
     
     [UIView setAnimationDelegate:self];
     [UIView setAnimationDidStopSelector:@selector(animationFinished:)];
     //设置翻转方向
     
     [UIView setAnimationTransition:
      
      UIViewAnimationTransitionFlipFromRight forView:parentView cache:YES];
     
     //动画结束
     
     [UIView commitAnimations];
}

//动画效果执行完毕
- (void) animationFinished: (id) sender{
     NSLog(@"animationFinished !");
     //     _aCell.userInteractionEnabled = YES;
     //     _bCell.userInteractionEnabled = YES;
     
}

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    
     if (indexPath.section == 0)
        {
             cell = _signCellA;
        }
     else
     if (indexPath.section == 1) {
          cell = _signCellB;
     }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 88;
   
        if (indexPath.section == 0)
        {
            height = 245;
        }
     else if(indexPath.section == 1)
     {
          height = _signCellB.height;

     }

    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
     if (section == 0) {
          return 15;
     }
    return 18;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     if (section == 0) {
          return 15;
     }
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
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
