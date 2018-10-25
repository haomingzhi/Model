//
//  ModifyPawViewController.m
//  ulife
//
//  Created by sunmax on 15/12/10.
//  Copyright © 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "ModifyPawViewController.h"
#import "TextFilleTableViewCell.h"
#import "BUSystem.h"
#import "LoginViewController.h"
@interface ModifyPawViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UITableView *_myTableView;
    NSArray * _placeHolderArr;
    __weak IBOutlet UIButton *_button;
}
@end

@implementation ModifyPawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"修改密码";
    self.view.backgroundColor =kUIColorFromRGB(color_white);
    _placeHolderArr =@[@"当前密码",@"输入新密码",@"确认新密码"];
    [_button corner:[UIColor clearColor] radius:5];
    [self addTableView];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidLayoutSubviews
{
    _myTableView.height =200;
    _button.y =_myTableView.height +20;
}

#pragma mark --- View
- (void)addTableView
{
    [_myTableView registerNib:[UINib nibWithNibName:@"TextFilleTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextFilleTableViewCell"];
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextFilleTableViewCell *textFilleCell =[tableView dequeueReusableCellWithIdentifier:@"TextFilleTableViewCell"];
    textFilleCell.tag =100 +indexPath.row;
    [textFilleCell setCell:_placeHolderArr[indexPath.row]];
    textFilleCell.separatorInset =UIEdgeInsetsMake(0, 130000, 0, -1300000);
    return textFilleCell;
}
#pragma mark --- Action
- (IBAction)recoveryTextFilerAction:(id)sender {
    [self recovery];
    
}
//确认
- (IBAction)confirmAction:(id)sender {
    [self recovery];
    TextFilleTableViewCell *textFilleCell =(TextFilleTableViewCell *)[self.view viewWithTag:100];
    TextFilleTableViewCell *textFilleCell1 =(TextFilleTableViewCell *)[self.view viewWithTag:101];
    TextFilleTableViewCell *textFilleCell2 =(TextFilleTableViewCell *)[self.view viewWithTag:102];
    if (textFilleCell.textField.text.length!=0&&textFilleCell1.textField.text.length!=0&&textFilleCell2.textField.text.length!=0) {
        TOASTSHOWUNDERVIEW(@"内容不能为空！", textFilleCell, CGPointMake(0,10));
        return;
    }
    
    if (![textFilleCell1.textField.text isEqualToString:textFilleCell2.textField.text]){
        NSString *hintStr = @"新密码和确认密码不一致";
        TOASTSHOWUNDERVIEW(hintStr, textFilleCell, CGPointMake(0,10));
        return;
    }
    
    if (textFilleCell.textField.text.length>6&&textFilleCell1.textField.text.length>6&&textFilleCell2.textField.text.length>6) {
        TOASTSHOWUNDERVIEW(@"密码不能少于6位", textFilleCell, CGPointMake(0,10));
        return;
    }
    
//    [busiSystem.agent updatePwd:textFilleCell.textField.text Npwd:textFilleCell1.textField.text RePwd:textFilleCell2.textField.text observer:self callback:@selector(updatePwdNotification:)];
}


-(void) updatePwdNotification:(BSNotification *) noti
{
//     BASENOTIFICATION(noti);
    busiSystem.agent.Phone=@"";
    busiSystem.agent.password =@"";
    busiSystem.agent.isLogin =NO;
    LoginViewController *loginVC =[LoginViewController new];
    //    loginVC.type =4;
    busiSystem.agent.isCancel =YES;
    UINavigationController *navSvc = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.view.window.rootViewController =navSvc;

}

#pragma mark --- Method
- (void)recovery
{
    for (int i=0; i<3; i++)
    {
        TextFilleTableViewCell *textFilleCell =(TextFilleTableViewCell *)[self.view viewWithTag:100+i];
        [textFilleCell.textField resignFirstResponder];
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
