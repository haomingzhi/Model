//
//  InstructionsViewController.m
//  ulife
//
//  Created by sunmax on 15/12/11.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "InstructionsViewController.h"
#import "InstructionsTableViewCell.h"
#import "BUInstruction.h"
//#import "BUdetailsViewController.h"
#import "BUSystem.h"
@interface InstructionsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *_myTableView;
    InstructionsTableViewCell *_instructionsCell;
    NSArray * _instructionsArr;
}

@end

@implementation InstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"使用说明";
    self.view.backgroundColor =kUIColorFromRGB(color_F3F3F3);
    [self addTableView];
//    [busiSystem.appBasicDocument instructionUid:busiSystem.agent.userId observer:self callback:@selector(instructionNotification:)];
    // Do any additional setup after loading the view from its nib.
}

-(void)instructionNotification:(BSNotification *) noti
{
    BASENOTIFICATION(noti);
//    _instructionsArr =busiSystem.appBasicDocument.instructionList;
    [_myTableView reloadData];
}

#pragma mark --- View
- (void)addTableView
{
    [_myTableView registerNib:[UINib nibWithNibName:@"InstructionsTableViewCell" bundle:nil] forCellReuseIdentifier:@"InstructionsTableViewCell"];
    _myTableView.delegate =self;
    _myTableView.dataSource =self;
    _myTableView.showsVerticalScrollIndicator =NO;
    //设置tableView不能滚动
    [_myTableView setScrollEnabled:NO];
    [self setExtraCellLineHidden:_myTableView];
}
#pragma mark --- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _instructionsArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    BUInstruction * ins =busiSystem.appBasicDocument.instructionList[indexPath.row];
//    CGSize size =[self detailSizeTitle:ins.Title size:15 flo:_instructionsCell.frame.size.width];
    return  35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _instructionsCell =[tableView dequeueReusableCellWithIdentifier:@"InstructionsTableViewCell"];
//    BUInstruction * ins =busiSystem.appBasicDocument.instructionList[indexPath.row];
//    [_instructionsCell setCellInstructions:ins.Title];
//    _instructionsCell.separatorInset =UIEdgeInsetsMake(0, -21, 0, -1);
    return _instructionsCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    BUInstruction * ins =busiSystem.appBasicDocument.instructionList[indexPath.row];
//    BUdetailsViewController *detaVC =[BUdetailsViewController new];
//    detaVC.type =Description;
//    detaVC.NoticeId =ins.InsId;
//    [self.navigationController pushViewController:detaVC animated:YES];
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
