//
//  PickerItemViewController.m
//  UniversalFramework
//
//  Created by ORANLLC_IOS1 on 15/8/6.
//  Copyright (c) 2015年 ORANLLC_IOS1. All rights reserved.
//

#import "PickerItemViewController.h"

@interface PickerItemViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UILabel *labelSelected;

@property (weak, nonatomic) IBOutlet UIButton *buttonSelect;

@end

@implementation PickerItemViewController
{
    NSArray *selectList;
}

-(id) initWithDatasource:(NSArray *) datasource
{
    self = [super initWithNibName:@"PickerItemViewController" bundle:NULL];
    if (self) {
        selectList = datasource;
        //[self initPickerView];
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [self initPickerView];
}

-(void)initPickerView
{
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttonSelect.backgroundColor = kUIColorFromRGB(color_mainTheme);
    if (selectList.count >0) {
        self.labelSelected.text = selectList[0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static NSInteger selectIndex;
- (IBAction)handleCompletion:(id)sender {
    [self.parentDialog dismiss];
    [self performSelector:@selector(handleCompletion) withObject:NULL afterDelay:0.1];
}

-(void) handleCompletion
{
    self.handleSelect(selectIndex);
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  selectList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return  selectList[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectIndex = row;
    self.selectedString = selectList[selectIndex];
    self.labelSelected.text = self.selectedString;
}

+(void)showSelect:(NSArray *) selectList completion:(void (^)(NSInteger index))completion
{
    PickerItemViewController *vc = [[PickerItemViewController alloc] initWithDatasource:selectList];
    vc.handleSelect = completion;
    MyDialog *dialog = [[MyDialog alloc] initWithViewController:vc];
    dialog.dismissOnTouchOutside = NO;
    [dialog show];
}

@end
