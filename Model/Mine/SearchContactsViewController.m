//
//  SearchContactsViewController.m
//  ulife
//
//  Created by sunmax on 16/1/12.
//  Copyright © 2016年 ORANLLC_IOS1. All rights reserved.
//

#import "SearchContactsViewController.h"
#import "BUSystem.h"
#import "BUSearch.h"
@interface SearchContactsViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    __weak IBOutlet UITextField *_textField;
    __weak IBOutlet UILabel *_myLabel;
    __weak IBOutlet UITableView *_myTableView;
    __weak IBOutlet UIButton *_SearchButtion;
    NSArray * _dateArr;
    BUSearch * search;
    BOOL _isPhoneNumber;
}
@end

@implementation SearchContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"选择用户";
    [_SearchButtion corner:[UIColor clearColor] radius:7 borderWidth:0];
    [_myLabel corner:[UIColor colorWithRed:0.929 green:0.937 blue:0.941 alpha:1.000] radius:7 borderWidth:1];
    _textField.delegate =self;
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [_myTableView addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view from its nib.
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_textField resignFirstResponder];
}

#pragma mark --- View
- (void)addTableView
{
//    [_myTableView registerNib:[UINib nibWithNibName:@"TextFilleTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextFilleTableViewCell"];
    _myTableView.delegate =self;
    _myTableView.dataSource =self;
    _myTableView.showsVerticalScrollIndicator =NO;
    //设置tableView不能滚动
//    [_myTableView setScrollEnabled:NO];
    [self setExtraCellLineHidden:_myTableView];
}

#pragma mark --- TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark --- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dateArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    search.uList =_dateArr[indexPath.row];
    UITableViewCell * tableViewCell =[tableView dequeueReusableCellWithIdentifier:@"111"];
    if (tableViewCell==nil)
    {
        tableViewCell =[[UITableViewCell alloc] init];
        NSString * str =search.uList.UserName;
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
        NSString *str1= _textField.text;
        NSString *temp = nil;
        if (_isPhoneNumber==YES) {
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:[UIColor orangeColor]
             
                                  range:NSMakeRange(0, str.length)];
            tableViewCell.textLabel.attributedText = AttributedStr;
            return tableViewCell;
        }
        else{
            for(int i =0; i < [str length]-[str1 length]==0?1:[str length]-[str1 length]; i++)
            {
                temp = [str substringWithRange:NSMakeRange(i, str1.length)];
                if ([temp isEqualToString:str1]) {
                    [AttributedStr addAttribute:NSForegroundColorAttributeName
                     
                                          value:[UIColor orangeColor]
                     
                                          range:NSMakeRange(i, str1.length)];
                    tableViewCell.textLabel.attributedText = AttributedStr;
                    return tableViewCell;
                }
            }

        }
    }
    tableViewCell.separatorInset =UIEdgeInsetsMake(0, 13, 0, 13);
    return tableViewCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    busiSystem.releases.search.uList =_dateArr[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- Action
//搜索按钮
- (IBAction)searchButtonAction:(id)sender {
    search =[BUSearch new];
    NSString * str =[self valiMobile:_textField.text];
    if (str==nil) {
        _isPhoneNumber=YES;
    }
    else{
        _isPhoneNumber=NO;
    }
    [search searchUser:_textField.text Observer:self callback:@selector(searchUserNotification:)];
    [_textField resignFirstResponder];
}

- (void)searchUserNotification:(BSNotification *)noti
{ ISTOLOGIN;
    BASENOTIFICATION(noti);
   
    _dateArr =search.UserList;
    if (_dateArr.count !=0) {
        [_myTableView reloadData];
    }
    else{
        TOASTSHOWUNDERVIEW(@"抱歉，没有该用户！", _textField, CGPointMake(0,10));
        [_myTableView reloadData];
    }
}


-(NSString *)valiMobile:(NSString *)mobile{
    if (mobile.length < 11)
    {
        return @"手机号长度只能是11位";
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            return @"请输入正确的电话号码";
        }
    }
    return nil;
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
